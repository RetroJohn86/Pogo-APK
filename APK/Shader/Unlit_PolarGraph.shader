//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/PolarGraph" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_MainColor ("Color", Color) = (1,1,1,1)
_RingColor ("RingColor", Color) = (0,0,0,1)
_CircleCenter ("Circle Center Position", Vector) = (0,0,0,0)
_RingInterval ("Interval", Float) = 0.1
_OneOverRingWidth ("RingWidth", Float) = 100
_NotchInterval ("RingCrossInterval", Float) = 0.1
_OneOverNotchWidth ("NotchWidth", Float) = 100
_OneOverNotchLength ("NotchLength", Float) = 20
_NotchColor ("NotchColor", Color) = (1,0,0,1)
_SecondaryRingAlpha ("Secondary Ring Alpha", Float) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 35517
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
    u_xlatb6 = u_xlat6<(-u_xlat6);
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _CircleCenter;
uniform 	float _RingInterval;
uniform 	float _OneOverRingWidth;
uniform 	float _NotchInterval;
uniform 	float _OneOverNotchWidth;
uniform 	float _OneOverNotchLength;
uniform 	float _SecondaryRingAlpha;
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _RingColor;
uniform 	mediump vec4 _NotchColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
float u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.yx + (-_CircleCenter.yx);
    u_xlat4.x = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = float(1.0) / u_xlat4.x;
    u_xlat6 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat4.x = u_xlat4.x * u_xlat6;
    u_xlat6 = u_xlat4.x * u_xlat4.x;
    u_xlat1.x = u_xlat6 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat6 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat6 * u_xlat1.x + -0.330299497;
    u_xlat6 = u_xlat6 * u_xlat1.x + 0.999866009;
    u_xlat1.x = u_xlat6 * u_xlat4.x;
    u_xlat1.x = u_xlat1.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb3 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1.x = u_xlatb3 ? u_xlat1.x : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat6 + u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.y<(-u_xlat0.y));
#else
    u_xlatb6 = u_xlat0.y<(-u_xlat0.y);
#endif
    u_xlat6 = u_xlatb6 ? -3.14159274 : float(0.0);
    u_xlat4.x = u_xlat6 + u_xlat4.x;
    u_xlat6 = min(u_xlat0.y, u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6<(-u_xlat6));
#else
    u_xlatb6 = u_xlat6<(-u_xlat6);
#endif
    u_xlat1.x = max(u_xlat0.y, u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = _RingInterval * 0.5 + u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat1.x>=(-u_xlat1.x));
#else
    u_xlatb2 = u_xlat1.x>=(-u_xlat1.x);
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb6;
    u_xlat2.x = (u_xlatb2) ? (-u_xlat4.x) : u_xlat4.x;
    u_xlat2.x = u_xlat2.x + 3.14159274;
    u_xlat4.x = u_xlat0.x / _RingInterval;
    u_xlat0.w = floor(u_xlat4.x);
    u_xlat1.x = u_xlat0.w + 1.0;
    u_xlat1.x = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _NotchInterval / u_xlat1.x;
    u_xlat2.x = u_xlat1.x * 0.5 + u_xlat2.x;
    u_xlat2.x = u_xlat2.x / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat2.x>=(-u_xlat2.x));
#else
    u_xlatb3 = u_xlat2.x>=(-u_xlat2.x);
#endif
    u_xlat2.x = fract(abs(u_xlat2.x));
    u_xlat2.x = (u_xlatb3) ? u_xlat2.x : (-u_xlat2.x);
    u_xlat3 = u_xlat1.x * 0.5;
    u_xlat2.x = u_xlat2.x * u_xlat1.x + (-u_xlat3);
    u_xlat0.x = u_xlat0.x * u_xlat2.x;
    u_xlat0.x = u_xlat0.x * _OneOverNotchWidth;
    u_xlat0.x = (-u_xlat0.x) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat4.x>=(-u_xlat4.x));
#else
    u_xlatb2 = u_xlat4.x>=(-u_xlat4.x);
#endif
    u_xlat4.x = fract(abs(u_xlat4.x));
    u_xlat2.x = (u_xlatb2) ? u_xlat4.x : (-u_xlat4.x);
    u_xlat4.x = _RingInterval * 0.5;
    u_xlat2.x = u_xlat2.x * _RingInterval + (-u_xlat4.x);
    u_xlat4.x = u_xlat2.x * _OneOverNotchLength;
    u_xlat2.x = u_xlat2.x * _OneOverRingWidth;
    u_xlat0.y = (-u_xlat2.x) * u_xlat2.x + 1.0;
    u_xlat0.z = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
    u_xlat4.xy = u_xlat0.zw * vec2(1.00000003e+16, 0.5);
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.x = u_xlat4.x * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4.y>=(-u_xlat4.y));
#else
    u_xlatb4 = u_xlat4.y>=(-u_xlat4.y);
#endif
    u_xlat6 = fract(abs(u_xlat4.y));
    u_xlat4.x = (u_xlatb4) ? u_xlat6 : (-u_xlat6);
    u_xlat6 = _SecondaryRingAlpha + 1.0;
    u_xlat4.x = (-u_xlat4.x) * 2.0 + u_xlat6;
    u_xlat4.x = min(u_xlat4.x, 1.0);
    u_xlat0.xy = u_xlat4.xx * u_xlat0.xy;
    u_xlat2.x = u_xlat0.y * _RingColor.w;
    u_xlat0.x = u_xlat0.x * _NotchColor.w;
    u_xlat1.xyz = (-_MainColor.xyz) + _RingColor.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat1.xyz + _MainColor.xyz;
    u_xlat1.xyz = (-u_xlat2.xyz) + _NotchColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _MainColor.w;
    return;
}

#endif
"
}
}
}
}
}