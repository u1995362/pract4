shader_type canvas_item;

uniform float ScreenWidth;
uniform float RealScreenWidth;

void fragment() {
    vec2 uv = vec2(VERTEX.x, VERTEX.y);
	float R1 = 8.0/ScreenWidth;
	float R2 = 80.0/ScreenWidth;
    if (uv.x < RealScreenWidth*R1 || uv.x > RealScreenWidth*R2) {
        discard;
    }
}