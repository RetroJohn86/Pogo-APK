//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/FX/Multiply-VA" {
Properties {
_MainColor ("MainColor", 2D) = "white" { }
_MainTexTilling ("MainTexTilling", Vector) = (1,1,1,1)
_speedVariation ("speedVariation", Vector) = (0,0.5,0,1)
_Intensity ("Intensity", Range(0, 1)) = 1
_VCDelay ("VCDelay", Range(0, 1)) = 0.5
_delayMagnitude ("delayMagnitude", Range(0, 10)) = 1
_NoiseA ("NoiseA", 2D) = "white" { }
_NoiseScroll ("NoiseScroll", Vector) = (0,0,0,0)
_Distortion ("Distortion", Range(0, 1)) = 0.5
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend DstColor Zero, DstColor Zero
  ZWrite Off
  Offset -1, -1
  GpuProgramID 4155
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainColor;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat10_1.xy = texture2D(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat10_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat10_1.xyz = texture2D(_MainColor, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat10_0.xyz, u_xlat10_1.xyz);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainColor;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat10_1.xy = texture2D(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat10_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat10_1.xyz = texture2D(_MainColor, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat10_0.xyz, u_xlat10_1.xyz);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainColor;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat10_1.xy = texture2D(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat10_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat10_1.xyz = texture2D(_MainColor, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture2D(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat10_0.xyz, u_xlat10_1.xyz);
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainColor;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat16_1.xy = texture(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat16_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat16_1.xyz = texture(_MainColor, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat16_0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainColor;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat16_1.xy = texture(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat16_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat16_1.xyz = texture(_MainColor, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat16_0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
uniform 	vec4 _MainColor_ST;
uniform 	float _Intensity;
uniform 	vec4 _MainTexTilling;
uniform 	vec4 _speedVariation;
uniform 	float _VCDelay;
uniform 	vec4 _NoiseA_ST;
uniform 	float _Distortion;
uniform 	vec4 _NoiseScroll;
uniform 	float _delayMagnitude;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainColor;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
float u_xlat6;
void main()
{
    u_xlat0.x = vs_COLOR0.x + -1.0;
    u_xlat0.x = _VCDelay * u_xlat0.x + 1.0;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat2 = _delayMagnitude * 0.5;
    u_xlat2 = max(u_xlat2, 1.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0 = u_xlat0.xxxx * _speedVariation;
    u_xlat1.xy = _NoiseScroll.xy * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat1.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat16_1.xy = texture(_NoiseA, u_xlat1.xy).xy;
    u_xlat1 = u_xlat16_1.xyxy * vec4(_Distortion);
    u_xlat1 = vs_TEXCOORD0.xyxy * _MainTexTilling + u_xlat1;
    u_xlat0 = (-u_xlat0) * vec4(_delayMagnitude) + u_xlat1;
    u_xlat0 = _speedVariation * _Time.yyyy + u_xlat0;
    u_xlat0 = u_xlat0 * _MainColor_ST.xyxy + _MainColor_ST.zwzw;
    u_xlat16_1.xyz = texture(_MainColor, u_xlat0.xy).xyz;
    u_xlat16_0.xyz = texture(_MainColor, u_xlat0.zw).xyz;
    u_xlat0.xyz = min(u_xlat16_0.xyz, u_xlat16_1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat6 = vs_COLOR0.w * _Intensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
Fallback "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}