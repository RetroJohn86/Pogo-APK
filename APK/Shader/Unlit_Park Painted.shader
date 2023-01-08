//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/Park Painted" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_TintColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Additive", Color) = (0,0,0,0)
_GroundUvDivider ("Ground UV Divider", Float) = 0.58
_GroundTint ("Ground Tint", Color) = (1,1,1,1)
_GroundTintGradationPower ("Ground Tint Gradation Power", Float) = 1
_Saturation ("Saturation", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  GpuProgramID 42463
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat10_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat10_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat10_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat10_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump float _GroundUvDivider;
uniform 	mediump vec4 _GroundTint;
uniform 	mediump float _Saturation;
uniform 	mediump float _GroundTintGradationPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
float u_xlat3;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.x = vs_TEXCOORD0.y / _GroundUvDivider;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _GroundTintGradationPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_1 = _GroundTint + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_GroundUvDivider>=vs_TEXCOORD0.y);
#else
    u_xlatb2 = _GroundUvDivider>=vs_TEXCOORD0.y;
#endif
    u_xlat16_1.x = (u_xlatb2) ? 1.0 : 0.0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1.x = (-_Saturation) + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_5.xyz = (-u_xlat16_2.xyz) + vec3(u_xlat3);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + u_xlat16_2.xyz;
    u_xlat16_12 = u_xlat16_0.w * u_xlat16_2.w;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat16_0.x = u_xlat16_12 * _TintColor.w;
    SV_Target0.w = u_xlat16_0.x;
    return;
}

#endif
"
}
}
}
}
}