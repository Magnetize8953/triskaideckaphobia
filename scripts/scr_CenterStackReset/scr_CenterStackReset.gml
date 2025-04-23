function center_stack_reset(){
	var pile_size = ds_stack_size(global.pile);
    for (var i = 1; i < pile_size; i++) {
        instance_destroy(instance_position(room_width / 2, room_height / 2, obj_Card));
    }
	instance_destroy(instance_position(room_width / 2, room_height / 2, obj_PotCard));
    ds_stack_clear(global.pile);
}