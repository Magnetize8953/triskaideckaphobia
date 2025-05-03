draw_self();

if (!playable) {
    shader_set(shdr_GreyScale);
    draw_self();
    shader_reset();
}