//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/World Map/Water Border" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_DistortIntensity ("Distortion Intensity", Float) = 1
_DistortFrequency ("Distortion Frequency", Float) = 1
_Speed ("Speed", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Stencil {
   Ref 2
   Comp Equal
   Pass IncrSat
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 27636
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_4.xy = texture2DLodEXT(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat10_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_4.xy = texture2DLodEXT(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat10_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
lowp vec2 u_xlat10_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_4.xy = texture2DLodEXT(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat10_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_4.xy = textureLod(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat16_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_4.xy = textureLod(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat16_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
vec2 u_xlat4;
mediump vec2 u_xlat16_4;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat4.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_4.xy = textureLod(_MainTex, u_xlat4.xy, 0.0).xy;
    u_xlat4.xy = u_xlat16_4.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat4.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat0.xyz = _Color.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_6.xy = texture2DLodEXT(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat10_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_6.xy = texture2DLodEXT(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat10_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif
#if !defined(GL_EXT_shader_texture_lod)
#define texture1DLodEXT texture1D
#define texture2DLodEXT texture2D
#define texture2DProjLodEXT texture2DProj
#define texture3DLodEXT texture3D
#define textureCubeLodEXT textureCube
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_0.xy = texture2DLodEXT(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat10_6.xy = texture2DLodEXT(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat10_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat10_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat10_0.x) + 1.0;
    u_xlatb0 = 0.5>=u_xlat16_1.x;
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_6.xy = textureLod(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat16_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_6.xy = textureLod(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat16_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	float _DistortFrequency;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2.xy = u_xlat1.xy * vec2(vec2(_DistortFrequency, _DistortFrequency));
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifdef GL_EXT_shader_texture_lod
#extension GL_EXT_shader_texture_lod : enable
#endif

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
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 _Color;
uniform 	float _DistortIntensity;
uniform 	float _Speed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
float u_xlat2;
vec3 u_xlat5;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
void main()
{
    u_xlat0.x = 0.0;
    u_xlat0.y = _Time.y;
    u_xlat0.xy = (-u_xlat0.xy) * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_0.xy = textureLod(_MainTex, u_xlat0.xy, 0.0).xy;
    u_xlat6.xy = _Time.yy * vec2(vec2(_Speed, _Speed)) + vs_TEXCOORD2.xy;
    u_xlat16_6.xy = textureLod(_MainTex, u_xlat6.xy, 0.0).xy;
    u_xlat6.xy = u_xlat16_6.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat6.xy + u_xlat16_0.xy;
    u_xlat16_1.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_DistortIntensity) + vs_TEXCOORD0.xy;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).z;
    u_xlat16_1.x = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5>=u_xlat16_1.x);
#else
    u_xlatb0 = 0.5>=u_xlat16_1.x;
#endif
    u_xlat0.w = u_xlatb0 ? _Color.w : float(0.0);
    u_xlat2 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-unity_FogColor.xyz) + _Color.xyz;
    u_xlat0.xyz = vec3(u_xlat2) * u_xlat5.xyz + unity_FogColor.xyz;
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