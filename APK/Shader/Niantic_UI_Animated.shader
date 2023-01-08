//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/Animated" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_AnimationSpeed ("Animation Speed", Float) = 130
_rotAngle ("Rotation Angle", Range(0, 1)) = 0
_AnimationScale ("Animation Scale", Float) = 1
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
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
  GpuProgramID 38086
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat10_0 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat10_0 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat10_0 = texture2D(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat16_0 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat16_0 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_9;
float u_xlat14;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat4.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat14 = _Time.x * _AnimationSpeed;
    u_xlat14 = sin(u_xlat14);
    u_xlat16_9 = u_xlat14 * _AnimationScale + u_xlat4.y;
    u_xlat4.y = u_xlat16_9;
    u_xlat16_0 = texture(_MainTex, u_xlat4.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
    u_xlatb3 = u_xlat16_1<0.0;
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_1<0.0);
#else
    u_xlatb3 = u_xlat16_1<0.0;
#endif
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_1<0.0);
#else
    u_xlatb3 = u_xlat16_1<0.0;
#endif
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec2 u_xlat3;
bool u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0 = u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_1<0.0);
#else
    u_xlatb3 = u_xlat16_1<0.0;
#endif
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    u_xlatb3.x = u_xlat16_1<0.0;
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    u_xlatb3.x = u_xlat16_1<0.0;
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat10_0 = texture2D(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
    u_xlatb3.x = u_xlat16_1<0.0;
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb3.x = u_xlat16_1<0.0;
#endif
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb3.x = u_xlat16_1<0.0;
#endif
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _AnimationSpeed;
uniform 	mediump float _rotAngle;
uniform 	mediump float _AnimationScale;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bvec4 u_xlatb3;
vec2 u_xlat4;
mediump float u_xlat16_8;
float u_xlat13;
void main()
{
    u_xlat16_0.x = _rotAngle * 6.28318024;
    u_xlat16_1 = cos(u_xlat16_0.x);
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat16_2.z = u_xlat16_0.x;
    u_xlat3.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.y = u_xlat16_1;
    u_xlat16_2.x = (-u_xlat16_0.x);
    u_xlat4.y = dot(u_xlat3.xy, u_xlat16_2.xy);
    u_xlat4.x = dot(u_xlat3.xy, u_xlat16_2.yz);
    u_xlat3.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat13 = _Time.x * _AnimationSpeed;
    u_xlat13 = sin(u_xlat13);
    u_xlat16_8 = u_xlat13 * _AnimationScale + u_xlat3.y;
    u_xlat3.y = u_xlat16_8;
    u_xlat16_0 = texture(_MainTex, u_xlat3.xy);
    u_xlat16_0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb3.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
    u_xlat3.z = u_xlatb3.z ? float(1.0) : 0.0;
    u_xlat3.w = u_xlatb3.w ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.zw * u_xlat3.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat16_0.w * u_xlat3.x + -0.00100000005;
    u_xlat3.x = u_xlat16_0.w * u_xlat3.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat16_1<0.0);
#else
    u_xlatb3.x = u_xlat16_1<0.0;
#endif
    if(u_xlatb3.x){discard;}
    return;
}

#endif
"
}
}
}
}
}