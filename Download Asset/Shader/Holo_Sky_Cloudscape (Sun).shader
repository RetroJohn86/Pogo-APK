//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Sky/Cloudscape (Sun)" {
Properties {
_HighlightColor ("Highlight Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_CloudShadowColor ("Shadow Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Alpha ("Alpha", Range(0, 1)) = 1
_PanSpeed ("Pan Speed", Float) = 0.1
_SunStrength ("Sun Intensity", Float) = 1
_SunSizePower ("Sun Power", Float) = 500
_SunGlowPower ("Sun Glow Power", Float) = 0.5
_SunColor ("Sun Color", Color) = (1,0.8,0.7,1)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  GpuProgramID 9249
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat10_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat10_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat10_0.x * u_xlat10_0.x;
    u_xlat16_14 = u_xlat10_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat10_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat10_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat10_0.x * u_xlat10_0.x;
    u_xlat16_14 = u_xlat10_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat10_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat10_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat10_0.x * u_xlat10_0.x;
    u_xlat16_14 = u_xlat10_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat16_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat16_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_14 = u_xlat16_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat16_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat16_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_14 = u_xlat16_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
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
uniform 	mediump float _PanSpeed;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.x = _Time.x * _PanSpeed;
    u_xlat1.yz = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.x * in_COLOR0.x + u_xlat1.y;
    vs_TEXCOORD0.xy = u_xlat1.xz;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _HighlightColor;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _CloudShadowColor;
uniform 	mediump float _Alpha;
uniform 	vec3 _SunDirection;
uniform 	mediump vec3 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunSizePower;
uniform 	mediump float _SunGlowPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec2 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
float u_xlat8;
mediump float u_xlat16_13;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = log2(u_xlat0.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunSizePower;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _SunStrength;
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat16_5.x = (-u_xlat16_0.y) * _Alpha + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _SunGlowPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    u_xlat16_5.xyz = _SunColor.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_5.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat8 = (-u_xlat16_0.x) + 1.25;
    u_xlat16_13 = u_xlat8 * u_xlat8;
    u_xlat16_13 = u_xlat8 * u_xlat16_13;
    u_xlat16_2.xyz = (-_Color.xyz) + _CloudShadowColor.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_2.xyz + _Color.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _HighlightColor.xyz;
    u_xlat16_13 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_14 = u_xlat16_0.y * _Alpha;
    SV_Target0.w = u_xlat16_14;
    u_xlat16_13 = u_xlat16_13 * u_xlat16_13;
    u_xlat16_2.xyz = vec3(u_xlat16_13) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat16_2.xyz;
    return;
}

#endif
"
}
}
}
}
}