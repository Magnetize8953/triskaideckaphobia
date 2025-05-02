show_debug_message("hand sizes: " + string(global.player1.hand_size) + " " + string(global.player2.hand_size) + " " + string(global.player3.hand_size));
// server is source of truth for deciding who's won
if ((global.player1.hand_size == 0) or (global.player2.hand_size == 0) or (global.player3.hand_size == 0)) {
    
    show_debug_message("someone won");
    
    // determine which player won the round only once to avoid possible race conditiony weirdness
    if (global.player1.hand_size == 0) {
        prev_round_winner = 1;
    } else if (global.player2.hand_size == 0) {
        prev_round_winner = 2;
    } else if (global.player3.hand_size == 0) {
        prev_round_winner = 3;
    }
    
    if (prev_round_winner == 1) {
        global.player1.points += 1;
    } else if (prev_round_winner == 2) {
        global.player2.points += 1;
    } else if (prev_round_winner == 3) {
        global.player3.points += 1;
    }
    
    center_stack_reset();
    flip_pot();
    base_selecting();
    obj_Game.shuffling = true;
    obj_Game.alarm[0] = 5;
    alarm[2] = 30;
    
}