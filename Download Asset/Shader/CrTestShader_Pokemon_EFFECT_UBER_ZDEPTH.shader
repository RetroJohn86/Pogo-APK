//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CrTestShader/Pokemon_EFFECT_UBER_ZDEPTH" {
Properties {
[Toggle(NIANTIC_MATERIAL_B)] _MaterialB ("Material Block B", Float) = 0
[Space] [Header(__Main texture______________________________)] [Space] _Color ("Main Color", Color) = (0.8,0.8,0.8,1)
_MainTex ("Main Texture", 2D) = "white" { }
_TransUvMainTex_A ("Input UV animation (x,y): MainA", Vector) = (0,0,0,0)
_TransUvMainTex_B ("Input UV animation (x,y): MainB", Vector) = (0,0,0,0)
[Space] [KeywordEnum(Default,withFlow,withRoundTrip,Matcap)] _UVMAIN ("UV mode : Main", Float) = 0
[Space] _FlowMainUv ("Flow-Speed(x,y)/Round-Width(x,y)Speed(z,w)", Vector) = (-0.02,-0.2,16,1)
_RoundTripSmoothnessMain ("Round trip:Smoothness", Range(0, 1)) = 0
_MainColor ("Tint Color", Color) = (1,1,1,1)
[Space] [Header(__LookDev system______________________________)] [Space] [KeywordEnum(Default,Flat,SandoBox1)] _LOOKDEV ("LookDev mode", Float) = 0
[Space] _Ramp2D ("BRDF Ramp", 2D) = "grey" { }
[Space] _cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] _vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_vAmOcPower ("vAmbOcclusion Power", Range(0.1, 10)) = 1
_vAmTxPower ("vAmbTexture Power", Range(1, 10)) = 5
[Space] [Header(__Layer system______________________________)] [Space] [MaterialToggle] _UseLayer ("Use Layer system", Float) = 0
[Space] [KeywordEnum(Emission, Addition, Multiply, Decal, None)] _LAYERMODE ("Layer mode", Float) = 0
[Space] _EmiAddColor ("Add Emission mode color", Color) = (0.54,0.54,0.54,1)
[Space] [Header(_Layer texture_)] [Space] _LayerColor ("Layer Color", Color) = (1,1,1,1)
_LayerMap ("Layer Texture", 2D) = "white" { }
_TransUvLayerMap_A ("Input UV animation (x,y) : LayerA", Vector) = (0,0,0,0)
_TransUvLayerMap_B ("Input UV animation (x,y) : LayerB", Vector) = (0,0,0,0)
[Space] [KeywordEnum(Default,withFlow,withRoundTrip,Matcap,None)] _UVLAY ("UV mode : Layer", Float) = 0
[Space] [MaterialToggle] _SwitchUVset2Layer ("use Multi UV (uv1)", Float) = 0
[Space] _FlowLayerUv ("Flow-Speed(x,y)/Round-Width(x,y)Speed(z,w)", Vector) = (0.05,0.4,16,1)
_RoundTripSmoothness ("Round trip:Smoothness", Range(0, 1)) = 0
[Space] [Header(_Layer Mask_)] [Space] [KeywordEnum(LayerAlpha,MainAlpha,BothAlpha,None)] _MASK1 ("Select Texture mask", Float) = 0
[Space] [KeywordEnum(None,withAnimation,withVC,withVCwithAnima,LocalUp)] _MASK2 ("Select Mask mode", Float) = 1
[Space] _LayerInputAnima_A ("Input Color Animation A (x)", Float) = 1
[Space] _LayerInputAnima_B ("Input Color Animation B (x)", Float) = 1
[Space] [Header(_Layer Mask_Local Up)] [Space] _LocalUpScale ("Scale Up", Range(0, 1)) = 1
_LocalUpOffset ("Offset Up", Range(-0.5, 0.5)) = 0
[Space] [Header(__Alpha system______________________________)] [Space] [KeywordEnum(MainAlpha, LayerAlpha, BothAlpha, AddAlpha, None)] _ALPHA1 ("select Texture alpha", Float) = 0
[KeywordEnum(None, withVC, withAnimation, withVCwithAnima, AddAnimation, GlabalY)] _ALPHA2 ("select Alpha mode", Float) = 0
_AlphaOffSet ("Alpha Offset", Range(0, 1)) = 1
[Space] [Header(__Blend system______________________________)] [Space] [MaterialToggle] _UseCutout ("Use Cutout", Float) = 0
_Cutoff ("Adjust Cutout", Range(0, 1)) = 0.5
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2
[Space] [Header(_Blend mode_)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Enum(Off, 0, On, 1)] _ZWrite ("Z Write", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Factor", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Factor", Float) = 0
_BlendMode ("__mode", Float) = 0
[Space] [Header(_Stencil_)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Space] [Header(__Final Adjustment______________________________)] [Space] _FinalAlphaAdjust_A ("Final Alpha Multiply", Range(0, 1)) = 1
_FinalAlphaAdjust_B ("Final Alpha Multiply", Range(0, 1)) = 1
_FinalColorAdjust ("Final Color Multiply", Color) = (1,1,1,1)
_FinalColorValue_A ("Final Color Lerp Value", Range(0, 1)) = 0
_FinalColorValue_B ("Final Color Lerp Value", Range(0, 1)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ColorMask 0 0
  ZTest Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
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
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 63205
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_0 = texture2D(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_0 = texture2D(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_0 = texture2D(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_0 = texture(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_0 = texture(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ALPHA1_MAINALPHA" "_ALPHA2_NONE" "_LAYERMODE_EMISSION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_NONE" "_UVLAY_DEFAULT" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat14;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat14 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat14 = inversesqrt(u_xlat14);
    u_xlat2.xyz = vec3(u_xlat14) * _WorldSpaceLightPos0.xyz;
    u_xlat14 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = u_xlat14 * 0.5 + 0.5;
    u_xlat0.y = u_xlat16_3.x * 0.949999988;
    u_xlat16_3.xy = u_xlat0.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_0 = texture(_Ramp2D, u_xlat16_3.xy);
    u_xlat16_3.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * _cRimt.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_24 = _cRimt.w + _cRimt.w;
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_0.zzz * u_xlat16_4.xyz;
    u_xlat16_24 = _cKeyf.w + _cKeyf.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_3.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_0.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_0.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat0.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat0.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_0 = texture(_MainTex, u_xlat16_4.xy);
    u_xlat16_0 = u_xlat16_0 * _Color;
    u_xlat16_0 = u_xlat16_0 * _MainColor;
    u_xlat16_4.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = log2(u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_4.xyz = exp2(u_xlat16_4.xyz);
    u_xlat16_24 = dot(u_xlat16_0.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_24) + 1.0;
    u_xlat16_25 = log2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_25 = exp2(u_xlat16_25);
    u_xlat16_25 = u_xlat16_25 * _vAmTxPower;
    u_xlat16_4.xyz = vec3(u_xlat16_25) * vec3(0.5, 0.5, 0.5) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = max(u_xlat16_4.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_5.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz + _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_0.xyz * _vAmOc.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz + (-u_xlat16_6.xyz);
    u_xlat16_4.xyz = _vAmOc.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_3.xyz + (-u_xlat16_4.xyz);
    SV_Target0.w = u_xlat16_0.w * _FinalAlphaAdjust_A + _AlphaOffSet;
    u_xlat16_24 = log2(vs_COLOR0.w);
    u_xlat16_24 = u_xlat16_24 * _vAmOcPower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_3.xyz = vec3(u_xlat16_24) * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_A;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_A;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_A;
uniform 	mediump float _FinalColorValue_A;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_A, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_A.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_A.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_A, _FinalColorValue_A, _FinalColorValue_A)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_A;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _LayerMap;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat10_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat10_1 = texture2D(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat10_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat10_2.xyz = texture2D(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_MATERIAL_B" "_ALPHA1_NONE" "_ALPHA2_NONE" "_LAYERMODE_ADDITION" "_LOOKDEV_DEFAULT" "_MASK1_LAYERALPHA" "_MASK2_WITHANIMATION" "_USELAYER_ON" "_UVLAY_MATCAP" "_UVMAIN_DEFAULT" }
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _MainColor;
uniform 	vec4 _TransUvMainTex_B;
uniform 	mediump vec4 _LayerColor;
uniform 	mediump vec4 _LayerMap_ST;
uniform 	mediump float _LayerInputAnima_B;
uniform 	float _AlphaOffSet;
uniform 	mediump vec4 _Ramp2D_ST;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform 	mediump vec4 _FinalColorAdjust;
uniform 	mediump float _FinalAlphaAdjust_B;
uniform 	mediump float _FinalColorValue_B;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _LayerMap;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat19;
mediump float u_xlat16_27;
float u_xlat28;
mediump float u_xlat16_31;
mediump float u_xlat16_32;
mediump float u_xlat16_33;
void main()
{
    u_xlat16_0.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * _cRimt.xyz;
    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat1.xyz = vec3(u_xlat28) * u_xlat1.xyz;
    u_xlat28 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD3.xyz;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat19 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat3.xyz = vec3(u_xlat19) * _WorldSpaceLightPos0.xyz;
    u_xlat19 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat16_27 = u_xlat19 * 0.5 + 0.5;
    u_xlat1.y = u_xlat16_27 * 0.949999988;
    u_xlat16_4.xy = u_xlat1.xy * _Ramp2D_ST.xy + _Ramp2D_ST.zw;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_4.xy);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_1.xxx;
    u_xlat16_27 = _cRimt.w + _cRimt.w;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_27 = _cKeyf.w + _cKeyf.w;
    u_xlat16_0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_27) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat1.xy = u_xlat2.yy * hlslcc_mtx4x4unity_MatrixV[1].xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[0].xy * u_xlat2.xx + u_xlat1.xy;
    u_xlat1.xy = hlslcc_mtx4x4unity_MatrixV[2].xy * u_xlat2.zz + u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    u_xlat16_4.xy = u_xlat1.xy * _LayerMap_ST.xy + _LayerMap_ST.zw;
    u_xlat16_1 = texture(_LayerMap, u_xlat16_4.xy);
    u_xlat16_1 = u_xlat16_1 * _LayerColor;
    u_xlat16_27 = max(_LayerInputAnima_B, 0.0);
    u_xlat16_27 = min(u_xlat16_27, 2.0);
    u_xlat16_27 = u_xlat16_27 * u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat2.x = vs_TEXCOORD0.x + (-_TransUvMainTex_B.x);
    u_xlat2.y = vs_TEXCOORD0.y + _TransUvMainTex_B.y;
    u_xlat16_4.xy = u_xlat2.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.xyz = texture(_MainTex, u_xlat16_4.xy).xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * _Color.xyz;
    u_xlat16_5.xyz = u_xlat16_4.xyz * _MainColor.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _MainColor.xyz + u_xlat16_1.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_27) * u_xlat16_1.xyz + u_xlat16_5.xyz;
    u_xlat16_31 = dot(u_xlat16_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_6.xyz = u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_6.xyz = log2(u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_6.xyz = exp2(u_xlat16_6.xyz);
    u_xlat16_32 = dot(u_xlat16_5.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_32 = min(max(u_xlat16_32, 0.0), 1.0);
#else
    u_xlat16_32 = clamp(u_xlat16_32, 0.0, 1.0);
#endif
    u_xlat16_33 = (-u_xlat16_32) + 1.0;
    u_xlat16_33 = log2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_33 = exp2(u_xlat16_33);
    u_xlat16_33 = u_xlat16_33 * _vAmTxPower;
    u_xlat16_6.xyz = vec3(u_xlat16_33) * vec3(0.5, 0.5, 0.5) + u_xlat16_6.xyz;
    u_xlat16_6.xyz = max(u_xlat16_6.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_6.xyz = min(u_xlat16_6.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_7.xyz = vec3(u_xlat16_32) + (-_vAmOc.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_32) * u_xlat16_7.xyz + _vAmOc.xyz;
    u_xlat16_8.xyz = u_xlat16_5.xyz * _vAmOc.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_7.xyz + (-u_xlat16_8.xyz);
    u_xlat16_6.xyz = _vAmOc.www * u_xlat16_6.xyz + u_xlat16_8.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * u_xlat16_6.xyz;
    u_xlat16_0.xyz = u_xlat16_5.xyz * u_xlat16_0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_5.x = log2(vs_COLOR0.w);
    u_xlat16_5.x = u_xlat16_5.x * _vAmOcPower;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xyz + u_xlat16_6.xyz;
    u_xlat16_5.x = (-u_xlat16_27) * u_xlat16_31 + 1.0;
    u_xlat16_27 = u_xlat16_27 * u_xlat16_31;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_5.xxx;
    u_xlat16_0.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz + u_xlat16_0.xyz;
    u_xlat16_4.xyz = _FinalColorAdjust.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.xyz = vec3(vec3(_FinalColorValue_B, _FinalColorValue_B, _FinalColorValue_B)) * u_xlat16_4.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = _AlphaOffSet + _FinalAlphaAdjust_B;
    return;
}

#endif
"
}
}
}
}
Fallback "Legacy Shaders/Diffuse"
CustomEditor "PokemonEffectShaderGUI"
}