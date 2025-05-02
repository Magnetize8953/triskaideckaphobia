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
        var size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player1.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player1.update_hand = true;
        
        ds_list_clear(global.player2.hand);
        size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player2.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player2.update_hand = true;
        
        ds_list_clear(global.player3.hand);
        size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player3.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player3.update_hand = true;
        
        ds_list_clear(global.pot);
        size = ds_list_size(global.pot_cards);
        for (var i = 0; i < size; i++) {
            instance_destroy(obj_PotCard);
        }
        size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.pot, buffer_read(connection_buffer, buffer_u8));
        }
        global.pot_obj.hand = global.pot;
        global.pot_obj.alarm[0] = 5;
        
        show_debug_message("resetting hand pool...")
        ds_list_clear(global.hand_pool);
        ds_list_concat(global.hand_pool, global.player1.hand);
        ds_list_concat(global.hand_pool, global.player2.hand);
        ds_list_concat(global.hand_pool, global.player3.hand);
        
        show_debug_message("resetting hand object pool...")
        ds_list_clear(global.hand_obj_pool);
        ds_list_concat(global.hand_obj_pool, global.player1.my_cards);
        ds_list_concat(global.hand_obj_pool, global.player2.my_cards);
        ds_list_concat(global.hand_obj_pool, global.player3.my_cards);
        
        // give a bit of time to allow resetting hands
        alarm[1] = 15;
        
    }
    #endregion
    
    #region game identifiers
    else if (identifier == NETWORK.BASE_SELECT) {
        
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
        
    }
    
    else if (identifier == NETWORK.HONEST_HAND) {
        
        var other_player = buffer_read(connection_buffer, buffer_u8);
        var other_card_id = buffer_read(connection_buffer, buffer_u8);
        while (other_card_id != 255) {
            show_debug_message("client honest buffer read: " + string(other_card_id));
            with (obj_Card) {
                if (card_id == other_card_id) {
                    ds_stack_push(global.staging_cards, self);
                }
            }
            other_card_id = buffer_read(connection_buffer, buffer_u8);
        }
        show_debug_message("client honest buffer read: " + string(other_card_id));
        
        // decrease numeric hand size
        with (obj_Player) {
            if (num == other_player) {
                hand_size -= ds_stack_size(global.staging_cards);
            }
        }
        
        global.hand_is_go = false;
        global.building_honest_hand = true;
        with (instance_create_layer(-100, -100, "Instances", obj_PlayButton, { type: 1 })) {
            global.networked_action = true;
            event_perform(ev_mouse, ev_left_press);
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
        
        // decrease numeric hand size
        with (obj_Player) {
            if (num == other_player) {
                hand_size -= ds_stack_size(global.staging_cards);
            }
        }
        
        global.supposed_top = buffer_read(connection_buffer, buffer_s8);
        
        global.hand_is_go = false;
        global.building_bluffed_hand = true;
        with (instance_create_layer(-100, -100, "Instances", obj_PlayButton, { type: 1 })) {
            global.networked_action = true;
            ds_list_copy(added_cards, tmp_added_cards);
            hand_message = buffer_read(connection_buffer, buffer_string);
            event_perform(ev_mouse, ev_left_press);
        }
        
    }
    
    else if (identifier == NETWORK.NEXT_ROUND) {
        
        var other_player = buffer_read(connection_buffer, buffer_u8);
        
        with (obj_Player) {
            if (num == other_player) {
                points += 1;
            }
            show_debug_message("player " + string(num) + " has " + string(points) + " point(s)");
        }
        
        // reset player nums for card placement
        global.player1.num = 1;
        global.player2.num = 2;
        global.player3.num = 3;
        
        ds_list_clear(global.player1.hand);
        var size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player1.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player1.update_hand = true;
        
        ds_list_clear(global.player2.hand);
        size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player2.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player2.update_hand = true;
        
        ds_list_clear(global.player3.hand);
        size = buffer_read(connection_buffer, buffer_u8)
        for (var i = 0; i < size; i++) {
            ds_list_add(global.player3.hand, buffer_read(connection_buffer, buffer_u8));
        }
        global.player3.update_hand = true;
        
        show_debug_message("resetting hand pool...")
        ds_list_clear(global.hand_pool);
        ds_list_concat(global.hand_pool, global.player1.hand);
        ds_list_concat(global.hand_pool, global.player2.hand);
        ds_list_concat(global.hand_pool, global.player3.hand);
        
        show_debug_message("resetting hand object pool...")
        ds_list_clear(global.hand_obj_pool);
        ds_list_concat(global.hand_obj_pool, global.player1.my_cards);
        ds_list_concat(global.hand_obj_pool, global.player2.my_cards);
        ds_list_concat(global.hand_obj_pool, global.player3.my_cards);
        
        // re-reset player id number
        alarm[1] = 15;
        
        center_stack_reset();
        flip_pot();
        base_selecting();
        
    }
    #endregion
    
}