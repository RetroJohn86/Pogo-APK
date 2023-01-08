//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/MapBuddyShadow" {
Properties {
[Header(BLENDING (ShadowAlpha only works with some blend modes))] [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 2
[Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend mode 2", Float) = 0
[Space] [Header(GENERAL PARAMETERS)] _ShadowDir ("Shadow Direction", Vector) = (-0.3,-0.3,0,1)
_Color ("Color", Color) = (0,0,0,1)
_GroundHeight ("Ground Height", Float) = 0
_ShadowAlpha ("Shadow Alpha", Range(0, 1)) = 1
_ShadowAngleHeightScale ("Shadow Angle Height Scale", Float) = 2
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Offset 0, -1
  Stencil {
   Ref 1
   ReadMask 1
   WriteMask 1
   Comp NotEqual
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 58358
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
varying mediump vec3 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
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
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
varying mediump vec3 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
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
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
attribute highp vec4 in_POSITION0;
varying mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
varying mediump vec3 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
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
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
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
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
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
uniform 	mediump vec3 _ShadowDir;
uniform 	mediump vec4 _Color;
uniform 	mediump float _GroundHeight;
in highp vec4 in_POSITION0;
out mediump vec3 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
float u_xlat2;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat16_1.x = dot(_ShadowDir.xyz, _ShadowDir.xyz);
    u_xlat16_1.x = inversesqrt(u_xlat16_1.x);
    u_xlat16_1.xyz = u_xlat16_1.xxx * _ShadowDir.xyz;
    u_xlat2 = u_xlat0.y / u_xlat16_1.y;
    u_xlat0.xy = (-vec2(u_xlat2)) * u_xlat16_1.xz + u_xlat0.xz;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[1] * vec4(_GroundHeight);
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.yyyy + u_xlat1;
    gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
    vs_COLOR0.xyz = _Color.xyz;
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
uniform 	mediump float _ShadowAlpha;
in mediump vec3 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = _ShadowAlpha;
    return;
}

#endif
"
}
}
}
}
}