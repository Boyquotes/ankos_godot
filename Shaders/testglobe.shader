shader_type canvas_item;

// black opaque
uniform vec4 alive = vec4(0,0,0,1);
// white opaque
uniform vec4 dead = vec4(1,1,1,1);

void fragment() {
    COLOR = vec4(UV.x, UV.y, 0.5, 1.0);
}
