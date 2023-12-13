shader_type canvas_item;

uniform sampler2D maskTexture;
uniform bool isReverted = true;
uniform float textureScale = 1;
uniform float defaultOpacity = 1;
uniform vec2 dimensions = vec2(1, 1);

vec2 scale(vec2 uv, float x, float y) {
	mat2 scale = mat2(vec2(x, 0.0), vec2(0.0, y));
	
	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;
	return uv;
}

void fragment() {
	float yDimensions = textureScale * dimensions.y / dimensions.x;
	vec2 scaledUV = scale(UV, textureScale, yDimensions);
	vec4 textureColor = texture(maskTexture, scaledUV);
	vec4 colour = COLOR;
	colour.a = (isReverted ? (1.0 - textureColor.a) : textureColor.a) * defaultOpacity;
	COLOR = colour;
}
