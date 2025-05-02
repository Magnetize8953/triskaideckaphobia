show_debug_message("bluff called");

if (get_rank(global.supposed_top) != get_rank(ds_list_find_value(global.pile, ds_list_size(global.pile) - 1).card_id)) {
    successful_call = true;
}

// TODO: make this not care about the order the cards were selected
for (var i = ds_list_size(global.pile) - ds_list_size(prev_hand) - 1; i < ds_list_size(global.pile) - 1; i++) {
    var current_card = ds_list_find_value(global.pile, i).card_id;
    var next_card = ds_list_find_value(global.pile, i + 1).card_id;
    if (!validate_stack(next_card, current_card)) {
        alarm[0] = -1;
        show_debug_message("bluff successfully called on " + string(bluffing_player));
        successful_call = true;
        break;
    }
}

if (!global.networked_action) {
    if (instance_exists(obj_Server)) {
        // set win condition for player
        if (successful_call) {
            global.player1.hand_size = 0;
        } else {
            if (bluffing_player == 2) {
                global.player2.hand_size = 0;
            } else {
                global.player3.hand_size = 0;
            }
        }
        obj_Server.alarm[1] = 60 * 3;
    }
    else if (instance_exists(obj_Client)) {
        var bluffer = bluffing_player;
        var success = successful_call;
        with (obj_Client) {
            buffer_seek(buffer, buffer_seek_start, 1);
            buffer_write(buffer, buffer_u8, NETWORK.BLUFF_CALLED);
            buffer_write(buffer, buffer_u8, global.id_on_server);
            buffer_write(buffer, buffer_u8, bluffer);
            buffer_write(buffer, buffer_bool, success);
            network_send_packet(client_socket, buffer, buffer_tell(buffer));
        }
    }
}
global.networked_action = false;
alarm[0] = 1;