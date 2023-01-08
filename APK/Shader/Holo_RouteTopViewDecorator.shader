//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/RouteTopViewDecorator" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_LargeOuterCol ("Large Circle Outer Color", Color) = (0.38,0.47,0.518,1)
_SmallInnerCol ("Small Circle Inner Color", Color) = (0.38,0.47,0.518,1)
_SmallOuterCol ("Small Circle Outer Color", Color) = (0.22,0.7,0.611,1)
_ShowSmallCircle ("Show Small Circle", Float) = 1
_SmallCircleRadius ("Small Circle Scale", Float) = 0.15
_SmallCircleOutline ("Small Circle Outline", Float) = 0.04
_SmallCircleXOffset ("Small X Offset", Float) = 0.2
_SmallCircleYOffset ("Small Y Offset", Float) = 0.8
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  GpuProgramID 42423
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
    u_xlatb3 = u_xlat16_0.x<0.0;
    if(u_xlatb3){discard;}
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
    u_xlatb3 = u_xlat16_0.x<0.0;
    if(u_xlatb3){discard;}
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
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat10_1.xyz = texture2D(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
    u_xlatb3 = u_xlat16_0.x<0.0;
    if(u_xlatb3){discard;}
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb3 = u_xlat16_0.x<0.0;
#endif
    if(u_xlatb3){discard;}
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb3 = u_xlat16_0.x<0.0;
#endif
    if(u_xlatb3){discard;}
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _LargeOuterCol;
uniform 	mediump vec4 _SmallInnerCol;
uniform 	mediump vec4 _SmallOuterCol;
uniform 	float _ShowSmallCircle;
uniform 	mediump float _SmallCircleRadius;
uniform 	mediump float _SmallCircleOutline;
uniform 	mediump float _SmallCircleXOffset;
uniform 	mediump float _SmallCircleYOffset;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
float u_xlat3;
bool u_xlatb3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat16_0.w = _SmallCircleOutline + _SmallCircleRadius;
    u_xlat16_0.x = float(0.375);
    u_xlat16_0.y = float(0.425000012);
    u_xlat16_0.z = _SmallCircleRadius;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0 + vec4(-0.00999999978, -0.00999999978, -0.00499999989, -0.00499999989);
    u_xlat1.xy = vs_TEXCOORD0.xy + (-vec2(_SmallCircleXOffset, _SmallCircleYOffset));
    u_xlat16_2.y = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(1.33333337, 1.33333337) + vec2(0.5, 0.5);
    u_xlat1.xy = (-u_xlat1.xy);
    u_xlat16_1.xyz = texture(_MainTex, u_xlat1.xy).xyz;
    u_xlat16_0 = (-u_xlat16_0) + u_xlat16_2.xxyy;
    u_xlat16_0 = u_xlat16_0 * vec4(49.9999733, 49.9999733, 100.0, 100.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0.xz = u_xlat16_0.xz * u_xlat16_2.xz;
    u_xlat16_4.xz = (-u_xlat16_2.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _LargeOuterCol.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat16_2.xyz = (-_SmallInnerCol.xyz) + _SmallOuterCol.xyz;
    u_xlat16_2.xyz = u_xlat16_0.zzz * u_xlat16_2.xyz + _SmallInnerCol.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + u_xlat16_2.xyz;
    u_xlat16_1.w = u_xlat16_4.x;
    u_xlat16_2.w = u_xlat16_4.z * _ShowSmallCircle + (-u_xlat16_1.w);
    u_xlat3 = u_xlat16_4.z * _ShowSmallCircle;
    u_xlat16_0 = vec4(u_xlat3) * u_xlat16_2 + u_xlat16_1;
    u_xlat16_0.w = max(u_xlat16_0.w, u_xlat3);
    SV_Target0 = u_xlat16_0;
    u_xlat16_0.x = u_xlat16_0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat16_0.x<0.0);
#else
    u_xlatb3 = u_xlat16_0.x<0.0;
#endif
    if(u_xlatb3){discard;}
    return;
}

#endif
"
}
}
}
}
}