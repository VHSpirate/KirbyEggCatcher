shader_type canvas_item;

uniform float progress = 0.0; // Progress from 0.0 to 8.0

void fragment() {
    float segmentWidth = 1.0 / 8.0;  
    int currentSegment = int(progress); 

    if (UV.x < (float(currentSegment) + 1.0) * segmentWidth) {
        COLOR = texture(TEXTURE, UV);
    } else {
        discard;
    }
}
