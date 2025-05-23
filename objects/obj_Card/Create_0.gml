show_debug_message("Creating card " + string(card_id) + " associated with " + string(associated_player) + "...");

show_debug_message(global.is_Premium);
if(global.is_Premium){
	sprite_index = spr_Cards_Premium;
}

image_speed = 0;
image_index = card_id;


image_xscale = scale;
image_yscale = scale;

face_down = false;
flip_speed = 2;
flip_scale = 0.05;

flipping = false;


image_angle = rotation;

// Used for move functionality
new_x = -1;
new_y = -1;
move_speed = 0;
move_wait = 0;
new_angle = 0;

shader_depth = shader_get_uniform(shdr_Dim, "depth");