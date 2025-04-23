function clear_staged(){
	var size_holder = ds_stack_size(global.staging_cards)
	for (var i = 0; i < size_holder; i++) {
		var to_destroy = ds_stack_pop(global.staging_cards);
		instance_destroy(to_destroy);
	}
	show_debug_message("Current stack size: " + string(ds_stack_size(global.staging_cards)));
}