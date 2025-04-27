// resetting the pot
for (var i = 0; i < ds_list_size(global.pot_cards); i++) {
    instance_destroy(ds_list_find_value(global.pot_cards, i));
}
ds_list_clear(global.pot_cards);

for (var i = 0; i < 13; i++) {
    _card = ds_list_find_value(global.pot, i); // an integer corresponding to the card id
    _card_sprite_width = sprite_get_width(spr_Cards) * 0.25;
    _y_position = 0 + (sprite_get_height(spr_Cards) * 0.45);
    _x_position = (i+1.5) * (_card_sprite_width * 0.8) + 384/2;
    ds_list_add(global.pot_cards, instance_create_layer(_x_position, _y_position, "Instances", obj_PotCard, { card_id: _card , rotation: 0, scale: 0.27}));
}

global.card_being_selected = false;

global.pot_moving = false;
global.pot_visible = true;