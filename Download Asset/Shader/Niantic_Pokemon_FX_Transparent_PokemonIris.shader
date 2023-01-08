//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/FX/Transparent/PokemonIris" {
Properties {
[Toggle(NIANTIC_UV_ANIMATE)] _UVAnimated ("IsUvAnimated", Float) = 0
[Toggle(NIANTIC_EMISSION)] _IsEmission ("IsEmission", Float) = 1
[Toggle(NIANTIC_OPACITY)] _IsOpacity ("IsOpacity", Float) = 1
[Toggle(NIANTIC_LIGHTING)] _IsLighting ("IsLighting", Float) = 1
[Header(__________________________________________)] [Space] _ColorOutside ("ColorOutside", Color) = (0.7750865,0.7831048,0.9411765,1)
_ColorInside ("ColorInside", Color) = (0.5159989,0.4319853,0.6911765,1)
_RimSmootth ("RimSmootth", Range(0.5, 2)) = 1.567605
_RimPosition ("RimPosition", Range(0.1, 2)) = 1.028863
_EyeColor ("Eye Color Tint", Color) = (1,1,1,1)
[Header(EMISSION__________________________________)] [Space] _EmissonAttachKey ("EmissonAttachKey", Range(0, 2)) = 0
_AddEmissonColor ("AddEmissonColor", Color) = (0.1658737,0.3894733,0.4338235,1)
[Header(OPACITY___________________________________)] [Space] _OpacityIntencity ("OpacityIntencity", Range(0, 1)) = 1
[MaterialToggle] _UseTexOpacity ("UseTexOpacity", Float) = 1
_texOpacityMask ("texOpacityMask", 2D) = "white" { }
[MaterialToggle] _UseRimOpacity ("UseRimOpacity", Float) = 1
[Header(LIGHTING__________________________________)] [Space] _SpecularGloss ("SpecularGloss", Range(0.1, 0.9)) = 0.5
_AmbientBias ("AmbientBias", Float) = 0.8
_DiffusePower ("DiffusePower", Range(0, 3)) = 2
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 31081
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13.xy = log2(vec2(_RimSmootth, _RimPosition));
    u_xlat16_8.x = u_xlat16_13.y * u_xlat16_8.x;
    u_xlat16_13.x = u_xlat16_13.x * _RimSmootth;
    u_xlat16_13.x = exp2(u_xlat16_13.x);
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_13.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    vs_TEXCOORD1.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "NIANTIC_EMISSION" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_EMISSION" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_EMISSION" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
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
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "NIANTIC_EMISSION" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_EMISSION" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_EMISSION" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat16_18 = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = vec3(u_xlat16_18) * _EyeColor.xyz + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    vs_TEXCOORD1.w = _OpacityIntencity;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_13;
float u_xlat15;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat16_3.x = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_8.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.x = min(max(u_xlat16_8.x, 0.0), 1.0);
#else
    u_xlat16_8.x = clamp(u_xlat16_8.x, 0.0, 1.0);
#endif
    u_xlat16_13 = log2(_RimPosition);
    u_xlat16_8.x = u_xlat16_13 * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_8.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat0.x = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_8.x = log2(u_xlat0.x);
    u_xlat16_8.x = u_xlat0.x * u_xlat16_8.x;
    u_xlat16_8.x = exp2(u_xlat16_8.x);
    u_xlat16_3.x = u_xlat16_8.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_8.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_8.xyz = u_xlat16_3.xxx * u_xlat16_8.xyz + _ColorInside.xyz;
    u_xlat0.x = u_xlat16_3.x + -1.0;
    u_xlat0.x = _UseRimOpacity * u_xlat0.x + 1.0;
    vs_TEXCOORD1.w = u_xlat0.x;
    u_xlat16_3.x = dot(u_xlat16_8.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
attribute highp vec4 in_POSITION0;
attribute mediump vec3 in_NORMAL0;
attribute mediump vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
uniform lowp sampler2D _texOpacityMask;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat10_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "NIANTIC_EMISSION" "NIANTIC_LIGHTING" "NIANTIC_OPACITY" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorOutside;
uniform 	mediump vec4 _ColorInside;
uniform 	mediump float _RimSmootth;
uniform 	mediump float _RimPosition;
uniform 	mediump vec4 _EyeColor;
uniform 	mediump float _UseRimOpacity;
uniform 	mediump float _EmissonAttachKey;
uniform 	mediump vec4 _AddEmissonColor;
uniform 	mediump float _SpecularGloss;
uniform 	mediump float _AmbientBias;
uniform 	mediump float _DiffusePower;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_10.x = _RimPosition;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10.x = min(max(u_xlat16_10.x, 0.0), 1.0);
#else
    u_xlat16_10.x = clamp(u_xlat16_10.x, 0.0, 1.0);
#endif
    u_xlat16_17 = log2(_RimPosition);
    u_xlat16_10.x = u_xlat16_17 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10.x;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat21 = _EmissonAttachKey * 0.150000006 + _RimSmootth;
    u_xlat16_10.x = log2(u_xlat21);
    u_xlat16_10.x = u_xlat21 * u_xlat16_10.x;
    u_xlat16_10.x = exp2(u_xlat16_10.x);
    u_xlat16_3.x = u_xlat16_10.x * u_xlat16_3.x;
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_10.xyz = _ColorOutside.xyz + (-_ColorInside.xyz);
    u_xlat16_10.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz + _ColorInside.xyz;
    u_xlat21 = u_xlat16_3.x + -1.0;
    u_xlat21 = _UseRimOpacity * u_xlat21 + 1.0;
    vs_TEXCOORD1.w = u_xlat21;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = u_xlat16_3.xxx * _EyeColor.xyz + (-u_xlat16_10.xyz);
    u_xlat16_3.xyz = _EyeColor.www * u_xlat16_4.xyz + u_xlat16_10.xyz;
    u_xlat16_24 = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat16_24 = u_xlat16_24 * _DiffusePower;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(vec3(_AmbientBias, _AmbientBias, _AmbientBias)) + vec3(u_xlat16_24);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat16_24 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat16_24 = max(u_xlat16_24, 0.0);
    u_xlat16_24 = log2(u_xlat16_24);
    u_xlat0.x = _SpecularGloss * 5.0 + 1.0;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat16_24 = u_xlat16_24 * u_xlat0.x;
    u_xlat16_24 = exp2(u_xlat16_24);
    u_xlat16_5.xyz = _ColorOutside.xyz * vec3(_SpecularGloss);
    u_xlat16_25 = dot(u_xlat16_5.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_6.xyz = vec3(u_xlat16_25) * _EyeColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_5.xyz = _EyeColor.www * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_5.xyz = vec3(u_xlat16_24) * u_xlat16_5.xyz;
    u_xlat16_24 = _EmissonAttachKey;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat0.x = (-u_xlat16_24) + 1.0;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * u_xlat0.xyz + u_xlat16_5.xyz;
    u_xlat0.x = min(_EmissonAttachKey, 1.45000005);
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx + _AddEmissonColor.xyz;
    u_xlat16_4.xyz = (-u_xlat16_3.xyz) + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = vec3(vec3(_EmissonAttachKey, _EmissonAttachKey, _EmissonAttachKey)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
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
uniform 	mediump float _OpacityIntencity;
uniform 	mediump float _UseTexOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _texOpacityMask;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_texOpacityMask, vs_TEXCOORD0.xy).y;
    u_xlat16_1 = u_xlat16_0 + (-vs_TEXCOORD1.w);
    u_xlat16_1 = _UseTexOpacity * u_xlat16_1 + vs_TEXCOORD1.w;
    SV_Target0.w = u_xlat16_1 * _OpacityIntencity;
    SV_Target0.xyz = vs_TEXCOORD1.xyz;
    return;
}

#endif
"
}
}
}
}
CustomEditor "PokemonShaderFXGUI"
}