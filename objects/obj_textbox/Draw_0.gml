/// obj_textbox – Draw
// box
draw_set_color(c_white);
draw_rectangle(x, y, x + 200, y + 30, false);

// typed text
draw_set_color(c_black);
draw_text(x + 5, y + 15, text_input);

// blinking cursor
if (floor(current_time/500) mod 2 == 0) {
    var cx = x + 5 + string_width(text_input);
    draw_text(cx, y + 15, "|");
}

/* show feedback if we’re waiting on the server
if (awaiting_response) {
    draw_set_color(c_orange);
    draw_text(x, y + 50, "verifying...");
}
*/

if(global.not_key){
	draw_set_color(c_red);
    draw_text(x, y + 50, "incorrect key");
}
