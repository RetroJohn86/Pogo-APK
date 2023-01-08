//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "ARDK/Effects/DepthMeshOccluder" {
Properties {
_textureDepth ("Depth Texture", 2D) = "white" { }
_textureDepthSuppressionMask ("Depth Suppresion Mask", 2D) = "black" { }
_colorMask ("Color Mask", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry-1" "RenderType" = "Opaque" }
 Pass {
  Tags { "QUEUE" = "Geometry-1" "RenderType" = "Opaque" }
  ColorMask 0 0
  Offset 1, 1
  GpuProgramID 22624
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = texture2DLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
    u_xlatb1 = u_xlat1.x==0.0;
    if(u_xlatb1){
        u_xlat1.x = texture2DLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = texture2DLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
    u_xlatb1 = u_xlat1.x==0.0;
    if(u_xlatb1){
        u_xlat1.x = texture2DLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
uniform lowp sampler2D _textureDepthSuppressionMask;
uniform lowp sampler2D _textureDepth;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = texture2DLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
    u_xlatb1 = u_xlat1.x==0.0;
    if(u_xlatb1){
        u_xlat1.x = texture2DLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(1) uniform mediump sampler2D _textureDepth;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = textureLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    if(u_xlatb1){
        u_xlat1.x = textureLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(1) uniform mediump sampler2D _textureDepth;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = textureLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    if(u_xlatb1){
        u_xlat1.x = textureLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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
uniform 	float _depthScaleMin;
uniform 	float _depthScaleMax;
uniform 	vec4 hlslcc_mtx4x4_depthTransform[4];
uniform 	vec4 hlslcc_mtx4x4_semanticsTransform[4];
UNITY_LOCATION(0) uniform mediump sampler2D _textureDepthSuppressionMask;
UNITY_LOCATION(1) uniform mediump sampler2D _textureDepth;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec3 u_xlat1;
bool u_xlatb1;
float u_xlat3;
float u_xlat5;
void main()
{
    u_xlat0.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_depthTransform[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_depthTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[2].xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4_depthTransform[3].xyz;
    u_xlat1.xyz = in_TEXCOORD0.yyy * hlslcc_mtx4x4_semanticsTransform[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4_semanticsTransform[0].xyz * in_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[2].xyz;
    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4x4_semanticsTransform[3].xyz;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.zz;
    u_xlat1.xy = u_xlat1.xy / u_xlat1.zz;
    u_xlat1.x = textureLod(_textureDepthSuppressionMask, u_xlat1.xy, 0.0).x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x==0.0);
#else
    u_xlatb1 = u_xlat1.x==0.0;
#endif
    if(u_xlatb1){
        u_xlat1.x = textureLod(_textureDepth, u_xlat0.xy, 0.0).x;
        u_xlat3 = (-_depthScaleMin) + _depthScaleMax;
        u_xlat0.z = u_xlat1.x * u_xlat3 + _depthScaleMin;
    } else {
        u_xlat0.z = 0.0;
    }
    u_xlat1.x = (-u_xlat0.z) * hlslcc_mtx4x4glstate_matrix_projection[2].z + hlslcc_mtx4x4glstate_matrix_projection[3].z;
    gl_Position.z = u_xlat1.x / u_xlat0.z;
    u_xlat1.x = (-in_TEXCOORD0.y) * 2.0 + 1.0;
    u_xlat3 = in_TEXCOORD0.y * 2.0 + -1.0;
    u_xlat5 = _ProjectionParams.x + 1.0;
    u_xlat5 = u_xlat5 * 0.5;
    u_xlat3 = (-u_xlat1.x) + u_xlat3;
    gl_Position.y = u_xlat5 * u_xlat3 + u_xlat1.x;
    gl_Position.x = in_TEXCOORD0.x * 2.0 + -1.0;
    gl_Position.w = 1.0;
    u_xlat0.w = 1.0;
    vs_COLOR0 = u_xlat0.xzyw;
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