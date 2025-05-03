// TODO: uncomment out and finish 
// play_hand script call here
// If there are cards set to be played
if (ds_stack_size(passed_cards) > 0 and !global.hand_is_go and type == 0) {
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;

    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(passed_cards);
    for (var i = 0; i < staging_size; i++) {
        ds_stack_push(staging_reversed, ds_stack_pop(passed_cards));
    }
    
    // moved staged stack to pile
    for (var i = 0; i < staging_size; i++) {
        var next_card = ds_stack_pop(staging_reversed);
        next_card.new_x = room_width / 2;
        next_card.new_y = room_height / 2;
		next_card.move_speed = 19 + 1/(i-staging_size);
		next_card.move_wait = i;
		next_card.alarm[3] = 1;
		
        next_card.image_xscale = global.stack_scale;
        next_card.image_yscale = global.stack_scale;
		
        randomize();
        next_card.new_angle = random_range(0, 180);
        next_card.depth = -1 + -ds_list_size(global.pile);

        ds_list_add(global.pile, next_card);
    }
	
	// Make supposed_top the actual new top
	global.supposed_top = ds_list_find_value(global.pile, ds_list_size(global.pile) - 1).card_id;
	
	with(obj_Tutorial) {
		layer_sprite_destroy(fifteenth_text);
		layer_sprite_destroy(sixteenth_text);
		op1.alarm[1] = 100;
	}
}


else if (ds_stack_size(passed_cards) > 0 and !global.hand_is_go and type == 1){
	with (obj_Tutorial) {
		layer_sprite_destroy(nineteenth_text);
		layer_sprite_destroy(twentieth_text);
	}
	
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	// make self invisible
	self.image_alpha = 0;
 
    // reverse stack
    staging_reversed = ds_stack_create();
    staging_size = ds_stack_size(passed_cards);
    for (var i = 0; i < staging_size; i++) {
		var card = ds_stack_pop(passed_cards);
		card.flipping = true;
		card.alarm[0] = 5;
        ds_stack_push(staging_reversed, card);
    }
	// Go to alarm to wait for cards to flip
	alarm[0] = 5;
	
} 


if (global.hand_is_go and type != 1) {
	instance_destroy();
}
