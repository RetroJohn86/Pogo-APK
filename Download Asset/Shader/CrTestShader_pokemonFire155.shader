//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CrTestShader/pokemonFire155" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
[MaterialToggle] _useTex ("use Texture Color", Float) = 0
_Color ("Color1", Color) = (1,0.9310346,0,1)
_gradation ("gradation", Range(0, 5)) = 1
_gradationPower ("gradationPower", Range(0.1, 10)) = 1
[MaterialToggle] _useTexAlpha ("use Texture Alpha", Float) = 1
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Space] [Header(STENCIL_ID_SORTING___________________)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_Stencil ("Stencil ID", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha DstAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 10540
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat10_0.w + -1.0;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
    u_xlatb9 = u_xlat9<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat10_0.w + -1.0;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
    u_xlatb9 = u_xlat9<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat10_0.w + -1.0;
    u_xlat0.xyz = u_xlat10_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
    u_xlatb9 = u_xlat9<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat16_0.w + -1.0;
    u_xlat0.xyz = u_xlat16_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat16_0.w + -1.0;
    u_xlat0.xyz = u_xlat16_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _useTex;
uniform 	float _gradation;
uniform 	float _gradationPower;
uniform 	mediump float _useTexAlpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec3 u_xlat2;
float u_xlat4;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat9 = u_xlat16_0.w + -1.0;
    u_xlat0.xyz = u_xlat16_0.xyz + (-_Color.xyz);
    u_xlat0.xyz = vec3(_useTex) * u_xlat0.xyz + _Color.xyz;
    u_xlat9 = _useTexAlpha * u_xlat9 + 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9<0.0);
#else
    u_xlatb9 = u_xlat9<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = log2(vs_COLOR0.w);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat1 = min(_gradation, 1.0);
    u_xlat9 = u_xlat9 * u_xlat1;
    u_xlat4 = max(_gradation, 1.0);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat4 = u_xlat4 + u_xlat4;
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.949999988, 0.949999988, 0.949999988);
    u_xlat0.xyz = log2(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat4);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = (-u_xlat2.xyz) + u_xlat0.xyz;
    u_xlat9 = (-vs_COLOR0.w) + 1.0;
    u_xlat9 = log2(u_xlat9);
    u_xlat9 = u_xlat9 * _gradationPower;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = u_xlat1 * u_xlat9;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz + u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}