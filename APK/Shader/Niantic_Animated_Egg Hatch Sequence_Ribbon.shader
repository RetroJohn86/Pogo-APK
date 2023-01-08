//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Animated/Egg Hatch Sequence/Ribbon" {
Properties {
_MaskTex ("Mask Texture", 2D) = "white" { }
_FrontColor ("Front Color", Color) = (1,0,0,1)
_BackColor ("Back Color", Color) = (0,1,0,1)
_OuterEdgeMaskFalloff ("Outside Edge Mask Falloff", Range(0, 11)) = 4
_Brightness ("Brightness", Range(0, 1)) = 1
_BrightnessScalar ("Brightness Scalar", Float) = 2
_Alpha ("Alpha", Range(0, 1)) = 1
_Wipe ("Wipe", Range(0, 1)) = 0.5
_ScrollSpeed ("Scroll Speed", Float) = 0.1
_RingRadius ("Ring Radius", Float) = 0
[Space] [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 2
[Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend mode 2", Float) = 0
[Toggle] _ZWrite ("Z Write", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 42120
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
uniform lowp sampler2D _MaskTex;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture2D(_MaskTex, u_xlat0.xz).x;
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _Wipe;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
float u_xlat3;
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
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
    u_xlat16_2 = _Wipe + -0.5;
    vs_TEXCOORD1.x = u_xlat16_2 + u_xlat16_2;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    u_xlat3 = u_xlat0.x * 0.660000026;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD1.y = u_xlat0.x;
    u_xlat0.x = fract(u_xlat3);
    vs_TEXCOORD1.z = u_xlat0.x;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _FrontColor;
uniform 	mediump vec3 _BackColor;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _RingRadius;
uniform 	mediump float _Alpha;
uniform 	mediump float _Wipe;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1 = u_xlat0.x + (-_RingRadius);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_3.x = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_3.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = u_xlat16_1 * _Alpha;
    u_xlat0.z = vs_TEXCOORD0.x;
    u_xlat0.xy = vs_TEXCOORD0.yy + vs_TEXCOORD1.yx;
    u_xlat0.xz = u_xlat0.zx * _MaskTex_ST.xy + _MaskTex_ST.zw;
    u_xlat2.x = u_xlat0.y * 3.0;
    u_xlat0.x = texture(_MaskTex, u_xlat0.xz).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = vs_TEXCOORD0.y + _Wipe;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _FrontColor.xyz + (-_BackColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + _BackColor.xyz;
    u_xlat16_3.x = _BrightnessScalar * _Brightness;
    u_xlat16_3.x = max(u_xlat16_3.x, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xxx;
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1;
    return;
}

#endif
"
}
}
}
}
}