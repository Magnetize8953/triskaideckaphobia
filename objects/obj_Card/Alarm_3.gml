if !(self.x == new_x and self.y == new_y) {
	// Following code developed off of a skeleton produced by ChatGPT
	var dx = new_x - self.x;
	var dy = new_y - self.y;

	// Normalize the vector
	var dist = point_distance(self.x, self.y, new_x, new_y);
	show_debug_message(dist);

	if (move_wait > 0) {
		move_wait--;
		alarm[3] = 5;
	}
	else if (dist > move_speed and new_x != -1 and new_y != -1) {
	    self.x += (dx / dist) * (move_speed * max((dist / (60 + move_wait)), 1)); //scales faster with more distance
		self.y += (dy / dist) * (move_speed * max((dist / (60 + move_wait)), 1)); //scales faster with more distance
		
		//Rotate as it starts moving
		var angle_update = angle_difference(image_angle, new_angle) * 0.2;
		if (image_angle + angle_update <= new_angle) {
			image_angle += angle_update;
		}
		alarm[3] = 1;
	} else {
		// Snap to target if close enough
		self.x = new_x;
		self.y = new_y;
		new_x = -1;
		new_y = -1;
	}
}