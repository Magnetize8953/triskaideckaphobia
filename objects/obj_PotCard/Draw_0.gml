draw_self();

if ((ds_list_size(global.pile) > 1) and !(face_down)) {
    shader_set(shdr_Dim);
    shader_set_uniform_f(shader_depth, 1.0);
    draw_self();
    shader_reset();
}