function update_last_hand_string(str){
	global.last_hand_message = "";
	if (global.which_last_hand == "honest") {
		global.last_hand_message = "Last hand played: ";
		for (var i = 0; i < ds_list_size(global.last_played_hand); i++) {
			var card = card_string(ds_list_find_value(global.last_played_hand, i).card_id);
			if !(i == 0) {
				global.last_hand_message += ", ";
			}
			global.last_hand_message += card;
		}
	} else if (global.which_last_hand == "bluff") {
		var trimmed_last_comma = string_copy(str, 1, string_length(str) - 2);
		global.last_hand_message = "Last hand played: " + trimmed_last_comma;
	}
}