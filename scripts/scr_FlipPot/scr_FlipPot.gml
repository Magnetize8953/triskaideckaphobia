function flip_pot(){
	for (var i = 0; i < ds_list_size(global.pot_cards); i++) {
		with (ds_list_find_value(global.pot_cards, i)) {
            if ((self.x != room_width / 2) or (self.y != room_height / 2)) {
                self.alarm[0] = 5;
            }
        }
	}
}