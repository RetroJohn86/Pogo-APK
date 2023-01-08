//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/UI-SpecialRankBadgeGem" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_FxTex ("FX Texture", 2D) = "white" { }
_StardustSpeed ("Star Dust Blink Speed", Range(0, 2)) = 1
[Toggle(USE_STAR_ANIMATION)] _UseStarAnimation ("Use Star Animation", Float) = 0
_StarBlinkSpeed1 ("Star Blink Speed 1", Float) = 0
_StarRotationAngle1 ("Star Rotation Angle 1", Float) = 0
_StarScale1 ("Star Scale 1", Float) = 1
_StarBlinkSpeed2 ("Star Blink Speed 2", Float) = 0
_StarRotationAngle2 ("Star Rotation Angle 2", Float) = 0
_StarScale2 ("Star Scale 2", Float) = 1
[Toggle(USE_HEXAGON_WAVE)] _UseHexWave ("Use Hexagon Wave", Float) = 0
_HexColorTint ("Hex Color Tint", Color) = (1,1,1,1)
_HexPower ("Hex Power", Float) = 0
_HexWaveSpeed ("Hex Wave Speed", Float) = 0
_HexWaveWidth ("Hex Wave Width", Float) = 0
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
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
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
  GpuProgramID 10345
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
lowp float u_xlat10_12;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat0.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_12 = texture2D(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_FxTex, u_xlat0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat10_12) * vec3(u_xlat10_0) + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
lowp float u_xlat10_12;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat0.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_12 = texture2D(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_FxTex, u_xlat0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat10_12) * vec3(u_xlat10_0) + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
lowp float u_xlat10_12;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat0.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_12 = texture2D(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_FxTex, u_xlat0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat10_12) * vec3(u_xlat10_0) + u_xlat10_1.xyz;
    SV_Target0.w = u_xlat10_1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat0.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_12 = texture(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_FxTex, u_xlat0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat16_12) * vec3(u_xlat16_0) + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat0.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_12 = texture(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_FxTex, u_xlat0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat16_12) * vec3(u_xlat16_0) + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_1.w;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
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
uniform 	mediump float _StardustSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec2 u_xlat3;
float u_xlat4;
vec3 u_xlat5;
vec2 u_xlat12;
mediump float u_xlat16_12;
void main()
{
    u_xlat0.x = _Time.x * _StardustSpeed;
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat0.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = sin(u_xlat0.y);
    u_xlat4 = cos(u_xlat0.y);
    u_xlat5.z = u_xlat0.x;
    u_xlat5.y = u_xlat2.x;
    u_xlat5.x = (-u_xlat0.x);
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat0.xy, u_xlat5.yz);
    u_xlat2.y = dot(u_xlat0.xy, u_xlat5.xy);
    u_xlat12.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_12 = texture(_FxTex, u_xlat12.xy).x;
    u_xlat2.z = u_xlat3.x;
    u_xlat2.y = u_xlat4;
    u_xlat2.x = (-u_xlat3.x);
    u_xlat3.y = dot(u_xlat0.xy, u_xlat2.xy);
    u_xlat3.x = dot(u_xlat0.xy, u_xlat2.yz);
    u_xlat0.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_FxTex, u_xlat0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.xyz = vec3(u_xlat16_12) * vec3(u_xlat16_0) + u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
lowp float u_xlat10_16;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat16.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_16 = texture2D(_FxTex, u_xlat16.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_2) * vec3(u_xlat10_16) + u_xlat10_1.xyz;
    u_xlat10_16 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_1.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
lowp float u_xlat10_16;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat16.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_16 = texture2D(_FxTex, u_xlat16.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_2) * vec3(u_xlat10_16) + u_xlat10_1.xyz;
    u_xlat10_16 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_1.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
lowp float u_xlat10_16;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1 = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1 = _Time.x * _StardustSpeed + (-u_xlat16_1);
    u_xlat16_1 = abs(u_xlat16_1) * 140.0 + 10.0;
    u_xlat16.xy = vec2(u_xlat16_1) * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_16 = texture2D(_FxTex, u_xlat16.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_2) * vec3(u_xlat10_16) + u_xlat10_1.xyz;
    u_xlat10_16 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_1.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat16.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_16 = texture(_FxTex, u_xlat16.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_1.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat16.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_16 = texture(_FxTex, u_xlat16.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_1.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec2 u_xlat16;
mediump float u_xlat16_16;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat16.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat16.x);
    u_xlat3.x = cos(u_xlat16.x);
    u_xlat4.x = sin(u_xlat16.y);
    u_xlat5 = cos(u_xlat16.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat16.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat16.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat16.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat16.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat16.xy, u_xlat3.yz);
    u_xlat16.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_16 = texture(_FxTex, u_xlat16.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_7.xyz = vec3(u_xlat16_2) * vec3(u_xlat16_16) + u_xlat16_1.xyz;
    u_xlat16_16 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_16) * u_xlat0.xxx + u_xlat16_7.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_1.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
lowp float u_xlat10_14;
float u_xlat21;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_14 = texture2D(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat10_14 * u_xlat10_2;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat10_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.xyz = (-vec3(u_xlat10_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat10_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_3.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
lowp float u_xlat10_14;
float u_xlat21;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_14 = texture2D(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat10_14 * u_xlat10_2;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat10_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.xyz = (-vec3(u_xlat10_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat10_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_3.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FxTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
vec3 u_xlat3;
lowp vec4 u_xlat10_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
lowp float u_xlat10_14;
float u_xlat21;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = unity_roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat10_2 = texture2D(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat10_14 = texture2D(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat10_14 * u_xlat10_2;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat10_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat2.xyz = (-vec3(u_xlat10_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat10_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat10_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat10_14 = texture2D(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat10_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat10_3.xyz = vec3(u_xlat10_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat10_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
mediump float u_xlat16_14;
float u_xlat21;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_14 = texture(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat16_14 * u_xlat16_2;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat16_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-vec3(u_xlat16_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat16_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_3.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
mediump float u_xlat16_14;
float u_xlat21;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_14 = texture(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat16_14 * u_xlat16_2;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat16_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-vec3(u_xlat16_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat16_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_3.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_HEXAGON_WAVE" "USE_STAR_ANIMATION" }
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
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump float _StarRotationAngle1;
uniform 	mediump float _StarRotationAngle2;
uniform 	mediump float _StarScale1;
uniform 	mediump float _StarScale2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_5;
vec3 u_xlat6;
vec2 u_xlat7;
float u_xlat14;
vec2 u_xlat15;
vec2 u_xlat18;
float u_xlat21;
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
    u_xlat0.xy = vec2(6.28318548, 6.28318548) / vec2(_StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat0.xy = _Time.yy / u_xlat0.xy;
    u_xlat0.xy = floor(u_xlat0.xy);
    u_xlat0.x = dot(u_xlat0.xx, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat0.yy, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat7.xy = u_xlat0.yy * vec2(6.28318548, 0.300000012) + vec2(-3.14159274, 0.100000001);
    u_xlat21 = u_xlat0.x * 6.28318548 + -3.14159274;
    u_xlat0.x = u_xlat0.x * 0.400000006;
    u_xlat16_2 = sin(u_xlat21);
    u_xlat16_3.x = cos(u_xlat21);
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat16_3.y = u_xlat0.x * u_xlat16_2;
    u_xlat0.xw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.xy = u_xlat0.xw + vec2(-0.5, -0.5);
    vs_TEXCOORD0.xy = u_xlat0.xw;
    u_xlat0.xw = (-u_xlat16_3.xy) + u_xlat1.xy;
    u_xlat4.xyz = _Time.yxy * vec3(_StarBlinkSpeed1, _StarRotationAngle1, _StarBlinkSpeed2);
    u_xlat2.yzw = sin(u_xlat4.xyz);
    u_xlat2.x = cos(u_xlat4.y);
    u_xlat15.xy = u_xlat2.yw * vec2(_StarScale1, _StarScale2);
    u_xlat15.xy = vec2(1.0, 1.0) / u_xlat15.xy;
    u_xlat0.xw = u_xlat0.xw * u_xlat15.xx;
    u_xlat4.xy = u_xlat2.zx * vec2(-1.0, 1.0);
    u_xlat18.x = dot(u_xlat0.xw, u_xlat2.xz);
    u_xlat18.y = dot(u_xlat0.xw, u_xlat4.xy);
    vs_TEXCOORD2.xy = u_xlat18.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_3.x = sin(u_xlat7.x);
    u_xlat16_5.x = cos(u_xlat7.x);
    u_xlat16_5.x = u_xlat7.y * u_xlat16_5.x;
    u_xlat16_5.y = u_xlat7.y * u_xlat16_3.x;
    u_xlat0.xy = u_xlat1.xy + (-u_xlat16_5.xy);
    u_xlat0.xy = u_xlat15.yy * u_xlat0.xy;
    u_xlat14 = _Time.x * _StarRotationAngle2;
    u_xlat1.x = sin(u_xlat14);
    u_xlat4.x = cos(u_xlat14);
    u_xlat6.z = u_xlat1.x;
    u_xlat6.y = u_xlat4.x;
    u_xlat6.x = (-u_xlat1.x);
    u_xlat1.y = dot(u_xlat0.xy, u_xlat6.xy);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat6.yz);
    vs_TEXCOORD3.xy = u_xlat1.xy + vec2(0.5, 0.5);
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
uniform 	mediump float _StardustSpeed;
uniform 	mediump float _StarBlinkSpeed1;
uniform 	mediump float _StarBlinkSpeed2;
uniform 	mediump vec4 _HexColorTint;
uniform 	mediump float _HexPower;
uniform 	mediump float _HexWaveSpeed;
uniform 	mediump float _HexWaveWidth;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _FxTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
mediump vec4 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec2 u_xlat14;
mediump float u_xlat16_14;
float u_xlat21;
void main()
{
    u_xlat0.xyz = _Time.xyy * vec3(_StardustSpeed, _StarBlinkSpeed1, _StarBlinkSpeed2);
    u_xlat16_1.x = roundEven(u_xlat0.x);
    u_xlat0.xy = sin(u_xlat0.yz);
    u_xlat0.xy = max(u_xlat0.xy, vec2(0.0, 0.0));
    u_xlat16_1.x = _Time.x * _StardustSpeed + (-u_xlat16_1.x);
    u_xlat16_1.x = abs(u_xlat16_1.x) * 140.0 + 10.0;
    u_xlat14.xy = u_xlat16_1.xx * vec2(0.0174532942, -0.0174532942);
    u_xlat2.x = sin(u_xlat14.x);
    u_xlat3.x = cos(u_xlat14.x);
    u_xlat4.x = sin(u_xlat14.y);
    u_xlat5 = cos(u_xlat14.y);
    u_xlat6.z = u_xlat2.x;
    u_xlat6.y = u_xlat3.x;
    u_xlat6.x = (-u_xlat2.x);
    u_xlat14.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.x = dot(u_xlat14.xy, u_xlat6.yz);
    u_xlat2.y = dot(u_xlat14.xy, u_xlat6.xy);
    u_xlat2.xy = u_xlat2.xy + vec2(0.5, 0.5);
    u_xlat16_2 = texture(_FxTex, u_xlat2.xy).x;
    u_xlat3.z = u_xlat4.x;
    u_xlat3.y = u_xlat5;
    u_xlat3.x = (-u_xlat4.x);
    u_xlat4.y = dot(u_xlat14.xy, u_xlat3.xy);
    u_xlat4.x = dot(u_xlat14.xy, u_xlat3.yz);
    u_xlat14.xy = u_xlat4.xy + vec2(0.5, 0.5);
    u_xlat16_14 = texture(_FxTex, u_xlat14.xy).x;
    u_xlat16_1.x = u_xlat16_14 * u_xlat16_2;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD0.xy).w;
    u_xlat21 = _Time.x * _HexWaveSpeed + (-u_xlat16_14);
    u_xlat21 = fract(u_xlat21);
    u_xlat21 = u_xlat21 * 2.0 + -1.0;
    u_xlat21 = abs(u_xlat21) + _HexWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-vec3(u_xlat16_14)) + _HexColorTint.xyz;
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz + vec3(u_xlat16_14);
    u_xlat2.xyz = log2(u_xlat2.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_HexPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_3.xyz * u_xlat2.xyz + u_xlat16_1.xxx;
    u_xlat16_14 = texture(_FxTex, vs_TEXCOORD2.xy).y;
    u_xlat0.xzw = vec3(u_xlat16_14) * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_FxTex, vs_TEXCOORD3.xy).z;
    u_xlat16_3.xyz = vec3(u_xlat16_2) * u_xlat0.yyy + u_xlat0.xzw;
    SV_Target0 = u_xlat16_3;
    return;
}

#endif
"
}
}
}
}
}