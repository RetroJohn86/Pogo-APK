//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/GoFest 2021/Sky/HoloSky" {
Properties {
_SkyTex ("Sky Color Gradient Texture", 2D) = "white" { }
_SkyUvScale ("Sky uv.y scale", Float) = 1
_StarTex ("Star Texture", 2D) = "black" { }
_StarStrength ("Star Brightness", Range(0, 10)) = 0
_StarFalloff ("Star Falloff", Float) = 5
_StarOffset ("Star Offset", Float) = 0.02
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  GpuProgramID 49588
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
uniform lowp sampler2D _SkyTex;
uniform lowp sampler2D _StarTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(vs_TEXCOORD1) + u_xlat10_0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
uniform lowp sampler2D _SkyTex;
uniform lowp sampler2D _StarTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(vs_TEXCOORD1) + u_xlat10_0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
uniform lowp sampler2D _SkyTex;
uniform lowp sampler2D _StarTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_1 * vec4(vs_TEXCOORD1) + u_xlat10_0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
UNITY_LOCATION(0) uniform mediump sampler2D _SkyTex;
UNITY_LOCATION(1) uniform mediump sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_1 * vec4(vs_TEXCOORD1) + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
UNITY_LOCATION(0) uniform mediump sampler2D _SkyTex;
UNITY_LOCATION(1) uniform mediump sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_1 * vec4(vs_TEXCOORD1) + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump float _SkyUvScale;
uniform 	vec4 _StarTex_ST;
uniform 	mediump float _StarFalloff;
uniform 	mediump float _StarOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * _StarTex_ST.xy + _StarTex_ST.zw;
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    u_xlat0.x = u_xlat0.x + _StarOffset;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _StarFalloff;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    vs_TEXCOORD1 = u_xlat0.x;
    vs_TEXCOORD2.y = in_TEXCOORD0.y * _SkyUvScale;
    vs_TEXCOORD2.x = in_TEXCOORD0.x;
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
UNITY_LOCATION(0) uniform mediump sampler2D _SkyTex;
UNITY_LOCATION(1) uniform mediump sampler2D _StarTex;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_SkyTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_StarTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_1 * vec4(vs_TEXCOORD1) + u_xlat16_0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}