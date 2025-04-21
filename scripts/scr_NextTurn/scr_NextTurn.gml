function next_turn(){
	if (global.current_turn == 3) {
		global.current_turn = 1;
	} else {
		global.current_turn++;
}