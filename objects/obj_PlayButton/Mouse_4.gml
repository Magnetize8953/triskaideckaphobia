// TODO: uncomment out and finish 
// play_hand script call here
// If there are cards set to be played
if (ds_stack_size(global.staging_cards) > 0 and (!global.hand_is_go or global.networked_action) and global.building_honest_hand) {
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;
	
	// Turn off the honest hand tracking, because we don't need that anymore
	global.building_honest_hand = false;
	
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
	show_debug_message("Top of stack: " + string(ds_stack_top(global.staging_cards)));
	
    
    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(global.staging_cards);
    for (var i = 0; i < staging_size; i++) {
        ds_stack_push(staging_reversed, ds_stack_pop(global.staging_cards));
    }
    
    // moved staged stack to pile
    var next_card;
    for (var i = 0; i < staging_size; i++) {
        next_card = ds_stack_pop(staging_reversed);
        if (global.networked_action) {
            next_card.scale = global.stack_scale;
            next_card.alarm[0] = 1;
        }
        
        next_card.new_x = room_width / 2;
        next_card.new_y = room_height / 2;
		next_card.move_speed = 19 + 1 / (i - staging_size);
		next_card.move_wait = i;
		next_card.alarm[3] = 30;
		
        if (!global.networked_action) {
            next_card.image_xscale = global.stack_scale;
        }
        next_card.image_yscale = global.stack_scale;
		
        randomize();
        next_card.new_angle = random_range(0, 180);
        next_card.depth = -1 + -ds_list_size(global.pile);
		ds_list_add(global.last_played_hand, next_card); // add to global last hand tracker
		global.which_last_hand = "honest";
		
        ds_list_add(global.pile, next_card);
    }
	
	// Make supposed_top the actual new top
	global.supposed_top = next_card.card_id;
	
	update_last_hand_string("");
	
    if (!global.networked_action) {
        var in_staging = self.staging_size;
        if (instance_exists(obj_Server)) {
            with (obj_Server) {
                for (var i = 0; i < ds_list_size(sockets); i++) {
                    buffer_seek(buffer, buffer_seek_start, 1);
                    buffer_write(buffer, buffer_u8, NETWORK.HONEST_HAND);
                    buffer_write(buffer, buffer_u8, 1);
                    for (var j = ds_list_size(global.pile) - in_staging; j < ds_list_size(global.pile); j++) {
                        buffer_write(buffer, buffer_u8, ds_list_find_value(global.pile, j).card_id);
                    }
                    buffer_write(buffer, buffer_u8, 255);
                    network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
                }
            }
        }
        else if (instance_exists(obj_Client)) {
            with (obj_Client) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.HONEST_HAND);
                buffer_write(buffer, buffer_u8, global.id_on_server);
                for (var j = ds_list_size(global.pile) - in_staging; j < ds_list_size(global.pile); j++) {
                    buffer_write(buffer, buffer_u8, ds_list_find_value(global.pile, j).card_id);
                }
                buffer_write(buffer, buffer_u8, 255);
                network_send_packet(client_socket, buffer, buffer_tell(buffer));
            }
        }
    }
    global.networked_action = false;
    
    next_turn();
	
}

else if (ds_stack_size(global.staging_cards) > 0 and (!global.hand_is_go or global.networked_action) and global.building_bluffed_hand){
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;
	
	// Turn off the honest hand tracking, because we don't need that anymore
	global.building_bluffed_hand = false;
	
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
	show_debug_message("Top of stack: " + string(ds_stack_top(global.staging_cards)));
	
    
    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(global.staging_cards);
    for (var i = 0; i < staging_size; i++) {
        ds_stack_push(staging_reversed, ds_stack_pop(global.staging_cards));
    }
    
    
    if (!global.networked_action) {
        // other players' cards are already face down, so only need to flip if my bluff
        for (var i = 0; i < staging_size; i++) {
            // If the card isn't flipping yet, start it flipping
            if (!ds_list_find_value(added_cards, i).flipping) {
                ds_list_find_value(added_cards, i).flipping = true;
                ds_list_find_value(added_cards, i).alarm[0] = 5;
            }
        }
        // Go to alarm to wait for cards to flip
        alarm[0] = 5;
    } else {
        // TODO: clean up, move to script probably
        // stolen from obj_BluffNumberPrompter
        
        show_debug_message("new supposed top: " + string(global.supposed_top));
        show_debug_message("supposed rank: " + string(get_rank(global.supposed_top)));
        // NOW move the cards over
        // moved staged stack to pile
        for (var i = 0; i < staging_size; i++) {
            var next_card = ds_stack_pop(staging_reversed);
            next_card.new_x = room_width / 2;
            next_card.new_y = room_height / 2;
            next_card.move_speed = 19 + 1 / (i - staging_size);
            next_card.move_wait = i;
            next_card.alarm[3] = 1;
            
            next_card.image_xscale = global.stack_scale;
            next_card.image_yscale = global.stack_scale;
            
            randomize();
            next_card.new_angle = random_range(0, 180);
            next_card.depth = -1 + -ds_list_size(global.pile);
            
            ds_list_add(global.last_played_hand, next_card); // add to global last hand tracker
            global.which_last_hand = "bluff";
            
            ds_list_add(global.pile, next_card);
        }
        
        // update the displayed last played hand (needs bluff functionality added)
        update_last_hand_string(hand_message);
    }
    global.networked_action = false;
    
    next_turn();
	
} 

if (global.hand_is_go and type == 1) {
	instance_destroy(self);
}