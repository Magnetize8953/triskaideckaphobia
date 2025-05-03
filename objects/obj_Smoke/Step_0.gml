// advance interpolation
// step event animation was skeletoned from ChatGPT
t += 1 / anim_interval  

// once we reach or exceed 1, wrap and produce a new pattern
if t >= 1 {
    t -= 1  
    ds_grid_copy(noise_old, noise_new)            // shift new→old
    scr_generate_noise(noise_new, grid_w, grid_h, 4, 4)  // fresh noise
}
