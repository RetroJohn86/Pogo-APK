//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UltraWormhole/WormholeShader" {
Properties {
[Header(Colors_____________)] [Space] _MainTex ("Albedo (RGB)", 2D) = "white" { }
_CracksTex ("Albedo (RGB)", 2D) = "white" { }
_AlphaTex ("Transparency", 2D) = "white" { }
_ColorIntensity ("Color Intensity", Float) = 0.5
[Space] [Header(Grid_____________)] [Space] _GridTex ("Albedo (RGB)", 2D) = "white" { }
_Intensity ("Intensity", Float) = 0.5
[Space] [Header(FX_____________)] [Space] _cOverride ("Color override (rgb = color, a = blend)", Color) = (1,1,1,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 23215
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GridTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _CracksTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture2D(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture2D(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat10_0.x * u_xlat10_0.y;
    u_xlat10_0.xy = texture2D(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat10_0.z + u_xlat10_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GridTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _CracksTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture2D(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture2D(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat10_0.x * u_xlat10_0.y;
    u_xlat10_0.xy = texture2D(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat10_0.z + u_xlat10_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _GridTex;
uniform lowp sampler2D _AlphaTex;
uniform lowp sampler2D _CracksTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0.xyz = texture2D(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat10_0.xyz = texture2D(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat10_0.x * u_xlat10_0.y;
    u_xlat10_0.xy = texture2D(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat10_0.z + u_xlat10_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _GridTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CracksTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = texture(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat16_0.x * u_xlat16_0.y;
    u_xlat16_0.xy = texture(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat16_0.z + u_xlat16_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _GridTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CracksTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = texture(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat16_0.x * u_xlat16_0.y;
    u_xlat16_0.xy = texture(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat16_0.z + u_xlat16_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _CracksTex_ST;
uniform 	vec4 _GridTex_ST;
uniform 	vec4 _AlphaTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _CracksTex_ST.xy + _CracksTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _GridTex_ST.xy + _GridTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _AlphaTex_ST.xy + _AlphaTex_ST.zw;
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
uniform 	mediump float _ColorIntensity;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _cOverride;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _GridTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CracksTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0.xyz = texture(_GridTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_Intensity, _Intensity, _Intensity));
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(_ColorIntensity) + u_xlat16_1.xyz;
    u_xlat16_0.xyz = texture(_CracksTex, vs_TEXCOORD1.xy).yzw;
    u_xlat16_10 = u_xlat16_0.x * u_xlat16_0.y;
    u_xlat16_0.xy = texture(_AlphaTex, vs_TEXCOORD3.xy).xy;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xxx + vec3(u_xlat16_10);
    SV_Target0.w = u_xlat16_0.z + u_xlat16_0.y;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _cOverride.xyz;
    SV_Target0.xyz = _cOverride.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    return;
}

#endif
"
}
}
}
}
}