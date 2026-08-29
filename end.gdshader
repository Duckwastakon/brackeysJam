shader_type canvas_item;

uniform vec4 color_a : source_color = vec4(0.15, 0.15, 0.15, 1.0);
uniform vec4 color_b : source_color = vec4(0.25, 0.25, 0.25, 1.0);
uniform float stripe_width : hint_range(0.01, 0.5) = 0.1;
uniform float custom_time = 0.0;
uniform float angle : hint_range(0.0, 6.283) = 0.785;

void fragment() {
	vec2 uv = UV;
	float s = sin(angle);
	float c = cos(angle);
	float diagonal = uv.x * c - uv.y * s;
	diagonal += custom_time;
	
	float stripe = mod(diagonal, stripe_width * 2.0);
	COLOR = (stripe < stripe_width) ? color_a : color_b;
}