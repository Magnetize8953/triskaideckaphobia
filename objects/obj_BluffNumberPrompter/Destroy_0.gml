// Basically; when this number is selected, make another prompter for 
// the next highest number with the remaining
show_debug_message("selected number: " + string(selected_number));

// Craft contribution to last_played_hand
var card_message = "";
if (selected_number == 1) {
	card_message += "one ";
} else if (selected_number == 2) {
	card_message += "two ";
} else if (selected_number == 3) {
	card_message += "three ";
} else if (selected_number == 4) {
	card_message += "four ";
}
if (selected_number > 0) {
	card_message += card_name;
}
if (selected_number > 1) { // tags on the plural
	card_message += "s"
}
if (selected_number > 0) {
	card_message += ", ";
}

hand_mess += card_message;


// Update the number of cards available
var new_available = available - selected_number;
var next_num = 0;
if (num == 13) {
	next_num = 1;
} else {
	next_num = num + 1;
}
if (new_available > 0) {
	instance_create_layer(0, 0, "Instances", obj_BluffNumberPrompter, {num: next_num, available: new_available, stag_size: size, stag_reverse: rev, hand_message: hand_mess});
} else {
	// Update the global supposed top 
	global.supposed_top = -num; // make it ≤0 so that it always is considered lower suit
		// NOTE: gamemaker, for some reason, evaluates negative mod incorrectly
		// ie, -4%13 is considered 4, not 9 like it mathematically should be. 
	show_debug_message("new supposed top: " + string(global.supposed_top));
	show_debug_message("supposed rank: " + string(get_rank(global.supposed_top)));
	// NOW move the cards over
	// moved staged stack to pile
    for (var i = 0; i < stag_size; i++) {
		var next_card = ds_stack_pop(stag_reverse);
        next_card.new_x = room_width / 2;
        next_card.new_y = room_height / 2;
		next_card.move_speed = 19 + 1/(i-stag_size);
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
	update_last_hand_string(hand_mess);
    
    var in_staging = stag_size;
    var hand_msg = hand_mess;
    if (instance_exists(obj_Server)) {
        with (obj_Server) {
            for (var i = 0; i < ds_list_size(sockets); i++) {
                buffer_seek(buffer, buffer_seek_start, 1);
                buffer_write(buffer, buffer_u8, NETWORK.BLUFFED_HAND);
                buffer_write(buffer, buffer_u8, 1);
                for (var j = ds_list_size(global.pile) - in_staging; j < ds_list_size(global.pile); j++) {
                    buffer_write(buffer, buffer_u8, ds_list_find_value(global.pile, j).card_id);
                }
                buffer_write(buffer, buffer_u8, 255);
                buffer_write(buffer, buffer_s8, global.supposed_top);
                buffer_write(buffer, buffer_string, hand_msg);
                network_send_packet(ds_list_find_value(sockets, i), buffer, buffer_tell(buffer));
            }
        }
    }
    else if (instance_exists(obj_Client)) {
        with (obj_Client) {
            buffer_seek(buffer, buffer_seek_start, 1);
            buffer_write(buffer, buffer_u8, NETWORK.BLUFFED_HAND);
            buffer_write(buffer, buffer_u8, 1);
            for (var j = ds_list_size(global.pile) - in_staging; j < ds_list_size(global.pile); j++) {
                buffer_write(buffer, buffer_u8, ds_list_find_value(global.pile, j).card_id);
            }
            buffer_write(buffer, buffer_u8, 255);
            buffer_write(buffer, buffer_s8, global.supposed_top);
            buffer_write(buffer, buffer_string, hand_msg);
            network_send_packet(client_socket, buffer, buffer_tell(buffer));
        }
    }
}