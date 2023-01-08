//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Fx/Hologram" {
Properties {
_Color ("Tint Color", Color) = (1,1,1,1)
_MainTex ("Texture", 2D) = "white" { }
_RampTex ("Ramp", 2D) = "white" { }
_ScanFrequency ("Scan Line Frequency", Float) = 1.5
_ScanSpeed ("Scan Line Speed", Float) = 100
_ScanMin ("Scan Strength (Minimum)", Float) = 0.5
_ScanMax ("Scan Strength (Maximum)", Float) = 1
_ScanColor ("Scan Color", Color) = (0.29411766,0.6509804,0.7137255,0.3647059)
_RandomOffset ("Random Offset (set by code per instance)", Vector) = (1,2,1,0)
_FlickerOffsetTime ("Flicker Offset Time", Float) = 20
_FlickerSpeed ("Flicker Speed", Float) = 1
_PhaseSpeed ("Phase Speed", Float) = 1
_PhaseEndBias ("Phase End Bias", Float) = 1
_PhaseInBias ("Phase In Bias", Range(0, 1)) = 0.1
_UseRampTex ("Use Ramp Tex", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 4773
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_2.x;
    u_xlat10_1 = texture2D(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat10_2.xyz);
    u_xlat16_0.w = (-u_xlat10_2.w) + u_xlat10_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_2.x;
    u_xlat10_1 = texture2D(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat10_2.xyz);
    u_xlat16_0.w = (-u_xlat10_2.w) + u_xlat10_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat10_2.x;
    u_xlat10_1 = texture2D(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat10_1.xyz * u_xlat16_0.xyz + (-u_xlat10_2.xyz);
    u_xlat16_0.w = (-u_xlat10_2.w) + u_xlat10_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat10_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1 = min(max(vs_TEXCOORD1, 0.0), 1.0);
#else
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat16_2.x;
    u_xlat16_1 = texture(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_0.w = (-u_xlat16_2.w) + u_xlat16_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1 = min(max(vs_TEXCOORD1, 0.0), 1.0);
#else
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat16_2.x;
    u_xlat16_1 = texture(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_0.w = (-u_xlat16_2.w) + u_xlat16_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    vs_TEXCOORD1 = u_xlat0.x + _PhaseEndBias;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1 = min(max(vs_TEXCOORD1, 0.0), 1.0);
#else
    vs_TEXCOORD1 = clamp(vs_TEXCOORD1, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMin;
uniform 	mediump float _ScanMax;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _UseRampTex;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0.xyz = _Color.xyz + _Color.xyz;
    u_xlat1.y = 0.5;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = u_xlat16_2.x;
    u_xlat16_1 = texture(_RampTex, u_xlat1.xy);
    u_xlat16_0.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_0.w = (-u_xlat16_2.w) + u_xlat16_1.w;
    u_xlat16_0 = vec4(vec4(_UseRampTex, _UseRampTex, _UseRampTex, _UseRampTex)) * u_xlat16_0 + u_xlat16_2;
    u_xlat16_0 = u_xlat16_0 + (-_ScanColor);
    u_xlat1.x = _Time.x * _ScanSpeed;
    u_xlat1.x = hlslcc_FragCoord.y * _ScanFrequency + u_xlat1.x;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, _ScanMin);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat1.x = max(u_xlat1.x, vs_TEXCOORD1);
    u_xlat1.x = min(u_xlat1.x, _ScanMax);
    u_xlat16_3 = max(u_xlat1.x, _ScanColor.w);
    SV_Target0 = vec4(u_xlat16_3) * u_xlat16_0 + _ScanColor;
    return;
}

#endif
"
}
}
}
}
}