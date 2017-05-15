#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;


#define PI2 6.283184
#define CV 0.01
#define ST 0.25

vec4 colorat(vec2 uv) {
	return texture2D(texture, uv);
}

vec4 blur(vec2 uv) {
	vec4 col = vec4(0.0);
	for(float r0 = 0.0; r0 < 1.0; r0 += ST) {
		float r = r0 * CV;
		for(float a0 = 0.0; a0 < 1.0; a0 += ST) {
			float a = a0 * PI2;
			col += colorat(uv + vec2(cos(a), sin(a)) * r);
		}
	}
	col *= ST * ST;
	return col;
}

void main() {
	vec2 uv = vertTexCoord.xy;
	gl_FragColor = blur(uv);
}
