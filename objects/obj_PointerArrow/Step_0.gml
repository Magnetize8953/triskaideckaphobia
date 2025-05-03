if (traveling_up > 0 ){
	y -= 0.5;
	traveling_up--;
	if (traveling_up == 0) {
		traveling_down = 60;
	}
} else if (traveling_down > 0 ){
	y += 0.5;
	traveling_down--;
	if (traveling_down == 0) {
		traveling_up = 60;
	}
}