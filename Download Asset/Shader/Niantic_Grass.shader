//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Grass" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_AmbientStrength ("Ambient Strength", Range(0, 1)) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 41247
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.w = u_xlat10_0.w;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    SV_Target0.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat10_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat10_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat10_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat10_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat10_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat16_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindData;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
vec4 u_xlat5;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyxy;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xyxy * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xyxy * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xyxy * in_POSITION0.wwww + u_xlat0;
    u_xlat1.x = _WindData.z + 0.5;
    u_xlat1 = u_xlat1.xxxx * _Time.xyyx;
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat1;
    u_xlat1 = trunc(u_xlat0);
    u_xlat0 = u_xlat0 + (-u_xlat1);
    u_xlat2.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat2.z = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat2.xy = sin(u_xlat2.xz);
    u_xlat2.xy = u_xlat2.xy * vec2(43758.5469, 43758.5469);
    u_xlat2.xy = fract(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat0.xy);
    u_xlat3.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat3.z = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat3.xz);
    u_xlat3.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.zw);
    u_xlat3 = u_xlat1.xyxy + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.xyxy + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.x = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.y = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3 = u_xlat1.zwzw + vec4(1.0, 0.0, 1.0, 1.0);
    u_xlat1 = u_xlat1 + vec4(0.0, 1.0, 0.0, 1.0);
    u_xlat4.x = dot(u_xlat3.xy, vec2(127.099998, 269.5));
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat3.x = dot(u_xlat3.xy, vec2(311.700012, 183.300003));
    u_xlat4.y = sin(u_xlat3.x);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4 = u_xlat0.zwzw + vec4(-1.0, -0.0, -1.0, -1.0);
    u_xlat5.z = dot(u_xlat3.xy, u_xlat4.xy);
    u_xlat3.x = dot(u_xlat3.zw, vec2(127.099998, 269.5));
    u_xlat3.y = dot(u_xlat3.zw, vec2(311.700012, 183.300003));
    u_xlat4.xy = sin(u_xlat3.xy);
    u_xlat3.xy = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat3.xy = fract(u_xlat3.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat5.w = dot(u_xlat3.xy, u_xlat4.zw);
    u_xlat3.x = dot(u_xlat1.xy, vec2(127.099998, 269.5));
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat1.x = dot(u_xlat1.xy, vec2(311.700012, 183.300003));
    u_xlat3.y = sin(u_xlat1.x);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat3 = u_xlat0 + vec4(-0.0, -1.0, -0.0, -1.0);
    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat2.y = dot(u_xlat1.xy, u_xlat3.xy);
    u_xlat1.x = dot(u_xlat1.zw, vec2(127.099998, 269.5));
    u_xlat1.y = dot(u_xlat1.zw, vec2(311.700012, 183.300003));
    u_xlat3.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat3.xy * vec2(43758.5469, 43758.5469);
    u_xlat1.xy = fract(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat2.w = dot(u_xlat1.xy, u_xlat3.zw);
    u_xlat1 = (-u_xlat2) + u_xlat5;
    u_xlat3 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = u_xlat0.xxzz * u_xlat1 + u_xlat2;
    u_xlat0.xz = (-u_xlat1.xz) + u_xlat1.yw;
    u_xlat0.xy = u_xlat0.yw * u_xlat0.xz + u_xlat1.xz;
    u_xlat0.xy = _WindData.xy * vec2(0.300000012, 0.300000012) + u_xlat0.xy;
    u_xlat12 = in_POSITION0.y * in_POSITION0.y;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat12);
    u_xlat0.xy = u_xlat0.xy * _WindData.zz;
    u_xlat0.xy = u_xlat0.xy * vec2(30.0, 30.0) + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump float _AmbientStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * glstate_lightmodel_ambient.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-u_xlat16_0.xyz);
    u_xlat16_1.xyz = vec3(_AmbientStrength) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
}
}
}
}