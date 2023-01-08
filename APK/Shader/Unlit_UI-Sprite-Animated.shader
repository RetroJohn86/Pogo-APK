//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/UI-Sprite-Animated" {
Properties {
_MainTex ("Image Texture", 2D) = "white" { }
[Header(Base Properties)] [Spacing(10)] _Color ("Tint", Color) = (1,1,1,1)
[Header(Animation Properties)] [Spacing(10)] _ScaleMin ("Scale Min Size", Float) = 0.8
_ScaleMax ("Scale Max Size", Float) = 1.2
_ScaleSpeed ("Scale Speed", Float) = 1
_Rotation ("Rotation Range", Range(-180, 180)) = 0
_RotateSpeed ("Rotate Speed", Float) = 1
_BobSpeed ("Bob Speed", Float) = 1
_BobAmount ("Bob Amount (Y)", Float) = 0.5
_PivotOffset ("Pivot Position Offset", Vector) = (0,0,0,1)
_Delay ("Delay", Float) = 0
_ScaleUVAmount ("UV Scale Amount", Float) = 0
_PowerAmount ("Power Amount", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 48337
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
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
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	mediump vec4 _Color;
uniform 	vec4 _MainTex_ST;
uniform 	vec2 _PivotOffset;
uniform 	float _ScaleSpeed;
uniform 	float _Rotation;
uniform 	float _RotateSpeed;
uniform 	float _BobAmount;
uniform 	float _BobSpeed;
uniform 	mediump float _ScaleMin;
uniform 	mediump float _ScaleMax;
uniform 	mediump float _ScaleUVAmount;
uniform 	mediump float _Delay;
uniform 	mediump float _PowerAmount;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
vec2 u_xlat5;
float u_xlat8;
float u_xlat9;
float u_xlat13;
void main()
{
    u_xlat0.x = _Time.y * _ScaleSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat4 = (-_ScaleMin) + _ScaleMax;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + _ScaleMin;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0 = u_xlat0.xxxx * u_xlat1;
    u_xlat16_2 = _Delay * _PowerAmount;
    u_xlat1.x = u_xlat16_2 * _Time.y;
    u_xlat1.x = sin(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat5.xy = vec2(_BobAmount, _BobSpeed) * vec2(_PowerAmount);
    u_xlat13 = _Delay * _PowerAmount + _Time.y;
    u_xlat9 = u_xlat5.y * u_xlat13;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat1.x * u_xlat9;
    u_xlat4 = u_xlat5.x * u_xlat9 + u_xlat0.y;
    u_xlat3.xyz = vec3(u_xlat4) * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat3.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3].yyyy * hlslcc_mtx4x4unity_MatrixV[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[0] * hlslcc_mtx4x4unity_ObjectToWorld[3].xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixV[2] * hlslcc_mtx4x4unity_ObjectToWorld[3].zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_MatrixV[3];
    u_xlat0.w = 0.0;
    u_xlat0 = u_xlat0 + u_xlat2;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4glstate_matrix_projection[1];
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.x = u_xlat13 * _RotateSpeed;
    u_xlat4 = u_xlat13 * 1.57079637;
    u_xlat4 = sin(u_xlat4);
    u_xlat4 = log2(abs(u_xlat4));
    u_xlat4 = u_xlat4 * 3.5;
    u_xlat4 = exp2(u_xlat4);
    u_xlat4 = (-u_xlat4) + 1.0;
    u_xlat4 = u_xlat4 * _Rotation;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = (-u_xlat0.x) + 0.5;
    u_xlat0.x = u_xlat0.x + u_xlat0.x;
    u_xlat8 = u_xlat4 * 0.5;
    u_xlat0.x = abs(u_xlat0.x) * u_xlat4 + (-u_xlat8);
    u_xlat0.x = u_xlat1.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat3.x = (-u_xlat0.x);
    u_xlat3.y = u_xlat1.x;
    u_xlat3.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat1.x = dot(u_xlat3.yx, u_xlat0.xy);
    u_xlat1.y = dot(u_xlat3.zy, u_xlat0.xy);
    u_xlat0.xy = u_xlat1.xy + _PivotOffset.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
}
}
}
}