shader_type canvas_item;
render_mode blend_disabled, unshaded;

uniform vec4 alive = vec4(0,0,0,1);
uniform vec4 dead = vec4(1,1,1,1);

vec4 conway_rule(vec4 center, float count) {
	if (center == alive)
		if (count < 2.0 || count > 3.0)
		 	return dead;
	if (center == dead)
		if (count == 3.0)
			return alive;
}

void fragment(){
	// neighbour colour, get red component
	vec4 tl = texture(TEXTURE, UV + vec2(-1, -1) * TEXTURE_PIXEL_SIZE);
	vec4 cl = texture(TEXTURE, UV + vec2(-1,  0) * TEXTURE_PIXEL_SIZE);
	vec4 bl = texture(TEXTURE, UV + vec2(-1,  1) * TEXTURE_PIXEL_SIZE);

	vec4 tc = texture(TEXTURE, UV + vec2( 0, -1) * TEXTURE_PIXEL_SIZE);
	vec4 cc = texture(TEXTURE, UV + vec2( 0,  0) * TEXTURE_PIXEL_SIZE);
	vec4 bc = texture(TEXTURE, UV + vec2( 0,  1) * TEXTURE_PIXEL_SIZE);

	vec4 cr = texture(TEXTURE, UV + vec2( 1, -1) * TEXTURE_PIXEL_SIZE);
	vec4 br = texture(TEXTURE, UV + vec2( 1,  0) * TEXTURE_PIXEL_SIZE);
	vec4 tr = texture(TEXTURE, UV + vec2( 1,  1) * TEXTURE_PIXEL_SIZE);
	//// implement rule
	float count = (tl.x + cl.x + bl.x + tc.x + bc.x + tr.x + cr.x + br.x);
	vec4 newstate = conway_rule(cc, count);
	COLOR = newstate;
}