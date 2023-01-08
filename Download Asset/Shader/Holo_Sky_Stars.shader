//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Sky/Stars" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Dim ("Dimness", Range(0, 1)) = 0.1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Transparent" }
  Blend One One, One One
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 27147
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
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
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	vec4 _Time;
uniform 	float _Dim;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
bvec3 u_xlatb1;
vec3 u_xlat2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_7;
mediump float u_xlat16_11;
float u_xlat12;
void main()
{
    u_xlat0.xyz = vs_COLOR0.wzx * vec3(1000.0, 1500.0, 2000.0);
    u_xlatb1.xyz = greaterThanEqual(u_xlat0.xyzx, (-u_xlat0.xyzx)).xyz;
    u_xlat1.x = (u_xlatb1.x) ? float(1.0) : float(-1.0);
    u_xlat1.y = (u_xlatb1.y) ? float(1.0) : float(-1.0);
    u_xlat1.z = (u_xlatb1.z) ? float(1.0) : float(-1.0);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat2.xyz = fract(u_xlat2.xyz);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(6.0, 6.0, 6.0) + vec3(4.0, 4.0, 4.0);
    u_xlat0.xyz = _Time.yyy * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = (-u_xlat0.xyz) * u_xlat0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.600000024, 0.349999994, 0.150000006));
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat0.x = (-u_xlat16_3.x) + 1.0;
    u_xlat4 = (-vs_COLOR0.y) * 5.0 + 2.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat4 * u_xlat0.x + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat0.x * 0.5 + 0.5;
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_7 = u_xlat0.x * 4.0;
    u_xlat16_7 = min(u_xlat16_7, 1.0);
    u_xlat16_11 = u_xlat16_7 * -2.0 + 3.0;
    u_xlat16_7 = u_xlat16_7 * u_xlat16_7;
    u_xlat16_7 = (-u_xlat16_11) * u_xlat16_7 + 1.0;
    u_xlat0.xyz = log2(vs_COLOR0.xyz);
    u_xlat0.xyz = u_xlat0.xyz * vec3(1.20000005, 1.20000005, 1.20000005);
    u_xlat0.xyz = exp2(u_xlat0.xyz);
    u_xlat0.xyz = vec3(u_xlat16_7) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_Dim);
    u_xlat0.xyz = u_xlat16_3.xxx * u_xlat0.xyz;
    u_xlat12 = vs_TEXCOORD1.y * 0.0500000007;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat12 = float(1.0) / u_xlat12;
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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