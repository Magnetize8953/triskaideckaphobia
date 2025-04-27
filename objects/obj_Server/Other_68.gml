var event_id = async_load[? "id"];

if (event_id == server) {
    var type = async_load[? "type"];
    var socket = async_load[? "socket"];
    
    if (type == network_type_connect) {
        
        if (num_players == 3) {
            show_debug_message("exceeded player count");
            
            buffer_seek(buffer, buffer_seek_start, 1);
            buffer_write(buffer, buffer_u8, NETWORK.MAX_PLAYERS_REACHED);
            network_send_packet(socket, buffer, buffer_tell(buffer));
            
            return;
        }
        
        ds_list_add(sockets, socket);
        ds_map_add(clients, socket, ++num_players);
        
        var player_hand, other_hand;
        if (num_players == 2) { // player 2
            player_hand = obj_Game.player_2_hand;
            other_hand = obj_Game.player_3_hand;
        } else { // player 3
            player_hand = obj_Game.player_3_hand;
            other_hand = obj_Game.player_2_hand;
        }
        
        // give player their server-side num, hand, pot
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.JOINING);
        buffer_write(buffer, buffer_u8, num_players);
        buffer_write(buffer, buffer_u8, ds_list_size(player_hand));
        for (var i = 0; i < ds_list_size(player_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(player_hand, i));
        }
        buffer_write(buffer, buffer_u8, ds_list_size(global.pot));
        for (var i = 0; i < ds_list_size(global.pot); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(global.pot, i));
        }
        network_send_packet(socket, buffer, buffer_tell(buffer));
        
        // give new player server host information
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.PLAYER_ADD);
        buffer_write(buffer, buffer_u8, 1);
        for (var i = 0; i < ds_list_size(obj_Game.player_1_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(obj_Game.player_1_hand, i));
        }
        network_send_packet(socket, buffer, buffer_tell(buffer));
        
        // give new player other player's information
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.PLAYER_ADD);
        buffer_write(buffer, buffer_u8, num_players == 2 ? 3 : 2);
        for (var i = 0; i < ds_list_size(other_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(other_hand, i));
        }
        network_send_packet(socket, buffer, buffer_tell(buffer));
        
    } else if (type == network_type_disconnect) {
        
        // TODO: figure out how to handle player 2 leaving and another (re)joining
        num_players--;
        
        // TODO: handle player disconnects gracefully
        // end game
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.END_GAME);
        network_send_packet(socket, buffer, buffer_tell(buffer));
        
        // delete leaving player info
        ds_list_delete(sockets, ds_list_find_index(sockets, socket));
        ds_map_delete(clients, socket);
        
    }
} else if (event_id != server) { // non-connection packets
    
    var socket = async_load[? "id"];
    var connection_buffer = async_load[? "buffer"];
    var player = clients[? socket];
    
    buffer_seek(connection_buffer, buffer_seek_start, 1);
    var identifier = buffer_read(connection_buffer, buffer_u8);
    show_debug_message("server received: " + string(identifier));
    
}