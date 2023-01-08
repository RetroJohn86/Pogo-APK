//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/AnimatedProgressIcon" {
Properties {
[Header(Main Icon Properties)] [Spacing(10)] _MainTex ("Icon Base", 2D) = "clear" { }
_Color ("Tint Color", Color) = (1,1,1,1)
_ProgressColor ("Progress Filled Color", Color) = (1,1,1,1)
_UnfilledColor ("Progress Empty Color", Color) = (0.2,0.2,0.2,1)
[Header(Scrolling Gradient Properties)] [Spacing(10)] _Gradient ("Gradient Texture", 2D) = "white" { }
_GradScale ("Gradient UV Scale", Vector) = (1,1,1,1)
_GradColor ("Gradient Tint", Color) = (1,1,1,1)
_HSpeed ("Horizontal Speed", Float) = 1
_VSpeed ("Vertical Speed", Float) = 1
[Header(Wave Properties)] [Spacing(10)] _Period ("Phase Period", Float) = 1
_Frequency ("Phase Frequency (Speed)", Float) = 1
_MaxAmp ("Max Amplitude", Range(0, 1.99)) = 1
_MinAmp ("Minimum Noise Power", Range(0.001, 1)) = 0.1
_Power ("Wave Shape Power", Float) = 10
[Header(Progress Bar Properties)] [Spacing(10)] _Progress ("Progress", Range(0, 1)) = 0.2
_StartPad ("Start Padding", Range(-1, 1)) = 0
_EndPad ("End Padding", Range(-1, 1)) = 0
[Toggle(TOP_FILL)] _TopFill ("Fill From Top", Float) = 0
[Space] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(USE_GRADIENT)] _UseGradient ("Use Gradient", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 21722
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = _ProgressColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat10_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat10_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlatb0 = _Progress>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat10_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat16_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat16_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_Progress>=u_xlat16_1.x);
#else
    u_xlatb0 = _Progress>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat1 = u_xlat16_1 * _GradColor + (-_UnfilledColor);
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _UnfilledColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TOP_FILL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_3>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOP_FILL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_3>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOP_FILL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_3>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TOP_FILL" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_3>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOP_FILL" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_3>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOP_FILL" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat2 = (-_MinAmp) + _MaxAmp;
    u_xlat2 = _SinTime.w * u_xlat2 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * _MaxAmp;
    u_xlat4 = _Time.w * _Frequency;
    u_xlat4 = _Period * vs_TEXCOORD0.x + u_xlat4;
    u_xlat4 = sin(u_xlat4);
    u_xlat2 = u_xlat4 * u_xlat2;
    u_xlat0.x = u_xlat2 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_3 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_3>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat1 = (-_ProgressColor) + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + _ProgressColor;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_4>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_1 * _GradColor;
    u_xlat1 = (-u_xlat10_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_4>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_1 * _GradColor;
    u_xlat1 = (-u_xlat10_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
uniform lowp sampler2D _Gradient;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1 = (-_StartPad) + _EndPad;
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = u_xlat0.x * u_xlat16_1 + _StartPad;
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
    u_xlatb0 = u_xlat16_4>=u_xlat16_1;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat10_1 * _GradColor;
    u_xlat1 = (-u_xlat10_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * u_xlat10_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _GradColor;
    u_xlat1 = (-u_xlat16_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _GradColor;
    u_xlat1 = (-u_xlat16_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOP_FILL" "USE_GRADIENT" }
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
uniform 	vec4 _Gradient_ST;
uniform 	vec4 _GradScale;
uniform 	float _VSpeed;
uniform 	float _HSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat4.x = _Time.y * _HSpeed + in_TEXCOORD0.x;
    u_xlat4.y = _Time.y * _VSpeed + in_TEXCOORD0.y;
    u_xlat0.xy = u_xlat4.xy * _GradScale.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _Gradient_ST.xy + _Gradient_ST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _GradColor;
uniform 	mediump vec4 _UnfilledColor;
uniform 	mediump float _MaxAmp;
uniform 	mediump float _MinAmp;
uniform 	mediump float _Progress;
uniform 	mediump float _StartPad;
uniform 	mediump float _EndPad;
uniform 	float _Period;
uniform 	float _Frequency;
uniform 	float _Power;
UNITY_LOCATION(0) uniform mediump sampler2D _Gradient;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + -0.5;
    u_xlat0.x = cos(u_xlat0.x);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Power;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat3 = (-_MinAmp) + _MaxAmp;
    u_xlat3 = _SinTime.w * u_xlat3 + _MinAmp;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat3 = u_xlat0.x * _MaxAmp;
    u_xlat6 = _Time.w * _Frequency;
    u_xlat6 = _Period * vs_TEXCOORD0.x + u_xlat6;
    u_xlat6 = sin(u_xlat6);
    u_xlat3 = u_xlat6 * u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x + vs_TEXCOORD0.y;
    u_xlat16_1.x = (-_StartPad) + _EndPad;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x + _StartPad;
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_4 = (-_Progress) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_4>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat16_4>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_Gradient, vs_TEXCOORD1.xy);
    u_xlat2 = u_xlat16_1 * _GradColor;
    u_xlat1 = (-u_xlat16_1) * _GradColor + _UnfilledColor;
    u_xlat0 = u_xlat0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat16_1 * u_xlat16_1.wwww + (-u_xlat16_0);
    u_xlat16_0 = u_xlat16_0 * _Color;
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