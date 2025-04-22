function two_play_buttons(){
	instance_create_layer(500, 530, "Instances", obj_HonestButton);
	instance_create_layer(room_width - 500, 530, "Instances", obj_BluffButton);
}