//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/RaidEmblemSDF" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_IconColor ("Icon Color", Color) = (1,1,1,1)
_IconOutlineColorA ("Icon Outline Color A", Color) = (1,1,1,1)
_IconOutlineColorB ("Icon Outline Color B", Color) = (1,1,1,1)
_IconDetailColor ("Icon Detail Color", Color) = (1,1,1,1)
_BorderColorA ("Border Color A", Color) = (1,1,1,1)
_BorderColorB ("Border Color A", Color) = (1,1,1,1)
_BackgroundColorA ("Background Color A", Color) = (1,1,1,1)
_BackgroundColorB ("Background Color B", Color) = (1,1,1,1)
_IconThreshold ("Icon Threshold", Range(0, 1)) = 0.5
_BorderThresholdA ("Border Threshold A", Range(0, 1)) = 0.5
_BorderThresholdB ("Border Threshold B", Range(0, 1)) = 0.5
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 31451
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat10_0.x) + 1.0;
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat10_0.x);
    u_xlat16_3.x = dFdy(u_xlat10_0.x);
    u_xlat16_0 = (-u_xlat10_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat10_0.x) + 1.0;
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat10_0.x);
    u_xlat16_3.x = dFdy(u_xlat10_0.x);
    u_xlat16_0 = (-u_xlat10_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat10_0.x) + 1.0;
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat10_0.x);
    u_xlat16_3.x = dFdy(u_xlat10_0.x);
    u_xlat16_0 = (-u_xlat10_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat16_0.x);
    u_xlat16_3.x = dFdy(u_xlat16_0.x);
    u_xlat16_0 = (-u_xlat16_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat16_0.x);
    u_xlat16_3.x = dFdy(u_xlat16_0.x);
    u_xlat16_0 = (-u_xlat16_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
    SV_Target0.w = 1.0;
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
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	mediump vec4 _IconColor;
uniform 	mediump vec4 _IconOutlineColorA;
uniform 	mediump vec4 _IconOutlineColorB;
uniform 	mediump vec4 _IconDetailColor;
uniform 	mediump vec4 _BorderColorA;
uniform 	mediump vec4 _BorderColorB;
uniform 	mediump vec4 _BackgroundColorA;
uniform 	mediump vec4 _BackgroundColorB;
uniform 	mediump float _IconThreshold;
uniform 	mediump float _BorderThresholdA;
uniform 	mediump float _BorderThresholdB;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_14;
void main()
{
    u_xlat0.xyz = (-_BackgroundColorA.xyz) + _BackgroundColorB.xyz;
    u_xlat0.xyz = vs_TEXCOORD0.yyy * u_xlat0.xyz + _BackgroundColorA.xyz;
    u_xlat1.xyz = (-_IconOutlineColorA.xyz) + _IconOutlineColorB.xyz;
    u_xlat1.xyz = vs_TEXCOORD0.yyy * u_xlat1.xyz + _IconOutlineColorA.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_14 = (-u_xlat16_0.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz + u_xlat1.xyz;
    u_xlat16_14 = dFdx(u_xlat16_0.x);
    u_xlat16_3.x = dFdy(u_xlat16_0.x);
    u_xlat16_0 = (-u_xlat16_0.xyzz) + vec4(_IconThreshold, _IconThreshold, _BorderThresholdA, _BorderThresholdB);
    u_xlat16_14 = abs(u_xlat16_14) + abs(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_14);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = _IconColor.xyz + (-_IconDetailColor.xyz);
    u_xlat16_3.xyz = u_xlat16_0.yyy * u_xlat16_3.xyz + _IconDetailColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-u_xlat16_3.xyz);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorA.xyz);
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _BorderColorA.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_BorderColorB.xyz);
    SV_Target0.xyz = u_xlat16_0.www * u_xlat16_2.xyz + _BorderColorB.xyz;
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