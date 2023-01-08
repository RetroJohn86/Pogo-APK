//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Sky/AdditiveWithHeightFog" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (1,1,1,1)
_Alpha ("Alpha", Range(0, 1)) = 1
_DayAlpha ("Daytime Alpha", Range(0, 1)) = 1
_NightAlpha ("Nighttime Alpha", Range(0, 1)) = 1
_TransitionAngle ("Transition Start Angle", Range(0, 90)) = 1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ZWrite Off
  Cull Off
  GpuProgramID 21121
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _DayAlpha;
uniform 	mediump float _NightAlpha;
uniform 	mediump float _Alpha;
uniform 	float _SunAngle;
uniform 	float _TransitionAngle;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.x = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat2 = (-_NightAlpha) + _DayAlpha;
    u_xlat0.x = u_xlat0.x * u_xlat2 + _NightAlpha;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat1 = in_COLOR0 * _TintColor;
    vs_COLOR0.w = u_xlat0.x * u_xlat1.w;
    vs_COLOR0.xyz = u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
mediump vec3 u_xlat16_1;
int u_xlati2;
mediump float u_xlat16_3;
void main()
{
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati2 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati2 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati2;
    u_xlat16_1.x = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_3 = u_xlat0.x * u_xlat0.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
}
}
}
}