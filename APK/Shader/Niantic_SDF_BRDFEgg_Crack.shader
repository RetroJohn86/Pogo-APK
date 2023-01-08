//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/SDF/BRDFEgg_Crack" {
Properties {
_SDFTex ("SDFTex", 2D) = "white" { }
_SDFChannels ("SDF Channel Use", Vector) = (1,1,1,1)
_CrackTex ("Crack Text", 2D) = "White" { }
_PrimaryColor ("Primary Color", Color) = (0.38,0.38,0.41,1)
_SecondaryColor ("Secondary Color", Color) = (0.54,0.47,0.67,1)
_OutlineColor ("Outline Color", Color) = (0.59,0.49,0.79,1)
_ClippingValue ("Clipping Value", Range(0, 1)) = 0.5
_OutlineDistance ("Outline Distance", Range(0, 0.3)) = 0
_EdgeFalloff ("Edge Softness", Range(1, 11)) = 7.7
_ShadowColor ("Shadow Color", Color) = (0,0,0,1)
_ShadowPosition ("Shadow Position", Range(0, 1)) = 0
_ShadowFalloff ("Shadow Falloff", Range(1, 11)) = 2
_HotspotPosition ("Hotspot Position", Range(0, 1)) = 0
_HotspotFalloff ("Hotspot Falloff", Range(1, 11)) = 1
_HotspotAmount ("Hotspot Amount", Range(0, 1)) = 1
_CrackColor ("Crack Color", Color) = (0.5,0.5,0.5,1)
_CrackClip ("Crack Clip", Range(0, 1)) = 0.5
_CrackFalloff ("Crack Softness", Range(1, 11)) = 7.7
_CrackProgress ("Crack Progress", Range(0, 3)) = 0
_CrackGlowFalloff ("Crack Glow Falloff", Range(0, 11)) = 5
_CrackGlowColor ("Crack Glow Color", Color) = (0,0,0,1)
_CrackGlowBalance ("Crack Glow Balance", Range(0, 1)) = 0
_CrackGlowScalar ("Crack Glow Scalar", Range(0, 5)) = 1
_ScrollScalar ("Glow Speed Scalar", Range(0, 1)) = 0.2
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKey ("Key (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0,0,1,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 0.3
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 26571
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _SDFTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_TARGET0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_1.xy = texture2D(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat10_1 = texture2D(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat10_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat10_3 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _SDFTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_TARGET0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_1.xy = texture2D(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat10_1 = texture2D(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat10_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat10_3 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _CrackTex;
uniform lowp sampler2D _SDFTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_TARGET0 gl_FragData[0]
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat10_1.xy = texture2D(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat10_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat10_1 = texture2D(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat10_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat10_1.x = texture2D(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat10_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat10_3 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat10_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat10_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(1) uniform mediump sampler2D _SDFTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat16_1.xy = texture(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.y = min(max(u_xlat16_0.y, 0.0), 1.0);
#else
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
#endif
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat16_1 = texture(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat16_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat16_3 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(1) uniform mediump sampler2D _SDFTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat16_1.xy = texture(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.y = min(max(u_xlat16_0.y, 0.0), 1.0);
#else
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
#endif
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat16_1 = texture(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat16_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat16_3 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ShadowPosition;
uniform 	mediump float _ShadowFalloff;
uniform 	mediump float _HotspotPosition;
uniform 	mediump float _HotspotFalloff;
uniform 	mediump float _HotspotAmount;
uniform 	mediump float _ScrollScalar;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_7;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 0.0);
    u_xlat12 = (-in_TEXCOORD0.y) + 1.0;
    u_xlat16_3 = u_xlat12 + _ShadowPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_7.xy = exp2(vec2(_ShadowFalloff, _HotspotFalloff));
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.x;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.x = (-u_xlat16_3) + 1.0;
    u_xlat16_3 = in_TEXCOORD0.y + _HotspotPosition;
    u_xlat16_3 = log2(u_xlat16_3);
    u_xlat16_3 = u_xlat16_3 * u_xlat16_7.y;
    u_xlat16_3 = exp2(u_xlat16_3);
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    vs_TEXCOORD1.y = u_xlat16_3 * _HotspotAmount;
    vs_TEXCOORD1.zw = vec2(0.0, 0.0);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    vs_TEXCOORD2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_3 = u_xlat0.x * 0.5 + 0.5;
    vs_TEXCOORD2.y = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD2.zw = vec2(1.0, 1.0);
    u_xlat0.x = _Time.x * _ScrollScalar;
    u_xlat0.x = u_xlat0.x * 4.0;
    u_xlat0.x = fract(u_xlat0.x);
    vs_TEXCOORD3.xy = (-u_xlat0.xx) + in_TEXCOORD0.xy;
    vs_TEXCOORD3.zw = u_xlat0.xx + in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _SDFTex_ST;
uniform 	vec4 _SDFChannels;
uniform 	vec4 _CrackTex_ST;
uniform 	mediump vec4 _PrimaryColor;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _ClippingValue;
uniform 	mediump float _OutlineDistance;
uniform 	mediump float _EdgeFalloff;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump vec3 _CrackColor;
uniform 	mediump float _CrackClip;
uniform 	mediump float _CrackFalloff;
uniform 	mediump float _CrackProgress;
uniform 	mediump float _CrackGlowFalloff;
uniform 	mediump vec3 _CrackGlowColor;
uniform 	mediump float _CrackGlowBalance;
uniform 	mediump float _CrackGlowScalar;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKey;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _CrackTex;
UNITY_LOCATION(1) uniform mediump sampler2D _SDFTex;
UNITY_LOCATION(2) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_6;
vec3 u_xlat7;
mediump vec2 u_xlat16_12;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = _CrackProgress;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _CrackTex_ST.xy + _CrackTex_ST.zw;
    u_xlat16_1.xy = texture(_CrackTex, u_xlat1.xy).xy;
    u_xlat16_0.y = _CrackProgress + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.y = min(max(u_xlat16_0.y, 0.0), 1.0);
#else
    u_xlat16_0.y = clamp(u_xlat16_0.y, 0.0, 1.0);
#endif
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_1.xy;
    u_xlat16_0.x = max(u_xlat16_0.y, u_xlat16_0.x);
    u_xlat16_6 = (-_CrackClip) + 1.0;
    u_xlat16_12.x = (-u_xlat16_6) + u_xlat16_0.x;
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_12.x = u_xlat16_12.x * 1.5;
    u_xlat16_6 = u_xlat16_12.x / u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat1.xy = vs_TEXCOORD0.xy * _SDFTex_ST.xy + _SDFTex_ST.zw;
    u_xlat16_1 = texture(_SDFTex, u_xlat1.xy);
    u_xlat1.x = dot(u_xlat16_1, _SDFChannels);
    u_xlat16_12.x = (-_OutlineDistance) + _ClippingValue;
    u_xlat16_12.x = u_xlat16_12.x + u_xlat1.x;
    u_xlat16_18 = u_xlat1.x + _ClippingValue;
    u_xlat16_12.y = log2(u_xlat16_18);
    u_xlat16_12.x = log2(u_xlat16_12.x);
    u_xlat16_2.x = exp2(_EdgeFalloff);
    u_xlat16_12.xy = u_xlat16_12.xy * u_xlat16_2.xx;
    u_xlat16_12.y = exp2(u_xlat16_12.y);
    u_xlat16_12.x = exp2(u_xlat16_12.x);
    u_xlat16_12.xy = min(u_xlat16_12.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = (-_PrimaryColor.xyz) + _OutlineColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.yyy * u_xlat16_2.xyz + _PrimaryColor.xyz;
    u_xlat16_18 = u_xlat16_12.y + _Amount_RimLt;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + _SecondaryColor.xyz;
    u_xlat16_2.xyz = u_xlat16_12.xxx * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(0.899999976, 0.899999976, 0.899999976);
    u_xlat16_4.xyz = (-u_xlat16_2.xyz) * vec3(0.899999976, 0.899999976, 0.899999976) + vec3(_CrackColor.x, _CrackColor.y, _CrackColor.z);
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = (-u_xlat16_2.xyz) + u_xlat16_3.xyz;
    u_xlat16_6 = u_xlat16_0.x + _CrackClip;
    u_xlat16_0.x = u_xlat16_0.x + _CrackGlowBalance;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.y = log2(u_xlat16_6);
    u_xlat16_4.xy = exp2(vec2(_CrackFalloff, _CrackGlowFalloff));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_4.yx;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.y = exp2(u_xlat16_0.y);
    u_xlat16_0.xy = min(u_xlat16_0.xy, vec2(1.0, 1.0));
    u_xlat16_2.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_6 = (-u_xlat16_0.y) + 1.0;
    u_xlat16_2.xyz = u_xlat16_2.xyz + vs_TEXCOORD1.yyy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_ShadowColor.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD1.xxx * u_xlat16_2.xyz + _ShadowColor.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.zw).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_3.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_1.x = texture(_CrackTex, vs_TEXCOORD3.xy).z;
    u_xlat16_12.x = u_xlat16_1.x * _CrackGlowScalar;
    u_xlat16_4.xyz = u_xlat16_12.xxx * _CrackGlowColor.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat1.x = _cKey.w + _cKey.w;
    u_xlat7.x = _cRimt.w + _cRimt.w;
    u_xlat16_3 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_3.xxx * _cRimt.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_3.zzz * _cKey.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat1.xxx + u_xlat7.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_6) * u_xlat16_4.xyz;
    u_xlat16_4.xyz = (-_cAmbn.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.yyy * u_xlat16_4.xyz + _cAmbn.xyz;
    u_xlat16_5.xyz = u_xlat16_3.www * _cRimb.xyz;
    u_xlat1.x = _cRimb.w + _cRimb.w;
    u_xlat16_4.xyz = u_xlat16_5.xyz * u_xlat1.xxx + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_18) + u_xlat16_4.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * u_xlat16_2.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}