shader_type canvas_item;
render_mode blend_disabled, unshaded;

// black opaque
uniform vec4 alive = vec4(0,0,0,1);
// black transparent
uniform vec4 dead = vec4(0,0,0,0);

vec4 conway_rule(vec4 center, float count) {
	if (center == alive && count < 2.) return dead;
	if (center == alive && count > 3.) return dead;
	if (center == dead && count == 3.) return alive;
	return center;
}

vec2 wrap_coords(vec2 coords) {
	if (coords[0] < 0.) coords[0] = 1.;
	if (coords[0] > 1.) coords[0] = 0.;
	if (coords[1] < 0.) coords[1] = 1.;
	if (coords[1] > 1.) coords[1] = 0.;
	return coords;
}

void fragment(){
	// coordinates
	vec2 ul = wrap_coords(UV + vec2(-1, -1) * TEXTURE_PIXEL_SIZE);
	vec2 cl = wrap_coords(UV + vec2(-1,  0) * TEXTURE_PIXEL_SIZE);
	vec2 dl = wrap_coords(UV + vec2(-1,  1) * TEXTURE_PIXEL_SIZE);

	vec2 uc = wrap_coords(UV + vec2( 0, -1) * TEXTURE_PIXEL_SIZE);
	vec2 cc = wrap_coords(UV + vec2( 0,  0) * TEXTURE_PIXEL_SIZE);
	vec2 dc = wrap_coords(UV + vec2( 0,  1) * TEXTURE_PIXEL_SIZE);

	vec2 cr = wrap_coords(UV + vec2( 1, -1) * TEXTURE_PIXEL_SIZE);
	vec2 dr = wrap_coords(UV + vec2( 1,  0) * TEXTURE_PIXEL_SIZE);
	vec2 ur = wrap_coords(UV + vec2( 1,  1) * TEXTURE_PIXEL_SIZE);
	// cells 
	vec4 ul_c = texture(TEXTURE, ul);
	vec4 cl_c = texture(TEXTURE, cl);
	vec4 dl_c = texture(TEXTURE, dl);

	vec4 uc_c = texture(TEXTURE, uc);
	vec4 cc_c = texture(TEXTURE, cc);
	vec4 dc_c = texture(TEXTURE, dc);

	vec4 cr_c = texture(TEXTURE, cr);
	vec4 dr_c = texture(TEXTURE, dr);
	vec4 ur_c = texture(TEXTURE, ur);
	//// implement rule
	float count = (ul_c.a + cl_c.a + dl_c.a + uc_c.a + dc_c.a + ur_c.a + cr_c.a + dr_c.a);
	vec4 newstate = conway_rule(cc_c, count);
	COLOR = newstate;
}