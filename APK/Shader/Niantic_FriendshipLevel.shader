//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/FriendshipLevel" {
Properties {
_Antialias ("Antialias Strength", Range(0, 1)) = 0.04
_NumIcons ("Number of Icons", Float) = 4
_CircleSize ("Circle Size", Range(0, 1)) = 0.8
_Progress ("Progress", Range(0, 1)) = 0.5
_HeartbeatIntensity ("Heartbeat Intensity", Float) = 0.005
_HeartbeatSpeed ("Heartbeat Speed", Float) = 3
_IconSize ("Icon Scale", Vector) = (1.5,1.5,1,1)
_IconOffset ("Icon Pos Offset", Vector) = (0,0,1,1)
_BackgroundColor ("Background Color", Color) = (1,1,1,0)
_CircleFullColor ("Circle Full Color", Color) = (1,0.65,0.66,1)
_CircleProgressColor ("Circle Progress Color", Color) = (0.97,0.4,0.98,1)
_CircleNoProgressColor ("Circle No Progress Color", Color) = (0.5,0.5,0.5,1)
_IconFullColor ("Inner Icon Full Color", Color) = (1,1,1,1)
_IconUnfullColor ("Inner Icon Unfull Color", Color) = (0.82,0.82,0.82,1)
[Toggle(USE_TEXTURE)] _UseTexture ("Use Texture As Icon", Float) = 0
_MainTex ("Inner Icon Texture", 2D) = "white" { }
_TextureHeight ("Texture Height", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 63174
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlati16 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = int(max((-float(u_xlati5)), float(u_xlati5)));
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
vec2 u_xlat10;
float u_xlat15;
int u_xlati16;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati16 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati16 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati5 = (-u_xlati16) + u_xlati5;
    u_xlati5 = max((-u_xlati5), u_xlati5);
    u_xlati5 = (-u_xlati5) + 1;
    u_xlat5 = float(u_xlati5);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat10.xy * u_xlat1.xx + (-u_xlat10.xy);
    u_xlat1.xy = vec2(u_xlat5) * u_xlat1.xy + u_xlat10.xy;
    u_xlat5 = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat10.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat15 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat10.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat15);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat10.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat15 = u_xlat5 + _Antialias;
    u_xlat5 = u_xlat5 + (-_Antialias);
    u_xlat15 = (-u_xlat5) + u_xlat15;
    u_xlat5 = (-u_xlat5) + _CircleSize;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat5 = u_xlat15 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat15 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat5) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat10.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat4) ? -1 : 0);
    u_xlati4 = int((u_xlat4<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
int u_xlati4;
vec2 u_xlat5;
bool u_xlatb5;
vec2 u_xlat8;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat5.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat5.xy = trunc(u_xlat5.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat5.x);
    u_xlat0.x = u_xlat5.y / u_xlat1.x;
    u_xlat4 = (-u_xlat5.x) + u_xlat5.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat8.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat8.xy, u_xlat8.xy);
    u_xlat5.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat5.x = (-u_xlat1.x) + u_xlat5.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat1.x = u_xlat5.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb5 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat5.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat4) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4<0.0; u_xlati4 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati4 = int((u_xlat4<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati4;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat4 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat8.xy * vec2(u_xlat4) + (-u_xlat8.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat8.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.x = u_xlat0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
    u_xlati19 = int((0.0<u_xlat6) ? -1 : 0);
    u_xlati6 = int((u_xlat6<0.0) ? -1 : 0);
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = int(max((-float(u_xlati6)), float(u_xlati6)));
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0.x = u_xlat1.x<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _TextureHeight;
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	vec4 _ClipRect;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
bvec4 u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
int u_xlati6;
vec2 u_xlat7;
vec2 u_xlat12;
float u_xlat18;
int u_xlati19;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat7.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat7.xy = trunc(u_xlat7.xy);
    u_xlat6 = (-u_xlat7.x) + u_xlat7.y;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat6; u_xlati19 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati19 = int((0.0<u_xlat6) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat6<0.0; u_xlati6 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati6 = int((u_xlat6<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati6 = (-u_xlati19) + u_xlati6;
    u_xlati6 = max((-u_xlati6), u_xlati6);
    u_xlati6 = (-u_xlati6) + 1;
    u_xlat6 = float(u_xlati6);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat7.x);
    u_xlat0.x = u_xlat7.y / u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0.x = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat12.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = vs_TEXCOORD0.z + 1.0;
    u_xlat1.xy = u_xlat12.xy * u_xlat1.xx + (-u_xlat12.xy);
    u_xlat1.xy = vec2(u_xlat6) * u_xlat1.xy + u_xlat12.xy;
    u_xlat6 = dot(u_xlat12.xy, u_xlat12.xy);
    u_xlat12.x = u_xlat1.y * 2.0 + 0.25;
    u_xlat18 = u_xlat1.x + u_xlat1.x;
    u_xlat1.x = _TextureHeight * _Antialias;
    u_xlat2.xz = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat2.yw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + u_xlat12.xx;
    u_xlat3 = u_xlat2.zwzw * u_xlat2.zwzw;
    u_xlat2 = u_xlat2 * u_xlat3;
    u_xlat4.xy = u_xlat1.xx * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat4.zw = (-u_xlat1.xx) * vec2(0.00499999989, 0.00499999989) + vec2(u_xlat18);
    u_xlat1 = u_xlat4 * u_xlat4;
    u_xlat3 = u_xlat4.yyww * u_xlat4.yyww + u_xlat3.zwzw;
    u_xlat3 = u_xlat3 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = u_xlat2 * u_xlat1;
    u_xlat2 = u_xlat3 * u_xlat3;
    u_xlat1 = u_xlat3 * u_xlat2 + (-u_xlat1);
    u_xlatb1 = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat1);
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
    u_xlat1.z = u_xlatb1.z ? float(1.0) : 0.0;
    u_xlat1.w = u_xlatb1.w ? float(1.0) : 0.0;
;
    u_xlat12.x = dot(u_xlat1, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat18 = u_xlat6 + _Antialias;
    u_xlat6 = u_xlat6 + (-_Antialias);
    u_xlat18 = (-u_xlat6) + u_xlat18;
    u_xlat6 = (-u_xlat6) + _CircleSize;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat6 = u_xlat18 * u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat18 = u_xlat6 * -2.0 + 3.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat18;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.w = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb0.w = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat1 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat1 = u_xlat0.wwww * u_xlat1 + _CircleNoProgressColor;
    u_xlat2 = (-u_xlat1) + _CircleFullColor;
    u_xlat1 = u_xlat0.xxxx * u_xlat2 + u_xlat1;
    u_xlat1 = u_xlat1 + (-_BackgroundColor);
    u_xlat1 = vec4(u_xlat6) * u_xlat1 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlat0 = u_xlat12.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_5 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_5;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat1.x<0.0);
#else
    u_xlatb0.x = u_xlat1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
    u_xlati0 = int((0.0<u_xlat5) ? -1 : 0);
    u_xlati5 = int((u_xlat5<0.0) ? -1 : 0);
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = int(max((-float(u_xlati0)), float(u_xlati0)));
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat10_0.wwww * u_xlat10_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb1 = u_xlat1.x<0.0;
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" "USE_TEXTURE" }
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
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _HeartbeatIntensity;
uniform 	float _HeartbeatSpeed;
uniform 	vec4 _ClipRect;
uniform 	float _UIMaskSoftnessX;
uniform 	float _UIMaskSoftnessY;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD1 = in_POSITION0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.w * _HeartbeatSpeed;
    u_xlat1 = u_xlat0.xxxx * vec4(1.0, 2.0, 3.0, 4.0);
    u_xlat1 = sin(u_xlat1);
    u_xlat0.x = dot(vec4(-7.7392087, 8.36960411, -6.13529205, 4.74730206), u_xlat1);
    vs_TEXCOORD0.z = u_xlat0.x * _HeartbeatIntensity;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = vec2(_UIMaskSoftnessX, _UIMaskSoftnessY) * vec2(0.25, 0.25) + abs(u_xlat0.xy);
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, vec4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = in_POSITION0.xy * vec2(2.0, 2.0) + (-u_xlat0.xy);
    vs_TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
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
uniform 	float _Antialias;
uniform 	int _NumIcons;
uniform 	float _CircleSize;
uniform 	float _Progress;
uniform 	vec4 _BackgroundColor;
uniform 	vec4 _CircleFullColor;
uniform 	vec4 _CircleProgressColor;
uniform 	vec4 _CircleNoProgressColor;
uniform 	vec4 _IconFullColor;
uniform 	vec4 _IconUnfullColor;
uniform 	mediump vec4 _IconSize;
uniform 	vec4 _IconOffset;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
int u_xlati0;
bool u_xlatb0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
int u_xlati5;
vec2 u_xlat6;
bool u_xlatb6;
vec2 u_xlat10;
void main()
{
    u_xlat0.y = _Progress;
    u_xlat1.x = float(_NumIcons);
    u_xlat0.xw = vs_TEXCOORD0.xy;
    u_xlat6.xy = u_xlat0.xy * u_xlat1.xx;
    u_xlat6.xy = trunc(u_xlat6.xy);
    u_xlat0.z = u_xlat0.x * u_xlat1.x + (-u_xlat6.x);
    u_xlat0.x = u_xlat6.y / u_xlat1.x;
    u_xlat5 = (-u_xlat6.x) + u_xlat6.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=vs_TEXCOORD0.x);
#else
    u_xlatb0 = u_xlat0.x>=vs_TEXCOORD0.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10.xy = u_xlat0.zw * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = dot(u_xlat10.xy, u_xlat10.xy);
    u_xlat6.x = u_xlat1.x + _Antialias;
    u_xlat1.x = u_xlat1.x + (-_Antialias);
    u_xlat6.x = (-u_xlat1.x) + u_xlat6.x;
    u_xlat1.x = (-u_xlat1.x) + _CircleSize;
    u_xlat6.x = float(1.0) / u_xlat6.x;
    u_xlat1.x = u_xlat6.x * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6.x = u_xlat1.x * -2.0 + 3.0;
    u_xlat1.x = u_xlat1.x * u_xlat1.x;
    u_xlat1.x = u_xlat1.x * u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(_Progress>=vs_TEXCOORD0.x);
#else
    u_xlatb6 = _Progress>=vs_TEXCOORD0.x;
#endif
    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
    u_xlat2 = _CircleProgressColor + (-_CircleNoProgressColor);
    u_xlat2 = u_xlat6.xxxx * u_xlat2 + _CircleNoProgressColor;
    u_xlat3 = (-u_xlat2) + _CircleFullColor;
    u_xlat2 = u_xlat0.xxxx * u_xlat3 + u_xlat2;
    u_xlat2 = u_xlat2 + (-_BackgroundColor);
    u_xlat1 = u_xlat1.xxxx * u_xlat2 + _BackgroundColor;
    u_xlat2 = _IconFullColor + (-_IconUnfullColor);
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + _IconUnfullColor;
    u_xlat2 = (-u_xlat1) + u_xlat2;
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat5; u_xlati0 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati0 = int((0.0<u_xlat5) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat5<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat5<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlati0 = (-u_xlati0) + u_xlati5;
    u_xlati0 = max((-u_xlati0), u_xlati0);
    u_xlati0 = (-u_xlati0) + 1;
    u_xlat0.x = float(u_xlati0);
    u_xlat5 = vs_TEXCOORD0.z + 1.0;
    u_xlat3.xy = u_xlat10.xy * vec2(u_xlat5) + (-u_xlat10.xy);
    u_xlat0.xy = u_xlat0.xx * u_xlat3.xy + u_xlat10.xy;
    u_xlat0.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy / _IconSize.xy;
    u_xlat0.xy = u_xlat0.xy + _IconOffset.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_0;
    u_xlat3.x = dot(u_xlat16_0, vec4(0.25, 0.25, 0.25, 0.25));
    u_xlat0 = u_xlat3.xxxx * u_xlat2 + u_xlat1;
    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.xy = min(max(u_xlat1.xy, 0.0), 1.0);
#else
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat1.y * u_xlat1.x;
    u_xlat1.x = u_xlat0.w * u_xlat16_4 + -0.00100000005;
    u_xlat0.w = u_xlat0.w * u_xlat16_4;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<0.0);
#else
    u_xlatb1 = u_xlat1.x<0.0;
#endif
    if(u_xlatb1){discard;}
    return;
}

#endif
"
}
}
}
}
}