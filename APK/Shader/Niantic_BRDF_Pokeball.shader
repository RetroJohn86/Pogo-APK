//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/Pokeball" {
Properties {
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Color1 ("Color Region 1", Color) = (1,1,1,1)
_Color2 ("Color Region 2", Color) = (1,1,1,1)
_Color3 ("Color Region 3", Color) = (1,1,1,1)
_Color4 ("Color Region 4", Color) = (1,1,1,1)
_Color5 ("Color Region 5", Color) = (1,1,1,1)
_Color6 ("Color Region 6", Color) = (1,1,1,1)
_Color7 ("Color Region 7", Color) = (1,1,1,1)
_Color8 ("Color Region 8", Color) = (1,1,1,1)
_Color9 ("Color Region 9", Color) = (1,1,1,1)
_Amount_Blend_1 ("BRDF Amount 1", Range(0, 2)) = 1
_Amount_Blend_2 ("BRDF Amount 2", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cAmbn_1 ("Ambient 1", Color) = (0,0,0,0.5)
_cKeyf_1 ("Specular 1 (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt_1 ("RimTop 1 (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb_1 ("RimBottom 1 (.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_cAmbn_2 ("Ambient 2", Color) = (0,0,0,0.5)
_cKeyf_2 ("Specular 2 (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt_2 ("RimTop 2 (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb_2 ("RimBottom 2 (.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
_Amount_RimLt_1 ("RimLight Mult 1", Range(0, 2)) = 1
_Amount_RimLt_2 ("RimLight Mult 2", Range(0, 2)) = 1
_EyeSpec ("Specular", Range(0, 1)) = 1
_EyeGloss ("Glossiness", Range(0.025, 100)) = 0.95
[Space] [Header(vRed_is_Edge)] _EdgeColor ("Edge Color, .a = amount", Color) = (1,1,1,0.5)
_EdgeFalloff ("Edge Falloff", Range(0, 11)) = 1
[Space] [Header(vGreen_is_AO)] _AOColor ("AO Color, .a = amount", Color) = (0,0,0,0.5)
_AOFalloff ("AO Falloff", Range(0, 11)) = 1
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 54177
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TANGENT0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec2 vs_TEXCOORD7;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat10_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat10_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat10_3 = textureCubeLodEXT(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat10_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat10_3.xyz * vec3(u_xlat16_24);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump float _AOFalloff;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TANGENT0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
out mediump vec2 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
mediump float u_xlat16_11;
float u_xlat19;
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
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
    vs_TEXCOORD0.y = u_xlat3.x;
    vs_TEXCOORD0.x = u_xlat2.z;
    vs_TEXCOORD0.z = u_xlat1.y;
    u_xlat4.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat4.xyz;
    vs_TEXCOORD0.w = u_xlat4.x;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD2.x = u_xlat2.y;
    vs_TEXCOORD1.z = u_xlat1.z;
    vs_TEXCOORD2.z = u_xlat1.x;
    vs_TEXCOORD1.y = u_xlat3.y;
    vs_TEXCOORD2.y = u_xlat3.z;
    vs_TEXCOORD1.w = u_xlat4.y;
    vs_TEXCOORD2.w = u_xlat4.z;
    u_xlat1.xyz = (-u_xlat4.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD3 = in_TEXCOORD0;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat16_5 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_11 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_5) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_5;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat16_5 = u_xlat16_11 * 0.5 + 0.5;
    u_xlat1.x = u_xlat16_5 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_11 * _Amount_Wrap + u_xlat1.x;
    vs_TEXCOORD4.z = u_xlat1.x;
    vs_TEXCOORD5 = in_COLOR0;
    u_xlat6 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat6;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD6.w = exp2(u_xlat0.x);
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
    vs_TEXCOORD7.x = exp2(_EdgeFalloff);
    vs_TEXCOORD7.y = exp2(_AOFalloff);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	mediump vec4 _Color3;
uniform 	mediump vec4 _Color4;
uniform 	mediump vec4 _Color5;
uniform 	mediump vec4 _Color6;
uniform 	mediump vec4 _Color7;
uniform 	mediump vec4 _Color8;
uniform 	mediump vec4 _Color9;
uniform 	mediump float _Amount_Blend_1;
uniform 	mediump float _Amount_Blend_2;
uniform 	mediump float _Amount_RimLt_1;
uniform 	mediump float _Amount_RimLt_2;
uniform 	mediump vec4 _cAmbn_1;
uniform 	mediump vec4 _cKeyf_1;
uniform 	mediump vec4 _cRimt_1;
uniform 	mediump vec4 _cRimb_1;
uniform 	mediump vec4 _cAmbn_2;
uniform 	mediump vec4 _cKeyf_2;
uniform 	mediump vec4 _cRimt_2;
uniform 	mediump vec4 _cRimb_2;
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
UNITY_LOCATION(0) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(1) uniform mediump samplerCube unity_SpecCube0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
in mediump vec2 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bvec4 u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
float u_xlat9;
float u_xlat17;
mediump float u_xlat16_24;
float u_xlat25;
mediump float u_xlat16_26;
void main()
{
    u_xlat16_0.xyz = (-_Color4.xyz) + _Color5.xyz;
    u_xlatb1 = greaterThanEqual(vs_TEXCOORD3.xxyy, vec4(0.333333343, 0.666666687, 0.333333343, 0.666666687));
    u_xlat16_2.x = (u_xlatb1.x) ? float(1.0) : float(0.0);
    u_xlat16_2.y = (u_xlatb1.y) ? float(1.0) : float(0.0);
    u_xlat16_2.z = (u_xlatb1.z) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb1.w) ? float(1.0) : float(0.0);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_0.xyz + _Color4.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + _Color6.xyz;
    u_xlat16_0.xyz = u_xlat16_2.yyy * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color1.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color3.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-u_xlat16_3.xyz);
    u_xlat16_0.xyz = u_xlat16_2.zzz * u_xlat16_0.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-_Color7.xyz) + _Color8.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + _Color7.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _Color9.xyz;
    u_xlat16_3.xyz = u_xlat16_2.yyy * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_0.xyz) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_2.www * u_xlat16_3.xyz + u_xlat16_0.xyz;
    u_xlat9 = (u_xlatb1.y) ? -1.0 : -0.0;
    u_xlat16_24 = (u_xlatb1.x) ? u_xlat9 : 0.0;
    u_xlat16_24 = u_xlat16_24 + u_xlat16_2.x;
    u_xlat16_24 = u_xlat16_2.z * (-u_xlat16_24) + u_xlat16_24;
    u_xlat16_2.xyz = (-_cAmbn_1.xyz) + _cAmbn_2.xyz;
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + _cAmbn_1.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_2.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3 = (-_cRimb_1) + _cRimb_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimb_1;
    u_xlat9 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat9) + u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_3 = (-_cRimt_1) + _cRimt_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cRimt_1;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat1.x = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat1.xyw = u_xlat1.xxx * u_xlat16_3.xyz;
    u_xlat16_3 = (-_cKeyf_1) + _cKeyf_2;
    u_xlat16_3 = vec4(u_xlat16_24) * u_xlat16_3 + _cKeyf_1;
    u_xlat16_3.xyz = u_xlat16_1.zzz * u_xlat16_3.xyz;
    u_xlat17 = u_xlat16_3.w + u_xlat16_3.w;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat17) + u_xlat1.xyw;
    u_xlat16_26 = (-_Amount_RimLt_1) + _Amount_RimLt_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_RimLt_1;
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_26) + u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    u_xlat16_26 = (-_Amount_Blend_1) + _Amount_Blend_2;
    u_xlat16_26 = u_xlat16_24 * u_xlat16_26 + _Amount_Blend_1;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_26);
    u_xlat16_2.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_0.xyz);
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _EdgeColor.xyz;
    u_xlat16_3.xy = (-vs_TEXCOORD5.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = log2(u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * vs_TEXCOORD7.xy;
    u_xlat16_3.xy = exp2(u_xlat16_3.xy);
    u_xlat16_3.xy = min(u_xlat16_3.xy, vec2(1.0, 1.0));
    u_xlat16_24 = u_xlat16_3.x * _EdgeColor.w;
    u_xlat16_26 = u_xlat16_3.y * _AOColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _AOColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_26) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat1.x = (-_EyeGloss) + 1.0;
    u_xlat16_24 = (-u_xlat1.x) * 0.699999988 + 1.70000005;
    u_xlat16_24 = u_xlat16_24 * u_xlat1.x;
    u_xlat16_24 = u_xlat16_24 * 6.0;
    u_xlat1.x = vs_TEXCOORD0.z;
    u_xlat1.y = vs_TEXCOORD1.z;
    u_xlat1.z = vs_TEXCOORD2.z;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    u_xlat5.xyz = u_xlat1.xyz + u_xlat1.xyz;
    u_xlat6.x = vs_TEXCOORD0.w;
    u_xlat6.y = vs_TEXCOORD1.w;
    u_xlat6.z = vs_TEXCOORD2.w;
    u_xlat6.xyz = (-u_xlat6.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat7.xyz = vec3(u_xlat25) * u_xlat6.xyz;
    u_xlat16_2.xyz = u_xlat6.xyz * vec3(u_xlat25) + _WorldSpaceLightPos0.xyz;
    u_xlat16_26 = dot(u_xlat7.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_26 = min(max(u_xlat16_26, 0.0), 1.0);
#else
    u_xlat16_26 = clamp(u_xlat16_26, 0.0, 1.0);
#endif
    u_xlat5.xyz = (-u_xlat5.xyz) * (-vec3(u_xlat16_26)) + (-u_xlat7.xyz);
    u_xlat25 = (-u_xlat16_26) + 1.0;
    u_xlat16_3 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat16_24);
    u_xlat16_24 = u_xlat16_3.w + -1.0;
    u_xlat16_24 = unity_SpecCube0_HDR.w * u_xlat16_24 + 1.0;
    u_xlat16_24 = u_xlat16_24 * unity_SpecCube0_HDR.x;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(u_xlat16_24);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = vec3(u_xlat25) * u_xlat16_4.xyz;
    u_xlat16_24 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_24 = inversesqrt(u_xlat16_24);
    u_xlat16_2.xyz = vec3(u_xlat16_24) * u_xlat16_2.xyz;
    u_xlat16_24 = dot(u_xlat1.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat1.x = log2(u_xlat16_24);
    u_xlat9 = _EyeGloss * 128.0;
    u_xlat1.x = u_xlat1.x * u_xlat9;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat16_2.xyz = u_xlat1.xxx * _LightColor0.xyz + u_xlat16_4.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * vec3(_EyeSpec) + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_0.xyz + vs_TEXCOORD6.xyz;
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