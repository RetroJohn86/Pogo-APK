//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/SimpleBlur" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_Offsets ("Texel Offsets", Vector) = (0.0035,0.0035,0.0035,0.0035)
_Kernel ("Kernel", Float) = 0.15
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
  GpuProgramID 58067
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat4;
void main()
{
    if((-1)!=0){discard;}
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat10_0 + _TextureSampleAdd;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat10_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat10_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _Offsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.x = sin(_Offsets.z);
    u_xlat1.x = cos(_Offsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _Offsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD2 = u_xlat0.zyxw;
    vs_TEXCOORD3 = u_xlat0;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	float _Kernel;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat4;
void main()
{
    if((int(0xFFFFFFFFu))!=0){discard;}
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat1 * _Kernel;
    u_xlat4 = (-u_xlat1) * 4.0 + 1.0;
    u_xlat0 = vec4(u_xlat4) * u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat2 = vec4(u_xlat1) * u_xlat16_2;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD3.zw);
    u_xlat0 = vec4(u_xlat1) * u_xlat16_2 + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}