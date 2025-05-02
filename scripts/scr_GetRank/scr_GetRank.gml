function get_rank(card){
	// if (card <= 0) {
	// 	show_debug_message("Gamemaker thinks " + string(card) + "%13 = " + string(card % 13));
	// }
    if card % 13 == 0 {
        return 13;
    } else {
        return abs(card % 13);
    }
}
