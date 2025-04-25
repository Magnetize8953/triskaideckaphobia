holder = self;

size = stag_size;
rev = stag_reverse;
hand_mess = hand_message;

// card name used both in draw and in bigger string assembly
card_name = "";
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

if (base_number) {
	instance_create_layer(room_width / 2 - (83 * 4), 1080 * (565/768), "Instances", obj_NumberButton, {num: 0, prompter: holder});
}
if (available >= 1) {
	instance_create_layer(room_width / 2 - (83 * 2), 1080 * (565/768), "Instances", obj_NumberButton, {num: 1, prompter: holder});
}
if (available >= 2) {
	instance_create_layer(room_width / 2, 1080 * (565/768), "Instances", obj_NumberButton, {num: 2, prompter: holder});
}
if (available >= 3) {
	instance_create_layer(room_width / 2 + (83 * 2), 1080 * (565/768), "Instances", obj_NumberButton, {num: 3, prompter: holder});
}
if (available >= 4) {
	instance_create_layer(room_width / 2 + (83 * 4), 1080 * (565/768), "Instances", obj_NumberButton, {num: 4, prompter: holder});
}

selected_number = -1;