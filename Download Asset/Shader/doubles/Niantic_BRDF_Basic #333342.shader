//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/Basic" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cSpec ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0,0,1,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 41588
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying highp vec2 vs_TEXCOORD0;
varying mediump float vs_TEXCOORD3;
varying mediump vec2 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat10_1 = texture2D(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.y = min(max(vs_TEXCOORD1.y, 0.0), 1.0);
#else
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.y = min(max(vs_TEXCOORD1.y, 0.0), 1.0);
#else
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump float vs_TEXCOORD3;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
mediump float u_xlat16_3;
float u_xlat5;
float u_xlat13;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    vs_TEXCOORD1.y = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD1.y = min(max(vs_TEXCOORD1.y, 0.0), 1.0);
#else
    vs_TEXCOORD1.y = clamp(vs_TEXCOORD1.y, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5 = (-_Amount_Wrap) + 1.0;
    u_xlat5 = u_xlat1.x * _Amount_Wrap + u_xlat5;
    u_xlat16_3 = u_xlat1.x * 0.5 + 0.5;
    vs_TEXCOORD3 = u_xlat16_3 * 0.899999976;
    vs_TEXCOORD1.x = u_xlat5;
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
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cSpec;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in highp vec2 vs_TEXCOORD0;
in mediump float vs_TEXCOORD3;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump float u_xlat16_17;
void main()
{
    u_xlat0 = _cSpec.w + _cSpec.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1.x = vs_TEXCOORD1.y;
    u_xlat16_1.y = vs_TEXCOORD3;
    u_xlat16_1 = texture(_Ramp2D, u_xlat16_1.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cSpec.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat16_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_17 = vs_TEXCOORD1.x * _Amount_Blend;
    SV_Target0.xyz = vec3(u_xlat16_17) * u_xlat16_2.xyz;
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