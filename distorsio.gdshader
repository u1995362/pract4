shader_type canvas_item;

uniform float strength : hint_range(0.0, 1.0) = 0.1; // 0 = sin efecto, 1 = máximo aplastamiento

void fragment() {
    vec2 uv = UV;

    // Convertir el UV.x de [0,1] a [-1,1]
    float offset = (uv.x - 0.5) * 2.0;

    // Escala que se reduce en los extremos y es 1 en el centro
    float scale = 1.0 - strength * (offset * offset);

    // Recentrar el UV con esa escala para que no se deforme hacia un lado
    uv.x = 0.5 + (uv.x - 0.5) / scale;

    // Evitar artefactos si se sale del rango
    if (uv.x < 0.0 || uv.x > 1.0) {
        discard;
    } else {
        COLOR = texture(TEXTURE, uv);
    }
}
