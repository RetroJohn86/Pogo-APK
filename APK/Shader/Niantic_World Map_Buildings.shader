//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/World Map/Buildings" {
Properties {
_yFaceColor ("Up Facing Color", Color) = (1,1,1,1)
_blendedFaceColor ("Blended (distant) Face Color", Color) = (1,1,1,1)
_wallColor ("Wall Color 1", Color) = (1,1,1,1)
_wallColorSecondary ("Wall Color 2", Color) = (1,1,1,1)
_NearOpacity ("Near Opacity", Range(0, 1)) = 0
_FarOpacity ("Far Opacity", Range(0, 1)) = 1
_NearDist ("Near Distance", Float) = 100
_FarDist ("Far Distance", Float) = 250
_BlendedColorNearDist ("Blended Near Distance", Float) = 80
_BlendedColorFarDist ("Blended Far Distance", Float) = 250
}
SubShader {
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 25757
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4 = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4 = u_xlat4 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp float vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _wallColor;
uniform 	mediump vec4 _wallColorSecondary;
uniform 	mediump vec4 _yFaceColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp float vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    gl_Position = u_xlat0;
    vs_TEXCOORD2 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xy = u_xlat0.yz * u_xlat0.xx + vec2(1.0, 1.0);
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5);
    u_xlat16_1 = (-_wallColor) + _wallColorSecondary;
    u_xlat16_1 = u_xlat0.yyyy * u_xlat16_1 + _wallColor;
    u_xlat16_2 = (-u_xlat16_1) + _yFaceColor;
    u_xlat16_0 = u_xlat0.xxxx * u_xlat16_2 + u_xlat16_1;
    vs_TEXCOORD0 = u_xlat16_0;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _blendedFaceColor;
uniform 	vec4 _playerPosition;
uniform 	mediump float _NearOpacity;
uniform 	mediump float _FarOpacity;
uniform 	mediump float _NearDist;
uniform 	mediump float _FarDist;
uniform 	mediump float _BlendedColorNearDist;
uniform 	mediump float _BlendedColorFarDist;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp float vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD1.xyz) + _playerPosition.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat4.x = u_xlat0.x + (-_BlendedColorNearDist);
    u_xlat0.x = u_xlat0.x + (-_NearDist);
    u_xlat16_1 = (-_BlendedColorNearDist) + _BlendedColorFarDist;
    u_xlat4.x = u_xlat4.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = vs_TEXCOORD0.xyz + (-_blendedFaceColor.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat2.xyz + _blendedFaceColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz + (-unity_FogColor.xyz);
    u_xlat2.x = vs_TEXCOORD2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat2.xxx * u_xlat4.xyz + unity_FogColor.xyz;
    u_xlat16_3.xy = (-vec2(_NearDist, _NearOpacity)) + vec2(_FarDist, _FarOpacity);
    u_xlat0.x = u_xlat0.x / u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.y + _NearOpacity;
    u_xlat1.w = u_xlat16_3.x * vs_TEXCOORD0.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
}
}
}
}