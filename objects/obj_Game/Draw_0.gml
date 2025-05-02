draw_text(room_width / 2 - 40, 90, "Current Player: " + string(global.current_turn) + ". Points: " + string(global.player1.points));

draw_text(room_width / 2 - 160, 130, global.last_hand_message);

// TODO: Make sure this doesn't update while someone is building their play
if (global.which_last_hand != "") {
	draw_text(room_width / 2 - 70, 110, "Last played hand type: " + global.which_last_hand);
}
if (global.last_hand_message != "") {
	draw_text(room_width / 2 - 40, room_height / 2 - 145, "Current top: " + string(get_rank(global.supposed_top)));
}