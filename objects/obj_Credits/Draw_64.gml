draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var room_center = x + (room_width / 2);
var spacing = 2;

// title
draw_text_transformed_color(room_center, y + (font_get_size(fnt_Menu) / 2 - pos), "Credits", 1.75, 1.75, 0, c_white, c_white, c_white, c_white, 1);


// devs
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Kialey", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Andy", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Devdan", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Ukiah", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_transformed_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "ChatGPT", 0.8, 0.8, 0, c_white, c_white, c_white, c_white, 1);
spacing += 2;


// audio
draw_text_transformed_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Audio", 1.5, 1.5, 0, c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_transformed_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Music", 1.25, 1.25, 0, c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Kevin MacLeod; One Sly Move", c_white, c_white, c_white, c_white, 1);
spacing += 2;


// art
draw_text_transformed_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Art", 1.5, 1.5, 0, c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "AJFU, Wikimedia Commons; Bonnie Springs slot machine", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Dominic Dobrzensky, Wikimedia Commons; Markiplier in 2015", c_white, c_white, c_white, c_white, 1);
spacing += 2;


// development
draw_text_transformed_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Development", 1.5, 1.5, 0, c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "u/zK4rim on r/gamemaker; Background Noise", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Khronos Group; GLSL Documentation", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "GameMaker Community; GameMaker Forums", c_white, c_white, c_white, c_white, 1);
spacing += 1;
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "YoYo Games; GameMaker Documentation", c_white, c_white, c_white, c_white, 1);
spacing += 3;


// further creditation
draw_text_color(room_center, y + ((font_get_size(fnt_Menu) + 50) * spacing - pos), "Detailed Credits in README", c_white, c_white, c_white, c_white, 1);