function center_stack_reset(){
	var pile_size = ds_list_size(global.pile);
    for (var i = 0; i < pile_size; i++) {
        instance_destroy(instance_position(room_width / 2, room_height / 2, obj_Card));
    }
    ds_list_clear(global.pile);
}