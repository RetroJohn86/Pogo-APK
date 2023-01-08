//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/FX/Stencil/FireStencilCR" {
Properties {
_Color1 ("Color1", Color) = (1,1,0,0.5)
_Color2 ("Color2", Color) = (1,0.28235295,0,0)
_MainTex ("Combo (R=A1,G=A2,B=Mask)", 2D) = "black" { }
_TilingRG ("Tiling for R(.xy) and G(.zw) channels", Vector) = (1,1,1,1)
_VMask ("VAlpha mask", Range(0, 1)) = 1
_VMaskBlend ("Mask color by VAlpha", Range(0, 1)) = 0
_TMaskBlend ("Mask color by B channel", Range(0, 1)) = 1
_Vspeed ("Vspeed ", Range(0, 10)) = 1
_Vmultiply ("Vmultiply", Range(0, 10)) = 1.5
_RimPower ("Rim Power", Range(0.01, 10)) = 1
_RimIntensity ("Rim Intensity", Range(0, 5)) = 0.5
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 3
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+2" "RenderType" = "Opaque" }
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 36423
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
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
uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
uniform lowp sampler2D _MainTex;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat10_3 = texture2D(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat10_3 + u_xlat10_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat10_9 = texture2D(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat10_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BRB_CHAR_FX" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _TilingRG;
uniform 	float _Vspeed;
uniform 	float _Vmultiply;
uniform 	float _RimPower;
uniform 	float _RimIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_3 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
#else
    u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat0.x = log2(u_xlat16_3);
    u_xlat0.x = u_xlat0.x * _RimPower;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RimIntensity;
    vs_TEXCOORD0.z = u_xlat0.x;
    vs_TEXCOORD0.y = min(in_TEXCOORD0.y, 0.949999988);
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    u_xlat0.xy = _Time.yy * _TilingRG.yw;
    u_xlat0.xy = u_xlat0.xy * vec2(_Vspeed);
    u_xlat1 = in_TEXCOORD0.xyxy * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat2.y = u_xlat1.y * _TilingRG.y + (-u_xlat0.x);
    u_xlat2.xzw = u_xlat1.xzw * _TilingRG.xzw;
    u_xlat2.w = (-u_xlat0.y) * _Vmultiply + u_xlat2.w;
    vs_TEXCOORD1 = u_xlat2;
    vs_TEXCOORD2 = in_COLOR0;
    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	mediump vec4 _Color1;
uniform 	mediump vec4 _Color2;
uniform 	float _VMask;
uniform 	float _VMaskBlend;
uniform 	float _TMaskBlend;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = texture(_MainTex, vs_TEXCOORD1.zw).y;
    u_xlat0.x = u_xlat16_3 + u_xlat16_0;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat16_1.x = (-_Color1.w) * u_xlat0.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _Color1.xyz;
    u_xlat0.xyz = (-_Color1.xyz) + _Color2.xyz;
    u_xlat2.xyz = vec3(vec3(_TMaskBlend, _TMaskBlend, _TMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat0.xyz = vec3(vec3(_VMaskBlend, _VMaskBlend, _VMaskBlend)) * u_xlat0.xyz + _Color1.xyz;
    u_xlat2.xyz = (-u_xlat16_1.xyz) + u_xlat2.xyz;
    u_xlat16_9 = texture(_MainTex, vs_TEXCOORD0.xy).z;
    u_xlat16_10 = u_xlat16_9 * _Color2.w;
    u_xlat2.xyz = vec3(u_xlat16_10) * u_xlat2.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
    u_xlat9 = vs_TEXCOORD2.w + -1.0;
    u_xlat9 = _VMask * u_xlat9 + 1.0;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD0.zzz + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
CustomEditor "CustomMaterialInspector"
}