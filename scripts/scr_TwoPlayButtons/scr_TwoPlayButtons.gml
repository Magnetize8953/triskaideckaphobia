function two_play_buttons(){
	instance_create_layer(1920 * (500/1366), 1080 * (573/768), "Instances", obj_HonestButton);
	instance_create_layer(room_width - (1920 * (500/1366)), 1080 * (573/768), "Instances", obj_BluffButton);
	
	// reset last played hand tracking
	global.last_played_hand = ds_list_create();
	global.which_last_hand = "";
}