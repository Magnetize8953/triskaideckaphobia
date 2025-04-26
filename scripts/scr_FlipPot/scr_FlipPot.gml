function flip_pot(){
	for (var i = 0; i < ds_list_size(global.pot_cards); i++) {
		ds_list_find_value(global.pot_cards, i).alarm[0] = 5;
	}
}