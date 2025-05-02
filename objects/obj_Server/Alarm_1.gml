show_debug_message("hand sizes: " + string(global.player1.hand_size) + " " + string(global.player2.hand_size) + " " + string(global.player3.hand_size))
// server is source of truth for deciding who's won
if ((global.player1.hand_size == 0) or (global.player2.hand_size == 0) or (global.player3.hand_size == 0)) {
    
    show_debug_message("someone won");
    
    // determine which player won the round only once to avoid possible race conditiony weirdness
    var player;
    if (global.player1.hand_size == 0) {
        player = 1;
    } else if (global.player2.hand_size == 0) {
        player = 2;
    } else if (global.player3.hand_size == 0) {
        player = 3;
    }
    
    for (var i = 0; i < ds_list_size(sockets); i++) {
        buffer_seek(buffer, buffer_seek_start, 1);
        buffer_write(buffer, buffer_u8, NETWORK.NEXT_ROUND);
        buffer_write(buffer, buffer_u8, player);
        network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
    }
    
    if (player == 1) {
        global.player1.points += 1;
    } else if (player == 2) {
        global.player2.points += 1;
    } else if (player == 3) {
        global.player3.points += 1;
    }
    
    center_stack_reset();
    flip_pot();
    base_selecting();
    
}