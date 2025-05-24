shader_type canvas_item;

uniform sampler2D noise_tex;

uniform vec2 scroll =  vec2(0.5,0.5);
uniform vec2 noiseScale = vec2(10.0,10.0);
uniform sampler2D TONE_MAPPING;
uniform float blur: hint_range(0,7) = 3.0;
uniform float fire_amount : hint_range(0,1) = 0.5;

void fragment( )
{
	vec4 pixelColor = texture(TEXTURE,UV);
	vec2 shifted_uv = UV+vec2(0.01, 0.0);
	float pixelAlpha = textureLod(TEXTURE,shifted_uv,blur).a;
	float noiseAlpha = textureLod(noise_tex,shifted_uv,blur).a;
	
	//vec2 noise_uv = UV * noiseScale+TIME*scroll;
	float pattern_intensity = texture(noise_tex,UV).r;
	float intensity = noiseAlpha*pattern_intensity;
	
	vec4 fireColor = texture(TONE_MAPPING, vec2(intensity));
	
	COLOR = fireColor;
	COLOR.a *= pixelAlpha;
}