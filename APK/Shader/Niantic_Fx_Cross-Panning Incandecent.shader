//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Fx/Cross-Panning Incandecent" {
Properties {
_MainTex ("Texture 1", 2D) = "white" { }
_Tex2 ("Texture 2", 2D) = "white" { }
_DiffuseIntensity ("Diffuse Intensity", Float) = 0.5
_PanSpeeds ("Pan Speeds: (XY=Tex1, ZW=Tex2)", Vector) = (0,0,0,0)
_IncandecentColor ("Incandecent Color", Color) = (0,0,0,0)
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 13556
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Tex2;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture2D(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = vec3(u_xlat10_0) * _IncandecentColor.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_DiffuseIntensity);
    u_xlat10_2.xy = texture2D(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat10_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat10_2.yyyy * _SpecularColor + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Tex2;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture2D(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = vec3(u_xlat10_0) * _IncandecentColor.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_DiffuseIntensity);
    u_xlat10_2.xy = texture2D(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat10_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat10_2.yyyy * _SpecularColor + u_xlat16_0;
    SV_Target0 = u_xlat0;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Tex2;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_Texcoord1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture2D(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = vec3(u_xlat10_0) * _IncandecentColor.xyz;
    u_xlat10_1.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_DiffuseIntensity);
    u_xlat10_2.xy = texture2D(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat10_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat10_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat10_2.yyyy * _SpecularColor + u_xlat16_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Tex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_Texcoord1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = u_xlat16_0.xxx * _IncandecentColor.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_DiffuseIntensity);
    u_xlat16_2.xy = texture(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_2.yyyy * _SpecularColor + u_xlat16_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Tex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_Texcoord1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = u_xlat16_0.xxx * _IncandecentColor.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_DiffuseIntensity);
    u_xlat16_2.xy = texture(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_2.yyyy * _SpecularColor + u_xlat16_0;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _Tex2_ST;
uniform 	mediump vec4 _PanSpeeds;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_Texcoord1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = _PanSpeeds.xy * _Time.xx + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _Tex2_ST.xy + _Tex2_ST.zw;
    vs_Texcoord1.xy = _PanSpeeds.zw * _Time.xx + u_xlat0.xy;
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
uniform 	vec4 _IncandecentColor;
uniform 	vec4 _SpecularColor;
uniform 	float _DiffuseIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Tex2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_Texcoord1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_Tex2, vs_Texcoord1.xy).x;
    u_xlat0.xyz = u_xlat16_0.xxx * _IncandecentColor.xyz;
    u_xlat16_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat16_1.xyz * vec3(_DiffuseIntensity);
    u_xlat16_2.xy = texture(_Tex2, vs_TEXCOORD0.xy).yz;
    u_xlat16_3.xyz = u_xlat16_2.xxx * u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat16_0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat1.xyz;
    u_xlat16_0.w = 1.0;
    u_xlat0 = u_xlat16_2.yyyy * _SpecularColor + u_xlat16_0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}