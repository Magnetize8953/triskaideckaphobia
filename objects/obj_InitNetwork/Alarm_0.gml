// flip hands for all other players
with (obj_Card) {
    if (object_index != obj_PotCard and self.associated_player.num != global.id_on_server) {
        self.image_index = 0;
        self.face_down = true;
    }
}