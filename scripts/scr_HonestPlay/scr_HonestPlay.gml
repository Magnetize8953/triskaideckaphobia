function honest_play(){
	global.building_honest_hand = true;
	ds_stack_clear(global.staging_cards);
	// Track the current card on top of the stack
	var current_top = instance_position(room_width / 2, room_height / 2, obj_Card);
	if (!global.hand_is_go) {
		instance_create_layer(room_width / 2, 1080 * (565/768), "Instances", obj_PlayButton, {type: 1});
	}
}