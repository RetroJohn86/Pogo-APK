//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/PoiPowerUp/OrbitalSparkle" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Boost ("Boost", Float) = 0
_FogBias ("fogBias", Range(0, 10)) = 0
_OrbitRadius ("OrbitRadius", Float) = 1
_SpriteScale ("Sprite Scale", Float) = 1
_ScaleInOutSpeed ("Scale In/Out Speed", Float) = 0.25
_OrbitSpeed ("Orbit Speed", Float) = 0.25
_PhaseOffset ("Phase Offset", Float) = 0
_Alpha ("Alpha", Float) = 1
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "CanUseSpriteAtlas" = "true" "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  Blend One One, One One
  ZWrite Off
  GpuProgramID 29517
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
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

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat0.xyz * vec3(_Boost);
    SV_Target0.xyz = u_xlat0.www * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
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
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump vec4 _Color;
uniform 	float _SpriteScale;
uniform 	float _ScaleInOutSpeed;
uniform 	float _PhaseOffset;
uniform 	mediump float _OrbitRadius;
uniform 	mediump float _OrbitSpeed;
uniform 	mediump float _Alpha;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
float u_xlat2;
mediump float u_xlat16_3;
mediump float u_xlat16_7;
vec2 u_xlat8;
void main()
{
    u_xlat0.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[0].xyz, hlslcc_mtx4x4unity_ObjectToWorld[0].xyz);
    u_xlat0.z = dot(hlslcc_mtx4x4unity_ObjectToWorld[2].xyz, hlslcc_mtx4x4unity_ObjectToWorld[2].xyz);
    u_xlat0.xy = sqrt(u_xlat0.xz);
    u_xlat0.z = _Time.x + _PhaseOffset;
    u_xlat0.xyw = u_xlat0.xyz * vec3(_OrbitRadius, _OrbitRadius, _OrbitSpeed);
    u_xlat8.x = u_xlat0.z * _ScaleInOutSpeed;
    u_xlat8.x = sin(u_xlat8.x);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.y = fract(u_xlat0.w);
    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 360.0);
    u_xlat1.x = sin(u_xlat8.y);
    u_xlat2 = cos(u_xlat8.y);
    u_xlat1.y = u_xlat2;
    u_xlat0.xy = u_xlat1.xy * u_xlat0.xy + hlslcc_mtx4x4unity_ObjectToWorld[3].xz;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat16_3 = u_xlat8.x * u_xlat8.x;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat8.x * u_xlat16_3 + -1.0;
    u_xlat16_7 = u_xlat16_3 * 2.0 + 3.0;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7;
    u_xlat0.x = u_xlat16_3 * _SpriteScale;
    u_xlat16_3 = u_xlat16_3 * _Alpha;
    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    u_xlat16_0 = in_COLOR0 * _Color;
    vs_COLOR0.w = u_xlat16_3 * u_xlat16_0.w;
    vs_COLOR0.xyz = u_xlat16_0.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump float _Boost;
uniform 	mediump float _FogBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0.x = vs_TEXCOORD1 + _FogBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * vec3(_Boost) + (-unity_FogColor.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0.xyz = u_xlat1.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
}
}
}
}