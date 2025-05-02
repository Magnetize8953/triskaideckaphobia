// clean up resources
// used ChatGPT to figure out i needed a destroy event for
// freeing surface_create() for no RAM leak, and same for ds_grid_create()
if surface_exists(bg_surface) surface_free(bg_surface)
ds_grid_destroy(noise_old)
ds_grid_destroy(noise_new)
