//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/DissolvePanning" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DissolveAmount ("Dissolve Amount", Range(-0.1, 1)) = 0
_Color ("Color", Color) = (0,0,0,0)
_RimColor ("Rim Color", Color) = (0,0,0,0)
_RimWidth ("Rim Width", Float) = 0
_RimPower ("Rim Power", Float) = 0
_WaveSpeed ("Wave Speed", Float) = 0
_WaveWidth ("Wave Width", Float) = 0
_HexColor ("Hex Color", Color) = (0,0,0,0)
_HexBrightnessStart ("Hex Brightness Start", Float) = 0
_HexBrightnessEnd ("Hex Brightness End", Float) = 0
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_OutlineWaveWidth ("Outline Wave Width", Float) = 0
_OutlineSpeed ("Outline Speed", Float) = 0
_NormalTex ("Normal Texture", 2D) = "white" { }
_LightVector ("Light Vector", Vector) = (0,0,0,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 44413
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat10_0.x) + _DissolveAmount;
    u_xlatb10 = u_xlat10<0.0;
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat10_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0 = u_xlat10 * u_xlat10_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat10_2.xyz = texture2D(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat10_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat10_0.x) + _DissolveAmount;
    u_xlatb10 = u_xlat10<0.0;
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat10_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0 = u_xlat10 * u_xlat10_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat10_2.xyz = texture2D(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat10_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
uniform lowp sampler2D _NormalTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
varying highp vec3 vs_TEXCOORD3;
varying highp vec3 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat10_0.xy = texture2D(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat10_0.x) + _DissolveAmount;
    u_xlatb10 = u_xlat10<0.0;
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat10_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0 = u_xlat10 * u_xlat10_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat10_2.xyz = texture2D(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat10_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
UNITY_LOCATION(0) uniform mediump sampler2D _NormalTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat16_0.x) + _DissolveAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat16_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat10 * u_xlat16_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat16_2.xyz = texture(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat16_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
UNITY_LOCATION(0) uniform mediump sampler2D _NormalTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat16_0.x) + _DissolveAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat16_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat10 * u_xlat16_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat16_2.xyz = texture(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat16_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xyz = in_POSITION0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.x = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_TANGENT0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx;
    vs_TEXCOORD3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat2.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
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
uniform 	vec4 _Time;
uniform 	float _DissolveAmount;
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _RimColor;
uniform 	float _RimWidth;
uniform 	float _RimPower;
uniform 	float _WaveSpeed;
uniform 	float _WaveWidth;
uniform 	mediump vec4 _HexColor;
uniform 	float _HexBrightnessStart;
uniform 	float _HexBrightnessEnd;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWaveWidth;
uniform 	float _OutlineSpeed;
uniform 	mediump vec4 _LightVector;
UNITY_LOCATION(0) uniform mediump sampler2D _NormalTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat10;
bool u_xlatb10;
void main()
{
    u_xlat16_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xw;
    u_xlat10 = (-u_xlat16_0.x) + _DissolveAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat10<0.0);
#else
    u_xlatb10 = u_xlat10<0.0;
#endif
    if(u_xlatb10){discard;}
    u_xlat10 = _Time.x * _WaveSpeed + (-u_xlat16_0.x);
    u_xlat10 = fract(u_xlat10);
    u_xlat10 = u_xlat10 * 2.0 + -1.0;
    u_xlat10 = abs(u_xlat10) + _WaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat10 * u_xlat16_0.x;
    u_xlat16_1 = vec4(u_xlat0) * _HexColor;
    u_xlat0 = (-_HexBrightnessStart) + _HexBrightnessEnd;
    u_xlat10 = min(abs(vs_TEXCOORD1.y), 1.0);
    u_xlat0 = u_xlat10 * u_xlat0 + _HexBrightnessStart;
    u_xlat10 = log2(u_xlat10);
    u_xlat10 = u_xlat10 * _RimWidth;
    u_xlat10 = exp2(u_xlat10);
    u_xlat1 = vec4(u_xlat0) * u_xlat16_1;
    u_xlat16_2.xyz = texture(_NormalTex, vs_TEXCOORD0.xy).xyz;
    u_xlat2.xyz = u_xlat16_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat3.xyz = u_xlat2.yyy * vs_TEXCOORD3.xyz;
    u_xlat2.xyw = vs_TEXCOORD2.xyz * u_xlat2.xxx + u_xlat3.xyz;
    u_xlat2.xyz = vs_TEXCOORD4.xyz * u_xlat2.zzz + u_xlat2.xyw;
    u_xlat16_4 = dot(u_xlat2.xyz, _LightVector.xyz);
    u_xlat16_4 = min(abs(u_xlat16_4), 1.0);
    u_xlat16_4 = u_xlat16_4 * _LightVector.w;
    u_xlat2 = log2(_RimColor);
    u_xlat2 = u_xlat2 * vec4(vec4(_RimPower, _RimPower, _RimPower, _RimPower));
    u_xlat2 = exp2(u_xlat2);
    u_xlat3 = (-u_xlat2) + _Color;
    u_xlat2 = vec4(u_xlat10) * u_xlat3 + u_xlat2;
    u_xlat16_1 = vec4(u_xlat16_4) * u_xlat1 + u_xlat2;
    u_xlat0 = _Time.x * _OutlineSpeed + (-vs_TEXCOORD1.y);
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * 2.0 + -1.0;
    u_xlat0 = abs(u_xlat0) + _OutlineWaveWidth;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat0 = u_xlat0 * u_xlat16_0.y;
    SV_Target0 = vec4(u_xlat0) * _OutlineColor + u_xlat16_1;
    return;
}

#endif
"
}
}
}
}
}