//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/UI-PanningShine" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ShineWidth ("ShineWidth", Range(0, 1)) = 0.01
_Softness ("Softness", Range(0, 1)) = 0
_Brightness ("Brightness", Range(0, 1)) = 0
_ReflectPower ("Reflect Power", Float) = 1
_Rotation ("Rotation in Degree", Range(0, 180)) = 0
_PanSpeed ("Pan Speed", Float) = 0
_TimeWait ("Time Gap For Next Pan", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
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
  GpuProgramID 797
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat10_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat10_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp float u_xlat10_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat10_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_0.x>=u_xlat1.x);
#else
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_0.x>=u_xlat1.x);
#else
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump float u_xlat16_1;
bvec4 u_xlatb1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_6;
void main()
{
    u_xlat16_0.x = float(1.0) / _PanSpeed;
    u_xlat16_3.x = u_xlat16_0.x + _TimeWait;
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_3.x;
    u_xlat1.x = _Time.y / u_xlat16_3.x;
    u_xlat1.x = fract(u_xlat1.x);
    u_xlat16_6 = u_xlat1.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1.x = !!(u_xlat16_0.x>=u_xlat1.x);
#else
    u_xlatb1.x = u_xlat16_0.x>=u_xlat1.x;
#endif
    u_xlat16_0.x = (u_xlatb1.x) ? 1.0 : 0.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = (-u_xlat16_3.x) + vs_TEXCOORD2.x;
    u_xlat1.x = abs(u_xlat1.x) / _ShineWidth;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat1.x = u_xlat4 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat4;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_3.xyz = u_xlat2.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_3.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat1.xxx;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Color.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_1) + u_xlat2.xyz;
    u_xlatb1.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb1.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat1.xy = u_xlat1.zw * u_xlat1.xy;
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat2.w;
    SV_Target0.w = u_xlat1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_2.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat10_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_2.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat10_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _Rotation;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MaskTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_2.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat10_0 = texture2D(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat10_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat16_0 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat16_0 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump float _Rotation;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Rotation * 0.0174532942;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat1.y = u_xlat0.x;
    u_xlat2.y = u_xlat1.x;
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat6.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat6.x = dot(u_xlat0.xy, u_xlat1.xy);
    vs_TEXCOORD2.xy = u_xlat6.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _ShineWidth;
uniform 	mediump float _Softness;
uniform 	mediump float _Brightness;
uniform 	mediump float _ReflectPower;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _TimeWait;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MaskTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat16_2.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2.x<0.0);
#else
    u_xlatb0.x = u_xlat16_2.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_2.xyz = u_xlat1.xyz * vec3(_ReflectPower) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = vec3(vec3(_Softness, _Softness, _Softness)) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14 = float(1.0) / _PanSpeed;
    u_xlat16_3 = u_xlat16_14 + _TimeWait;
    u_xlat16_14 = u_xlat16_14 / u_xlat16_3;
    u_xlat0.x = _Time.y / u_xlat16_3;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat16_7 = u_xlat0.x * _PanSpeed;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_14>=u_xlat0.x);
#else
    u_xlatb0.x = u_xlat16_14>=u_xlat0.x;
#endif
    u_xlat16_14 = (u_xlatb0.x) ? 1.0 : 0.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_3) + vs_TEXCOORD2.x;
    u_xlat0.x = abs(u_xlat0.x) / _ShineWidth;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat4 = float(1.0) / _Softness;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xxx;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Brightness, _Brightness, _Brightness));
    u_xlat16_2.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat16_0 = texture(_MaskTex, vs_TEXCOORD0.xy).w;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_0) + u_xlat1.xyz;
    return;
}

#endif
"
}
}
}
}
}