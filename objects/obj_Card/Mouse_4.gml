show_debug_message("rank: " + string(get_rank(self.card_id)));
show_debug_message("card id itself: " + string(self.card_id));

if (instance_exists(obj_Tutorial)) {
	with (obj_Tutorial) {
		if (need3 and other.card_id == 3) {
			other.y -= 15;
			need3 = false;
			eleven_twelve = false;
			arrow.x = 2.5 * (_card_sprite_width);
			ds_stack_push(collected_cards, other);
		} else if (need4_1 and other.card_id == 4) {
			other.y -=15;
			need4_1 = false;
			thir_four = false;
			arrow.x = 5.5 * (_card_sprite_width);
			ds_stack_push(collected_cards, other);
		} else if (need4_2 and other.card_id == 17) {
			layer_sprite_destroy(eleventh_text);
			layer_sprite_destroy(twelth_text);
			layer_sprite_alpha(eleventh_text, 0);
			layer_sprite_alpha(twelth_text, 0);
			instance_create_layer(0,0,"Instances", obj_TextDestroyer, {t1:eleventh_text, t2: twelth_text});
			other.y -= 15;
			need4_2 = false;
			fif_six = false;
			arrow.x = 11.5 * (_card_sprite_width);
			ds_stack_push(collected_cards, other);
		} else if (need5 and other.card_id == 44) {
			other.y -= 15;
			need5 = false;
			arrow.x = room_width * 2; // move off-screen to destroy later
			ds_stack_push(collected_cards, other);
			instance_create_layer(room_width / 2, 1080 * (565/768), "Instances", obj_TutPlayButton, {passed_cards: collected_cards});
		}
		
		else if (needA and other.card_id == 27) {
			 other.y -= 15;
			 needA = false;
			 ds_stack_push(collected_cards, other);
			 instance_destroy(second_arrow);
		} else if (need9 and other.card_id == 9) {
			other.y -= 15;
			need9 = false;
			ds_stack_push(collected_cards, other);
			instance_destroy(first_arrow);
		} else if (need10 and other.card_id == 36) {
			other.y -= 15;
			need10 = false;
			ds_stack_push(collected_cards, other);
			instance_destroy(third_arrow);
		}
	}
}

// If an honest hand is being built and it's my turn (and also im not in the center)
if (global.building_honest_hand and global.current_turn == self.associated_player.num and !(self.x == room_width / 2 and self.y == room_height / 2)) {
	// If there is no cards currently being queued, and the selected one can be played on the top of the stack
	if (ds_stack_size(global.staging_cards) == 0 and validate_stack(self.card_id, global.supposed_top)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	// If this next selected card is a valid play
	} else if (ds_stack_size(global.staging_cards) != 0 and validate_stack(self.card_id, ds_stack_top(global.staging_cards).card_id)) {
		ds_stack_push(global.staging_cards, self);
		self.y -= 15; // TODO: MAKE SIGNIFYING SELECTED CARDS BETTER
	} else if (ds_stack_top(global.staging_cards) == self) {
		ds_stack_pop(global.staging_cards);
		self.y += 15;
	}
}

else if (global.building_bluffed_hand and global.current_turn == self.associated_player.num and !(self.x == room_width / 2 and self.y == room_height / 2)) {
	var button = instance_nearest(self.x, self.y, obj_PlayButton);
	// If i am the most recently staged card, deselect me
	if (ds_stack_top(global.staging_cards) == self) {
		ds_stack_pop(global.staging_cards);
		self.y += 15;
		// Delete from the button's log of cards
		ds_list_delete(button.added_cards, ds_list_find_index(button.added_cards , self));
	// otherwise, select me if I'm not already selected
	} else if (ds_list_find_index(button.added_cards, self) == -1){
		
		ds_stack_push(global.staging_cards, self);
		ds_list_add(button.added_cards, self);
		self.y -= 15;
	} 
} else {
    show_debug_message("That shouldn't have happened");
}
