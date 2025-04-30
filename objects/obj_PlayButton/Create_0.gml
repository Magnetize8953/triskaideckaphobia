if (global.building_bluffed_hand) {
	added_cards = ds_list_create();
}

staging_size = -1;
staging_reversed = ds_stack_create();

networked_action = false;