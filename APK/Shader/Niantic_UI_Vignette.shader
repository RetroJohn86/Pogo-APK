//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/Vignette" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Frame ("Frame", Vector) = (0.4,0.4,0.6,0.6)
_ClipFrame ("Clip Frame", Vector) = (0,0,0.1,0.1)
_Ratio ("Ratio", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
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
  GpuProgramID 45813
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _Frame;
uniform 	vec4 _ClipFrame;
uniform 	float _Ratio;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec2 u_xlat16_6;
bool u_xlatb9;
bool u_xlatb14;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD0.xyx + (-_Frame.xwz);
    u_xlat16_1.z = -0.0199999996;
    u_xlat2.x = float(1.0);
    u_xlat2.z = float(1.0);
    u_xlat2.y = _Ratio;
    u_xlat16_1.xy = u_xlat2.zy * vec2(0.0199999996, 0.0199999996);
    u_xlat16_1.w = (-u_xlat16_1.y);
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_1.xwz);
    u_xlat0.xyz = u_xlat0.xyz / u_xlat2.xyz;
    u_xlat16_3.z = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat16_3.w = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlatb0.zw = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), (-u_xlat0.zzzy)).zw;
    u_xlat4.xyz = vs_TEXCOORD0.xyx + (-_Frame.xyz);
    u_xlat4.xyz = (-u_xlat16_1.xyz) + u_xlat4.xyz;
    u_xlat2.xyz = u_xlat4.xyz / u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat16_3.y = dot(u_xlat2.yz, u_xlat2.yz);
    u_xlatb0.xy = greaterThanEqual(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy;
    u_xlat16_0.x = (u_xlatb0.x) ? float(1.0) : float(0.0);
    u_xlat16_0.y = (u_xlatb0.y) ? float(1.0) : float(0.0);
    u_xlat16_0.z = (u_xlatb0.z) ? float(1.0) : float(0.0);
    u_xlat16_0.w = (u_xlatb0.w) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_0.ywwy * u_xlat16_0.xzxz;
    u_xlat16_1.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_1.x = max(u_xlat16_1.y, u_xlat16_1.x);
    u_xlat16_0 = u_xlat16_3 + vec4(-7.50000036e-05, -7.50000036e-05, -7.50000036e-05, -7.50000036e-05);
    u_xlat16_0 = (-u_xlat16_0) + vec4(0.00039999999, 0.00039999999, 0.00039999999, 0.00039999999);
    u_xlat16_0 = u_xlat16_0 * vec4(6666.6665, 6666.6665, 6666.6665, 6666.6665);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_6.xy = max(u_xlat16_0.yw, u_xlat16_0.xz);
    u_xlat16_6.x = max(u_xlat16_6.y, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat16_6.x) + 1.0;
    u_xlat16_1.x = (-u_xlat16_6.x) * u_xlat16_1.x + 1.0;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _Frame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb14 = u_xlatb0.z || u_xlatb0.w;
    u_xlat16_6.x = u_xlat4.y * u_xlat4.x;
    u_xlatb0 = greaterThanEqual(vs_TEXCOORD0.xyxy, _ClipFrame);
    u_xlat4.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlat16_6.x * u_xlat4.x;
    u_xlat4.x = u_xlat4.y * u_xlat4.x;
    u_xlatb9 = u_xlatb14 || u_xlatb0.z;
    u_xlatb9 = u_xlatb0.w || u_xlatb9;
    u_xlat16_6.x = (u_xlatb9) ? 0.0 : u_xlat4.x;
    u_xlat16_1.x = min(u_xlat16_1.x, u_xlat16_6.x);
    SV_Target0.w = u_xlat16_1.x * (-vs_COLOR0.w) + vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}