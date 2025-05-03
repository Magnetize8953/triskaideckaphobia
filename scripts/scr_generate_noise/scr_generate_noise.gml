/// destination : pre-created ds_grid (size w×h) to hold the noise
/// w, h       : grid width and height
/// samples    : disk-radius for local averaging (default 4)
/// smoothing  : number of blur passes (default 4)
// this largely was skeletoned from this reddit post: 
// https://www.reddit.com/r/gamemaker/comments/1k4599e/i_accidentally_recreated_perlin_noise_with_just/
function scr_generate_noise(destination, w, h, samples = 4, smoothing = 4) {
    // create a temporary grid to build noise
    var grid = ds_grid_create(w, h);
    
    // fill grid with random values between 0 and 1
    for (var yy = 0; yy < h; yy++) {
        for (var xx = 0; xx < w; xx++) {
            ds_grid_set(grid, xx, yy, random_range(0, 1));
        }
    }

    // perform smoothing passes to blur the noise
    for (var pass = 0; pass < smoothing; pass++) {
        for (yy = 0; yy < h; yy++) {
            for (xx = 0; xx < w; xx++) {
                // average nearby values in a disk of radius 'samples'
                var avg = ds_grid_get_disk_mean(grid, xx, yy, samples);
                ds_grid_set(grid, xx, yy, avg);
            }
        }
    }

    // copy the completed noise into the destination grid
    ds_grid_copy(destination, grid);
    // clean up the temporary grid to avoid memory leaks
    ds_grid_destroy(grid);
}
