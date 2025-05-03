draw_text_color(room_width / 2, 90, "Turn Player: " + string(global.current_turn) + " | Your (Player " + string(global.id_on_server) + ") Points: " + string(global.player1.points), c_white, c_white, c_white, c_white, 1);

draw_text(room_width / 2, 320, global.last_hand_message);

// TODO: Make sure this doesn't update while someone is building their play
/*
if (global.which_last_hand != "") {
	draw_text(room_width / 2 - 70, 110, "Last played hand type: " + global.which_last_hand);
}
*/
if (global.last_hand_message != "") {
	draw_text(room_width / 2, room_height / 2 + 155, "Current top: " + string(get_rank(global.supposed_top)));
}

if (!global.base_card_exists) {
    draw_text(room_width / 2, room_height / 2, "Player " + string(global.base_picker) + " is picking the base card");
}