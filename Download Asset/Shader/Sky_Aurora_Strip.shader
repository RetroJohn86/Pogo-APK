//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Sky/Aurora_Strip" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_ColorTex ("Color Gradient", 2D) = "white" { }
_WaveFrequency ("Distortion Frequency", Float) = 0.5
_WaveAmplitude ("Distortion Amplitude", Float) = 1
_WaveSpeed ("Distortion Speed", Float) = 1
_FlareTex ("Flare Texture", 2D) = "white" { }
_FlareSpeed ("Flare Panning Speed", Float) = 1
_FlareStrength ("Flare Strength", Range(0, 2)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  Cull Off
  GpuProgramID 50242
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ColorTex;
uniform lowp sampler2D _FlareTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_9;
void main()
{
    u_xlat10_0.x = texture2D(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat10_0.xyz = texture2D(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat10_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ColorTex;
uniform lowp sampler2D _FlareTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_9;
void main()
{
    u_xlat10_0.x = texture2D(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat10_0.xyz = texture2D(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat10_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ColorTex;
uniform lowp sampler2D _FlareTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_9;
void main()
{
    u_xlat10_0.x = texture2D(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat10_0.xyz = texture2D(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat10_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = texture(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat16_0.xyz = texture(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat16_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = texture(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat16_0.xyz = texture(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat16_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ColorTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _WaveFrequency;
uniform 	mediump float _WaveAmplitude;
uniform 	mediump float _WaveSpeed;
uniform 	mediump float _FlareSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    u_xlat1.x = (-_Time.y) * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD1.x = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat16_0.y;
    u_xlat1.x = _Time.y * _FlareSpeed + u_xlat16_0.x;
    vs_TEXCOORD2.y = u_xlat16_0.y;
    vs_TEXCOORD2.x = u_xlat1.x;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _ColorTex_ST.xy + _ColorTex_ST.zw;
    u_xlat1.x = _Time.y * _WaveSpeed;
    u_xlat1.x = in_TEXCOORD0.x * _WaveFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _WaveAmplitude + in_POSITION0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _FlareStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _ColorTex;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = texture(_FlareTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_FlareTex, vs_TEXCOORD2.xy).x;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat16_1 = u_xlat16_1 * _FlareStrength;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.x;
    u_xlat16_0.xyz = texture(_ColorTex, vs_TEXCOORD3.xy).xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_2.w = u_xlat16_9 * _MainColor.w;
    u_xlat16_4.xyz = u_xlat16_0.xyz * u_xlat16_2.www;
    u_xlat16_2.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    SV_Target0 = vec4(u_xlat16_1) * vs_COLOR0.wwww + u_xlat16_2;
    return;
}

#endif
"
}
}
}
}
}