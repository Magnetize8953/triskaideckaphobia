holder = self;

if (available >= 1) {
	instance_create_layer(room_width / 2 - (83 * 3), 1080 * (565/768), "Instances", obj_NumberButton, {num: 0, prompter: holder});
}
if (available >= 2) {
	instance_create_layer(room_width / 2 - (83 * 1), 1080 * (565/768), "Instances", obj_NumberButton, {num: 1, prompter: holder});
}
if (available >= 3) {
	instance_create_layer(room_width / 2 + (83 * 1), 1080 * (565/768), "Instances", obj_NumberButton, {num: 2, prompter: holder});
}
if (available >= 4) {
	instance_create_layer(room_width / 2 + (83 * 3), 1080 * (565/768), "Instances", obj_NumberButton, {num: 3, prompter: holder});
}

selected_number = -1;