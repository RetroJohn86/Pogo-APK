//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Sky/Moon" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Phase ("Phase", Range(0, 6.2831855)) = 0.6
_Dim ("Dimness", Range(0, 1)) = 0.05
_Alpha ("Alpha", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 45494
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
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
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
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
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    SV_Target0.w = u_xlat0.x;
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? -1 : 0);
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
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
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0 = in_TEXCOORD0.xyxy * vec4(1.0, 1.0, 2.0, 2.0) + vec4(0.0, 0.0, -1.0, -1.0);
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
uniform 	float _Phase;
uniform 	float _Alpha;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
int u_xlati0;
mediump float u_xlat16_1;
vec2 u_xlat2;
float u_xlat3;
float u_xlat4;
int u_xlati4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.zw, vs_TEXCOORD0.zw);
    u_xlat16_1 = (-u_xlat0.x) + 1.0;
    u_xlat16_5.x = u_xlat0.x + -0.899999976;
    u_xlat16_5.x = u_xlat16_5.x * 9.99999809;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.x = min(max(u_xlat16_5.x, 0.0), 1.0);
#else
    u_xlat16_5.x = clamp(u_xlat16_5.x, 0.0, 1.0);
#endif
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_6 = sqrt(u_xlat16_1);
    u_xlat2.y = u_xlat16_6;
    u_xlat2.x = vs_TEXCOORD0.z;
    u_xlat0.x = sin(_Phase);
    u_xlat3 = cos(_Phase);
    u_xlat0.y = u_xlat3;
    u_xlat0.x = dot((-u_xlat0.xxyy), u_xlat2.xxyy);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat4 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat4;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1 = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_5.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlat0.x = u_xlat0.x * _Alpha;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<vs_TEXCOORD1.y; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<vs_TEXCOORD1.y) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = vs_TEXCOORD1.y<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((vs_TEXCOORD1.y<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlat16_1 = float(u_xlati0);
    u_xlat0.x = vs_TEXCOORD1.y * 0.0333333351;
    u_xlat16_5.x = u_xlat0.x * u_xlat0.x;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_5.xyz + unity_FogColor.xyz;
    return;
}

#endif
"
}
}
}
}
}