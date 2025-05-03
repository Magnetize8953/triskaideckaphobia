if (text == "win_screen") {
    text = "Player " + string(global.winner) + " has won the game :D"
}

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text_transformed_color(x, y, text, 0.5, 0.5, 0, text_colour, text_colour, text_colour, text_colour, 1);