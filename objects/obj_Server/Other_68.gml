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
        
        // give player their server-side num, hand
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.JOINING);
        buffer_write(buffer, buffer_u8, num_players);
        buffer_write(buffer, buffer_u8, ds_list_size(player_hand));
        for (var i = 0; i < ds_list_size(player_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(player_hand, i));
        }
        
        // host hand
        buffer_write(buffer, buffer_u8, ds_list_size(obj_Game.player_1_hand));
        for (var i = 0; i < ds_list_size(obj_Game.player_1_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(obj_Game.player_1_hand, i));
        }
        
        // other player hand
        buffer_write(buffer, buffer_u8, ds_list_size(other_hand));
        for (var i = 0; i < ds_list_size(other_hand); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(other_hand, i));
        }
        
        // pot
        buffer_write(buffer, buffer_u8, ds_list_size(global.pot));
        for (var i = 0; i < ds_list_size(global.pot); i++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(global.pot, i));
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
    
    if (identifier == NETWORK.BASE_SELECT) {
        
        base_selecting();
        var other_player = buffer_read(connection_buffer, buffer_u8);
        var base_card_id = buffer_read(connection_buffer, buffer_u8);
        
        var base_card_obj;
        with (obj_PotCard) {
            if (card_id == base_card_id) {
                base_card_obj = self;
            }
        }
        show_debug_message(string(base_card_obj.card_id));
        with (base_card_obj) {
            global.networked_action = true;
            event_perform(ev_mouse, ev_left_press);
        }
        
        // re-emit base select to other player
        for (var i = 0; i < ds_list_size(sockets); i++) {
            if (ds_list_find_value(sockets, i) != socket) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.BASE_SELECT);
                buffer_write(buffer, buffer_u8, other_player);
                buffer_write(buffer, buffer_u8, base_card_id);
                network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
            }
        }
        
    }
    
    else if (identifier == NETWORK.HONEST_HAND) {
        
        var other_player = buffer_read(connection_buffer, buffer_u8);
        var other_card_id = buffer_read(connection_buffer, buffer_u8);
        while (other_card_id != 255) {
            show_debug_message("server honest buffer read: " + string(other_card_id));
            with (obj_Card) {
                if (card_id == other_card_id) {
                    ds_stack_push(global.staging_cards, self);
                }
            }
            other_card_id = buffer_read(connection_buffer, buffer_u8);
        }
        show_debug_message("server honest buffer read: " + string(other_card_id));
        
        // copy staging to be re-emitted
        var copy_staging = ds_stack_create();
        var staging_size = ds_stack_size(global.staging_cards);
        ds_stack_copy(copy_staging, global.staging_cards);
        
        // turn stack into list to be able to loop
        var staging_list = ds_list_create();
        for (var i = 0; i < staging_size; i++) {
            ds_list_add(staging_list, ds_stack_pop(copy_staging).card_id);
        }
        ds_stack_destroy(copy_staging);
        
        // play hand
        global.hand_is_go = false;
        global.building_honest_hand = true;
        with (instance_create_layer(-100, -100, "Instances", obj_PlayButton, { type: 1 })) {
            global.networked_action = true;
            event_perform(ev_mouse, ev_left_press);
        }
        
        // decrease numeric hand size
        with (obj_Player) {
            if (num == other_player) {
                hand_size -= staging_size;
            }
        }
        
        // re-emit hand to other player
        for (var i = 0; i < ds_list_size(sockets); i++) {
            if (ds_list_find_value(sockets, i) != socket) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.HONEST_HAND);
                buffer_write(buffer, buffer_u8, other_player);
                for (var j = staging_size - 1; j >= 0; j--) {
                    buffer_write(buffer, buffer_u8, ds_list_find_value(staging_list, j));
                }
                buffer_write(buffer, buffer_u8, 255);
                network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
            }
        }
        
    }
    
    else if (identifier == NETWORK.BLUFFED_HAND) {
        
        var other_player = buffer_read(connection_buffer, buffer_u8);
        var other_card_id = buffer_read(connection_buffer, buffer_u8);
        var tmp_added_cards = ds_list_create();
        while (other_card_id != 255) {
            show_debug_message("client honest buffer read: " + string(other_card_id));
            with (obj_Card) {
                if (card_id == other_card_id) {
                    ds_stack_push(global.staging_cards, self);
                    ds_list_add(tmp_added_cards, self);
                }
            }
            other_card_id = buffer_read(connection_buffer, buffer_u8);
        }
        show_debug_message("client honest buffer read: " + string(other_card_id));
        
        global.supposed_top = buffer_read(connection_buffer, buffer_s8);
        var hand_msg = buffer_read(connection_buffer, buffer_string);
        
        // copy staging to be re-emitted
        var copy_staging = ds_stack_create();
        var staging_size = ds_stack_size(global.staging_cards);
        ds_stack_copy(copy_staging, global.staging_cards);
        
        // turn stack into list to be able to loop
        var staging_list = ds_list_create();
        for (var i = 0; i < staging_size; i++) {
            ds_list_add(staging_list, ds_stack_pop(copy_staging).card_id);
        }
        ds_stack_destroy(copy_staging);
        
        global.hand_is_go = false;
        global.building_bluffed_hand = true;
        with (instance_create_layer(-100, -100, "Instances", obj_PlayButton, { type: 1 })) {
            global.networked_action = true;
            ds_list_copy(added_cards, tmp_added_cards);
            hand_message = hand_msg;
            event_perform(ev_mouse, ev_left_press);
        }
        
        // decrease numeric hand size
        with (obj_Player) {
            if (num == other_player) {
                hand_size -= staging_size;
            }
        }
        
        // re-emit hand to other player
        for (var i = 0; i < ds_list_size(sockets); i++) {
            if (ds_list_find_value(sockets, i) != socket) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.BLUFFED_HAND);
                buffer_write(buffer, buffer_u8, other_player);
                for (var j = staging_size - 1; j >= 0; j--) {
                    buffer_write(buffer, buffer_u8, ds_list_find_value(staging_list, j));
                }
                buffer_write(buffer, buffer_u8, 255);
                buffer_write(buffer, buffer_s8, global.supposed_top);
                buffer_write(buffer, buffer_string, hand_msg);
                network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
            }
        }
        
    }
    
}