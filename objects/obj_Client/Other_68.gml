var event_id = async_load[? "id"];

if (event_id == client_socket && event_id != 1) {
    
    var connection_buffer = async_load[? "buffer"];
    buffer_seek(connection_buffer, buffer_seek_start, 1);
    var identifier = buffer_read(connection_buffer, buffer_u8);
    show_debug_message("client received: " + string(identifier));
    
    #region network identifiers
    if (identifier == NETWORK.MAX_PLAYERS_REACHED) {
        
        show_debug_message("max players reached. connection rejected");
        network_destroy(client_socket);
        instance_destroy(self);
        
    }
    
    else if (identifier == NETWORK.JOINING) {
        
        global.id_on_server = buffer_read(connection_buffer, buffer_u8);
        show_debug_message("id on server: " + string(global.id_on_server));
        
        ds_list_clear(global.player1.hand);
        var hand_size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < hand_size; i++) {
            ds_list_add(global.player1.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player1.update_hand = true;
        
        ds_list_clear(global.pot);
        var pot_size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < pot_size; i++) {
            ds_list_add(global.pot, buffer_read(connection_buffer, buffer_u8));
        }
        global.pot_obj.hand = global.pot;
        global.pot_obj.alarm[0] = 5;
        
    }
    #endregion
    
    #region game identifiers
    else if (identifier == NETWORK.BASE_SELECT) {
        
        base_selecting();
        var other_player = buffer_read(connection_buffer, buffer_u8);
        var base_card_id = buffer_read(connection_buffer, buffer_u8);
        
        var base_card_obj;
        for (var i = 0; i < ds_list_size(global.pot_cards); i++) {
            if (ds_list_find_value(global.pot_cards, i).card_id == base_card_id) {
                base_card_obj = ds_list_find_value(global.pot_cards, i);
                break;
            }
        }
        show_debug_message(string(base_card_obj.card_id));
        with (base_card_obj) {
            networked_base_pick = true;
            event_perform(ev_mouse, ev_left_press);
        }
        
    }
    #endregion
    
}