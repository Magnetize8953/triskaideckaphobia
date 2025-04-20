/*
if (!flipping) {
    alarm[0] = flip_speed;
    flipping = true;
}
*/
// If clicked on, check to see if a card is in the stack at x,y
in_pot = instance_position(room_width / 2, room_height / 2, obj_Card);
if (in_pot != noone) { // If one exists
	if (validate_stack(self.card_id, in_pot.card_id)) { // if clicked on card is a valid play
		instance_destroy(in_pot);
		self.x = room_width / 2;
		self.y = room_height / 2;
	}
}