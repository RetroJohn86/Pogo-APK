//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/Grounded Blob Glow" {
Properties {
_MainTex ("Blob Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_FlickerAmount ("Flicker Amount", Float) = 1
_FlickerSpeed ("Flicker Speed", Float) = 1
_GroundHeight ("Ground Height", Float) = 0
_FadeDistance ("Fade Out Distance", Float) = 1
_FadeScale ("Fade Out Scale", Float) = 0.5
_FadeAlpha ("Fade Out Alpha", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Blend OneMinusDstColor One, OneMinusDstColor One
  ZWrite Off
  GpuProgramID 56387
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _FadeScale;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeAlpha;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat6;
void main()
{
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _FlickerAmount;
    u_xlat0.xy = u_xlat0.xx * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yxzw;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * in_POSITION0.z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat6;
    u_xlat6 = u_xlat6 + (-_GroundHeight);
    u_xlat6 = abs(u_xlat6) / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_2 = _FadeScale + -1.0;
    u_xlat16_2 = u_xlat6 * u_xlat16_2 + 1.0;
    u_xlat0.xy = u_xlat0.xy * vec2(u_xlat16_2);
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xzw * u_xlat0.xxx + u_xlat1.yzw;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[2].xzw * u_xlat0.yyy + u_xlat1.xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzw * in_POSITION0.www + u_xlat0.xyw;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2 = (-_Color.w) + _FadeAlpha;
    vs_COLOR0.w = u_xlat6 * u_xlat16_2 + _Color.w;
    vs_COLOR0.xyz = _Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0.wwww;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _GroundHeight;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	mediump vec4 _Color;
	mediump float _FlickerAmount;
	mediump float _FlickerSpeed;
	mediump float _FadeScale;
	mediump float _FadeDistance;
	mediump float _FadeAlpha;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec2 u_xlat3;
mediump float u_xlat16_4;
int u_xlati5;
float u_xlat10;
float u_xlat15;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati5 = int(u_xlati0 << 3);
    u_xlati0 = u_xlati0 * 3;
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].yxzw;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].y * in_POSITION0.x + u_xlat1.x;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].y * in_POSITION0.z + u_xlat10;
    u_xlat10 = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].y * in_POSITION0.w + u_xlat10;
    u_xlat10 = u_xlat10 + (-_GroundHeight);
    u_xlat10 = abs(u_xlat10) / PropsArray[u_xlati0 / 3]._FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat16_2 = -1.0 + PropsArray[u_xlati0 / 3]._FadeScale;
    u_xlat16_2 = u_xlat10 * u_xlat16_2 + 1.0;
    u_xlat15 = _Time.w * PropsArray[u_xlati0 / 3]._FlickerSpeed;
    u_xlat15 = sin(u_xlat15);
    u_xlat15 = u_xlat15 * PropsArray[u_xlati0 / 3]._FlickerAmount;
    u_xlat3.xy = vec2(u_xlat15) * in_POSITION0.xy + in_POSITION0.xz;
    u_xlat3.xy = vec2(u_xlat16_2) * u_xlat3.xy;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xzw * u_xlat3.xxx + u_xlat1.yzw;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xzw * u_xlat3.yyy + u_xlat1.xyz;
    u_xlat1.xyz = unity_Builtins0Array[u_xlati5 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xzw * in_POSITION0.www + u_xlat1.xyz;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.yyyy + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.zzzz + u_xlat2;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_4 = (-PropsArray[u_xlati0 / 3]._Color.w) + PropsArray[u_xlati0 / 3]._FadeAlpha;
    vs_COLOR0.w = u_xlat10 * u_xlat16_4 + PropsArray[u_xlati0 / 3]._Color.w;
    vs_COLOR0.xyz = PropsArray[u_xlati0 / 3]._Color.xyz;
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
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat2.xyz = vs_COLOR0.xyz * u_xlat1.xyz + (-unity_FogColor.xyz);
    u_xlat1.w = u_xlat1.w * vs_COLOR0.w;
    u_xlat1.xyz = vec3(u_xlat0) * u_xlat2.xyz + unity_FogColor.xyz;
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