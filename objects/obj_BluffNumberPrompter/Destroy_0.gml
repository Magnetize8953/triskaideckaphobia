// Basically; when this number is selected, make another prompter for 
// the next highest number with the remaining
show_debug_message("selected number: " + string(selected_number));

// Update the number of cards available
var new_available = available - selected_number;
var next_num = 0;
if (num == 13) {
	next_num = 1;
} else {
	next_num = num + 1;
}
if (new_available > 0) {
	instance_create_layer(0, 0, "Instances", obj_BluffNumberPrompter, {num: next_num, available: new_available});
} else {
	// Update the global supposed talk 
	global.supposed_top = -num; // make it ≤0 so that it always is considered lower suit
	show_debug_message("new suposed top: " + string(global.supposed_top));
	show_debug_message("supposed rank: " + string(get_rank(global.supposed_top)));
	// NOW move the cards over
}