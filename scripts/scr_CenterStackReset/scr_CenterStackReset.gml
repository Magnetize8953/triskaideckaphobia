function center_stack_reset(){
	instance_destroy(instance_position(room_width / 2, room_height / 2, obj_Card));
	instance_destroy(instance_position(room_width / 2, room_height / 2, obj_PotCard));
}