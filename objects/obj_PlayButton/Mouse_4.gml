// TODO: uncomment out and finish 
// play_hand script call here
// If there are cards set to be played
if (ds_stack_size(global.staging_cards) > 0 and !global.hand_is_go) {
	// Disable it happening a second time, to start
	global.hand_is_go = true;
	
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
	show_debug_message("Top of stack: " + string(ds_stack_top(global.staging_cards)));
	
	// destroy current card on top of stack
	instance_destroy(instance_position(room_width / 2, room_height / 2, obj_Card));
	
	// Remove the new top card from your hand, move it to the top of the stack
	var new_top = ds_stack_pop(global.staging_cards);
	new_top.x = room_width / 2;
	new_top.y = room_height / 2;
	new_top.image_xscale = global.stack_scale;
	new_top.image_yscale = global.stack_scale;
	new_top.image_angle = 0;
	
	// Clear out the rest of the stack
	for (var i = 0; i < ds_stack_size(global.staging_cards); i++) {
		var to_destroy = ds_stack_pop(global.staging_cards);
		instance_destroy(to_destroy);
	}
	
}
if (global.hand_is_go) {
	instance_destroy();
}