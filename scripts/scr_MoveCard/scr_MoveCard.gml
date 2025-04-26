function move_card(card, new_x, new_y, move_speed){
	if !(card.x == new_x and card.y == new_y) {
		// Following code developed off of a skeleton produced by ChatGPT
		var dx = new_x - card.x;
		var dy = new_y - card.y;

		// Normalize the vector
		var dist = point_distance(card.x, card.y, new_x, new_y);
		show_debug_message(dist);

		if (dist > move_speed) {
		    card.x += (dx / dist) * move_speed;
			card.y += (dy / dist) * move_speed;
			move_card(card, new_x, new_y, move_speed);
		} else {
			// Snap to target if close enough
			card.x = new_x;
			card.y = new_y;
		}
	}
}