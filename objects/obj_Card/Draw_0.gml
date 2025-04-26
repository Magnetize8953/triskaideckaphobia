if ((global.building_honest_hand and 
    global.current_turn == self.associated_player.num and 
    !(self.x == room_width / 2 and self.y == room_height / 2) and
    ((ds_stack_size(global.staging_cards) == 0 and validate_stack(self.card_id, global.supposed_top)) or 
    (ds_stack_size(global.staging_cards) != 0 and validate_stack(self.card_id, ds_stack_top(global.staging_cards).card_id)))) or 
    (global.building_bluffed_hand) or 
    (self.x == room_width / 2 and self.y == room_height / 2) or
    (face_down)) {
        draw_self();
} else {
    shader_set(shdr_GreyScale);
    draw_self();
    shader_reset();
}

if ((self.x == room_width / 2 and self.y == room_height / 2) and
    (global.supposed_top != self.card_id)) {
    shader_set(shdr_Dim);
    shader_set_uniform_f(shader_depth, ds_list_find_index(global.pile, self));
    draw_self();
    shader_reset();
}