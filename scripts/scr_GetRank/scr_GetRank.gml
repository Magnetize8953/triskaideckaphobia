function get_rank(card){
    if card % 13 == 0 {
        return 13;
    } else {
        return card % 13;
    }
}
