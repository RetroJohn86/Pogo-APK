//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Fx/Spotlight Texture-Animated-Additive" {
Properties {
_MaskTex ("Mask Texture", 2D) = "white" { }
_Color ("Color (.a is Alpha)", Color) = (0,0,0,1)
_MaxBrightness ("Max Brightness", Float) = 1
_ScrollSpeed ("Scroll Speed", Range(0, 1)) = 1
}
SubShader {
 Tags { "IgnoreProjectors" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IgnoreProjectors" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  Cull Off
  GpuProgramID 30940
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump float in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MaskTex;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture2D(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_2 + u_xlat10_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump float in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MaskTex;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture2D(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_2 + u_xlat10_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump float in_COLOR0;
attribute mediump vec4 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MaskTex;
varying highp vec3 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_0 = texture2D(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat10_2 = texture2D(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat10_2 + u_xlat10_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
    SV_Target0.xyz = _Color.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump float in_COLOR0;
in mediump vec4 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_0 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_2 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat16_2 + u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = _Color.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump float in_COLOR0;
in mediump vec4 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_0 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_2 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat16_2 + u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = _Color.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump float in_COLOR0;
in mediump vec4 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yz * vec2(vec2(_ScrollSpeed, _ScrollSpeed));
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.z = (-u_xlat0.y) + in_TEXCOORD0.x;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(in_NORMAL0.xyz, u_xlat0.xyz);
    u_xlat16_1 = abs(u_xlat16_1) * abs(u_xlat16_1);
    u_xlat16_3 = _Color.w * _MaxBrightness;
    vs_TEXCOORD1.y = u_xlat16_3 * u_xlat16_1;
    vs_TEXCOORD1.x = in_COLOR0;
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
uniform 	mediump vec4 _MaskTex_ST;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_0 = texture(_MaskTex, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.zy * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat16_2 = texture(_MaskTex, u_xlat2.xy).x;
    u_xlat16_1 = u_xlat16_2 + u_xlat16_0;
    u_xlat16_1 = u_xlat16_1 * vs_TEXCOORD1.y;
    u_xlat16_3 = vs_TEXCOORD1.x * vs_TEXCOORD1.x;
    SV_Target0.w = dot(vec2(u_xlat16_3), vec2(u_xlat16_1));
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = _Color.xyz;
    return;
}

#endif
"
}
}
}
}
}