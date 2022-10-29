shader_type canvas_item;
render_mode blend_disabled, unshaded;

vec2 wrap_coords(vec2 coords) {
	if (coords[0] < 0.) coords[0] = 1.;
	if (coords[0] > 1.) coords[0] = 0.;
	if (coords[1] < 0.) coords[0] = 1.;
	if (coords[1] > 1.) coords[1] = 0.;
	return coords;
}

void fragment(){
	vec2 cc = UV + vec2(0., 0.) * TEXTURE_PIXEL_SIZE;
	vec2 uc = UV + vec2(-1., 0.) * TEXTURE_PIXEL_SIZE;
	vec4 here = texture(TEXTURE, cc);
	vec2 ucwrap = wrap_coords(uc);
	vec4 upcenter = texture(TEXTURE, ucwrap);
	COLOR = upcenter;
	COLOR;
}