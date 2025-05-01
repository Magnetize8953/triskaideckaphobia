if (!ds_list_find_value(added_cards, ds_list_size(added_cards) - 1).flipping) {
    // TODO: clean up, move to script probably
    // stolen from obj_BluffNumberPrompter
    
    show_debug_message("new supposed top: " + string(global.supposed_top));
    show_debug_message("supposed rank: " + string(get_rank(global.supposed_top)));
    // NOW move the cards over
    // moved staged stack to pile
    for (var i = 0; i < staging_size; i++) {
        var next_card = ds_stack_pop(staging_reversed);
        next_card.new_x = room_width / 2;
        next_card.new_y = room_height / 2;
        next_card.move_speed = 19 + 1 / (i - staging_size);
        next_card.move_wait = i;
        next_card.alarm[3] = 1;
        
        next_card.image_xscale = global.stack_scale;
        next_card.image_yscale = global.stack_scale;
        
        randomize();
        next_card.new_angle = random_range(0, 180);
        next_card.depth = -1 + -ds_list_size(global.pile);
        
        ds_list_add(global.last_played_hand, next_card); // add to global last hand tracker
        global.which_last_hand = "bluff";
        
        ds_list_add(global.pile, next_card);
    }
    
    // update the displayed last played hand (needs bluff functionality added)
    update_last_hand_string(hand_message);
} else {
    alarm[1] = 5;
}