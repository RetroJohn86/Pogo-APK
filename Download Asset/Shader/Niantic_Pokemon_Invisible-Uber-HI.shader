//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/Invisible-Uber-HI" {
Properties {
[Header(Base Properties)] [Space] _Color ("Tint Color", Color) = (1,1,1,1)
_FaceTex ("Face Texture", 2D) = "clear" { }
_MainTex ("Body Texture", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_FxMaskTex ("FX Mask Texture", 2D) = "clear" { }
_FxMagnitude_A ("Light Magnitude_A", Range(0, 1)) = 1
_FxTint ("Light Tint", Color) = (1,1,1,1)
[Space] [Header(Fresnel)] [Space] _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
_FresnelPower ("Fresnel Power", Range(0.001, 4)) = 1
[Space] [Header(Invisibility)] [Space] _invisibility ("Invisibility Power", Range(0, 1)) = 1
_refraction ("Refraction", Range(0, 1)) = 1
_Size ("Blur Power", Range(0, 64)) = 2
[Space] [Header(Misc Properties)] [Space] _Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap", Range(0, 1)) = 0
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Specular (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(AO______________________________)] [Space] _vAmOc ("vAmbOcclusion", Color) = (0,0,0,1)
_vAmOcPower ("vAmbOcclusion Power", Range(0.1, 10)) = 1
_vAmTxPower ("vAmbTexture Power", Range(1, 10)) = 5
[Space] [Header(STENCIL_ID_SORTING___________________)] [Space] [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Header(ANIM_UV_A___________________________)] [Space] _uv0 ("_uv0_A", Vector) = (0,0,4,0)
_uv1 ("_uv1_A", Vector) = (0,0,4,2)
_uv2 ("_uv2_A", Vector) = (0,0,4,2)
[Header(ANIM_UV_B___________________________)] [Space] _uv0_B ("_uv0_B", Vector) = (0,0,4,0)
_uv1_B ("_uv1_B", Vector) = (0,0,4,2)
_uv2_B ("_uv2_B", Vector) = (0,0,4,2)
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
 GrabPass {
  "_BlurGrab"
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
  GpuProgramID 58424
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.yw = vs_TEXCOORD0.yy;
    u_xlat1 = _BlurGrab_TexelSize.xxxx * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.wxyz * _Color.wwww + vs_TEXCOORD0.xxxx;
    u_xlat0.xz = u_xlat1.yz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.x = u_xlat1.w;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab_TexelSize.x) * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x * _Size;
    u_xlat2.x = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.yw = vs_TEXCOORD0.yy;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab_TexelSize.x + _BlurGrab_TexelSize.x;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.z = u_xlat2.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.yw = vs_TEXCOORD0.yy;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab_TexelSize.x * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.z = u_xlat1.x * _Color.w + vs_TEXCOORD0.x;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
 GrabPass {
  "_BlurGrab1"
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
  GpuProgramID 81292
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab1;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab1;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
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
varying highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
uniform highp sampler2D _BlurGrab1;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture2D(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture2D(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab1;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab1;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
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
    u_xlat1.xyz = u_xlat0.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD0.zw = u_xlat0.zw;
    vs_TEXCOORD0.xy = u_xlat1.zz + u_xlat1.xy;
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
uniform 	vec4 _BlurGrab1_TexelSize;
uniform 	mediump float _Size;
uniform 	mediump vec4 _Color;
UNITY_LOCATION(0) uniform highp sampler2D _BlurGrab1;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
void main()
{
    u_xlat0.xz = vs_TEXCOORD0.xx;
    u_xlat1 = _BlurGrab1_TexelSize.yyyy * vec4(-4.0, -3.0, -2.0, 3.0);
    u_xlat1 = u_xlat1 * vec4(_Size);
    u_xlat1 = u_xlat1.xwyz * _Color.wwww + vs_TEXCOORD0.yyyy;
    u_xlat0.yw = u_xlat1.xz;
    u_xlat0 = u_xlat0 / vs_TEXCOORD0.wwww;
    u_xlat2 = texture(_BlurGrab1, u_xlat0.zw);
    u_xlat0 = texture(_BlurGrab1, u_xlat0.xy);
    u_xlat2 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036);
    u_xlat0 = u_xlat0 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat2;
    u_xlat2.y = u_xlat1.w;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat2.x = (-_BlurGrab1_TexelSize.y) * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.180000007, 0.180000007, 0.180000007, 0.180000007) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y * _Size;
    u_xlat2.y = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xz = vs_TEXCOORD0.xx;
    u_xlat2.xy = u_xlat2.xy / vs_TEXCOORD0.ww;
    u_xlat3 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat3 * vec4(0.150000006, 0.150000006, 0.150000006, 0.150000006) + u_xlat0;
    u_xlat2.x = _BlurGrab1_TexelSize.y + _BlurGrab1_TexelSize.y;
    u_xlat2.x = u_xlat2.x * _Size;
    u_xlat2.w = u_xlat2.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat2.xy = u_xlat2.zw / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat2.xy);
    u_xlat0 = u_xlat2 * vec4(0.119999997, 0.119999997, 0.119999997, 0.119999997) + u_xlat0;
    u_xlat1.xz = vs_TEXCOORD0.xx;
    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
    u_xlat2 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat2 * vec4(0.0900000036, 0.0900000036, 0.0900000036, 0.0900000036) + u_xlat0;
    u_xlat1.x = _BlurGrab1_TexelSize.y * 4.0;
    u_xlat1.x = u_xlat1.x * _Size;
    u_xlat1.w = u_xlat1.x * _Color.w + vs_TEXCOORD0.y;
    u_xlat1.xy = u_xlat1.zw / vs_TEXCOORD0.ww;
    u_xlat1 = texture(_BlurGrab1, u_xlat1.xy);
    u_xlat0 = u_xlat1 * vec4(0.0500000007, 0.0500000007, 0.0500000007, 0.0500000007) + u_xlat0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
 GrabPass {
  "_BlurGrab2"
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Geometry+500" "RenderType" = "Opaque" }
  GpuProgramID 151451
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform highp sampler2D _BlurGrab2;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0.xyz = texture2D(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_23 = (-u_xlat10_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat10_3 = texture2D(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat10_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat10_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture2D(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform highp sampler2D _BlurGrab2;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0.xyz = texture2D(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_23 = (-u_xlat10_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat10_3 = texture2D(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat10_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat10_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture2D(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec4 in_COLOR0;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp2D;
uniform lowp sampler2D _FxMaskTex;
uniform lowp sampler2D _FaceTex;
uniform highp sampler2D _BlurGrab2;
varying mediump vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec2 vs_TEXCOORD2;
varying mediump vec2 vs_TEXCOORD3;
varying mediump vec3 vs_COLOR0;
varying mediump vec4 vs_COLOR1;
varying highp vec3 vs_TEXCOORD4;
varying highp vec3 vs_TEXCOORD5;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat10_0.xyz = texture2D(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_0.xyz + (-u_xlat10_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_23 = (-u_xlat10_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat10_1 = texture2D(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat10_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat10_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat10_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat10_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat10_3 = texture2D(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat10_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat10_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture2D(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform highp sampler2D _BlurGrab2;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_23 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat16_3 = texture(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat16_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat16_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform highp sampler2D _BlurGrab2;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_23 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat16_3 = texture(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat16_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat16_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	mediump float _Amount_Wrap;
uniform 	mediump vec4 _uv0;
uniform 	mediump vec4 _uv1;
uniform 	mediump vec4 _uv2;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
bvec4 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat6;
float u_xlat11;
vec2 u_xlat12;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    u_xlat2.xy = (-_uv0.xy) + _uv1.xy;
    u_xlatb3 = greaterThanEqual(vec4(2.0, 3.0, 1.0, 1.00001001), in_TEXCOORD0.yyyx);
    u_xlat2.xy = (u_xlatb3.x) ? vec2(0.0, 0.0) : u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy + _uv0.xy;
    u_xlat12.xy = (-u_xlat2.xy) + _uv2.xy;
    u_xlat12.xy = (u_xlatb3.y) ? vec2(0.0, 0.0) : u_xlat12.xy;
    u_xlat3.x = (u_xlatb3.w) ? float(0.0) : float(1.0);
    u_xlat3.y = (u_xlatb3.z) ? float(0.0) : float(1.0);
    u_xlat2.xy = u_xlat12.xy + u_xlat2.xy;
    vs_TEXCOORD0.xy = u_xlat2.xy * u_xlat3.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.zw = u_xlat3.xy;
    u_xlat2.xyz = u_xlat1.xyw * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = u_xlat2.zz + u_xlat2.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    vs_TEXCOORD2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD2.x = min(max(vs_TEXCOORD2.x, 0.0), 1.0);
#else
    vs_TEXCOORD2.x = clamp(vs_TEXCOORD2.x, 0.0, 1.0);
#endif
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_4 = u_xlat1.x * 0.5 + 0.5;
    u_xlat6 = u_xlat16_4 * 0.949999988;
    vs_TEXCOORD2.y = u_xlat6;
    u_xlat6 = (-_Amount_Wrap) + 1.0;
    u_xlat1.x = u_xlat1.x * _Amount_Wrap + u_xlat6;
    vs_TEXCOORD3.x = u_xlat1.x;
    vs_TEXCOORD3.y = in_COLOR0.w;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[1].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[1].xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[1].zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[1].wwww + u_xlat1;
    u_xlat1 = u_xlat1 * in_NORMAL0.yyyy;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[0].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[0].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[0].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.xxxx + u_xlat1;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[2].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[2].zzzz + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[3] * hlslcc_mtx4x4unity_ObjectToWorld[2].wwww + u_xlat2;
    u_xlat1 = u_xlat2 * in_NORMAL0.zzzz + u_xlat1;
    u_xlat11 = dot(u_xlat1, u_xlat1);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat1.xy = vec2(u_xlat11) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_COLOR0.xy = u_xlat1.xy;
    vs_COLOR0.z = in_COLOR0.z;
    u_xlat5 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixVP[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[0].z * u_xlat0.x + u_xlat5;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixVP[3].z * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
    vs_COLOR1.w = exp2(u_xlat0.x);
    vs_COLOR1.xyz = unity_FogColor.xyz;
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
uniform 	vec4 _BlurGrab2_TexelSize;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _FresnelColor;
uniform 	mediump float _FresnelPower;
uniform 	mediump float _refraction;
uniform 	mediump float _invisibility;
uniform 	mediump float _Amount_Blend;
uniform 	mediump float _Amount_RimLt;
uniform 	mediump vec4 _cDiff;
uniform 	mediump vec4 _cAmbn;
uniform 	mediump vec4 _cKeyf;
uniform 	mediump vec4 _cRimt;
uniform 	mediump vec4 _cRimb;
uniform 	mediump float _FxMagnitude_A;
uniform 	mediump vec3 _FxTint;
uniform 	mediump vec4 _vAmOc;
uniform 	mediump float _vAmOcPower;
uniform 	mediump float _vAmTxPower;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Ramp2D;
UNITY_LOCATION(2) uniform mediump sampler2D _FxMaskTex;
UNITY_LOCATION(3) uniform mediump sampler2D _FaceTex;
UNITY_LOCATION(4) uniform highp sampler2D _BlurGrab2;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
vec3 u_xlat8;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat16_0.xyz = texture(_FaceTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-u_xlat16_1.xyz);
    u_xlat16_2.xyz = vs_TEXCOORD0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_23 = (-u_xlat16_1.w) + 1.0;
    u_xlat16_23 = u_xlat16_23 * _invisibility;
    u_xlat16_3.xyz = u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_vAmTxPower, _vAmTxPower, _vAmTxPower));
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_24 = dot(u_xlat16_2.xyz, vec3(0.298911989, 0.586610973, 0.114478));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_24) + 1.0;
    u_xlat16_4.x = log2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_4.x = exp2(u_xlat16_4.x);
    u_xlat16_4.x = u_xlat16_4.x * _vAmTxPower;
    u_xlat16_3.xyz = u_xlat16_4.xxx * vec3(0.5, 0.5, 0.5) + u_xlat16_3.xyz;
    u_xlat16_3.xyz = max(u_xlat16_3.xyz, vec3(0.100000001, 0.100000001, 0.100000001));
    u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(0.899999976, 0.899999976, 0.899999976));
    u_xlat16_4.xyz = vec3(u_xlat16_24) + (-_vAmOc.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_24) * u_xlat16_4.xyz + _vAmOc.xyz;
    u_xlat16_5.xyz = u_xlat16_2.xyz * _vAmOc.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_4.xyz + (-u_xlat16_5.xyz);
    u_xlat16_3.xyz = _vAmOc.www * u_xlat16_3.xyz + u_xlat16_5.xyz;
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat16_3.xyz;
    u_xlat16_3.x = _cKeyf.w + _cKeyf.w;
    u_xlat16_10.x = _cRimt.w + _cRimt.w;
    u_xlat16_4.xyz = _cRimt.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimt.xyz;
    u_xlat16_1 = texture(_Ramp2D, vs_TEXCOORD2.xy);
    u_xlat16_4.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_10.xyz = u_xlat16_10.xxx * u_xlat16_4.xyz;
    u_xlat16_4.xyz = _cKeyf.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cKeyf.xyz;
    u_xlat16_4.xyz = u_xlat16_1.zzz * u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat16_3.xxx + u_xlat16_10.xyz;
    u_xlat16_4.xyz = _cRimb.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_4.xyz * _cRimb.xyz;
    u_xlat16_4.xyz = u_xlat16_1.www * u_xlat16_4.xyz;
    u_xlat16_24 = _cRimb.w + _cRimb.w;
    u_xlat16_5.xyz = _cDiff.xyz + (-_cAmbn.xyz);
    u_xlat16_5.xyz = u_xlat16_1.yyy * u_xlat16_5.xyz + _cAmbn.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Amount_RimLt) + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_2.x = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
    u_xlat8.xy = u_xlat16_2.xx * vs_TEXCOORD5.xy;
    u_xlat6.xy = u_xlat8.xy * vec2(vec2(_refraction, _refraction));
    u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(vec3(_Amount_Blend, _Amount_Blend, _Amount_Blend));
    u_xlat16_3.xyz = u_xlat16_2.xyz * vs_TEXCOORD3.xxx + (-u_xlat16_0.xyz);
    u_xlat16_2.x = log2(vs_TEXCOORD3.y);
    u_xlat16_2.x = u_xlat16_2.x * _vAmOcPower;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_0.w = 1.0;
    u_xlat16_3.w = 0.0;
    u_xlat16_0 = u_xlat16_2.xxxx * u_xlat16_3 + u_xlat16_0;
    u_xlat16_3 = texture(_FxMaskTex, vs_COLOR0.xy);
    u_xlat16_3 = u_xlat16_3 * vec4(_FxMagnitude_A);
    u_xlat8.xyz = u_xlat16_3.xyz * vec3(3.0, 3.0, 3.0);
    u_xlat3.w = u_xlat16_3.w * 3.0;
    u_xlat3.xyz = u_xlat8.xyz * vec3(_FxTint.x, _FxTint.y, _FxTint.z);
    u_xlat1 = u_xlat16_1.xxxx * u_xlat3;
    u_xlat1 = u_xlat16_2.xxxx * u_xlat1;
    u_xlat0 = u_xlat1 * vs_TEXCOORD3.yyyy + u_xlat16_0;
    u_xlat1.xy = _BlurGrab2_TexelSize.xy * vs_TEXCOORD1.zz + vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD1.w;
    u_xlat6.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat6.xyz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1 = texture(_BlurGrab2, u_xlat1.xy);
    u_xlat16_1 = (-u_xlat0) + u_xlat1;
    u_xlat16_0 = vec4(u_xlat16_23) * u_xlat16_1 + u_xlat0;
    u_xlat6.x = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD4.xyz);
    u_xlat16_2.x = (-u_xlat6.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelPower;
    u_xlat16_1.w = exp2(u_xlat16_2.x);
    u_xlat16_1.xyz = _FresnelColor.www;
    u_xlat16_2 = u_xlat16_1.wwwz * _FresnelColor;
    u_xlat16_0 = u_xlat16_2 * u_xlat16_1 + u_xlat16_0;
    u_xlat16_2.xyz = u_xlat16_0.xyz + (-vs_COLOR1.xyz);
    u_xlat16_0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + vs_COLOR1.xyz;
    SV_Target0 = u_xlat16_0 * _Color;
    return;
}

#endif
"
}
}
}
}
}