//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "ARDK/Effects/DepthMeshOcclusionEffect" {
Properties {
_minDepth ("Min Depth", Float) = 0
_maxDepth ("Max Depth", Float) = 0
_disparityTexture ("Depth Texture", 2D) = "white" { }
_suppressionTexture ("Suppression Texture", 2D) = "black" { }
_colorMask ("Color Mask", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry-1" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Geometry-1" "RenderType" = "Opaque" }
  ColorMask 0 0
  Offset 1, 1
  GpuProgramID 13157
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
uniform highp sampler2D _disparityTexture;
uniform highp sampler2D _suppressionTexture;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat2 = texture2DLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = texture2DLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat2 = u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
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
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
uniform highp sampler2D _disparityTexture;
uniform highp sampler2D _suppressionTexture;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat2 = texture2DLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = texture2DLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat2 = u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
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
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
uniform highp sampler2D _disparityTexture;
uniform highp sampler2D _suppressionTexture;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
    u_xlat2 = texture2DLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = texture2DLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
    u_xlatb0 = 0.0<u_xlat0.x;
    u_xlat2 = u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
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
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
UNITY_LOCATION(0) uniform highp sampler2D _disparityTexture;
UNITY_LOCATION(1) uniform highp sampler2D _suppressionTexture;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat2 = textureLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = textureLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat0.x);
#else
    u_xlatb0 = 0.0<u_xlat0.x;
#endif
    u_xlat2 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
UNITY_LOCATION(0) uniform highp sampler2D _disparityTexture;
UNITY_LOCATION(1) uniform highp sampler2D _suppressionTexture;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat2 = textureLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = textureLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat0.x);
#else
    u_xlatb0 = 0.0<u_xlat0.x;
#endif
    u_xlat2 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _minDepth;
uniform 	float _maxDepth;
UNITY_LOCATION(0) uniform highp sampler2D _disparityTexture;
UNITY_LOCATION(1) uniform highp sampler2D _suppressionTexture;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec2 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
float u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat2 = textureLod(_disparityTexture, u_xlat0.xy, 0.0).x;
    u_xlat0.x = textureLod(_suppressionTexture, u_xlat0.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat0.x);
#else
    u_xlatb0 = 0.0<u_xlat0.x;
#endif
    u_xlat2 = u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat1.xz = vec2(1.0, 1.0) / vec2(_maxDepth, _minDepth);
    u_xlat3 = (-u_xlat1.x) + u_xlat1.z;
    u_xlat1.x = u_xlat3 * u_xlat2 + u_xlat1.x;
    u_xlat2 = float(1.0) / u_xlat1.x;
    vs_COLOR0.y = u_xlat1.x;
    u_xlat0.x = (u_xlatb0) ? _maxDepth : u_xlat2;
    u_xlat1.x = u_xlat0.x + -70.0;
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlat0.x = u_xlat1.x * u_xlat1.x + u_xlat0.x;
    u_xlat1.x = (-u_xlat0.x) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.x;
    u_xlat0.x = _ProjectionParams.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5;
    u_xlat1.x = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat2 = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat1.x = (-u_xlat2) + u_xlat1.x;
    gl_Position.y = u_xlat0.x * u_xlat1.x + u_xlat2;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    vs_COLOR0.xz = in_TEXCOORD0.xy;
    vs_COLOR0.w = 1.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}