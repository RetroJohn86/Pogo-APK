//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/Mega Raid Egg" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Shine Color (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(SPECULAR____________)] [Space] _Spec ("Specular", Range(0, 1)) = 1
_Gloss ("Glossiness", Range(0.025, 100)) = 0.95
[Space] [Header(FRESNEL_____________)] [Space] _FresnelEdge ("Fresnel Outer Color", Color) = (1,1,1,0)
_FresnelCenter ("Fresnel Center Color", Color) = (0,0,0,0)
_FresnelBias ("Fresnel Bias", Float) = 0
_FresnelPinch ("Fresnel Pinch", Float) = 1
_FresnelPower ("Fresnel Power", Float) = 1
[Space] [Header(FX_____________)] [Space] _cOverride ("Color override (rgb = color, a = blend)", Color) = (1,1,1,0)
_CrackTex ("Crack Texture", 2D) = "black" { }
_CrackAmount ("Crack Amount", Range(0, 0.999)) = 0
[Space] [Header(MEGA_____________)] [Space] _DetailTex ("Detail Noise", 2D) = "white" { }
_RainbowTex ("Rainbow", 2D) = "white" { }
_CloudTex ("Cloud", 2D) = "white" { }
_DetailScale ("Detail Scale", Float) = 4
_PanSpeed ("Pan Speed", Float) = 0.5
_PanScale ("Pan Scale", Float) = 0.1
_CloudWarpSpeed ("Cloud Warp Speed", Float) = -0.1
_CloudWarpScale ("Cloud Warp Scale", Float) = 0.2
_CloudWarpIntensity ("Cloud Warp Intensity", Float) = 0.5
_ThresholdDark ("Threshold Dark", Range(0, 1)) = 0.4
_ThresholdLight ("Threshold Light", Range(0, 1)) = 0.6
_VerticalGradientIntensity ("Vertical Gradient Intensity", Float) = 0.7
_VerticalGradientScale ("Vertical Gradient Scale", Float) = 2
_LightColorTint ("Light Color Tint", Float) = 0.3
_LightColorShadowIntensity ("Light Color Shadow Intensity", Float) = 0.5
_LightColorBaseIntensity ("Light Color Base Intensity", Float) = 1
_LightColorSpotIntensity ("Light Color Spot Intensity", Float) = 1.5
_DarkColorBaseIntensity ("Dark Color Base Intensity", Float) = 1
_DarkColorSpotIntensity ("Dark Color Spot Intensity", Float) = 1.5
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  GpuProgramID 19979
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
uniform lowp sampler2D _CloudTex;
attribute mediump vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = texture2DLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _RainbowTex;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp samplerCube unity_SpecCube0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec2 u_xlat10_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
lowp float u_xlat10_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat10_0.xyz = texture2D(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat10_27 = texture2D(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat10_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture2D(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat10_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat10_2.xy = texture2D(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat10_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat10_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat10_0 = textureCubeLodEXT(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat10_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat10_0.xyz * vec3(u_xlat16_30);
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _CloudWarpSpeed;
uniform 	mediump vec4 _CrackTex_ST;
UNITY_LOCATION(6) uniform mediump sampler2D _CloudTex;
in mediump vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
float u_xlat13;
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
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    vs_TEXCOORD0.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.zw = in_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat2.x = _Time.y * _CloudWarpSpeed;
    u_xlat2.y = 0.0;
    u_xlat2.xy = u_xlat2.xy + in_TEXCOORD0.yx;
    u_xlat13 = textureLod(_CloudTex, u_xlat2.xy, 0.0).x;
    vs_TEXCOORD3.x = u_xlat13;
    vs_TEXCOORD3.y = in_TEXCOORD0.y;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat16_3 = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat1.x = (-u_xlat16_3) + 1.0;
    vs_TEXCOORD4.x = u_xlat16_3;
    vs_TEXCOORD4.w = u_xlat1.x;
    u_xlat1.x = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat16_7 * _Amount_Wrap + u_xlat1.x;
    u_xlat16_3 = u_xlat16_7 * 0.5 + 0.5;
    vs_TEXCOORD4.y = u_xlat16_3 * 0.949999988;
    vs_TEXCOORD4.z = u_xlat1.x;
    u_xlat4 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat4;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_TEXCOORD5.w = exp2(u_xlat0.x);
    vs_TEXCOORD5.xyz = unity_FogColor.xyz;
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
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	mediump vec4 _LightColor0;
uniform 	mediump vec4 _cOverride;
uniform 	mediump vec4 _FresnelEdge;
uniform 	mediump vec4 _FresnelCenter;
uniform 	mediump float _FresnelBias;
uniform 	mediump float _FresnelPinch;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _CrackAmount;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _Spec;
uniform 	mediump float _Gloss;
uniform 	mediump float _DetailScale;
uniform 	mediump float _PanSpeed;
uniform 	mediump float _PanScale;
uniform 	mediump float _CloudWarpIntensity;
uniform 	mediump float _ThresholdDark;
uniform 	mediump float _ThresholdLight;
uniform 	mediump float _VerticalGradientIntensity;
uniform 	mediump float _VerticalGradientScale;
uniform 	mediump float _LightColorTint;
uniform 	mediump float _LightColorShadowIntensity;
uniform 	mediump float _LightColorBaseIntensity;
uniform 	mediump float _LightColorSpotIntensity;
uniform 	mediump float _DarkColorBaseIntensity;
uniform 	mediump float _DarkColorSpotIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _RainbowTex;
UNITY_LOCATION(3) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(4) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(5) uniform mediump samplerCube unity_SpecCube0;
in highp vec3 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec2 u_xlat16_2;
bvec4 u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat11;
mediump vec2 u_xlat16_12;
float u_xlat27;
mediump float u_xlat16_27;
mediump float u_xlat16_28;
float u_xlat29;
mediump float u_xlat16_30;
mediump float u_xlat16_31;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.y * _PanScale;
    u_xlat0.x = _Time.y * _PanSpeed + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x * _CloudWarpIntensity + u_xlat0.x;
    u_xlat16_0.xyz = texture(_RainbowTex, u_xlat0.xx).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat0.xyz = vec3(vec3(_LightColorTint, _LightColorTint, _LightColorTint)) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(vec2(_DetailScale, _DetailScale));
    u_xlat16_27 = texture(_DetailTex, u_xlat2.xy).x;
    u_xlat16_3.xy = (-vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity)) + vec2(_LightColorSpotIntensity, _DarkColorSpotIntensity);
    u_xlat16_3.xy = vec2(u_xlat16_27) * u_xlat16_3.xy + vec2(_LightColorBaseIntensity, _DarkColorBaseIntensity);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_3.yyy + vec3(-1.0, -1.0, -1.0);
    u_xlat16_28 = u_xlat16_3.x + (-_LightColorShadowIntensity);
    u_xlat27 = texture(_MainTex, vs_TEXCOORD2.xy).x;
    u_xlat16_3.x = dFdx(u_xlat27);
    u_xlat16_12.x = dFdy(u_xlat27);
    u_xlat16_3.x = abs(u_xlat16_12.x) + abs(u_xlat16_3.x);
    u_xlat16_12.xy = (-vec2(u_xlat27)) + vec2(_ThresholdLight, _ThresholdDark);
    u_xlat16_28 = u_xlat27 * u_xlat16_28 + _LightColorShadowIntensity;
    u_xlat2.xy = u_xlat16_12.xy / u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.xy = min(max(u_xlat2.xy, 0.0), 1.0);
#else
    u_xlat2.xy = clamp(u_xlat2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat2.yyy * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vec3(u_xlat16_28) + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_28);
    u_xlat16_1.xyz = u_xlat2.xxx * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat0.x = vs_TEXCOORD2.y * _VerticalGradientScale;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat0.x = _VerticalGradientIntensity * u_xlat0.x + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_1.xyz;
    u_xlat27 = _cKeyf.w + _cKeyf.w;
    u_xlat2.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD4.xy);
    u_xlat16_3.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(u_xlat27) + u_xlat2.xyz;
    u_xlat16_4.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_4.xyz = u_xlat16_1.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat27 = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * vec3(u_xlat27) + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD4.zzz;
    u_xlat16_30 = vs_TEXCOORD4.x + _FresnelBias;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_30 = log2(u_xlat16_30);
    u_xlat16_30 = u_xlat16_30 * _FresnelPinch;
    u_xlat16_30 = exp2(u_xlat16_30);
    u_xlat16_0 = (-_FresnelEdge) + _FresnelCenter;
    u_xlat16_0 = vec4(u_xlat16_30) * u_xlat16_0 + _FresnelEdge;
    u_xlat16_4.xyz = u_xlat16_0.xyz * vec3(vec3(_FresnelPower, _FresnelPower, _FresnelPower)) + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_4.xyz = (-vec3(_CrackAmount)) + vec3(1.04999995, 1.0, 1.04999995);
    u_xlat16_2.xy = texture(_CrackTex, vs_TEXCOORD2.zw).xy;
    u_xlatb2.xzw = greaterThanEqual(u_xlat16_2.xxxx, u_xlat16_4.xxyz).xzw;
    u_xlat16_4.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_4.y = (u_xlatb2.z) ? float(-1.0) : float(-0.0);
    u_xlat16_4.z = (u_xlatb2.w) ? float(2.0) : float(0.0);
    u_xlat16_30 = u_xlat16_2.y * u_xlat16_4.z;
    u_xlat16_4.x = u_xlat16_4.y + u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x + 1.0;
    u_xlat16_4.x = max(u_xlat16_4.x, 0.75);
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xxx + vec3(u_xlat16_30);
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + _cOverride.xyz;
    u_xlat16_3.xyz = _cOverride.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat2.x = (-_Gloss) + 1.0;
    u_xlat16_30 = (-u_xlat2.x) * 0.699999988 + 1.70000005;
    u_xlat16_30 = u_xlat2.x * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 6.0;
    u_xlat16_4.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat16_4.x = inversesqrt(u_xlat16_4.x);
    u_xlat16_4.xyz = u_xlat16_4.xxx * vs_TEXCOORD0.xyz;
    u_xlat2.xyz = u_xlat16_4.xyz + u_xlat16_4.xyz;
    u_xlat6.xyz = (-vs_TEXCOORD1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat29 = inversesqrt(u_xlat29);
    u_xlat7.xyz = vec3(u_xlat29) * u_xlat6.xyz;
    u_xlat16_5.xyz = u_xlat6.xyz * vec3(u_xlat29) + _WorldSpaceLightPos0.xyz;
    u_xlat16_31 = dot(u_xlat7.xyz, u_xlat16_4.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_31 = min(max(u_xlat16_31, 0.0), 1.0);
#else
    u_xlat16_31 = clamp(u_xlat16_31, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-u_xlat2.xyz) * (-vec3(u_xlat16_31)) + (-u_xlat7.xyz);
    u_xlat29 = (-u_xlat16_31) + 1.0;
    u_xlat16_0 = textureLod(unity_SpecCube0, u_xlat2.xyz, u_xlat16_30);
    u_xlat16_30 = u_xlat16_0.w + -1.0;
    u_xlat16_30 = unity_SpecCube0_HDR.w * u_xlat16_30 + 1.0;
    u_xlat16_30 = u_xlat16_30 * unity_SpecCube0_HDR.x;
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(u_xlat16_30);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = vec3(u_xlat29) * u_xlat16_8.xyz;
    u_xlat16_30 = dot(u_xlat16_5.xyz, u_xlat16_5.xyz);
    u_xlat16_30 = inversesqrt(u_xlat16_30);
    u_xlat16_5.xyz = vec3(u_xlat16_30) * u_xlat16_5.xyz;
    u_xlat16_30 = dot(u_xlat16_4.xyz, u_xlat16_5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat2.x = log2(u_xlat16_30);
    u_xlat11 = _Gloss * 128.0;
    u_xlat2.x = u_xlat2.x * u_xlat11;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat16_4.xyz = u_xlat2.xxx * _LightColor0.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(_Spec) + u_xlat16_3.xyz;
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