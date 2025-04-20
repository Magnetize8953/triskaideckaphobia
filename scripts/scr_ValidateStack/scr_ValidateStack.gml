function validate_stack(card1, card2) {
	if (get_rank(card1) == get_rank(card2) + 1) { 
		// if card 1's rank is directly above card 2's
		return true;
	} else if ((get_rank(card1) == 1) and (get_rank(card2) == 2)) {
		// if card 1 is an ace and card 2 is a king
		return true;
	} else if ((get_rank(card1) == get_rank(card2)) and (card1 > card2)) {
		// if card 1 and card 2 are the same rank, but card 1 is a higher suit
		return true;
	} else {
		return false;
	}
}