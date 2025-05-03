show_debug_message("rank: " + string(get_rank(self.card_id)));
show_debug_message("card id itself: " + string(self.card_id));


// TODO: Use this as a baseline for future loops through; need to reset 
// card_was_selected next time a card is going to be selected

// tutorial
if (instance_exists(obj_Tutorial) and !global.base_card_exists and global.card_being_selected and self.card_id == 1) {
    // No more card being selected
    global.card_being_selcted = false;
    global.base_card_exists = true;
    
    // Card is the base of the pot
    self.is_base = true;
    
    // Move to center of the room, and as deep as physically possible
    self.x = room_width / 2;
    self.y = room_height / 2;
    
    image_xscale = global.stack_scale;
    image_yscale = global.stack_scale;
    
    ds_list_add(global.pile, self);
    
    global.supposed_top = self.card_id;
    
// If there is no base card, and a base card is being selected
} else if (!instance_exists(obj_Tutorial) and !global.base_card_exists and global.card_being_selected and (global.id_on_server == global.base_picker or global.networked_action)) {
    center_stack_reset();
    
    // No more card being selected
    global.card_being_selcted = false;
    global.base_card_exists = true;
    
    // Card is the base of the pot
    self.is_base = true;
    
    // Remove card from the global pot
    var index_to_delete = ds_list_find_index(global.pot, self.card_id);
    ds_list_delete(global.pot, index_to_delete);
    ds_list_delete(global.pot_cards, index_to_delete);
    
    // Move to center of the room, and as deep as physically possible
    self.x = room_width / 2;
    self.y = room_height / 2;
    
    image_xscale = global.stack_scale;
    image_yscale = global.stack_scale;
    
    ds_list_add(global.pile, self);
    
    global.supposed_top = self.card_id;
    
    if (!global.networked_action) {
        var card_id = self.card_id;
        if (instance_exists(obj_Server)) {
            with (obj_Server) {
                for (var i = 0; i < ds_list_size(sockets); i++) {
                    buffer_seek(buffer, buffer_seek_start, 1);
                    buffer_write(buffer, buffer_u8, NETWORK.BASE_SELECT);
                    buffer_write(buffer, buffer_u8, 1);
                    buffer_write(buffer, buffer_u8, card_id);
                    network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
                }
            }
        }
        else if (instance_exists(obj_Client)) {
            with (obj_Client) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.BASE_SELECT);
                buffer_write(buffer, buffer_u8, global.id_on_server);
                buffer_write(buffer, buffer_u8, card_id);
                network_send_packet(client_socket, buffer, buffer_tell(buffer));
            }
        }
    }
    
    if (global.base_picker == 3) {
        global.base_picker = 1;
    } else {
        global.base_picker++;
    }
    global.networked_action = false;
    flip_pot();
}
