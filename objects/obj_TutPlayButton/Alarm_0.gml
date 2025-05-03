// if cards are all flipped, move them to pile, otherwise don't
if (ds_stack_top(staging_reversed).flipping) {
	
	// moved staged stack to pile
	
	// hand off the procedure to recursive buttons that let the player craft their bluff
	with(obj_Tutorial) {
		alarm[6] = 1;
	}
	//instance_create_layer(room_width / 2 - (83 * 3), 1080 * (565/768), "Instances", obj_NumberButton, {num: 0});
	
	// Create the (for some reason) necessary object to destroy the play button
	instance_create_layer(0, 0, "Instances", obj_TutPlayDestroyer);
	// Make supposed_top the actual new top
	// TODO: ADD SCRIPT THAT RUNS PROMPT TO ASK PLAYER HOW MANY OF EACH THEY BLUFFED
} else {
	alarm[0] = 5;
}

	
	