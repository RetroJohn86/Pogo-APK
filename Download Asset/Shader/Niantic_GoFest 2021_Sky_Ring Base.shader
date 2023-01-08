//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/GoFest 2021/Sky/Ring Base" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom (.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_GlowColor ("Glow Color", Color) = (1,1,1,1)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
_vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  GpuProgramID 26912
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
attribute mediump vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying highp vec3 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec3 u_xlat10_0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat10_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_1.zzz * _cKeyf.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat0) + u_xlat5.xyz;
    u_xlat16_3.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_3.xyz = u_xlat10_1.yyy * u_xlat16_3.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * _cRimb.xyz;
    u_xlat0 = _cRimb.w + _cRimb.w;
    u_xlat16_3.xyz = u_xlat16_4.xyz * vec3(u_xlat0) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_RimLt, _Amount_RimLt, _Amount_RimLt)) + u_xlat16_3.xyz;
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" "DIRECTIONAL" "LIGHTPROBE_SH" }
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
uniform 	mediump vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Amount_Wrap;
in mediump vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
mediump float u_xlat16_5;
float u_xlat9;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    vs_TEXCOORD0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD2 = in_TEXCOORD0;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_5 = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat0.x = (-u_xlat16_2) + 1.0;
    vs_TEXCOORD3.x = u_xlat16_2;
    vs_TEXCOORD3.w = u_xlat0.x;
    u_xlat16_2 = u_xlat16_5 * 0.5 + 0.5;
    u_xlat0.x = u_xlat16_2 * 0.949999988;
    vs_TEXCOORD3.y = u_xlat0.x;
    u_xlat0.x = (-_Amount_Wrap) + 1.0;
    u_xlat0.x = u_xlat16_5 * _Amount_Wrap + u_xlat0.x;
    vs_TEXCOORD3.z = u_xlat0.x;
    vs_TEXCOORD4 = in_COLOR0;
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
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump vec4 _GlowColor;
uniform 	mediump vec4 _vAmOc;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
void main()
{
    u_xlat0 = _cKeyf.w + _cKeyf.w;
    u_xlat5.x = _cRimt.w + _cRimt.w;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = u_xlat16_1.xxx * _cRimt.xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_1.zzz * _cKeyf.xyz;
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
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.zzz;
    u_xlat16_3.xyz = (-_vAmOc.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vs_TEXCOORD4.www * u_xlat16_3.xyz + _vAmOc.xyz;
    u_xlat16_4.xyz = vs_TEXCOORD4.xxx * _GlowColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_TEXCOORD4.yyy;
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