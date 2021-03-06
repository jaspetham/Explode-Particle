uniform float time;
uniform float move;
uniform float mousePressed;
uniform vec2 mouse;
uniform float transition;

varying vec2 vCoordinates;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vPosition;


attribute vec2 aCoordinates;
attribute float aSpeed;
attribute float aOffset;
attribute float aDirection;
attribute float aPress;

float PI=3.141592653589793238;
void main(){
    vUv=uv;
    vCoordinates = aCoordinates.xy;

    // not stable
    vec3 pos=position;
    pos.x += sin(move * aSpeed) * 3.;
    pos.y += sin(move * aSpeed) * 3.;
    pos.z = mod(position.z + move * 200. * aSpeed + aOffset,2000.) - 1000.;

    // stable
    vec3 stable=position;
    float dist = distance(stable.xy, mouse);
    float area = 1. - smoothstep(0.,500.,dist);
    stable.x += 50.*sin(0.1*time * aPress)*aDirection * area * mousePressed;
    stable.y += 50.*sin(0.1*time * aPress)*aDirection * area * mousePressed;
    stable.z += 200.*cos(0.1*time * aPress)*aDirection * area * mousePressed;

    pos = mix(pos,stable,transition);

    vec4 mvPosition=modelViewMatrix*vec4(pos,1.);
    gl_PointSize=4000.*(1./-mvPosition.z);
    gl_Position=projectionMatrix*mvPosition;
    vPos = pos;
}