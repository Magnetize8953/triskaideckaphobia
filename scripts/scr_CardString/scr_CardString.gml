function card_string(card) {
	// Stringify rank
	return_string = "";
	if (get_rank(card) == 1) {
		return_string = "Ace of ";
	} else if (get_rank(card) == 11) {
		return_string = "Jack of ";
	} else if (get_rank(card) == 12) {
		return_string = "Queen of ";
	} else if (get_rank(card) == 13) {
		return_string = "King of ";
	} else {
		return_string = string(get_rank(card)) + " of ";
	}
	
	// Stringify suit
	if (card <= 13 ){
		return_string += "Cool S's";
	}
	else if (card <= 26) {
		return_string += "Fleur-de-Lis's";
	}
	else if (card <= 39) {
		return_string += "Eyes";
	}
	else {
		return_string += "Stratos";
	}
	
	return return_string;
}