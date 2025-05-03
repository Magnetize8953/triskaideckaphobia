if (!surface_exists(bg_surface)) {
    bg_surface = surface_create(room_width, room_height);
}

/// draw onto the offscreen surface, clearing to fully transparent
surface_set_target(bg_surface);
draw_clear_alpha(c_black, 0);

var cw       = room_width  / grid_w;
var ch       = room_height / grid_h;
var contrast = 3;
var threshold = 0.4;        // only draw the brighter 60% of noise

for (var yy = 0; yy < grid_h; yy++) {
    for (var xx = 0; xx < grid_w; xx++) {
        // blend old/new noise
        var v0 = ds_grid_get(noise_old, xx, yy);
        var v1 = ds_grid_get(noise_new, xx, yy);
        var v  = lerp(v0, v1, t);
        // contrast curve
        v = clamp((v - 0.5) * contrast + 0.5, 0, 1);

        // skip the low‑intensity bits
        if (v <= threshold) continue;

        // map noise to alpha (0..smoke_opacity)
        var a = v * smoke_opacity;
        draw_set_alpha(a);
        draw_set_color(c_white);
        draw_rectangle(
            xx * cw, yy * ch,
            (xx + 1) * cw, (yy + 1) * ch,
            false
        );
    }
}

// restore defaults
draw_set_alpha(1);
surface_reset_target();

// finally blit to screen
draw_surface(bg_surface, 0, 0);