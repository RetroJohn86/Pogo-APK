//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/HalloweenPumpkin" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_CarvingTex ("Carving Texture", 2D) = "black" { }
_DayPumpkinColor ("Day Pumpkin Color", Color) = (1,1,1,1)
_NightPumpkinColor ("Night Pumpkin Color", Color) = (0.5,0.5,0.5,1)
_DayCarvingColor ("Carving Day Color", Color) = (1,0.8,0,1)
_NightCarvingColor ("Carving Night Color", Color) = (1,1,1,1)
_FlickerAmount ("Flicker Amount", Float) = 1
_FlickerSpeed ("Flicker Speed", Float) = 1
_FlickerFrequency ("Flicker Frequency", Vector) = (1,1.5,2.8,3.25)
_FlickerDampener ("Flicker Dampener", Vector) = (1,0.2,0.1,0.05)
_TransitionAngle ("Transition Start Angle", Range(0, 90)) = 1
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 63882
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
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
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _CarvingTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat10_1 = texture2D(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat10_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_SV_InstanceID0 = uint(0u);
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
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat2.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    vs_SV_InstanceID0 = uint(0u);
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    vs_SV_InstanceID0 = uint(0u);
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _CarvingTex_ST;
uniform 	mediump vec4 _DayPumpkinColor;
uniform 	mediump vec4 _NightPumpkinColor;
uniform 	mediump vec4 _DayCarvingColor;
uniform 	mediump vec4 _NightCarvingColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _TransitionAngle;
uniform 	mediump float _FlickerAmount;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump vec4 _FlickerFrequency;
uniform 	mediump vec4 _FlickerDampener;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = _DayPumpkinColor + (-_NightPumpkinColor);
    u_xlat16_2 = _SunAngle / _TransitionAngle;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat0 = vec4(u_xlat16_2) * u_xlat0 + _NightPumpkinColor;
    vs_COLOR0 = u_xlat0;
    u_xlat0.x = _Time.w * _FlickerSpeed;
    u_xlat0 = u_xlat0.xxxx * _FlickerFrequency;
    u_xlat0 = sin(u_xlat0);
    u_xlat0.x = dot(u_xlat0, _FlickerDampener);
    u_xlat0.xyz = vec3(vec3(_FlickerAmount, _FlickerAmount, _FlickerAmount)) * u_xlat0.xxx + _NightCarvingColor.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz);
    u_xlat1.w = (-_NightCarvingColor.w);
    u_xlat1 = u_xlat1 + _DayCarvingColor;
    u_xlat0.xyz = vec3(u_xlat16_2) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.w = u_xlat16_2 * u_xlat1.w + _NightCarvingColor.w;
    vs_TEXCOORD2 = u_xlat0;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _CarvingTex_ST.xy + _CarvingTex_ST.zw;
    vs_SV_InstanceID0 = uint(0u);
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
uniform 	mediump vec4 unity_FogColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CarvingTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat10;
void main()
{
    u_xlat16_0.x = 1.0;
    u_xlat16_1 = texture(_CarvingTex, vs_TEXCOORD3.xy);
    u_xlat10 = u_xlat16_0.x * u_xlat16_1.w;
    u_xlat16_0.xyz = vs_TEXCOORD2.xyz;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat2.xyz);
    u_xlat16_0.xyz = vec3(u_xlat10) * u_xlat16_0.xyz + u_xlat2.xyz;
    u_xlat1.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
}
}
}
}