prompter.selected_number = num + 1;

with (obj_NumberButton) {
	if (id != other.id) {
		instance_destroy();
	}
}

instance_destroy();