//y = sin((current_time/1000) * pi) * 11 + 256;

layer_sprite_x(logo, sin((current_time/1000) * pi/3) * 11 + (room_width/2) + 10);
layer_sprite_y(logo, sin((current_time/1000) * pi/1.5) * 11 + 256);