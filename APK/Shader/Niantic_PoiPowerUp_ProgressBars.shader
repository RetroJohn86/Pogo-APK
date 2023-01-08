//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/PoiPowerUp/ProgressBars" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
[Header(ANIMATED HOTSPOT)] _HotspotColor ("Hotspot Color", Color) = (1,1,1,1)
_HotspotRadius ("Hotspot Radius", Range(0, 1)) = 0.1
_HotspotBloom ("Hotspot Bloom", Float) = 0.2
[Header(BAR COLORS)] _Background_Color ("Background Color (.a = alpha)", Color) = (0,0,0,0.25)
_Fill_Color ("Fill Color", Color) = (1,0.7,0,1)
[Header(GENERAL SETTINGS)] _OverallRadiusScalar ("Main Radius Scalar", Range(0, 1)) = 1
_BaseSpace ("Base Space", Range(0, 1)) = 0.2
[Header(Bar1  X.Radius(0TO1)  Y.Width(0TO1)  Z.SpacerSize)] _B1_DataRWS ("Bar 1 Layout", Vector) = (1,0.25,0.1,0)
[IntRange] _B1_Spacers ("Bar 1 Segments", Range(1, 100)) = 3
[Space] _B1_Background_Progress ("Bar Size", Range(0, 1)) = 0.75
_B1_Fill_Progress ("Fill Progress", Range(0, 1)) = 0.05
_B1_Overlay_Progress ("Overlay Progress", Range(0, 1)) = 0.25
[Header(Bar2  X.Radius(0TO1)  Y.Width(0TO1)  Z.SpacerSize)] _B2_DataRWS ("Bar 2 Layout", Vector) = (0.8,0.2,0.04,0)
[IntRange] _B2_Spacers ("Bar 2 Segments", Range(1, 500)) = 50
[Space] _B2_Fill_Progress ("Fill Progress", Range(0, 1)) = 0.8
_B2_Overlay_Progress ("Overlay Progress", Range(0, 1)) = 0.75
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilReadMask ("Stencil Read Mask", Float) = 255
_StencilWriteMask ("Stencil Write Mask", Float) = 255
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 56421
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb8 = u_xlat8<(-u_xlat8);
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb16 = u_xlat16>=(-u_xlat16);
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
    u_xlatb0 = abs(u_xlat0)>=1.0;
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb8 = u_xlat8<(-u_xlat8);
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb16 = u_xlat16>=(-u_xlat16);
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
    u_xlatb0 = abs(u_xlat0)>=1.0;
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
    u_xlatb3 = u_xlat0.x>=2.0;
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec3 vs_NORMAL0;
varying mediump vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb8 = u_xlat8<(-u_xlat8);
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb16 = u_xlat16>=(-u_xlat16);
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
    u_xlatb0 = abs(u_xlat0)>=1.0;
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_NORMAL0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
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
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_NORMAL0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8<(-u_xlat8));
#else
    u_xlatb8 = u_xlat8<(-u_xlat8);
#endif
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(u_xlat0)>=1.0);
#else
    u_xlatb0 = abs(u_xlat0)>=1.0;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.xy = min(max(u_xlat16_10.xy, 0.0), 1.0);
#else
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(9.99999975e-05>=vs_TEXCOORD4.z);
#else
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
#endif
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(9.99999975e-05>=vs_NORMAL0.z);
#else
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
#endif
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_NORMAL0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
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
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_NORMAL0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8<(-u_xlat8));
#else
    u_xlatb8 = u_xlat8<(-u_xlat8);
#endif
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(u_xlat0)>=1.0);
#else
    u_xlatb0 = abs(u_xlat0)>=1.0;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.xy = min(max(u_xlat16_10.xy, 0.0), 1.0);
#else
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(9.99999975e-05>=vs_TEXCOORD4.z);
#else
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
#endif
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(9.99999975e-05>=vs_NORMAL0.z);
#else
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
#endif
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _HotspotRadius;
uniform 	mediump float _HotspotBloom;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _BaseSpace;
uniform 	mediump vec3 _B1_DataRWS;
uniform 	mediump float _B1_Background_Progress;
uniform 	int _B1_Spacers;
uniform 	mediump vec3 _B2_DataRWS;
uniform 	int _B2_Spacers;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec3 vs_NORMAL0;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump float u_xlat16_8;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * 20.0;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0500000007 + 1.0;
    u_xlat0.x = u_xlat0.x * _HotspotBloom;
    vs_TEXCOORD0.w = max(u_xlat0.x, 0.0);
    u_xlat0.x = _Time.y + _Time.y;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = abs(u_xlat0.x) * 0.0900000036 + 1.0;
    u_xlat16_2.xy = _B2_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = u_xlat16_2.y * 4.0;
    u_xlat0.x = _HotspotRadius * u_xlat0.x + (-u_xlat16_8);
    u_xlat0.x = _HotspotRadius * u_xlat0.x + u_xlat16_8;
    vs_TEXCOORD0.z = u_xlat0.x * _OverallRadiusScalar;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat16_8 = (-_BaseSpace) + 1.0;
    vs_TEXCOORD2.z = u_xlat16_8;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.x = (-u_xlat0.x);
    vs_TEXCOORD2.y = u_xlat0.y;
    u_xlat0.x = float(_B1_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_8 = _B1_Background_Progress + 9.99999975e-05;
    u_xlat0.x = u_xlat0.x / u_xlat16_8;
    vs_TEXCOORD3.x = u_xlat0.x;
    u_xlat0.x = float(_B2_Spacers);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=2.0);
#else
    u_xlatb3 = u_xlat0.x>=2.0;
#endif
    u_xlat3 = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_TEXCOORD4.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.w = u_xlat16_8 * _OverallRadiusScalar;
    u_xlat16_2.xy = _B1_DataRWS.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16_2.y) + u_xlat16_2.x;
    vs_NORMAL0.xy = u_xlat16_2.xy;
    vs_TEXCOORD3.z = u_xlat16_8 * _OverallRadiusScalar;
    vs_NORMAL0.z = _B1_DataRWS.z;
    vs_TEXCOORD4.z = _B2_DataRWS.z;
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
uniform 	mediump vec4 _HotspotColor;
uniform 	mediump vec4 _Background_Color;
uniform 	mediump vec4 _Fill_Color;
uniform 	mediump float _OverallRadiusScalar;
uniform 	mediump float _B1_Background_Progress;
uniform 	mediump float _B1_Fill_Progress;
uniform 	mediump float _B1_Overlay_Progress;
uniform 	mediump float _B2_Fill_Progress;
uniform 	mediump float _B2_Overlay_Progress;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec3 vs_NORMAL0;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec4 u_xlat16_4;
float u_xlat5;
mediump vec4 u_xlat16_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
bool u_xlatb7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump vec2 u_xlat16_10;
float u_xlat16;
bool u_xlatb16;
mediump float u_xlat16_17;
mediump vec2 u_xlat16_20;
bool u_xlatb24;
mediump float u_xlat16_25;
mediump float u_xlat16_26;
void main()
{
    u_xlat0 = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = float(1.0) / u_xlat0;
    u_xlat8 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat0 = u_xlat0 * u_xlat8;
    u_xlat8 = u_xlat0 * u_xlat0;
    u_xlat16 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat16 = u_xlat8 * u_xlat16 + 0.180141002;
    u_xlat16 = u_xlat8 * u_xlat16 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat16 + 0.999866009;
    u_xlat16 = u_xlat8 * u_xlat0;
    u_xlat16 = u_xlat16 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb24 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat16 = u_xlatb24 ? u_xlat16 : float(0.0);
    u_xlat0 = u_xlat0 * u_xlat8 + u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb8 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat8 = u_xlatb8 ? -3.14159274 : float(0.0);
    u_xlat0 = u_xlat8 + u_xlat0;
    u_xlat8 = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat8<(-u_xlat8));
#else
    u_xlatb8 = u_xlat8<(-u_xlat8);
#endif
    u_xlat16 = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16>=(-u_xlat16));
#else
    u_xlatb16 = u_xlat16>=(-u_xlat16);
#endif
    u_xlatb8 = u_xlatb16 && u_xlatb8;
    u_xlat0 = (u_xlatb8) ? (-u_xlat0) : u_xlat0;
    u_xlat0 = u_xlat0 * 0.318309873;
    u_xlat0 = u_xlat0 / vs_TEXCOORD2.z;
    u_xlat16_1.x = u_xlat0 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(abs(u_xlat0)>=1.0);
#else
    u_xlatb0 = abs(u_xlat0)>=1.0;
#endif
    u_xlat16_9 = (u_xlatb0) ? 0.0 : 1.0;
    u_xlat16_1.x = (-u_xlat16_1.x) * 0.5 + 1.0;
    u_xlat16_17 = dFdx(u_xlat16_1.x);
    u_xlat16_25 = dFdy(u_xlat16_1.x);
    u_xlat16_17 = abs(u_xlat16_25) + abs(u_xlat16_17);
    u_xlat16_2.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.y = (-u_xlat16_1.x) + _B2_Fill_Progress;
    u_xlat16_2.z = (-u_xlat16_1.x) + _B2_Overlay_Progress;
    u_xlat16_2.xyz = u_xlat16_2.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_0 = (-_Background_Color) + _Fill_Color;
    u_xlat16_3 = u_xlat16_2.yyyy * u_xlat16_0 + _Background_Color;
    u_xlat16_4 = (-u_xlat16_3) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_3 = u_xlat16_2.zzzz * u_xlat16_4 + u_xlat16_3;
    u_xlat16_25 = u_xlat16_2.x * u_xlat16_3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat5 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat16_2.x = dFdx(u_xlat5);
    u_xlat16_10.x = dFdy(u_xlat5);
    u_xlat16_2.x = abs(u_xlat16_10.x) + abs(u_xlat16_2.x);
    u_xlat16_4.x = vs_TEXCOORD4.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_4.zw = vec2(u_xlat5) + (-vs_TEXCOORD3.zw);
    u_xlat16_4.y = vs_NORMAL0.x * _OverallRadiusScalar + (-u_xlat5);
    u_xlat16_10.xy = u_xlat16_4.yz / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.xy = min(max(u_xlat16_10.xy, 0.0), 1.0);
#else
    u_xlat16_10.xy = clamp(u_xlat16_10.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xw = u_xlat16_4.xw / u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
    u_xlat16_25 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_25 = u_xlat16_2.w * u_xlat16_25;
    u_xlat16_2.xw = u_xlat16_1.xx * vs_TEXCOORD3.xy;
    u_xlat16_2.xw = fract(u_xlat16_2.xw);
    u_xlat16_2.xw = u_xlat16_2.xw + vec2(-0.5, -0.5);
    u_xlat16_2.xw = -abs(u_xlat16_2.xw) * vec2(2.0, 2.0) + vec2(1.0, 1.0);
    u_xlat16_4.xy = dFdx(u_xlat16_2.xw);
    u_xlat16_20.xy = dFdy(u_xlat16_2.xw);
    u_xlat16_4.xy = abs(u_xlat16_20.xy) + abs(u_xlat16_4.xy);
    u_xlat16_2.w = u_xlat16_2.w + (-vs_TEXCOORD4.z);
    u_xlat16_2.x = u_xlat16_2.x + (-vs_NORMAL0.z);
    u_xlat16_2.xw = u_xlat16_2.xw / u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xw = min(max(u_xlat16_2.xw, 0.0), 1.0);
#else
    u_xlat16_2.xw = clamp(u_xlat16_2.xw, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(9.99999975e-05>=vs_TEXCOORD4.z);
#else
    u_xlatb5 = 9.99999975e-05>=vs_TEXCOORD4.z;
#endif
    u_xlat16_4.x = (u_xlatb5) ? 1.0 : 0.0;
    u_xlat16_26 = u_xlat16_2.w + u_xlat16_4.x;
    u_xlat16_26 = min(u_xlat16_26, 1.0);
    u_xlat16_26 = u_xlat16_26 + -1.0;
    u_xlat16_4.xy = vs_TEXCOORD3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_4.y * u_xlat16_26 + 1.0;
    u_xlat16_3.w = u_xlat16_25 * u_xlat16_26;
    u_xlat16_6.x = (-u_xlat16_1.x) + _B1_Background_Progress;
    u_xlat16_6.yz = vec2(_B1_Fill_Progress, _B1_Overlay_Progress) * vec2(vec2(_B1_Background_Progress, _B1_Background_Progress)) + (-u_xlat16_1.xx);
    u_xlat16_1.xzw = u_xlat16_6.xyz / vec3(u_xlat16_17);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_1.zzzz * u_xlat16_0 + _Background_Color;
    u_xlat16_5 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat16_0 = u_xlat16_1.wwww * u_xlat16_5 + u_xlat16_0;
    u_xlat16_17 = u_xlat16_1.x * u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_17 = min(max(u_xlat16_17, 0.0), 1.0);
#else
    u_xlat16_17 = clamp(u_xlat16_17, 0.0, 1.0);
#endif
    u_xlat16_17 = u_xlat16_10.x * u_xlat16_17;
    u_xlat16_17 = u_xlat16_10.y * u_xlat16_17;
    u_xlat16_25 = u_xlat16_10.y * u_xlat16_10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(9.99999975e-05>=vs_NORMAL0.z);
#else
    u_xlatb7 = 9.99999975e-05>=vs_NORMAL0.z;
#endif
    u_xlat16_10.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_2.x = u_xlat16_10.x + u_xlat16_2.x;
    u_xlat16_2.x = min(u_xlat16_2.x, 1.0);
    u_xlat16_2.x = u_xlat16_2.x + -1.0;
    u_xlat16_2.x = u_xlat16_4.x * u_xlat16_2.x + 1.0;
    u_xlat16_0.w = u_xlat16_17 * u_xlat16_2.x;
    u_xlat16_17 = u_xlat16_25 * u_xlat16_2.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_17;
    u_xlat16_0 = (-u_xlat16_3) + u_xlat16_0;
    u_xlat16_0 = u_xlat16_1.xxxx * u_xlat16_0 + u_xlat16_3;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_2 = vec4(u_xlat16_9) * u_xlat16_0;
    u_xlat16_1.xzw = u_xlat16_2.www * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-_B2_Fill_Progress) + 1.0;
    u_xlat7.x = vs_TEXCOORD2.z * 0.5;
    u_xlat7.x = vs_TEXCOORD2.z * u_xlat16_2.x + (-u_xlat7.x);
    u_xlat7.x = u_xlat7.x + 0.5;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_2.x = u_xlat7.x * 6.28318548;
    u_xlat16_3.x = cos(u_xlat16_2.x);
    u_xlat16_2.x = sin(u_xlat16_2.x);
    u_xlat16_2.y = u_xlat16_3.x;
    u_xlat7.x = dot(u_xlat16_2.xy, u_xlat16_2.xy);
    u_xlat7.x = inversesqrt(u_xlat7.x);
    u_xlat7.xy = u_xlat16_2.xy * u_xlat7.xx;
    u_xlat16_2.x = (-vs_TEXCOORD4.y) * 0.5 + vs_TEXCOORD4.x;
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat7.xy;
    u_xlat7.xy = u_xlat16_2.xy * vec2(_OverallRadiusScalar) + vs_TEXCOORD2.xy;
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat7.x = u_xlat7.x / vs_TEXCOORD0.z;
    u_xlat16_2.x = (-u_xlat7.x) + 1.0;
    u_xlat16_10.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_10.x = u_xlat16_10.x * u_xlat16_10.x;
    u_xlat16_2.x = u_xlat16_10.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat16_10.x = (-u_xlat16_2.x) * vs_TEXCOORD0.w + 1.0;
    u_xlat7.x = u_xlat16_2.x * vs_TEXCOORD0.w;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_10.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xzw = min(max(u_xlat16_1.xzw, 0.0), 1.0);
#else
    u_xlat16_1.xzw = clamp(u_xlat16_1.xzw, 0.0, 1.0);
#endif
    SV_Target0.xyz = _HotspotColor.xyz * u_xlat7.xxx + u_xlat16_1.xzw;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_0.w * u_xlat16_9 + u_xlat7.x;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
}
}
}
}