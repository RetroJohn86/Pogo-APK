//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/WorldMap/SnowUnlit" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
[Header (Snow Properties)] _Noise ("Noise (RGB)", 2D) = "gray" { }
_Mask ("Mask", 2D) = "black" { }
_Scale ("World Noise Scale", Range(0, 0.5)) = 0.25
_RimScale ("Rim Noise Scale", Range(0, 20)) = 0.5
_Height ("Pile Height", Range(0, 10)) = 0.1
_PileSize ("Pile Radius", Range(1, 2)) = 2
_ColorStrength ("Base Color Strength", Range(0.5, 1)) = 0.5
_RimStrength ("Rim Color Strength", Range(0, 1)) = 0.5
[Header (Environment Properties)] _TintColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Additive", Color) = (0,0,0,0)
_Saturation ("Saturation", Range(0, 1)) = 1
_SnowColor ("Snow Base Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (0.6,1,1,1)
_SunsetColor ("Sunset Tint", Color) = (1,1,1,1)
_SunsetTransitionAngle ("Sunset Transition Start Angle", Range(0, 90)) = 1
_RimTintStrength ("Rim Tint Strength", Range(0, 1)) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 52185
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = texture2DLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = texture2DLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = texture2DLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = texture2DLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
    SV_Target0.w = u_xlat0.w;
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
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = texture2DLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = texture2DLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = texture2DLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = textureLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = textureLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = textureLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = textureLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SnowColor;
uniform 	mediump float _SunAngle;
uniform 	mediump float _SunsetTransitionAngle;
uniform 	float _Scale;
uniform 	float _RimScale;
uniform 	float _Height;
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
vec3 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xzxz;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].xzxz * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2].xzxz * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3].xzxz * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = abs(u_xlat0) * vec4(_Scale, _Scale, _RimScale, _RimScale);
    u_xlat0 = u_xlat0 * vec4(0.100000001, 0.100000001, 0.00999999978, 0.00999999978);
    u_xlat1.xyz = textureLod(_Noise, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xz = textureLod(_Noise, u_xlat0.zw, 0.0).xy;
    u_xlat2.xyz = textureLod(_Mask, in_TEXCOORD0.xy, 0.0).xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_Height);
    u_xlat1.xyz = u_xlat1.xyz * in_NORMAL0.xyz;
    u_xlat0.y = in_POSITION0.y;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_PileSize, _PileSize, _PileSize));
    u_xlat2.xz = in_POSITION0.xz;
    u_xlat2.y = 0.0;
    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_3 = _SunAngle / _SunsetTransitionAngle;
    u_xlat16_3 = min(abs(u_xlat16_3), 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    vs_COLOR0.w = u_xlat16_3;
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
uniform 	mediump vec4 _SunsetColor;
uniform 	vec4 _RimColor;
uniform 	mediump float _Saturation;
uniform 	mediump float _RimTintStrength;
uniform 	float _ColorStrength;
uniform 	float _RimStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat9;
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
    u_xlat1.xyz = _RimColor.xyz * vec3(vec3(_RimTintStrength, _RimTintStrength, _RimTintStrength));
    u_xlat16_2.xyz = (-_TintColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + _RimColor.xyz;
    u_xlat9 = dot(vs_COLOR0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_2.xyz = vec3(u_xlat9) + (-vs_COLOR0.xyz);
    u_xlat16_11 = (-_Saturation) + 1.0;
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + vs_COLOR0.xyz;
    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat16_2.xyz;
    u_xlat0.w = vs_COLOR0.w;
    u_xlat1 = u_xlat0 * _SunsetColor + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vs_COLOR0.wwww * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = u_xlat0 * u_xlat1;
    SV_Target0.xyz = u_xlat0.xyz * _TintColor.xyz + _AddColor.xyz;
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