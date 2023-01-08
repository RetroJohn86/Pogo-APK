//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/ProgressRing" {
Properties {
_MainTex ("Base (RGB)", 2D) = "clear" { }
_Color ("Tint", Color) = (1,1,1,1)
_CenterColor ("Center Color", Color) = (1,1,1,1)
_IconTint ("Icon Color", Color) = (1,0,0,1)
_BarFillColor ("Bar Fill Color", Color) = (0.5,0,1,1)
_BarBaseColor ("Bar Base Color", Color) = (0,0,0,1)
_Progress ("Progress", Range(0, 1)) = 0.2
_Width ("Outline Width", Range(0, 1)) = 0.2
_Radius ("Outer Radius", Range(0, 1)) = 1
_TexScale ("Texture Scale", Float) = 1
[Toggle] _Clockwise ("Clockwise Fill", Float) = 1
[Toggle] _BottomFill ("Fill From Bottom", Float) = 1
[Space] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
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
  GpuProgramID 9607
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlatb7 = _Progress>=0.995000005;
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
    u_xlatb2 = 0.999000013>=u_xlat2;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat10_1.w;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlatb7 = _Progress>=0.995000005;
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
    u_xlatb2 = 0.999000013>=u_xlat2;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat10_1.w;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD2;
varying mediump float vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlatb7 = _Progress>=0.995000005;
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
    u_xlatb2 = 0.999000013>=u_xlat2;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat10_1.w;
    u_xlat16_1.xyz = u_xlat10_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_0.x>=(-u_xlat16_0.x));
#else
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
#endif
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_Progress>=0.995000005);
#else
    u_xlatb7 = _Progress>=0.995000005;
#endif
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.999000013>=u_xlat2);
#else
    u_xlatb2 = 0.999000013>=u_xlat2;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat16_1.w;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xy = min(max(u_xlat5.xy, 0.0), 1.0);
#else
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_0.x>=(-u_xlat16_0.x));
#else
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
#endif
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_Progress>=0.995000005);
#else
    u_xlatb7 = _Progress>=0.995000005;
#endif
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.999000013>=u_xlat2);
#else
    u_xlatb2 = 0.999000013>=u_xlat2;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat16_1.w;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xy = min(max(u_xlat5.xy, 0.0), 1.0);
#else
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Width;
uniform 	mediump float _TexScale;
uniform 	int _Clockwise;
uniform 	int _BottomFill;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
bvec2 u_xlatb1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat4.xy = u_xlat0.xy * vec2(vec2(_TexScale, _TexScale));
    vs_TEXCOORD0.zw = u_xlat4.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat4.xy;
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat4.xy = u_xlat0.xy + u_xlat0.xy;
    u_xlat1.xy = vec2(ivec2(_BottomFill, _Clockwise));
    u_xlatb1.xy = greaterThanEqual(u_xlat1.xyxx, vec4(0.5, 0.5, 0.0, 0.0)).xy;
    u_xlat1.x = u_xlatb1.x ? float(1.0) : 0.0;
    u_xlat1.y = u_xlatb1.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat1.xx * u_xlat4.xy + (-u_xlat0.xy);
    u_xlat4.x = u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat1.y * u_xlat4.x + (-u_xlat0.x);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    vs_TEXCOORD2.z = (-_Width) + _Radius;
    vs_TEXCOORD3 = (-_BarFillColor.w) + 1.0;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _IconTint;
uniform 	mediump vec4 _BarBaseColor;
uniform 	mediump vec4 _BarFillColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD2;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec4 u_xlat16_2;
bool u_xlatb2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_4;
vec2 u_xlat5;
mediump float u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
mediump float u_xlat16_15;
mediump float u_xlat16_18;
void main()
{
    u_xlat16_0.x = max(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = float(1.0) / u_xlat16_0.x;
    u_xlat16_6 = min(abs(vs_TEXCOORD2.y), abs(vs_TEXCOORD2.x));
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_6;
    u_xlat16_6 = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat1 = u_xlat16_6 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat16_6 * u_xlat1 + -0.330299497;
    u_xlat1 = u_xlat16_6 * u_xlat1 + 0.999866009;
    u_xlat7 = u_xlat16_0.x * u_xlat1;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x));
#else
    u_xlatb13 = abs(vs_TEXCOORD2.y)<abs(vs_TEXCOORD2.x);
#endif
    u_xlat7 = u_xlatb13 ? u_xlat7 : float(0.0);
    u_xlat1 = u_xlat16_0.x * u_xlat1 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(vs_TEXCOORD2.y<(-vs_TEXCOORD2.y));
#else
    u_xlatb7 = vs_TEXCOORD2.y<(-vs_TEXCOORD2.y);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat1 = u_xlat7 + u_xlat1;
    u_xlat16_0.x = min(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb7 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat16_0.x = max(vs_TEXCOORD2.y, vs_TEXCOORD2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_0.x>=(-u_xlat16_0.x));
#else
    u_xlatb13 = u_xlat16_0.x>=(-u_xlat16_0.x);
#endif
    u_xlatb7 = u_xlatb13 && u_xlatb7;
    u_xlat1 = (u_xlatb7) ? (-u_xlat1) : u_xlat1;
    u_xlat1 = u_xlat1 * 0.318309873 + 1.0;
    u_xlat7 = u_xlat1 * 0.5;
    u_xlat1 = (-u_xlat1) * 0.5 + _Progress;
    u_xlat13 = dFdx(u_xlat7);
    u_xlat7 = dFdy(u_xlat7);
    u_xlat7 = abs(u_xlat7) + abs(u_xlat13);
    u_xlat1 = u_xlat1 / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(_Progress>=0.995000005);
#else
    u_xlatb7 = _Progress>=0.995000005;
#endif
    u_xlat16_0.x = (u_xlatb7) ? 1.0 : 0.0;
    u_xlat16_0.x = u_xlat1 + u_xlat16_0.x;
    u_xlat16_0.x = min(u_xlat16_0.x, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_BarBaseColor) + _BarFillColor;
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_1 + _BarBaseColor;
    u_xlat2 = max(abs(vs_TEXCOORD0.y), abs(vs_TEXCOORD0.x));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.999000013>=u_xlat2);
#else
    u_xlatb2 = 0.999000013>=u_xlat2;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw);
    u_xlat16_3 = u_xlat2 * u_xlat16_1.w;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _IconTint.xyz;
    u_xlat16_1.w = u_xlat16_3 * _IconTint.w;
    u_xlat16_3 = u_xlat16_1.w * -2.0 + _CenterColor.w;
    u_xlat16_3 = u_xlat16_3 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_2 = (-u_xlat16_1) + _CenterColor;
    u_xlat16_1 = vec4(u_xlat16_3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-u_xlat16_1);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_9 = dFdx(u_xlat16_3);
    u_xlat16_15 = dFdy(u_xlat16_3);
    u_xlat16_9 = abs(u_xlat16_15) + abs(u_xlat16_9);
    u_xlat16_4.x = (-u_xlat16_3) + _Radius;
    u_xlat16_4.y = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat5.xy = u_xlat16_4.xy / vec2(u_xlat16_9);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.xy = min(max(u_xlat5.xy, 0.0), 1.0);
#else
    u_xlat5.xy = clamp(u_xlat5.xy, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat5.yyyy * u_xlat16_0 + u_xlat16_1;
    u_xlat16_18 = u_xlat5.x * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_18 * vs_COLOR0.w;
    return;
}

#endif
"
}
}
}
}
}