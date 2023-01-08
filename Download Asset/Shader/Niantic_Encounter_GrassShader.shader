//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Encounter/GrassShader" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
[Space] [Header(ENVIRONMENTAL FACTORS____________)] [Space] _WindTex ("Wind Texture", 2D) = "white" { }
_WindTiling ("Wind Tiling", Float) = 1
_WindForce ("Wind Force", Float) = 1
_WindContrast ("WindContrast", Float) = 1
[Space] [Header(GRASS FACTORS____________)] [Space] _GrassWobble ("Grass Wobble", Float) = 1
_WindEffect ("Wind Effect", Float) = 1
_DirectionBias ("Direction Bias", Float) = 0
_RootHeight ("Root Height", Float) = 0.01
_HeightInfluence ("Height Influence", Float) = 1
[Space] [Header(DEBUG____________)] [Space] [Toggle(SHOW_WIND)] _ShowWind ("Show Wind Flow", Float) = 0
[Toggle(SHOW_HEIGHT)] _ShowHeight ("Show Grass Height Influence", Float) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 38937
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(1) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(1) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0;
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(1) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "SHOW_HEIGHT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "SHOW_HEIGHT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "SHOW_HEIGHT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "SHOW_HEIGHT" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "SHOW_HEIGHT" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "SHOW_HEIGHT" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = float(0.0);
    u_xlat0.w = float(1.0);
    u_xlat0.z = vs_TEXCOORD1.y;
    SV_Target0 = u_xlat0.xxzw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlatb2 = _RootHeight<in_POSITION0.y;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = texture2DLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlatb2 = _RootHeight<in_POSITION0.y;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = texture2DLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlatb2 = _RootHeight<in_POSITION0.y;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = texture2DLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "SHOW_WIND" }
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb2 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = textureLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "SHOW_WIND" }
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb2 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = textureLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "SHOW_WIND" }
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
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb2;
float u_xlat4;
void main()
{
    u_xlat0.x = log2(in_POSITION0.y);
    u_xlat0.x = u_xlat0.x * _HeightInfluence;
    u_xlat0.x = exp2(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb2 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat1.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat1.x = _Time.x * _WindForce + u_xlat1.y;
    u_xlat4 = textureLod(_WindTex, u_xlat1.xz, 0.0).x;
    u_xlat4 = u_xlat4 * _WindContrast;
    u_xlat2 = u_xlat4 * u_xlat2;
    vs_TEXCOORD1.x = u_xlat4;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 * _WindEffect;
    u_xlat0.x = (-u_xlat2) * u_xlat0.x + in_POSITION0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
uniform lowp sampler2D _WindTex;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = texture2DLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
    u_xlatb4 = _RootHeight<in_POSITION0.y;
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
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
varying highp vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "SHOW_HEIGHT" "SHOW_WIND" }
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
uniform 	vec4 _WindTex_ST;
uniform 	mediump float _WindTiling;
uniform 	mediump float _DirectionBias;
uniform 	mediump float _WindContrast;
uniform 	mediump float _WindForce;
uniform 	mediump float _GrassWobble;
uniform 	mediump float _WindEffect;
uniform 	mediump float _HeightInfluence;
uniform 	mediump float _RootHeight;
UNITY_LOCATION(0) uniform mediump sampler2D _WindTex;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.yz = (-in_TEXCOORD1.xy) * vec2(_WindTiling);
    u_xlat0.x = _Time.x * _WindForce + u_xlat0.y;
    u_xlat0.x = textureLod(_WindTex, u_xlat0.xz, 0.0).x;
    u_xlat0.x = u_xlat0.x * _WindContrast;
    u_xlat2 = _Time.x * _GrassWobble;
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = u_xlat2 + _DirectionBias;
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WindEffect;
    u_xlat2 = log2(in_POSITION0.y);
    u_xlat2 = u_xlat2 * _HeightInfluence;
    u_xlat2 = exp2(u_xlat2);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_RootHeight<in_POSITION0.y);
#else
    u_xlatb4 = _RootHeight<in_POSITION0.y;
#endif
    u_xlat4 = u_xlatb4 ? 1.0 : float(0.0);
    u_xlat2 = u_xlat2 * u_xlat4;
    u_xlat0.x = (-u_xlat0.x) * u_xlat2 + in_POSITION0.x;
    vs_TEXCOORD1.y = u_xlat2;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.x = in_TEXCOORD1.x * _WindTex_ST.x + _WindTex_ST.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.x;
    u_xlat0.y = float(0.0);
    u_xlat0.w = float(1.0);
    SV_Target0 = u_xlat0.xyyw;
    return;
}

#endif
"
}
}
}
}
}