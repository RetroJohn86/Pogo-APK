//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Mega/Icon" {
Properties {
[Header(Icon Properties)] [Spacing(10)] _MainTex ("Main Texture", 2D) = "white" { }
_Color ("Main Tint", Color) = (1,1,1,1)
_Scale ("Main UV Scale", Vector) = (1,1,1,1)
[Header(Scrolling Gradient Properties)] [Spacing(10)] _Gradient ("Gradient Texture", 2D) = "white" { }
_GradScale ("Gradient UV Scale", Vector) = (1,1,1,1)
_PulseStart ("Gradient Tex Start Pos", Vector) = (0,0,0,0)
_PulseEnd ("Gradient Tex End Pos", Vector) = (0,0,0,0)
_SecColor ("Secondary Tint", Color) = (1,1,1,1)
_HSpeed ("Horizontal Speed", Float) = 1
_VSpeed ("Vertical Speed", Float) = 1
[Header(Outer Glow Properties)] [Spacing(10)] [IntRange] _Radius ("Blur Radius", Range(0, 24)) = 1
[IntRange] _Step ("Blur Step Size", Range(2, 10)) = 4
_Resolution ("Blur Resolution", Range(0.001, 0.1)) = 0.005
_AddPower ("Additive Power", Float) = 1
[Header(Fade Properties)] _Scroll ("Scroll", Float) = 0
_ScrollStart ("Scroll Start", Float) = 2
_ScrollScale ("Scroll Scale", Float) = 4
_PulseOffset ("Fade Time Offset", Float) = 0
_FadePower ("Fade Pulse Power", Float) = 1
_Duration ("Life Duration", Float) = 1
[Toggle(BLUR_ON)] _BlurOn ("Outer Glow", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 52826
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Gradient;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat10_2 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_2 * _SecColor;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Gradient;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat10_2 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_2 * _SecColor;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Gradient;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat10_2 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_2 * _SecColor;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat10_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat16_2 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_2 * _SecColor;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat16_2 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_2 * _SecColor;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0 = _Duration + _Duration;
    u_xlat0 = _Time.w / u_xlat0;
    u_xlat0 = sin(u_xlat0);
    u_xlat16_1 = u_xlat0 * _FadePower;
    u_xlat16_5 = ceil(u_xlat0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_5 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat0 = u_xlat0 * _ScrollScale + _Scroll;
    u_xlat0 = -abs(u_xlat0) + _ScrollStart;
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat16_2 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_2 * _SecColor;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3 = u_xlat16_3 * _Color;
    u_xlat16_2 = u_xlat2 * u_xlat16_3;
    u_xlat16_2 = u_xlat16_2 * vec4(_AddPower);
    u_xlat16_5 = u_xlat0 * u_xlat16_2.w;
    u_xlat16_2.w = u_xlat16_1 * u_xlat16_5;
    SV_Target0 = u_xlat16_2 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BLUR_ON" }
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	int _Radius;
uniform 	int _Step;
uniform 	mediump float _Resolution;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_16;
float u_xlat20;
bool u_xlatb20;
mediump vec3 u_xlat16_25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_38;
float u_xlat40;
int u_xlati40;
float u_xlat43;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _SecColor;
    u_xlat16_3.x = _Resolution + _Resolution;
    u_xlat16_16 = _Resolution * 4.0;
    u_xlat4.xy = vec2(ivec2(_Step, _Radius));
    u_xlat5 = u_xlat16_0;
    u_xlat40 = u_xlat4.x;
    while(true){
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(u_xlat4.y<u_xlat40);
#else
        u_xlatb30 = u_xlat4.y<u_xlat40;
#endif
        if(u_xlatb30){break;}
        u_xlat30 = (-u_xlat40) * _Resolution;
        u_xlat43 = u_xlat40 * _Resolution;
        u_xlat6 = u_xlat5;
        u_xlat7 = u_xlat16_3.x;
        while(true){
#ifdef UNITY_ADRENO_ES3
            u_xlatb20 = !!(u_xlat16_16<u_xlat7);
#else
            u_xlatb20 = u_xlat16_16<u_xlat7;
#endif
            if(u_xlatb20){break;}
            u_xlat20 = _Resolution * 6.0 + (-u_xlat7);
            u_xlat8.xy = vec2(u_xlat30) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat8.zw = vec2(u_xlat43) * vec2(u_xlat20) + vs_TEXCOORD0.xy;
            u_xlat16_9 = texture(_MainTex, u_xlat8.xw);
            u_xlat9 = u_xlat6 + u_xlat16_9;
            u_xlat10.xy = vec2(u_xlat43) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat10.zw = vec2(u_xlat30) * vec2(u_xlat20) + vs_TEXCOORD0.yx;
            u_xlat16_11 = texture(_MainTex, u_xlat10.xz);
            u_xlat9 = u_xlat9 + u_xlat16_11;
            u_xlat8.xw = u_xlat10.wy;
            u_xlat16_10 = texture(_MainTex, u_xlat8.xy);
            u_xlat9 = u_xlat9 + u_xlat16_10;
            u_xlat16_8 = texture(_MainTex, u_xlat8.zw);
            u_xlat6 = u_xlat16_8 + u_xlat9;
            u_xlat7 = u_xlat7 + _Resolution;
        }
        u_xlat5 = u_xlat6;
        u_xlat40 = u_xlat4.x + u_xlat40;
    }
    u_xlati40 = int(int_bitfieldInsert(1,_Radius,1,31) );
    u_xlat40 = float(u_xlati40);
    u_xlat3 = u_xlat5 / vec4(u_xlat40);
    u_xlat16_12 = u_xlat2.w * u_xlat3.w;
    u_xlat16_3.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_3.w = u_xlat2.w * u_xlat16_12;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat16_12 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_25.x = u_xlat16_12 * _AddPower;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_25.xxxx;
    u_xlat16_25.xyz = u_xlat16_1.xyz * _SecColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat2.www * u_xlat16_25.xyz + u_xlat16_3.xyz;
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_3 * vec4(u_xlat16_12) + u_xlat16_0;
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat1 = u_xlat1 * _ScrollScale + _Scroll;
    u_xlat1 = -abs(u_xlat1) + _ScrollStart;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat16_12 = u_xlat16_0.w * u_xlat1;
    u_xlat1 = _Duration + _Duration;
    u_xlat1 = _Time.w / u_xlat1;
    u_xlat1 = sin(u_xlat1);
    u_xlat16_25.x = u_xlat1 * _FadePower;
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_38 = ceil(u_xlat1);
    u_xlat16_25.x = u_xlat16_38 * u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_25.x = (-u_xlat16_25.x) + 1.0;
    u_xlat16_0.w = u_xlat16_25.x * u_xlat16_12;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BLUR_ON" }
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	int _Radius;
uniform 	int _Step;
uniform 	mediump float _Resolution;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_16;
float u_xlat20;
bool u_xlatb20;
mediump vec3 u_xlat16_25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_38;
float u_xlat40;
int u_xlati40;
float u_xlat43;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _SecColor;
    u_xlat16_3.x = _Resolution + _Resolution;
    u_xlat16_16 = _Resolution * 4.0;
    u_xlat4.xy = vec2(ivec2(_Step, _Radius));
    u_xlat5 = u_xlat16_0;
    u_xlat40 = u_xlat4.x;
    while(true){
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(u_xlat4.y<u_xlat40);
#else
        u_xlatb30 = u_xlat4.y<u_xlat40;
#endif
        if(u_xlatb30){break;}
        u_xlat30 = (-u_xlat40) * _Resolution;
        u_xlat43 = u_xlat40 * _Resolution;
        u_xlat6 = u_xlat5;
        u_xlat7 = u_xlat16_3.x;
        while(true){
#ifdef UNITY_ADRENO_ES3
            u_xlatb20 = !!(u_xlat16_16<u_xlat7);
#else
            u_xlatb20 = u_xlat16_16<u_xlat7;
#endif
            if(u_xlatb20){break;}
            u_xlat20 = _Resolution * 6.0 + (-u_xlat7);
            u_xlat8.xy = vec2(u_xlat30) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat8.zw = vec2(u_xlat43) * vec2(u_xlat20) + vs_TEXCOORD0.xy;
            u_xlat16_9 = texture(_MainTex, u_xlat8.xw);
            u_xlat9 = u_xlat6 + u_xlat16_9;
            u_xlat10.xy = vec2(u_xlat43) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat10.zw = vec2(u_xlat30) * vec2(u_xlat20) + vs_TEXCOORD0.yx;
            u_xlat16_11 = texture(_MainTex, u_xlat10.xz);
            u_xlat9 = u_xlat9 + u_xlat16_11;
            u_xlat8.xw = u_xlat10.wy;
            u_xlat16_10 = texture(_MainTex, u_xlat8.xy);
            u_xlat9 = u_xlat9 + u_xlat16_10;
            u_xlat16_8 = texture(_MainTex, u_xlat8.zw);
            u_xlat6 = u_xlat16_8 + u_xlat9;
            u_xlat7 = u_xlat7 + _Resolution;
        }
        u_xlat5 = u_xlat6;
        u_xlat40 = u_xlat4.x + u_xlat40;
    }
    u_xlati40 = int(int_bitfieldInsert(1,_Radius,1,31) );
    u_xlat40 = float(u_xlati40);
    u_xlat3 = u_xlat5 / vec4(u_xlat40);
    u_xlat16_12 = u_xlat2.w * u_xlat3.w;
    u_xlat16_3.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_3.w = u_xlat2.w * u_xlat16_12;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat16_12 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_25.x = u_xlat16_12 * _AddPower;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_25.xxxx;
    u_xlat16_25.xyz = u_xlat16_1.xyz * _SecColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat2.www * u_xlat16_25.xyz + u_xlat16_3.xyz;
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_3 * vec4(u_xlat16_12) + u_xlat16_0;
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat1 = u_xlat1 * _ScrollScale + _Scroll;
    u_xlat1 = -abs(u_xlat1) + _ScrollStart;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat16_12 = u_xlat16_0.w * u_xlat1;
    u_xlat1 = _Duration + _Duration;
    u_xlat1 = _Time.w / u_xlat1;
    u_xlat1 = sin(u_xlat1);
    u_xlat16_25.x = u_xlat1 * _FadePower;
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_38 = ceil(u_xlat1);
    u_xlat16_25.x = u_xlat16_38 * u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_25.x = (-u_xlat16_25.x) + 1.0;
    u_xlat16_0.w = u_xlat16_25.x * u_xlat16_12;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BLUR_ON" }
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
uniform 	vec4 _Scale;
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
uniform 	vec4 _PulseStart;
uniform 	vec4 _PulseEnd;
uniform 	float _PulseOffset;
uniform 	float _Duration;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump float vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Duration + _Duration;
    u_xlat3 = _Time.w + (-_PulseOffset);
    u_xlat0.x = u_xlat3 / u_xlat0.x;
    u_xlat0.z = u_xlat3 / _Duration;
    vs_TEXCOORD2 = u_xlat3;
    u_xlat0.xy = sin(u_xlat0.xz);
    u_xlat3 = ceil(u_xlat0.y);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat16_2 = max(u_xlat0.x, 0.0);
    u_xlat0.xy = _PulseStart.xy + (-_PulseEnd.xy);
    u_xlat0.xy = vec2(u_xlat16_2) * u_xlat0.xy + _PulseEnd.xy;
    u_xlat6.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.xy = u_xlat6.xy * _Scale.xy + vec2(0.5, 0.5);
    u_xlat1.xy = _Time.yy * vec2(_HSpeed, _VSpeed) + u_xlat6.xy;
    vs_TEXCOORD0.xy = u_xlat6.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat0.xy = u_xlat0.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SecColor;
uniform 	mediump float _AddPower;
uniform 	int _Radius;
uniform 	int _Step;
uniform 	mediump float _Resolution;
uniform 	mediump float _FadePower;
uniform 	float _Scroll;
uniform 	float _ScrollStart;
uniform 	float _ScrollScale;
uniform 	float _Duration;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Gradient;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
vec4 u_xlat5;
vec4 u_xlat6;
float u_xlat7;
vec4 u_xlat8;
mediump vec4 u_xlat16_8;
vec4 u_xlat9;
mediump vec4 u_xlat16_9;
vec4 u_xlat10;
mediump vec4 u_xlat16_10;
mediump vec4 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_16;
float u_xlat20;
bool u_xlatb20;
mediump vec3 u_xlat16_25;
float u_xlat30;
bool u_xlatb30;
mediump float u_xlat16_38;
float u_xlat40;
int u_xlati40;
float u_xlat43;
int int_bitfieldInsert(int base, int insert, int offset, int bits) {
    uint mask = ~(uint(0xffffffff) << uint(bits)) << uint(offset);
    return int((uint(base) & ~mask) | ((uint(insert) << uint(offset)) & mask));
}

void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _SecColor;
    u_xlat16_3.x = _Resolution + _Resolution;
    u_xlat16_16 = _Resolution * 4.0;
    u_xlat4.xy = vec2(ivec2(_Step, _Radius));
    u_xlat5 = u_xlat16_0;
    u_xlat40 = u_xlat4.x;
    while(true){
#ifdef UNITY_ADRENO_ES3
        u_xlatb30 = !!(u_xlat4.y<u_xlat40);
#else
        u_xlatb30 = u_xlat4.y<u_xlat40;
#endif
        if(u_xlatb30){break;}
        u_xlat30 = (-u_xlat40) * _Resolution;
        u_xlat43 = u_xlat40 * _Resolution;
        u_xlat6 = u_xlat5;
        u_xlat7 = u_xlat16_3.x;
        while(true){
#ifdef UNITY_ADRENO_ES3
            u_xlatb20 = !!(u_xlat16_16<u_xlat7);
#else
            u_xlatb20 = u_xlat16_16<u_xlat7;
#endif
            if(u_xlatb20){break;}
            u_xlat20 = _Resolution * 6.0 + (-u_xlat7);
            u_xlat8.xy = vec2(u_xlat30) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat8.zw = vec2(u_xlat43) * vec2(u_xlat20) + vs_TEXCOORD0.xy;
            u_xlat16_9 = texture(_MainTex, u_xlat8.xw);
            u_xlat9 = u_xlat6 + u_xlat16_9;
            u_xlat10.xy = vec2(u_xlat43) * vec2(u_xlat7) + vs_TEXCOORD0.xy;
            u_xlat10.zw = vec2(u_xlat30) * vec2(u_xlat20) + vs_TEXCOORD0.yx;
            u_xlat16_11 = texture(_MainTex, u_xlat10.xz);
            u_xlat9 = u_xlat9 + u_xlat16_11;
            u_xlat8.xw = u_xlat10.wy;
            u_xlat16_10 = texture(_MainTex, u_xlat8.xy);
            u_xlat9 = u_xlat9 + u_xlat16_10;
            u_xlat16_8 = texture(_MainTex, u_xlat8.zw);
            u_xlat6 = u_xlat16_8 + u_xlat9;
            u_xlat7 = u_xlat7 + _Resolution;
        }
        u_xlat5 = u_xlat6;
        u_xlat40 = u_xlat4.x + u_xlat40;
    }
    u_xlati40 = int(int_bitfieldInsert(1,_Radius,1,31) );
    u_xlat40 = float(u_xlati40);
    u_xlat3 = u_xlat5 / vec4(u_xlat40);
    u_xlat16_12 = u_xlat2.w * u_xlat3.w;
    u_xlat16_3.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_3.w = u_xlat2.w * u_xlat16_12;
    u_xlat16_3 = u_xlat2 * u_xlat16_3;
    u_xlat16_12 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_25.x = u_xlat16_12 * _AddPower;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_25.xxxx;
    u_xlat16_25.xyz = u_xlat16_1.xyz * _SecColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat2.www * u_xlat16_25.xyz + u_xlat16_3.xyz;
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_3 * vec4(u_xlat16_12) + u_xlat16_0;
    u_xlat1 = (-vs_TEXCOORD0.y) + 1.0;
    u_xlat1 = u_xlat1 * _ScrollScale + _Scroll;
    u_xlat1 = -abs(u_xlat1) + _ScrollStart;
    u_xlat1 = min(u_xlat1, 1.0);
    u_xlat16_12 = u_xlat16_0.w * u_xlat1;
    u_xlat1 = _Duration + _Duration;
    u_xlat1 = _Time.w / u_xlat1;
    u_xlat1 = sin(u_xlat1);
    u_xlat16_25.x = u_xlat1 * _FadePower;
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_38 = ceil(u_xlat1);
    u_xlat16_25.x = u_xlat16_38 * u_xlat16_25.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25.x = min(max(u_xlat16_25.x, 0.0), 1.0);
#else
    u_xlat16_25.x = clamp(u_xlat16_25.x, 0.0, 1.0);
#endif
    u_xlat16_25.x = (-u_xlat16_25.x) + 1.0;
    u_xlat16_0.w = u_xlat16_25.x * u_xlat16_12;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}