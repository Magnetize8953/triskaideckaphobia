function comp_card(card1, card2){
	card1rank = get_rank(card1);
	card2rank = get_rank(card2);
	if (card1rank == 1 and card2rank == 13) {
		return card1;
	} else if (card2rank == 1 and card1rank == 13) {
		return card2;
	} else if card1 > card2 {
        return card1;
    } else if card2 > card1 {
        return card2;
	} else {
        return -1;
    }
}
