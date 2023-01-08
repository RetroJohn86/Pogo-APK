//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ARKitFrame" {
Properties {
_textureY ("TextureY", 2D) = "black" { }
_textureCbCr ("TextureCbCr", 2D) = "gray" { }
_textureDepth ("Depth", 2D) = "white" { }
_textureDepthSuppressionMask ("Depth Suppresion Mask", 2D) = "black" { }
}
SubShader {
 Tags { "FORCENOSHADOWCASTING" = "true" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  LOD 100
  Tags { "FORCENOSHADOWCASTING" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  Cull Off
  GpuProgramID 61444
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
lowp vec4 u_xlat10_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
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
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec4 u_xlat16_0;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    gl_FragDepth = 0.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
float u_xlat1;
void main()
{
    SV_Target0.w = 1.0;
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureDepth;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureDepth;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureDepth;
varying highp vec3 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat10_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepth;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepth;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepth;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
    u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
    u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
    u_xlat0.x = u_xlat16_0 * u_xlat1 + _depthScaleMin;
    u_xlat1 = float(1.0) / u_xlat0.x;
    SV_Target0.xyz = vec3(u_xlat1) * vec3(0.25, 0.25, 0.25);
    SV_Target0.w = 1.0;
    u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
    u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
    gl_FragDepth = u_xlat1 / u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat10_0.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat10_0.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat10_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0.x = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat16_0.x = texture(_textureY, vs_TEXCOORD0.xy).x;
    u_xlat16_0.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
    u_xlat16_0.w = 1.0;
    SV_Target0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_0.xzw);
    SV_Target0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_0);
    SV_Target0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_0.xyw);
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0.x = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat1 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0.x * u_xlat1 + _depthScaleMin;
        u_xlat1 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat0.x = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat1 / u_xlat0.x;
    } else {
        gl_FragDepth = 0.0;
    }
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat10_1.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat10_1.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat10_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_1.xyw);
        gl_FragDepth = 0.0;
    }
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat10_1.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat10_1.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat10_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_1.xyw);
        gl_FragDepth = 0.0;
    }
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_EXT_frag_depth
#extension GL_EXT_frag_depth : enable
#endif
#define gl_FragDepth gl_FragDepthEXT

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform lowp sampler2D _textureY;
uniform lowp sampler2D _textureCbCr;
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
varying highp vec2 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
lowp vec4 u_xlat10_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture2D(_textureDepthSuppressionMask, u_xlat0.xy).x;
    u_xlatb0 = u_xlat0.x==0.0;
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat10_0 = texture2D(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat10_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat10_1.x = texture2D(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat10_1.yz = texture2D(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat10_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat10_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat10_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat10_1.xyw);
        gl_FragDepth = 0.0;
    }
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat16_1.x = texture(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat16_1.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_1.xyw);
        gl_FragDepth = 0.0;
    }
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat16_1.x = texture(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat16_1.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_1.xyw);
        gl_FragDepth = 0.0;
    }
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
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
uniform 	vec4 hlslcc_mtx4x4_displayTransform[4];
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.yy * hlslcc_mtx4x4_displayTransform[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4_displayTransform[0].xy * in_TEXCOORD0.xx + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + hlslcc_mtx4x4_displayTransform[3].xy;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    vs_TEXCOORD2.xyz = u_xlat0.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
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
uniform 	vec4 _ZBufferParams;
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
UNITY_LOCATION(0) uniform mediump sampler2D _textureY;
UNITY_LOCATION(1) uniform mediump sampler2D _textureCbCr;
UNITY_LOCATION(2) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(3) uniform mediump sampler2D _textureDepth;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
float u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.zz;
    u_xlat0.x = texture(_textureDepthSuppressionMask, u_xlat0.xy).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x==0.0);
#else
    u_xlatb0 = u_xlat0.x==0.0;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.zz;
        u_xlat16_0 = texture(_textureDepth, u_xlat0.xy).x;
        u_xlat2 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.x = u_xlat16_0 * u_xlat2 + _depthScaleMin;
        u_xlat2 = (-u_xlat0.x) * _ZBufferParams.w + 1.0;
        u_xlat4 = dot(u_xlat0.xx, _ZBufferParams.zz);
        gl_FragDepth = u_xlat2 / u_xlat4;
        u_xlat0.x = float(1.0) / u_xlat0.x;
        u_xlat0.xyz = u_xlat0.xxx * vec3(0.25, 0.25, 0.25);
    } else {
        u_xlat16_1.x = texture(_textureY, vs_TEXCOORD0.xy).x;
        u_xlat16_1.yz = texture(_textureCbCr, vs_TEXCOORD0.xy).xy;
        u_xlat16_1.w = 1.0;
        u_xlat0.x = dot(vec3(1.0, 1.40199995, -0.700999975), u_xlat16_1.xzw);
        u_xlat0.y = dot(vec4(1.0, -0.344099998, -0.714100003, 0.529100001), u_xlat16_1);
        u_xlat0.z = dot(vec3(1.0, 1.77199996, -0.885999978), u_xlat16_1.xyw);
        gl_FragDepth = 0.0;
    }
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