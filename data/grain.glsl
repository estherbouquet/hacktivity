#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float t=0.0;
uniform bool style=true;

void main()
{
	vec2 uv = vertTexCoord.xy;

    vec4 color = texture2D(texture, uv);

    float strength = 16.0;

    float x = (uv.x + 4.0 ) * (uv.y + 4.0 ) * (t * 10.0);
	vec4 grain = vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01)-0.005) * strength;

	
    if(style == true)
    {
    	grain = 1.0 - grain;
		gl_FragColor = color * grain;
    }
    else
    {
		gl_FragColor = color + grain;
    }
}
