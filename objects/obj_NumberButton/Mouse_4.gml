prompter.selected_number = num;

with (obj_NumberButton) {
	if (id != other.id) {
		instance_destroy();
	}
}

instance_destroy();