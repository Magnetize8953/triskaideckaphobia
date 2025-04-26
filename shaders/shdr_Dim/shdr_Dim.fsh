varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float depth;

void main()
{
    vec4 texColour = texture2D( gm_BaseTexture, v_vTexcoord );
    float shadeGrey = 0.33 - (0.1 / depth);
    float grey = dot(texColour.rgb, vec3(shadeGrey, shadeGrey, shadeGrey));
    gl_FragColor = vec4(grey, grey, grey, texColour.a);
}