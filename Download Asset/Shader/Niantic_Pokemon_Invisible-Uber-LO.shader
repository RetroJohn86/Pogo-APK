//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/Invisible-Uber-LO" {
Properties {
[Header(Invisibility Properties)] _invisibility ("Invisibility Power", Range(0, 1)) = 1
_FadeOffset ("Fade Time Offset", Float) = 0
_FadeSpeed ("Fade Speed", Float) = 1
[Space] [Header(Fresnel)] [Space] _FresnelColor1 ("Fresnel Color Far", Color) = (1,1,1,1)
_FresnelColor2 ("Fresnel Color Close", Color) = (1,1,1,1)
_FresnelPower1 ("Fresnel Power Far", Range(0.001, 24)) = 1
_FresnelPower2 ("Fresnel Power Close", Range(0.001, 8)) = 1
_CamDistScale ("Camera Dist Scale", Float) = 1
_AddPower ("Fresnel Additive Power", Float) = 1
[Space] [Header(Base Pokemon_UBER Properties)] [Space] _Color ("Color", Color) = (1,1,1,1)
_FaceTex ("Face Texture", 2D) = "clear" { }
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_FxMaskTex ("Fx Mask Texture", 2D) = "clear" { }
_FxMagnitude_A ("Light Magnitude_A", Range(0, 1)) = 1
_FxMagnitude_B ("Light Magnitude_B", Range(0, 1)) = 1
_FxTint ("Light Tint", Color) = (1,1,1,1)
_FxTintBG ("Light Tint Falloff", Color) = (1,1,1,1)
_FxMainColor ("Light Main Color", Color) = (1,1,1,1)
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap", Range(0, 1)) = 0
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(AO_MODE______________________________)] [Space] _vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_vAmOcPower ("vAmbOcclusion Power", Range(0.1, 10)) = 1
_vAmTxPower ("vAmbTexture Power", Range(1, 10)) = 5
_EyeSpec ("Specular", Range(0, 1)) = 1
_EyeGloss ("Glossiness", Range(0.025, 100)) = 0.95
_EyeColorPower ("Eye Color Power", Range(0, 1)) = 0.5
_EyeColor ("Eye Color", Color) = (1,1,1,0)
[Header(STENCIL_ID_SORTING___________________)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Space] [Header(ANIM_UV_A___________________________)] [Space] _uv0 ("_uv0_A", Vector) = (0,0,4,0)
_uv1 ("_uv1_A", Vector) = (0,0,4,2)
_uv2 ("_uv2_A", Vector) = (0,0,4,2)
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Enum(UnityEngine.Rendering.ColorWriteMask)] _ColorMask ("Z ColorMask", Float) = 15
[Enum(UnityEngine.Rendering.BlendMode)] _BlendRGBSrc ("Blend Mode Src Factor RGB", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _BlendRGBDst ("Blend Mode Dst Factor RGB", Float) = 10
[Enum(UnityEngine.Rendering.BlendMode)] _BlendAlphaSrc ("Blend Mode Src Factor Alpha", Float) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _BlendAlphaDst ("Blend Mode Dst Factor Alpha", Float) = 10
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  ColorMask 0 0
  Fog {
   Mode Off
  }
  GpuProgramID 77375
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
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
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
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
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
attribute highp vec3 in_POSITION0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
varying mediump vec4 vs_COLOR0;
varying mediump float vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
in mediump vec4 vs_COLOR0;
in mediump float vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
in mediump vec4 vs_COLOR0;
in mediump float vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
in highp vec3 in_POSITION0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_COLOR0;
out mediump float vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0 = min(max(vs_COLOR0, 0.0), 1.0);
#else
    vs_COLOR0 = clamp(vs_COLOR0, 0.0, 1.0);
#endif
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD0 = u_xlat0.x;
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
uniform 	mediump vec4 unity_FogColor;
in mediump vec4 vs_COLOR0;
in mediump float vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz + (-unity_FogColor.xyz);
    SV_Target0.xyz = vec3(vs_TEXCOORD0) * u_xlat16_0.xyz + unity_FogColor.xyz;
    SV_Target0.w = vs_COLOR0.w;
    return;
}

#endif
"
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 44612
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat10_2 = textureCubeLodEXT(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat10_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_1.xxx;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat10_0 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat10_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat10_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat10_0);
    u_xlat16_28 = u_xlat10_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat10_0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat10_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat10_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat10_2 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat10_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat10_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat10_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat10_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat10_3.xyz = texture2D(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat10_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat10_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _CharacterColor;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
mediump float u_xlat16_9;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
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
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    vs_TEXCOORD0.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD2.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD2.zw = u_xlat3.xy;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD3.x = min(max(vs_TEXCOORD3.x, 0.0), 1.0);
#else
    vs_TEXCOORD3.x = clamp(vs_TEXCOORD3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_4 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD3.z = u_xlat1.x;
    vs_TEXCOORD3.w = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD4.xy = u_xlat1.xy;
    vs_TEXCOORD4.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    u_xlat0.w = exp2(u_xlat0.x);
    u_xlat0.x = float(1.0);
    u_xlat0.y = float(1.0);
    u_xlat0.z = float(1.0);
    u_xlat0 = u_xlat0 * _CharacterColor;
    vs_TEXCOORD5 = u_xlat0;
    vs_TEXCOORD6 = in_POSITION0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _Color;
uniform 	float _FadeSpeed;
uniform 	mediump float _FadeOffset;
uniform 	float _CamDistScale;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump float _invisibility;
uniform 	mediump vec4 _FresnelColor1;
uniform 	mediump vec4 _FresnelColor2;
uniform 	mediump float _FresnelPower1;
uniform 	mediump float _FresnelPower2;
uniform 	mediump float _AddPower;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _EyeColorPower;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_13;
mediump vec3 u_xlat16_14;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_28;
float u_xlat30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = (-_EyeGloss) + 1.0;
    u_xlat16_1.x = (-u_xlat0.x) * 0.699999988 + 1.70000005;
    u_xlat16_1.x = u_xlat0.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 6.0;
    u_xlat16_10.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_10.x = inversesqrt(u_xlat16_10.x);
    u_xlat16_10.xyz = u_xlat16_10.xxx * vs_TEXCOORD0.xyz;
    u_xlat0.xyz = u_xlat16_10.xyz + u_xlat16_10.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat2.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat3.xyz, u_xlat16_10.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat0.xyz = (-u_xlat0.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat3.xyz);
    u_xlat27 = (-u_xlat16_31) + 1.0;
    u_xlat16_2 = textureLod(unity_SpecCube0, u_xlat0.xyz, u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_2.w + -1.0;
    u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
    u_xlat16_5.xyz = u_xlat16_2.xyz * u_xlat16_1.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = vec3(u_xlat27) * u_xlat16_5.xyz;
    u_xlat16_1.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.x = dot(u_xlat16_10.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat0.x = log2(u_xlat16_1.x);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat0.x = u_xlat0.x * u_xlat9;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz + u_xlat16_5.xyz;
    u_xlat16_0 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_28 = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_28 = log2(u_xlat16_28);
    u_xlat16_28 = u_xlat16_28 * _EyeColorPower;
    u_xlat16_28 = exp2(u_xlat16_28);
    u_xlat16_2 = (-u_xlat16_0) + vec4(u_xlat16_28);
    u_xlat16_2 = _EyeColor.wwww * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = _EyeColor * u_xlat16_2 + (-u_xlat16_0);
    u_xlat16_28 = u_xlat16_0.w + (-vs_TEXCOORD2.z);
    u_xlat16_28 = vs_TEXCOORD2.w * u_xlat16_28 + vs_TEXCOORD2.z;
    u_xlat16_4.x = u_xlat16_28 + -0.100000001;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_4.xxxx * u_xlat16_2 + u_xlat16_0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_2);
    u_xlat16_0 = vs_TEXCOORD2.wwww * u_xlat16_0 + u_xlat16_2;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_31 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat16_5.x = (-u_xlat16_31) + 1.0;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _vAmTxPower;
    u_xlat16_4.xyz = u_xlat16_5.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_31) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_31 = _cKeyf.w + _cKeyf.w;
    u_xlat16_5.x = _cRimt.w + _cRimt.w;
    u_xlat16_14.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = u_xlat16_14.xyz * _cRimt.xyz;
    u_xlat16_2 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_14.xyz = u_xlat16_2.xxx * u_xlat16_14.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_14.xyz;
    u_xlat16_6.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cKeyf.xyz;
    u_xlat16_6.xyz = u_xlat16_2.zzz * u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = u_xlat16_6.xyz * _cRimb.xyz;
    u_xlat16_6.xyz = u_xlat16_2.www * u_xlat16_6.xyz;
    u_xlat16_31 = _cRimb.w + _cRimb.w;
    u_xlat16_7.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_7.xyz = u_xlat16_2.yyy * u_xlat16_7.xyz + _cAmbn.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_31) + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat16_5.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(_Amount_Blend);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vs_TEXCOORD3.zzz + (-u_xlat16_4.xyz);
    u_xlat16_31 = log2(vs_TEXCOORD3.w);
    u_xlat16_31 = u_xlat16_31 * _vAmOcPower;
    u_xlat16_31 = exp2(u_xlat16_31);
    u_xlat16_4.xyz = vec3(u_xlat16_31) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = texture(_FxMaskTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_5.xyz = u_xlat16_3.xyz * vec3(vec3(_FxMagnitude_A, _FxMagnitude_A, _FxMagnitude_A));
    u_xlat3.xyz = u_xlat16_5.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.xyz = u_xlat3.xyz * _FxTint.xyz;
    u_xlat3.xyz = u_xlat16_2.xxx * u_xlat3.xyz;
    u_xlat3.xyz = vec3(u_xlat16_31) * u_xlat3.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD3.www + u_xlat16_4.xyz;
    u_xlat8.xyz = vs_TEXCOORD6.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD6.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD6.zzz + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * vs_TEXCOORD6.www + u_xlat8.xyz;
    u_xlat8.xyz = (-u_xlat8.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = inversesqrt(u_xlat30);
    u_xlat8.xyz = vec3(u_xlat30) * u_xlat8.xyz;
    u_xlat30 = dot(vs_TEXCOORD0.xyz, u_xlat8.xyz);
    u_xlat16_4.x = (-u_xlat30) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat8.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat8.xyz;
    u_xlat8.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat8.xyz;
    u_xlat8.xyz = u_xlat8.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat8.xyz = u_xlat8.xyz + (-vs_TEXCOORD6.xyz);
    u_xlat30 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat30 = sqrt(u_xlat30);
    u_xlat30 = u_xlat30 * _CamDistScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat16_13 = (-_FresnelPower2) + _FresnelPower1;
    u_xlat16_13 = u_xlat30 * u_xlat16_13 + _FresnelPower2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_13;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_2 = _FresnelColor2.wwww * _FresnelColor2;
    u_xlat16_5 = _FresnelColor1 * _FresnelColor1.wwww + (-u_xlat16_2);
    u_xlat16_2 = vec4(u_xlat30) * u_xlat16_5 + u_xlat16_2;
    u_xlat16_2 = u_xlat16_2 * u_xlat16_4.xxxx;
    u_xlat30 = _Time.w / _FadeSpeed;
    u_xlat30 = u_xlat30 + _FadeOffset;
    u_xlat30 = sin(u_xlat30);
    u_xlat16_4.x = max(u_xlat30, 0.0);
    u_xlat16_22 = (-u_xlat16_4.x) * _invisibility + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * _invisibility;
    u_xlat16_5.xyz = u_xlat16_2.xyz * vec3(u_xlat16_22);
    u_xlat16_31 = log2(u_xlat16_2.w);
    u_xlat16_13 = u_xlat16_31 * u_xlat16_13;
    u_xlat16_13 = exp2(u_xlat16_13);
    u_xlat16_13 = u_xlat16_22 * u_xlat16_13;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat3.xyz * _Color.xyz + u_xlat16_5.xyz;
    u_xlat16_22 = _EyeColor.w * (-_EyeSpec) + _EyeSpec;
    u_xlat16_22 = u_xlat16_28 * u_xlat16_22;
    u_xlat16_28 = (-u_xlat16_28) + u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_28 = min(max(u_xlat16_28, 0.0), 1.0);
#else
    u_xlat16_28 = clamp(u_xlat16_28, 0.0, 1.0);
#endif
    u_xlat16_31 = (-u_xlat16_0.w) + 1.0;
    u_xlat16_4.x = u_xlat16_31 * u_xlat16_4.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + u_xlat16_5.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-vs_TEXCOORD5.xyz);
    SV_Target0.xyz = vs_TEXCOORD5.www * u_xlat16_1.xyz + vs_TEXCOORD5.xyz;
    u_xlat16_1.x = (-u_xlat16_28) + 1.0;
    u_xlat16_1.x = u_xlat16_4.x * u_xlat16_1.x + u_xlat16_28;
    SV_Target0.w = _AddPower * u_xlat16_13 + u_xlat16_1.x;
    return;
}

#endif
"
}
}
}
}
CustomEditor "PokemonShaderGui"
}