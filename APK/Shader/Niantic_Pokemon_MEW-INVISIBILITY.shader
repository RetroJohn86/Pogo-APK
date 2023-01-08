//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/MEW-INVISIBILITY" {
Properties {
_FaceTex ("Face Texture", 2D) = "clear" { }
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_FxMaskTex ("Fx Mask Texture", 2D) = "clear" { }
_FxMagnitude_A ("Light Magnitude_A", Range(0, 1)) = 1
_FxMagnitude_B ("Light Magnitude_B", Range(0, 1)) = 1
_FxTint ("Light Tint", Color) = (1,1,1,1)
_FxTintBG ("Light Tint Falloff", Color) = (1,1,1,1)
_invisibility ("Invisibility", Range(0, 1)) = 1
_refraction ("Refraction", Range(0, 1)) = 1
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap", Range(0, 1)) = 0
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(AO______________________________)] [Space] _vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_vAmOcPower ("vAmbOcclusion Power", Range(0.1, 10)) = 1
_vAmTxPower ("vAmbTexture Power", Range(1, 10)) = 5
_EyeSpec ("Specular", Range(0, 1)) = 1
_EyeGloss ("Glossiness", Range(0.025, 100)) = 0.95
[Space] [Header(STENCIL_ID_SORTING___________________)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Header(ANIM_UV_A___________________________)] [Space] _uv0 ("_uv0_A", Vector) = (0,0,4,0)
_uv1 ("_uv1_A", Vector) = (0,0,4,2)
_uv2 ("_uv2_A", Vector) = (0,0,4,2)
[Header(ANIM_UV_B___________________________)] [Space] _uv0_B ("_uv0_B", Vector) = (0,0,4,0)
_uv1_B ("_uv1_B", Vector) = (0,0,4,2)
_uv2_B ("_uv2_B", Vector) = (0,0,4,2)
}
SubShader {
 Tags { "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
 GrabPass {
  "_BackgroundTexture"
}
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 43069
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
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _BackgroundTexture;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec3 vs_TEXCOORD5;
varying mediump vec4 vs_TEXCOORD6;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
lowp vec3 u_xlat10_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat10_1 = texture2D(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat10_0.xyz;
    u_xlat16_29 = u_xlat10_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat10_0 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat10_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat10_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat10_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat10_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat10_9.xyz = texture2D(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat10_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat10_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat10_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat10_1.xyz = texture2D(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat10_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat10_1 = textureCubeLodEXT(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat10_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xxx;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
mediump float u_xlat16_9;
float u_xlat10;
vec2 u_xlat12;
float u_xlat15;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
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
    u_xlat2.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat16 = u_xlat0.z * unity_FogParams.x;
    u_xlat16 = u_xlat16 * (-u_xlat16);
    vs_TEXCOORD6.w = exp2(u_xlat16);
    vs_TEXCOORD3 = u_xlat0;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    vs_TEXCOORD4.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.x = min(max(vs_TEXCOORD4.x, 0.0), 1.0);
#else
    vs_TEXCOORD4.x = clamp(vs_TEXCOORD4.x, 0.0, 1.0);
#endif
    u_xlat16_4 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_9 = u_xlat16_4 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_9 * 0.949999988;
    vs_TEXCOORD4.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_4 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = in_COLOR0.w;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat0;
    u_xlat0 = u_xlat0 * in_NORMAL0.yyyy;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.xxxx + u_xlat0;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat1;
    u_xlat0 = u_xlat1 * in_NORMAL0.zzzz + u_xlat0;
    u_xlat10 = dot(u_xlat0, u_xlat0);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat0.xy = vec2(u_xlat10) * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD5.xy = u_xlat0.xy;
    vs_TEXCOORD5.z = in_COLOR0.z;
    vs_TEXCOORD6.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _ScreenParams;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	float _refraction;
uniform 	float _invisibility;
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
uniform 	mediump float _EyeSpec;
uniform 	mediump float _EyeGloss;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform mediump sampler2D _BackgroundTexture;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_13;
float u_xlat27;
float u_xlat28;
mediump float u_xlat16_29;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_1 = texture(_FaceTex, vs_TEXCOORD2.xy);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD2.www * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_29 = u_xlat16_1.w + (-vs_TEXCOORD2.z);
    u_xlat16_29 = vs_TEXCOORD2.w * u_xlat16_29 + vs_TEXCOORD2.z;
    u_xlat16_29 = u_xlat16_29 * _EyeSpec;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_30 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_30) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_30) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_30 = _cKeyf.w + _cKeyf.w;
    u_xlat16_4.x = _cRimt.w + _cRimt.w;
    u_xlat16_13.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_13.xyz = u_xlat16_13.xyz * _cRimt.xyz;
    u_xlat16_0 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_13.xyz = u_xlat16_0.xxx * u_xlat16_13.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_13.xyz;
    u_xlat16_5.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cKeyf.xyz;
    u_xlat16_5.xyz = u_xlat16_0.zzz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_4.xyz;
    u_xlat16_30 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_5.xyz * _cRimb.xyz;
    u_xlat16_5.xyz = u_xlat16_0.www * u_xlat16_5.xyz;
    u_xlat16_6.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_6.xyz = u_xlat16_0.yyy * u_xlat16_6.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(u_xlat16_30) + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xyz = min(max(u_xlat16_5.xyz, 0.0), 1.0);
#else
    u_xlat16_5.xyz = clamp(u_xlat16_5.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * u_xlat16_4.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.xy = u_xlat16_2.xx * vs_TEXCOORD0.xy;
    u_xlat1.xy = u_xlat16_2.xy * vec2(_refraction);
    u_xlat16_2.xyz = u_xlat16_4.xyz * vec3(_Amount_Blend);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.zzz + (-u_xlat16_3.xyz);
    u_xlat16_30 = log2(vs_TEXCOORD4.w);
    u_xlat16_30 = u_xlat16_30 * _vAmOcPower;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_2.xyz = vec3(u_xlat16_30) * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_9.xyz = texture(_FxMaskTex, vs_TEXCOORD5.xy).xyz;
    u_xlat16_3.xyz = u_xlat16_9.xyz * vec3(_FxMagnitude_A);
    u_xlat9.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat9.xyz = u_xlat9.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat9.xyz = u_xlat16_0.xxx * u_xlat9.xyz;
    u_xlat9.xyz = vec3(u_xlat16_30) * u_xlat9.xyz;
    u_xlat9.xyz = u_xlat9.xyz * vs_TEXCOORD4.www + u_xlat16_2.xyz;
    u_xlat28 = log2(u_xlat16_0.x);
    u_xlat28 = u_xlat28 * 0.125;
    u_xlat28 = exp2(u_xlat28);
    u_xlat7.x = _Time.z * 0.100000001;
    u_xlat28 = u_xlat28 * 0.100000001 + u_xlat7.x;
    u_xlat28 = vs_TEXCOORD3.x * _ScreenParams.z + u_xlat28;
    u_xlat28 = vs_TEXCOORD3.y * _ScreenParams.w + u_xlat28;
    u_xlat28 = u_xlat28 * 4.0;
    u_xlat28 = fract(u_xlat28);
    u_xlat7.xyz = vec3(u_xlat28) + vec3(1.0, 0.666666687, 0.333333343);
    u_xlat7.xyz = fract(u_xlat7.xyz);
    u_xlat7.xyz = u_xlat7.xyz * vec3(6.0, 6.0, 6.0) + vec3(-3.0, -3.0, -3.0);
    u_xlat7.xyz = abs(u_xlat7.xyz) + vec3(-1.0, -1.0, -1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xyz = min(max(u_xlat7.xyz, 0.0), 1.0);
#else
    u_xlat7.xyz = clamp(u_xlat7.xyz, 0.0, 1.0);
#endif
    u_xlat7.xyz = u_xlat7.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat7.xyz = u_xlat7.xyz * vec3(0.800000012, 0.800000012, 0.800000012) + vec3(1.0, 1.0, 1.0);
    u_xlat7.xyz = u_xlat16_0.xxx * u_xlat7.xyz;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD3.xyw;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat16_1.xyz = texture(_BackgroundTexture, u_xlat1.xy).xyz;
    u_xlat16_2.xyz = u_xlat7.xyz * vec3(0.449999988, 0.449999988, 0.449999988) + u_xlat16_1.xyz;
    u_xlat1.xyz = (-u_xlat9.xyz) + u_xlat16_2.xyz;
    u_xlat0.xyz = vec3(vec3(_invisibility, _invisibility, _invisibility)) * u_xlat1.xyz + u_xlat9.xyz;
    u_xlat27 = (-_EyeGloss) + 1.0;
    u_xlat16_2.x = (-u_xlat27) * 0.699999988 + 1.70000005;
    u_xlat16_2.x = u_xlat27 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * 6.0;
    u_xlat16_11 = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_3.xyz = vec3(u_xlat16_11) * vs_TEXCOORD0.xyz;
    u_xlat1.xyz = u_xlat16_3.xyz + u_xlat16_3.xyz;
    u_xlat7.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat8.xyz = vec3(u_xlat27) * u_xlat7.xyz;
    u_xlat16_4.xyz = u_xlat7.xyz * vec3(u_xlat27) + _WorldSpaceLightPos0.xyz;
    u_xlat16_11 = dot(u_xlat8.xyz, u_xlat16_3.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-u_xlat1.xyz) * (-vec3(u_xlat16_11)) + (-u_xlat8.xyz);
    u_xlat27 = (-u_xlat16_11) + 1.0;
    u_xlat16_1 = textureLod(unity_SpecCube0, u_xlat1.xyz, u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_1.w + -1.0;
    u_xlat16_2.x = unity_SpecCube0_HDR.w * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * unity_SpecCube0_HDR.x;
    u_xlat16_2.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat27) * u_xlat16_2.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_4.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_3.x = dot(u_xlat16_3.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat27 = log2(u_xlat16_3.x);
    u_xlat1.x = _EyeGloss * 128.0;
    u_xlat27 = u_xlat27 * u_xlat1.x;
    u_xlat27 = exp2(u_xlat27);
    u_xlat16_2.xyz = vec3(u_xlat27) * _LightColor0.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_29) + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-vs_TEXCOORD6.xyz);
    SV_Target0.xyz = vs_TEXCOORD6.www * u_xlat16_2.xyz + vs_TEXCOORD6.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
CustomEditor "PokemonShaderGUI"
}