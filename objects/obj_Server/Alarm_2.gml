// check win status
if ((global.player1.points >= 7) or (global.player2.points >= 7) or (global.player3.points >= 7)) {
    
    if (global.player1.points >= 7) {
        global.winner = 1;
    } else if (global.player2.points >= 7) {
        global.winner = 2;
    } else {
        global.winner = 3;
    }
    
    // send out winner info
    for (var i = 0; i < ds_list_size(sockets); i++) {
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.GAME_OVER);
        buffer_write(buffer, buffer_u8, global.winner);
        network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
    }
    
    // go to game end room
    obj_Game.alarm[1] = 60 * 2;
    return;
    
}

// emit new cards
if (obj_Game.shuffling and ((ds_list_size(global.player1.my_cards) != 13) and (ds_list_size(global.player2.my_cards) != 13) and (ds_list_size(global.player3.my_cards) != 13))) {
    alarm[2] = 5;
} else {
    
    for (var i = 0; i < ds_list_size(sockets); i++) {
        
        var player_socket = ds_list_find_value(sockets, i);
        var player_num = ds_map_find_value(clients, player_socket);
        
        // pretty much just the joining procedure    
        var player_hand, other_hand;
        if (player_num == 2) { // player 2
            player_hand = obj_Game.player_2_hand;
            other_hand = obj_Game.player_3_hand;
        } else { // player 3
            player_hand = obj_Game.player_3_hand;
            other_hand = obj_Game.player_2_hand;
        }
        
        // say who won last round
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.NEXT_ROUND);
        buffer_write(buffer, buffer_u8, prev_round_winner);
        
        // player hand
        buffer_write(buffer, buffer_u8, ds_list_size(player_hand));
        for (var j = 0; j < ds_list_size(player_hand); j++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(player_hand, j));
        }
        
        // host hand
        buffer_write(buffer, buffer_u8, ds_list_size(obj_Game.player_1_hand));
        for (var j = 0; j < ds_list_size(obj_Game.player_1_hand); j++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(obj_Game.player_1_hand, j));
        }
        
        // other player hand
        buffer_write(buffer, buffer_u8, ds_list_size(other_hand));
        for (var j = 0; j < ds_list_size(other_hand); j++) {
            buffer_write(buffer, buffer_u8, ds_list_find_value(other_hand, j));
        }
        
        network_send_packet(player_socket, buffer, buffer_tell(buffer));
        
    }
    
}