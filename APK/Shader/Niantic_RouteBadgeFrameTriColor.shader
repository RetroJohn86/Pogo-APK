//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/RouteBadgeFrameTriColor" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_FrameMaskTex ("Frame Texture Mask", 2D) = "white" { }
_HeaderColor ("Header Color", Color) = (1,1,1,1)
_HeaderOpacity ("Header Opacity", Range(0, 1)) = 1
_LightGradientAngleX ("Light Gradient Angle x", Float) = 0
_LightGradientAngleY ("Light Gradient Angle y", Float) = 0
_DarkGradientAngleX ("Dark Gradient Angle x", Float) = 0
_DarkGradientAngleY ("Dark Gradient Angle y", Float) = 0
_BlurOffsets ("Texel Blur Offsets", Vector) = (0.0035,0.0035,0.0035,0.0035)
_Kernel ("Kernel Blur", Float) = 0.15
_BlurOutlineColor ("Blur Color", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
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
  GpuProgramID 37613
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _BlurOffsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FrameMaskTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2 = texture2D(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.www);
    u_xlat16_15 = u_xlat10_2.z + u_xlat10_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat10_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat10_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat10_1.x = texture2D(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat10_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat10_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat10_1.x + u_xlat6;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat10_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat10_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
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
uniform 	mediump vec4 _BlurOffsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FrameMaskTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2 = texture2D(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.www);
    u_xlat16_15 = u_xlat10_2.z + u_xlat10_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat10_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat10_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat10_1.x = texture2D(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat10_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat10_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat10_1.x + u_xlat6;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat10_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat10_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
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
uniform 	mediump vec4 _BlurOffsets;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FrameMaskTex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
lowp float u_xlat10_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_2 = texture2D(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_1.xyz + (-u_xlat10_2.www);
    u_xlat16_15 = u_xlat10_2.z + u_xlat10_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat10_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat10_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat10_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat10_1.x = texture2D(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat10_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat10_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat10_1.x + u_xlat6;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat10_6 = texture2D(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat10_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat10_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat10_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
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
uniform 	mediump vec4 _BlurOffsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FrameMaskTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = texture(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.www);
    u_xlat16_15 = u_xlat16_2.z + u_xlat16_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat16_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat16_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat16_1.x = texture(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat16_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat16_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat16_1.x + u_xlat6;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat16_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat16_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
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
uniform 	mediump vec4 _BlurOffsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FrameMaskTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = texture(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.www);
    u_xlat16_15 = u_xlat16_2.z + u_xlat16_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat16_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat16_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat16_1.x = texture(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat16_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat16_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat16_1.x + u_xlat6;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat16_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat16_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
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
uniform 	mediump vec4 _BlurOffsets;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.x = sin(_BlurOffsets.z);
    u_xlat1.x = cos(_BlurOffsets.z);
    u_xlat1.xz = u_xlat1.xx * vec2(-1.0, 1.0);
    u_xlat1.yw = u_xlat0.xx * vec2(1.0, -1.0);
    u_xlat0 = _BlurOffsets.xyxy * u_xlat1 + in_TEXCOORD0.xyxy;
    vs_TEXCOORD1 = u_xlat0.zyxw;
    vs_TEXCOORD2 = u_xlat0;
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
uniform 	mediump vec4 _HeaderColor;
uniform 	mediump float _HeaderOpacity;
uniform 	mediump float _LightGradientAngleX;
uniform 	mediump float _LightGradientAngleY;
uniform 	mediump float _DarkGradientAngleX;
uniform 	mediump float _DarkGradientAngleY;
uniform 	mediump float _Kernel;
uniform 	mediump vec4 _BlurOutlineColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FrameMaskTex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
float u_xlat6;
mediump float u_xlat16_6;
float u_xlat11;
mediump float u_xlat16_15;
float u_xlat16;
void main()
{
    u_xlat16_0.x = _DarkGradientAngleX;
    u_xlat16_0.y = _DarkGradientAngleY;
    u_xlat1.x = dot(vs_TEXCOORD0.xy, u_xlat16_0.xy);
    u_xlat16_0.xyz = _HeaderColor.xyz * _HeaderColor.xyz;
    u_xlat16_2.xyz = (-_HeaderColor.xyz) * _HeaderColor.xyz + _HeaderColor.xyz;
    u_xlat16_0.xyz = u_xlat1.xxx * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = texture(_FrameMaskTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_1.xyz + (-u_xlat16_2.www);
    u_xlat16_15 = u_xlat16_2.z + u_xlat16_2.y;
    u_xlat16_3.xyz = vec3(u_xlat16_15) * u_xlat16_3.xyz + u_xlat16_2.www;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_15 = u_xlat16_2.z * _HeaderOpacity;
    u_xlat16_0.xyz = vec3(u_xlat16_15) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat1.xyz = (-u_xlat16_0.xyz) + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat16_2.xxx * u_xlat1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat1.xyz + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = (-u_xlat1.xyz) + u_xlat16_0.xyz;
    u_xlat16 = dot(vs_TEXCOORD0.xy, vec2(_LightGradientAngleX, _LightGradientAngleY));
    u_xlat16_0.xyz = vec3(u_xlat16) * u_xlat16_0.xyz + u_xlat1.xyz;
    u_xlat16_1.x = texture(_FrameMaskTex, vs_TEXCOORD1.zw).w;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD1.xy).w;
    u_xlat11 = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat11 * _Kernel;
    u_xlat6 = u_xlat16_6 * u_xlat11;
    u_xlat16_15 = (-u_xlat11) * 4.0 + 1.0;
    u_xlat6 = u_xlat16_15 * u_xlat16_2.w + u_xlat6;
    u_xlat1.x = u_xlat11 * u_xlat16_1.x + u_xlat6;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.xy).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_6 = texture(_FrameMaskTex, vs_TEXCOORD2.zw).w;
    u_xlat1.x = u_xlat11 * u_xlat16_6 + u_xlat1.x;
    u_xlat16_1 = u_xlat1.xxxx * _BlurOutlineColor;
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) * vs_COLOR0.www + u_xlat16_0.xyz;
    u_xlat1 = u_xlat16_1 * vs_COLOR0.wwww;
    u_xlat16_0.w = u_xlat16_2.w * vs_COLOR0.w + (-u_xlat1.w);
    u_xlat4 = u_xlat16_2.w * vs_COLOR0.w;
    SV_Target0 = vec4(u_xlat4) * u_xlat16_0 + u_xlat1;
    return;
}

#endif
"
}
}
}
}
}