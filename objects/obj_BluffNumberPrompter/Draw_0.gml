var card_name = "";
if (num == 1) {
	card_name = "ace";
} else if (num == 11) {
	card_name = "jack";
} else if (num == 12) {
	card_name = "queen";
} else if (num == 13) {
	card_name = "king";
} else {
	card_name = string(num);
}
draw_text(room_width / 2 - 50, 1080 * (565/768) - 55, "How many " + card_name + "s are you bluffing?");