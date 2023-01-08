//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/Circle-ProgressBarWithDivisions" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_MainColor ("Main Color", Color) = (1,1,1,1)
_ProgressColor ("Progress Color", Color) = (1,0,0,1)
_Progress ("Progress", Range(0, 1)) = 0.2
_DividerColor ("Divider Color", Color) = (0.5,0.5,0.5,1)
_Divisions ("Radial Divisions", Float) = 3
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.2
[Space] _Radius ("Circle Radius", Range(0, 1)) = 1
_DivisionThickness ("Division Thickness", Range(0, 1)) = 0.1
_OutlineAmount ("Master Outline Visibility", Range(0, 1)) = 1
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
  GpuProgramID 50790
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = int(max(float(_Divisions), 1.40129846e-45));
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = op_and((ivec2(u_xlatb9.xy) * -1), (ivec2(u_xlatb2.xy) * -1));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
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
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = int(max(float(_Divisions), 1.40129846e-45));
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = op_and((ivec2(u_xlatb9.xy) * -1), (ivec2(u_xlatb2.xy) * -1));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
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
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = int(max(float(_Divisions), 1.40129846e-45));
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
varying mediump vec4 vs_COLOR0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = op_and((ivec2(u_xlatb9.xy) * -1), (ivec2(u_xlatb2.xy) * -1));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
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
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = max(_Divisions, 1);
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = ivec2(uvec2((uint(u_xlatb9.x) * 0xffffffffu) & (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb9.y) * 0xffffffffu) & (uint(u_xlatb2.y) * 0xffffffffu)));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
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
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = max(_Divisions, 1);
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = ivec2(uvec2((uint(u_xlatb9.x) * 0xffffffffu) & (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb9.y) * 0xffffffffu) & (uint(u_xlatb2.y) * 0xffffffffu)));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
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
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _DivisionThickness;
uniform 	mediump float _OutlineWidth;
uniform 	int _Divisions;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
int u_xlati0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD2.z = (-_OutlineWidth) + _Radius;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.w = (-u_xlat0.y);
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlati0 = max(_Divisions, 1);
    vs_TEXCOORD3.x = float(u_xlati0);
    vs_TEXCOORD3.y = (-_ProgressColor.w) + 1.0;
    vs_TEXCOORD3.z = (-_DividerColor.w) + 1.0;
    vs_TEXCOORD3.w = (-_DivisionThickness) + 1.0;
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
uniform 	mediump vec4 _MainColor;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _ProgressColor;
uniform 	mediump vec4 _DividerColor;
uniform 	mediump float _Radius;
uniform 	mediump float _Progress;
uniform 	mediump float _OutlineAmount;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb2;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
mediump float u_xlat16_7;
mediump vec2 u_xlat16_8;
vec2 u_xlat9;
ivec2 u_xlati9;
bvec2 u_xlatb9;
mediump float u_xlat16_11;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = max(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = vec2(1.0, 1.0) / u_xlat16_0.xy;
    u_xlat16_8.xy = min(abs(vs_TEXCOORD2.yw), abs(vs_TEXCOORD2.xx));
    u_xlat16_0.xy = u_xlat16_0.xy * u_xlat16_8.xy;
    u_xlat16_8.xy = u_xlat16_0.xy * u_xlat16_0.xy;
    u_xlat1.xy = u_xlat16_8.xy * vec2(0.0208350997, 0.0208350997) + vec2(-0.0851330012, -0.0851330012);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.180141002, 0.180141002);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(-0.330299497, -0.330299497);
    u_xlat1.xy = u_xlat16_8.xy * u_xlat1.xy + vec2(0.999866009, 0.999866009);
    u_xlat9.xy = u_xlat16_0.xy * u_xlat1.xy;
    u_xlat9.xy = u_xlat9.xy * vec2(-2.0, -2.0) + vec2(1.57079637, 1.57079637);
    u_xlatb2.xy = lessThan(abs(vs_TEXCOORD2.ywyy), abs(vs_TEXCOORD2.xxxx)).xy;
    u_xlat9.x = u_xlatb2.x ? u_xlat9.x : 0.0;
    u_xlat9.y = u_xlatb2.y ? u_xlat9.y : 0.0;
;
    u_xlat1.xy = u_xlat16_0.xy * u_xlat1.xy + u_xlat9.xy;
    u_xlatb9.xy = lessThan(vs_TEXCOORD2.ywyw, (-vs_TEXCOORD2.ywyw)).xy;
    u_xlat9.x = u_xlatb9.x ? float(-3.14159274) : 0.0;
    u_xlat9.y = u_xlatb9.y ? float(-3.14159274) : 0.0;
;
    u_xlat1.xy = u_xlat9.xy + u_xlat1.xy;
    u_xlat16_0.xy = min(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb9.xy = lessThan(u_xlat16_0.xyxy, (-u_xlat16_0.xyxy)).xy;
    u_xlat16_0.xy = max(vs_TEXCOORD2.yw, vs_TEXCOORD2.xx);
    u_xlatb2.xy = greaterThanEqual(u_xlat16_0.xyxx, (-u_xlat16_0.xyxx)).xy;
    u_xlati9.xy = ivec2(uvec2((uint(u_xlatb9.x) * 0xffffffffu) & (uint(u_xlatb2.x) * 0xffffffffu), (uint(u_xlatb9.y) * 0xffffffffu) & (uint(u_xlatb2.y) * 0xffffffffu)));
    {
        vec2 hlslcc_movcTemp = u_xlat1;
        hlslcc_movcTemp.x = (u_xlati9.x != 0) ? (-u_xlat1.x) : u_xlat1.x;
        hlslcc_movcTemp.y = (u_xlati9.y != 0) ? (-u_xlat1.y) : u_xlat1.y;
        u_xlat1 = hlslcc_movcTemp;
    }
    u_xlat16_0.x = u_xlat1.y * 0.159154937 + _Progress;
    u_xlat16_4 = u_xlat1.x * 0.159154937 + -0.5;
    u_xlat16_8.x = dFdx(u_xlat16_4);
    u_xlat16_12 = dFdy(u_xlat16_4);
    u_xlat16_4 = u_xlat16_4 * vs_TEXCOORD3.x;
    u_xlat16_0.y = fract(u_xlat16_4);
    u_xlat16_0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat16_8.x = abs(u_xlat16_12) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_0.x / u_xlat16_8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.y);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_1 = (-_OutlineColor) + _ProgressColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _OutlineColor;
    u_xlat16_2 = (-u_xlat16_1) + _DividerColor;
    u_xlat16_0.x = abs(u_xlat16_0.y) + abs(u_xlat16_0.y);
    u_xlat16_4 = abs(u_xlat16_0.y) * 2.0 + (-vs_TEXCOORD3.w);
    u_xlat16_8.x = dFdx(u_xlat16_0.x);
    u_xlat16_0.x = dFdy(u_xlat16_0.x);
    u_xlat16_0.x = abs(u_xlat16_0.x) + abs(u_xlat16_8.x);
    u_xlat16_0.x = u_xlat16_4 / u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0.x = u_xlat16_0.x + (-vs_TEXCOORD3.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat16_0.xxxx * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + (-_MainColor);
    u_xlat16_3 = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_3 = sqrt(u_xlat16_3);
    u_xlat16_7 = dFdx(u_xlat16_3);
    u_xlat16_11 = dFdy(u_xlat16_3);
    u_xlat16_7 = abs(u_xlat16_11) + abs(u_xlat16_7);
    u_xlat16_11 = u_xlat16_3 + (-vs_TEXCOORD2.z);
    u_xlat16_3 = (-u_xlat16_3) + _Radius;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_7 = u_xlat16_11 / u_xlat16_7;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7 = min(max(u_xlat16_7, 0.0), 1.0);
#else
    u_xlat16_7 = clamp(u_xlat16_7, 0.0, 1.0);
#endif
    u_xlat16_7 = min(u_xlat16_7, _OutlineAmount);
    u_xlat16_0 = vec4(u_xlat16_7) * u_xlat16_0 + _MainColor;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_3 * u_xlat16_12;
    return;
}

#endif
"
}
}
}
}
}