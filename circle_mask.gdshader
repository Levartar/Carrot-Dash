shader_type canvas_item;

uniform vec2 center = vec2(0.3, 0.5); // normalized (0-1)
uniform float radius : hint_range(0.0, 1.0); // 0 = hidden, 1 = full
uniform float softness : hint_range(0.0, 0.5) = 0.05;
uniform vec4 mask_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec2 uv = SCREEN_UV;
	float aspect = float(SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x);
    vec2 adjusted_uv = vec2((uv.x - center.x) * aspect, uv.y - center.y);
    float dist = length(adjusted_uv);
    float circle = smoothstep(radius - softness, radius, dist);
    COLOR = mask_color;
    COLOR.a *= circle;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
