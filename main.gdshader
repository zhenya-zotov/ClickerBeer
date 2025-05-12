shader_type canvas_item;

uniform float glow_time;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

	// Эффект пульсации
	float glow = sin(glow_time * 4.0 + UV.y * 15.0) * 0.05;

	COLOR = tex + vec4(glow, glow, glow, 0.0);
}
