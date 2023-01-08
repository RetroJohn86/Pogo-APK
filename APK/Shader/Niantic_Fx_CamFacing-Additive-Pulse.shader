//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Fx/CamFacing-Additive-Pulse" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Tint ("Tint (.a = Alpha)", Color) = (1,1,1,1)
_Scale ("Scale", Float) = 1
_Offset ("Offset", Vector) = (0,0,0,0)
_MaxBrightness ("Max Brightness", Float) = 1
_PulseSpeed ("Pulse Speed", Range(0, 5)) = 1
_PulseScale ("Pulse Scale (added to Scale)", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 48230
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
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
uniform 	mediump vec4 _Tint;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat10_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat10_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
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
uniform 	mediump vec4 _Tint;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat10_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat10_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
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
uniform 	mediump vec4 _Tint;
uniform lowp sampler2D _MainTex;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
float u_xlat3;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat10_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat10_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Tint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat16_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat16_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Tint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat16_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat16_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Scale;
uniform 	mediump vec3 _Offset;
uniform 	mediump vec4 _Tint;
uniform 	mediump float _MaxBrightness;
uniform 	mediump float _PulseSpeed;
uniform 	mediump float _PulseScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_7;
void main()
{
    u_xlat0.x = _Time.w * _PulseSpeed;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_1.x = u_xlat0.x * _PulseScale + _Scale;
    u_xlat0.xy = in_POSITION0.xy * u_xlat16_1.xx + _Offset.xxyz.yz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat2.xyz;
    u_xlat16_1.xy = u_xlat0.xy + u_xlat2.xy;
    u_xlat16_7 = u_xlat2.z + _Offset.xxyz.w;
    u_xlat0 = u_xlat16_1.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat16_1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[2] * vec4(u_xlat16_7) + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4x4glstate_matrix_projection[3];
    u_xlat16_1.x = _Tint.w * _MaxBrightness;
    vs_TEXCOORD0.z = u_xlat16_1.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _Tint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat3;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat3 = u_xlat16_0.w * vs_TEXCOORD0.z;
    SV_Target0.xyz = u_xlat16_0.xyz * _Tint.xyz;
    SV_Target0.w = u_xlat3;
    return;
}

#endif
"
}
}
}
}
}