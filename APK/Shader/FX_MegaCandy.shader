//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "FX/MegaCandy" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_RampColor1 ("Ramp 1", Color) = (1,1,1,1)
_RampColor2 ("Ramp 2", Color) = (1,1,1,1)
_RampColor3 ("Ramp 3", Color) = (1,1,1,1)
_RampColor4 ("Ramp 4", Color) = (1,1,1,1)
_GlowColor ("Glow Color", Color) = (1,1,1,1)
_Stop1 ("Stop 1", Range(0, 1)) = 0
_Stop2 ("Stop 2", Range(0, 1)) = 0.3
_Stop3 ("Stop 3", Range(0, 1)) = 0.6
_Stop4 ("Stop 4", Range(0, 1)) = 1
_GlassColor ("Glass Mode", Float) = 0
_GlassTint ("Glass Tint", Range(0, 1)) = 1
_GlowIntensity ("Glow Intensity", Float) = 1
_GlowColorIntensity ("Glow Color Intensity", Float) = 0.5
_BrightnessCurve ("Brightness Curve", Float) = 0.15
_ColorMask ("Color Mask", Float) = 15
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
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
  GpuProgramID 12954
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat10_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat10_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat10_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat10_1.y * _GlowColorIntensity + u_xlat10_1.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat10_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat10_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat10_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat10_1.y * _GlowColorIntensity + u_xlat10_1.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat10_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat10_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat10_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat10_1.y * _GlowColorIntensity + u_xlat10_1.w;
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
#else
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.z = min(max(u_xlat16_2.z, 0.0), 1.0);
#else
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
#endif
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat16_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xyz = min(max(u_xlat6.xyz, 0.0), 1.0);
#else
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat16_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat16_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat16_1.y * _GlowColorIntensity + u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
#else
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.z = min(max(u_xlat16_2.z, 0.0), 1.0);
#else
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
#endif
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat16_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xyz = min(max(u_xlat6.xyz, 0.0), 1.0);
#else
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat16_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat16_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat16_1.y * _GlowColorIntensity + u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform 	mediump vec4 _RampColor1;
uniform 	mediump vec4 _RampColor2;
uniform 	mediump vec4 _RampColor3;
uniform 	mediump vec4 _RampColor4;
uniform 	mediump float _Stop1;
uniform 	mediump float _Stop2;
uniform 	mediump float _Stop3;
uniform 	mediump float _Stop4;
uniform 	mediump float _GlassColor;
uniform 	mediump float _GlassTint;
uniform 	mediump float _GlowIntensity;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump float _GlowColorIntensity;
uniform 	mediump float _BrightnessCurve;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bvec3 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
mediump vec3 u_xlat16_8;
float u_xlat27;
mediump float u_xlat16_29;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(0.0, -1.0);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
#else
    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
#endif
    u_xlat0.xy = vs_TEXCOORD0.yx * vec2(-1.0, 1.0) + vec2(1.0, 0.0);
    u_xlat16_1.xy = u_xlat0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xy = min(max(u_xlat16_1.xy, 0.0), 1.0);
#else
    u_xlat16_1.xy = clamp(u_xlat16_1.xy, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.z = (-u_xlat0.x) + 1.39999998;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.z = min(max(u_xlat16_2.z, 0.0), 1.0);
#else
    u_xlat16_2.z = clamp(u_xlat16_2.z, 0.0, 1.0);
#endif
    u_xlat16_2.xy = vs_TEXCOORD0.xy * vec2(1.29999995, 1.29999995);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-u_xlat16_2.xyz);
    u_xlat16_1.xyz = vec3(_GlassColor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlatb0.xyz = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.0), u_xlat16_1.xyzx).xyz;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat3.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
    u_xlat5.xyz = (-_RampColor3.xyz) + _RampColor4.xyz;
    u_xlat6.xyz = (-vec3(_Stop3, _Stop2, _Stop1)) + vec3(_Stop4, _Stop3, _Stop2);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat7.xyz = u_xlat16_1.xxx + (-vec3(_Stop3, _Stop2, _Stop1));
    u_xlat6.xyz = u_xlat7.xyz / u_xlat6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xyz = min(max(u_xlat6.xyz, 0.0), 1.0);
#else
    u_xlat6.xyz = clamp(u_xlat6.xyz, 0.0, 1.0);
#endif
    u_xlat5.xyz = u_xlat6.xxx * u_xlat5.xyz + _RampColor3.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor2.xyz);
    u_xlat5.xyz = u_xlat6.yyy * u_xlat5.xyz + _RampColor2.xyz;
    u_xlat5.xyz = u_xlat5.xyz + (-_RampColor1.xyz);
    u_xlat5.xyz = u_xlat6.zzz * u_xlat5.xyz + _RampColor1.xyz;
    u_xlat6.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat4.xyz) * u_xlat6.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat4.xyz = (-u_xlat3.xyz) * u_xlat5.xyz + u_xlat4.xyz;
    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat4.xyz + u_xlat3.xyz;
    u_xlat27 = (-_GlassTint) + 1.0;
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_GlassTint, _GlassTint, _GlassTint)) + u_xlat3.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_29 = u_xlat16_1.z * _GlowIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_8.xyz = (-u_xlat16_2.xyz) + _GlowColor.xyz;
    u_xlat16_29 = u_xlat16_1.y * _GlowColorIntensity;
    u_xlat16_2.xyz = vec3(u_xlat16_29) * u_xlat16_8.xyz + u_xlat16_2.xyz;
    u_xlat16_8.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_8.xyz = (-u_xlat16_8.xyz) * u_xlat16_8.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_0.xyz = u_xlat16_8.xyz * vec3(_BrightnessCurve) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = vs_COLOR0.xyz;
    u_xlat16_2.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_0.w = u_xlat16_1.y * _GlowColorIntensity + u_xlat16_1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0 * u_xlat16_2;
    return;
}

#endif
"
}
}
}
}
}