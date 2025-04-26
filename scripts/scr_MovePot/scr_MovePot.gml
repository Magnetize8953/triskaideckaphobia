function move_pot(){
	global.pot_moving = true;
	if (global.pot_visible){
		
		global.pot_visible = false;
		global.pot_moving = false;
	} else {
		global.pot_visible = true;
		global.pot_moving = false;
	}
}