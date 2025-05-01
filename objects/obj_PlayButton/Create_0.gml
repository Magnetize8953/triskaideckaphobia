if (global.building_bluffed_hand) {
	added_cards = ds_list_create();
}

staging_size = -1;
staging_reversed = ds_stack_create();

global.networked_action = false;

alarm_1_running = false;