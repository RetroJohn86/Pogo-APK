//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/AR Photo Proximity Blur" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 21524
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
varying mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat10_0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat10_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
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
    u_xlat16_2.xy = in_TEXCOORD0.xy + _MainTex_TexelSize.xy;
    u_xlat0.xy = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1 = _MainTex_TexelSize.xyxy * vec4(-0.5, -0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat16_1.zwxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat0.zw = u_xlat1.zw;
    phase0_Output0_1 = u_xlat0;
    u_xlat16_2.xy = _MainTex_TexelSize.xy * vec2(-0.5, 0.5) + in_TEXCOORD0.xy;
    u_xlat1.zw = u_xlat16_2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_2 = u_xlat1;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
vs_TEXCOORD2 = phase0_Output0_2.xy;
vs_TEXCOORD3 = phase0_Output0_2.zw;
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
uniform 	mediump vec4 _Parameter;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat0 = u_xlat0 + u_xlat16_1;
    u_xlat16_1 = u_xlat0 * vec4(0.25, 0.25, 0.25, 0.25);
    u_xlat16_0 = (-u_xlat0) * vec4(0.25, 0.25, 0.25, 0.25) + _Color;
    SV_Target0 = _Parameter.yyyy * u_xlat16_0 + u_xlat16_1;
    return;
}

#endif
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 117332
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.xw = _Parameter.xx;
    u_xlat16_0.y = float(1.0);
    u_xlat16_0.z = float(0.0);
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 132370
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
lowp vec4 u_xlat10_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
#define UNITY_DYNAMIC_INDEX_ES2 0



vec4 ImmCB_0DynamicIndex(int i){
#if UNITY_DYNAMIC_INDEX_ES2
    return ImmCB_0[i];
#else
#define d_ar ImmCB_0
    if (i <= 0) return d_ar[0]; else if (i == 1) return d_ar[1]; else if (i == 2) return d_ar[2]; else if (i == 3) return d_ar[3]; else if (i == 4) return d_ar[4]; else if (i == 5) return d_ar[5]; else if (i == 6) return d_ar[6];
    return d_ar[0];
#undef d_ar
#endif
}

void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat10_3 = texture2D(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat10_3 * ImmCB_0DynamicIndex(u_xlati_loop_1).xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _Parameter;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD0.zw = vec2(1.0, 1.0);
    u_xlat16_0.x = float(1.0);
    u_xlat16_0.w = float(0.0);
    u_xlat16_0.yz = _Parameter.xx;
    u_xlat16_2.xy = u_xlat16_0.xy * _MainTex_TexelSize.xy;
    vs_TEXCOORD1.xy = u_xlat16_0.zw * u_xlat16_2.xy;
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
vec4 ImmCB_0[7];
uniform 	mediump vec4 _MainTex_ST;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
int u_xlati2;
mediump vec4 u_xlat16_3;
vec2 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_8;
void main()
{
ImmCB_0[0] = vec4(0.0205000006,0.0,0.0,0.0);
ImmCB_0[1] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[2] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[3] = vec4(0.324000001,0.0,0.0,1.0);
ImmCB_0[4] = vec4(0.231999993,0.0,0.0,0.0);
ImmCB_0[5] = vec4(0.0855000019,0.0,0.0,0.0);
ImmCB_0[6] = vec4(0.0205000006,0.0,0.0,0.0);
    u_xlat16_0.xy = (-vs_TEXCOORD1.xy) * vec2(3.0, 3.0) + vs_TEXCOORD0.xy;
    u_xlat16_1.x = float(0.0);
    u_xlat16_1.y = float(0.0);
    u_xlat16_1.z = float(0.0);
    u_xlat16_1.w = float(0.0);
    u_xlat16_8.xy = u_xlat16_0.xy;
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<7 ; u_xlati_loop_1++)
    {
        u_xlat6.xy = u_xlat16_8.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        u_xlat16_3 = texture(_MainTex, u_xlat6.xy);
        u_xlat16_1 = u_xlat16_3 * ImmCB_0[u_xlati_loop_1].xxxw + u_xlat16_1;
        u_xlat16_8.xy = u_xlat16_8.xy + vs_TEXCOORD1.xy;
    }
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
}
}
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 208835
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
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
uniform 	mediump vec4 _Color;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = _Color;
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
uniform 	mediump vec4 _Color;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = _Color;
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
uniform 	mediump vec4 _Color;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = _Color;
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
uniform 	mediump vec4 _Color;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
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
uniform 	mediump vec4 _Color;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
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
uniform 	mediump vec4 _Color;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = _Color;
    return;
}

#endif
"
}
}
}
}
}