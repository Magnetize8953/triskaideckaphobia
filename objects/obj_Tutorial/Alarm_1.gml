// 1. Pick base

if (!global.card_being_selected) {
	global.card_being_selected = true;
}


// make the pointer arrow, and use that for drawing text
if (instance_position(1.5 * (_card_sprite_width * 0.8) + 384/2, 180 + (sprite_get_height(spr_Cards) * 0.45), obj_PointerArrow) == noone) {
	arrow = instance_create_layer(1.5 * (_card_sprite_width * 0.8) + 384/2, 180 + (sprite_get_height(spr_Cards) * 0.45), "Instances", obj_PointerArrow, {image_angle: 180});
	arrow.image_angle = 180;
	fifth_text = layer_sprite_create("Assets_1", (4.5) * (_card_sprite_width * 0.8) + 384/2, 150 + (sprite_get_height(spr_Cards) * 0.45), spr_TutText5);
	sixth_text = layer_sprite_create("Assets_1", (4.5) * (_card_sprite_width * 0.8) + 384/2, 215 + (sprite_get_height(spr_Cards) * 0.45), spr_TutText6);
}
view_enabled = true;
//view_visible[0] = true;
view_visible[1] = true;

if (!global.base_card_exists) {
	alarm[1] = 1;
} else {
	layer_sprite_destroy(fifth_text);
	layer_sprite_destroy(sixth_text);
	instance_destroy(arrow);
	view_visible[1] = false;
	view_visible[0] = true;
	op1.alarm[0] = 100;
}