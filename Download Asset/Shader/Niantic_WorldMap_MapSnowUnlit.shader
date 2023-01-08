//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/WorldMap/MapSnowUnlit" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_Noise ("Noise (RGB)", 2D) = "gray" { }
_Mask ("Mask", 2D) = "black" { }
_TintColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Additive", Color) = (0,0,0,0)
_Saturation ("Saturation", Range(0, 1)) = 1
_SnowColor ("Snow Base Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (0.6,1,1,1)
_Scale ("World Noise Scale", Range(0, 0.5)) = 0.25
_RimScale ("Rim Noise Scale", Range(0, 1)) = 0.5
_Height ("Pile Height", Range(0, 0.15)) = 0.1
_PileSize ("Pile Radius", Range(0.5, 2)) = 1
_ColorStrength ("Base Color Strength", Range(0.5, 1)) = 0.5
_SunsetColor ("Sunset Tint", Color) = (1,1,1,1)
_SunsetTransitionAngle ("Sunset Transition Start Angle", Range(0, 90)) = 1
_RimStrength ("Rim Color Strength", Range(0, 1)) = 0.5
_RimTintStrength ("Rim Tint Strength", Range(0, 1)) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 43886
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
uniform lowp sampler2D _Noise;
uniform lowp sampler2D _Mask;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = texture2DLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = texture2DLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat10_3.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat10_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat10 = u_xlat0.w * vs_COLOR0.w;
    SV_Target0.w = u_xlat10;
    SV_Target0.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" }
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
uniform 	vec4 unity_FogParams;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.xy = in_POSITION0.zz * hlslcc_mtx4x4unity_ObjectToWorld[2].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xz * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.xy = in_NORMAL0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xz;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xz * in_NORMAL0.xx + u_xlat6.xy;
    u_xlat6.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xz * in_NORMAL0.zz + u_xlat6.xy;
    u_xlat0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat6.xy = abs(u_xlat0.xy) * in_POSITION0.yy;
    u_xlat0.xy = abs(u_xlat0.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat0.xy = u_xlat0.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat0.xy = textureLod(_Noise, u_xlat0.xy, 0.0).xy;
    u_xlat0.xy = u_xlat0.xy * in_NORMAL0.xz;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat6.xy = u_xlat6.xy * vec2(0.100000001, 0.100000001);
    u_xlat6.x = textureLod(_Noise, u_xlat6.xy, 0.0).x;
    u_xlat9 = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat6.x = u_xlat9 * u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_NORMAL0.y;
    u_xlat1 = u_xlat6.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _RimScale;
uniform 	float _PileSize;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(1) uniform mediump sampler2D _Noise;
UNITY_LOCATION(2) uniform mediump sampler2D _Mask;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
mediump float u_xlat16_2;
vec2 u_xlat3;
float u_xlat9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlati0 = int(u_xlati0 << 3);
    u_xlat3.xy = in_POSITION0.zz * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_POSITION0.xx + u_xlat3.xy;
    u_xlat3.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3].xz * in_POSITION0.ww + u_xlat3.xy;
    u_xlat1.xy = in_NORMAL0.yy * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1].xz;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0].xz * in_NORMAL0.xx + u_xlat1.xy;
    u_xlat1.xy = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2].xz * in_NORMAL0.zz + u_xlat1.xy;
    u_xlat3.xy = u_xlat3.xy + u_xlat1.xy;
    u_xlat1.xy = abs(u_xlat3.xy) * in_POSITION0.yy;
    u_xlat3.xy = abs(u_xlat3.xy) * vec2(vec2(_RimScale, _RimScale));
    u_xlat3.xy = u_xlat3.xy * vec2(0.00999999978, 0.00999999978);
    u_xlat3.xy = textureLod(_Noise, u_xlat3.xy, 0.0).xy;
    u_xlat3.xy = u_xlat3.xy * in_NORMAL0.xz;
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_PileSize, _PileSize)) + in_POSITION0.xz;
    u_xlat1.xy = u_xlat1.xy * vec2(0.100000001, 0.100000001);
    u_xlat9 = textureLod(_Noise, u_xlat1.xy, 0.0).x;
    u_xlat1.x = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).x;
    u_xlat9 = u_xlat9 * u_xlat1.x;
    u_xlat9 = u_xlat9 * in_NORMAL0.y;
    u_xlat1 = vec4(u_xlat9) * unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * u_xlat3.yyyy + u_xlat1;
    u_xlat0 = u_xlat1 + unity_Builtins0Array[u_xlati0 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_2 = min(abs(u_xlat16_2), 1.0);
    u_xlat16_2 = (-u_xlat16_2) + 1.0;
    vs_COLOR0.w = u_xlat16_2;
    vs_COLOR0.xyz = _SnowColor.xyz;
    vs_SV_InstanceID0 =  uint(gl_InstanceID);
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
uniform 	mediump vec4 unity_FogColor;
uniform 	mediump vec4 _TintColor;
uniform 	mediump vec4 _AddColor;
uniform 	vec4 _RimColor;
uniform 	mediump vec4 _SunsetColor;
uniform 	mediump float _Saturation;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
float u_xlat10;
mediump float u_xlat16_11;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = (-_RimColor.x) * _RimStrength + u_xlat0.x;
    u_xlat3 = _RimColor.x * _RimStrength;
    u_xlat3 = vs_COLOR0.x * _ColorStrength + (-u_xlat3);
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat0.x = u_xlat3 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat3;
    u_xlat16_3.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat0.xxx;
    u_xlat1.xyz = (-vs_COLOR0.xyz) + _RimColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + vs_COLOR0.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vec3(u_xlat9);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat0.xyz;
    u_xlat16_0.xyz = u_xlat16_2.xyz * _SunsetColor.xyz;
    u_xlat16_0.w = vs_COLOR0.w * _SunsetColor.w;
    u_xlat0 = u_xlat16_0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat0 = vs_COLOR0.wwww * u_xlat0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_2.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat16_2.xyz = u_xlat1.xyz * _TintColor.xyz + _AddColor.xyz;
    u_xlat1.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
    u_xlat10 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat10 = min(max(u_xlat10, 0.0), 1.0);
#else
    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat1.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}