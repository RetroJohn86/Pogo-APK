//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/FX/FireCore - Horizontally Stepped" {
Properties {
_MainTex ("Combo (R=A1 G=A2)", 2D) = "black" { }
_FPS ("FPS", Float) = 15
_Step ("Step", Float) = 0
_Offset ("Depth Offset", Float) = 0
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 8
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Blend One Zero, One One
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 35660
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat0;
    u_xlatb0 = u_xlat2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat0;
    u_xlatb0 = u_xlat2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat10_0 * u_xlat10_1 + -0.5;
    u_xlat0 = u_xlat10_1 * u_xlat10_0;
    SV_Target0.w = u_xlat0;
    u_xlatb0 = u_xlat2<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat16_0 * u_xlat16_1 + -0.5;
    u_xlat0 = u_xlat16_1 * u_xlat16_0;
    SV_Target0.w = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat16_0 * u_xlat16_1 + -0.5;
    u_xlat0 = u_xlat16_1 * u_xlat16_0;
    SV_Target0.w = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Step;
uniform 	mediump float _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat6;
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
    u_xlat0.zw = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.x = u_xlat0.w + -1.0;
    u_xlat1.x = ceil(u_xlat1.x);
    u_xlat6 = u_xlat0.w + u_xlat1.x;
    u_xlat6 = max(u_xlat6, 0.0500000007);
    u_xlat0.y = min(u_xlat6, 0.949999988);
    u_xlat6 = _Time.y * _FPS;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = u_xlat6 * _Step;
    u_xlat6 = fract(u_xlat6);
    u_xlat0.x = u_xlat6 + u_xlat0.z;
    vs_TEXCOORD0 = u_xlat0.xyzy;
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
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.zw).y;
    u_xlat2 = u_xlat16_0 * u_xlat16_1 + -0.5;
    u_xlat0 = u_xlat16_1 * u_xlat16_0;
    SV_Target0.w = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2<0.0);
#else
    u_xlatb0 = u_xlat2<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vec3(1.0, 0.5, 0.0);
    return;
}

#endif
"
}
}
}
}
}