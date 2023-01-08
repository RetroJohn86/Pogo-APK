//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Sky/Aurora_MultiPlanar" {
Properties {
_TopColor ("Top Color", Color) = (1,1,1,1)
_BottomColor ("Bottom Color", Color) = (0,0,0,1)
_CloudTex1 ("Cloud Texture 1", 2D) = "white" { }
_DistortionTex ("Distortion Texture", 2D) = "white" { }
_DistortionStrength ("Distortion Strength", Range(0, 1)) = 0.25
_DistortionSpeed ("Distortion Speed", Range(0, 1)) = 0.15
_FlareTex ("Flare Noise Texture", 2D) = "white" { }
_FlareStrength ("Flare Strength", Range(0, 20)) = 1
_PanningSpeed ("Flare Speed", Range(0, 20)) = 0.075
_EdgeFadeDist ("Edge Fade Distance", Range(0, 0.5)) = 0.1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ZWrite Off
  GpuProgramID 28429
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _CloudTex1;
uniform lowp sampler2D _FlareTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat10_5.x = texture2D(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD3.xy;
    u_xlat10_5.y = texture2D(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD4.xy;
    u_xlat10_5.x = texture2D(_FlareTex, u_xlat5.xz).x;
    u_xlat10_0 = texture2D(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat10_0.ww * u_xlat10_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _CloudTex1;
uniform lowp sampler2D _FlareTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat10_5.x = texture2D(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD3.xy;
    u_xlat10_5.y = texture2D(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD4.xy;
    u_xlat10_5.x = texture2D(_FlareTex, u_xlat5.xz).x;
    u_xlat10_0 = texture2D(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat10_0.ww * u_xlat10_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _CloudTex1;
uniform lowp sampler2D _FlareTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat10_5.x = texture2D(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD3.xy;
    u_xlat10_5.y = texture2D(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat10_5.xx + vs_TEXCOORD4.xy;
    u_xlat10_5.x = texture2D(_FlareTex, u_xlat5.xz).x;
    u_xlat10_0 = texture2D(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat10_0.ww * u_xlat10_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat10_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex1;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat16_5.x = texture(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD3.xy;
    u_xlat16_5.y = texture(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD4.xy;
    u_xlat16_5.x = texture(_FlareTex, u_xlat5.xz).x;
    u_xlat16_0 = texture(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat16_0.ww * u_xlat16_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex1;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat16_5.x = texture(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD3.xy;
    u_xlat16_5.y = texture(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD4.xy;
    u_xlat16_5.x = texture(_FlareTex, u_xlat5.xz).x;
    u_xlat16_0 = texture(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat16_0.ww * u_xlat16_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CloudTex1_ST;
uniform 	mediump vec4 _DistortionTex_ST;
uniform 	mediump vec4 _FlareTex_ST;
uniform 	mediump float _PanningSpeed;
uniform 	mediump float _DistortionSpeed;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
void main()
{
    u_xlat16_0.xy = in_TEXCOORD0.xy * _CloudTex1_ST.xy + _CloudTex1_ST.zw;
    vs_TEXCOORD0.xy = u_xlat16_0.xy;
    vs_TEXCOORD1.xy = in_POSITION0.zy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
    vs_TEXCOORD2.xy = _Time.xx * vec2(vec2(_DistortionSpeed, _DistortionSpeed)) + u_xlat16_0.xy;
    u_xlat16_0.xy = in_TEXCOORD0.xy * _FlareTex_ST.xy + _FlareTex_ST.zw;
    vs_TEXCOORD3.xy = _Time.xx * vec2(_PanningSpeed) + u_xlat16_0.xy;
    vs_TEXCOORD4.xy = _Time.xx * vec2(_PanningSpeed) + (-u_xlat16_0.xy);
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
uniform 	mediump vec4 _TopColor;
uniform 	mediump vec4 _BottomColor;
uniform 	mediump float _DistortionStrength;
uniform 	mediump float _FlareStrength;
uniform 	mediump float _EdgeFadeDist;
UNITY_LOCATION(0) uniform mediump sampler2D _DistortionTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex1;
UNITY_LOCATION(2) uniform mediump sampler2D _FlareTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
mediump float u_xlat16_7;
vec2 u_xlat9;
void main()
{
    u_xlat16_0.x = (-_EdgeFadeDist) + 1.0;
    u_xlat1 = (-u_xlat16_0.x) + 1.0;
    u_xlat5.x = (-u_xlat16_0.x) + vs_TEXCOORD0.y;
    u_xlat1 = float(1.0) / u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1 = min(max(u_xlat1, 0.0), 1.0);
#else
    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
#endif
    u_xlat5.x = u_xlat1 * -2.0 + 3.0;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat1 = (-u_xlat5.x) * u_xlat1 + 1.0;
    u_xlat5.x = float(1.0) / _EdgeFadeDist;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD0.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat9.x = u_xlat5.x * -2.0 + 3.0;
    u_xlat5.x = u_xlat5.x * u_xlat5.x;
    u_xlat5.x = u_xlat5.x * u_xlat9.x;
    u_xlat1 = u_xlat1 * u_xlat5.x;
    u_xlat16_5.x = texture(_DistortionTex, vs_TEXCOORD2.xy).x;
    u_xlat9.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD3.xy;
    u_xlat16_5.y = texture(_FlareTex, u_xlat9.xy).x;
    u_xlat2.xy = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD0.xy;
    u_xlat5.xz = vec2(vec2(_DistortionStrength, _DistortionStrength)) * u_xlat16_5.xx + vs_TEXCOORD4.xy;
    u_xlat16_5.x = texture(_FlareTex, u_xlat5.xz).x;
    u_xlat16_0 = texture(_CloudTex1, u_xlat2.xy);
    u_xlat5.xy = u_xlat16_0.ww * u_xlat16_5.xy;
    u_xlat16_3 = u_xlat5.x * u_xlat5.y;
    u_xlat16_3 = u_xlat16_3 * _FlareStrength;
    u_xlat2 = _TopColor + (-_BottomColor);
    u_xlat2 = vs_TEXCOORD1.yyyy * u_xlat2 + _BottomColor;
    u_xlat16_0 = u_xlat16_0 * u_xlat2;
    u_xlat16_7 = (-vs_TEXCOORD1.y) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_7);
    u_xlat16_3 = u_xlat16_3 * vs_TEXCOORD1.y + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat1 * u_xlat16_3;
    return;
}

#endif
"
}
}
}
}
}