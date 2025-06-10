shader_type canvas_item;

uniform float ScreenWidth;
uniform float RealScreenWidth;

uniform int num_colors = 5;
uniform sampler2D palette_in;
uniform sampler2D palette_out;

uniform float precision = 0.01;

void fragment() {
	vec2 uv = vec2(VERTEX.x, VERTEX.y);
	float R1 = 8.0/ScreenWidth;
	float R2 = 80.0/ScreenWidth;
    if (uv.x < RealScreenWidth*R1 || uv.x > RealScreenWidth*R2) {
        discard;
    }

    vec4 tex_color = texture(TEXTURE, UV);
    vec4 final_color = tex_color;

    for (int i = 0; i < num_colors; i++) {
        float index = float(i) / float(num_colors);
        vec4 in_color = texture(palette_in, vec2(index+0.1, 0.5));

        if (distance(tex_color.rgb, in_color.rgb) < precision) {
            vec4 out_color = texture(palette_out, vec2(index+0.1, 0.5));
            final_color = vec4(out_color.rgb, tex_color.a);
            break;
        }
    }

    COLOR = final_color;
}
