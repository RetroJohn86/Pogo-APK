//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CrTestShader/PokemonIce28_61_V" {
Properties {
_matcapTex ("Matcap Texture", 2D) = "white" { }
_maskTex ("Mask Texture", 2D) = "white" { }
_IceColor ("Ice Color", Color) = (0.647167,0.8340114,0.9264706,1)
_HairColor ("Hair Color", Color) = (0.2760597,0.4809316,0.8161765,1)
_Boundary ("Boundary between Ice and Hair", Range(0, 1)) = 0.6
_lineDensity ("Hair Line Density", Range(0, 1)) = 0.5
[Space] [Header(LIGHTING_PARAMETER___________________________)] [Space] _shadeColor ("Shade Color", Color) = (0.6393718,0.6237024,0.7573529,1)
_rimColor ("Matcap Color", Color) = (0.365917,0.5091159,0.5294118,1)
_AOColor ("AO Color", Color) = (0.5,0.5,0.5,1)
_AOPower ("AO Power", Range(0.01, 5)) = 1
_innerShadeMultiply ("Brightness of Shade on Hair(multiply)", Range(0, 2)) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 23241
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
uniform lowp sampler2D _maskTex;
uniform lowp sampler2D _matcapTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat10_2 = texture2D(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat10_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
    u_xlat10_6 = texture2D(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat10_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat10_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
uniform lowp sampler2D _maskTex;
uniform lowp sampler2D _matcapTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat10_2 = texture2D(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat10_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
    u_xlat10_6 = texture2D(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat10_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat10_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec4 in_TANGENT0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
uniform lowp sampler2D _maskTex;
uniform lowp sampler2D _matcapTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec3 vs_TEXCOORD2;
varying mediump vec3 vs_TEXCOORD3;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp float u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat10_2 = texture2D(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat10_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
    u_xlat10_6 = texture2D(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat10_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat10_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat10_2 = texture2D(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat10_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
UNITY_LOCATION(0) uniform mediump sampler2D _maskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _matcapTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat16_2 = texture(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat16_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_6 = texture(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat16_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
UNITY_LOCATION(0) uniform mediump sampler2D _maskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _matcapTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat16_2 = texture(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat16_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_6 = texture(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat16_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Boundary;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
float u_xlat12;
mediump float u_xlat16_14;
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
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xy = vec2(u_xlat12) * u_xlat1.xy;
    vs_TEXCOORD1.xy = u_xlat1.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat16_2.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    vs_TEXCOORD2.x = max(u_xlat16_2.x, 0.0);
    u_xlat16_2.x = (-_Boundary) + 1.0;
    u_xlat16_2.xyz = (-u_xlat1.xyz) * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_14 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_14 = inversesqrt(u_xlat16_14);
    u_xlat16_2.xyz = vec3(u_xlat16_14) * u_xlat16_2.xyz;
    u_xlat12 = dot(u_xlat16_2.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.z = u_xlat12;
    u_xlat12 = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat12 = max(u_xlat12, 0.0);
    vs_TEXCOORD2.y = u_xlat12;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.xyz = u_xlat0.zxy * u_xlat1.yzx;
    u_xlat3.xyz = u_xlat0.yzx * u_xlat1.zxy + (-u_xlat3.xyz);
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    u_xlat1.xyz = u_xlat3.xyz * in_TANGENT0.www;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, u_xlat16_2.xyz);
    vs_TEXCOORD3.xyz = u_xlat0.xyz;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _IceColor;
uniform 	mediump vec4 _HairColor;
uniform 	mediump vec4 _shadeColor;
uniform 	mediump vec4 _rimColor;
uniform 	mediump float _Boundary;
uniform 	mediump float _lineDensity;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOPower;
uniform 	mediump float _innerShadeMultiply;
UNITY_LOCATION(0) uniform mediump sampler2D _maskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _matcapTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
mediump float u_xlat16_12;
mediump float u_xlat16_13;
void main()
{
    u_xlat16_0.xyz = _shadeColor.xyz * vec3(vec3(_innerShadeMultiply, _innerShadeMultiply, _innerShadeMultiply));
    u_xlat16_0.xyz = min(u_xlat16_0.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_1.xyz = u_xlat16_0.xyz * _HairColor.xyz;
    u_xlat16_0.xyz = (-_HairColor.xyz) * u_xlat16_0.xyz + _HairColor.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.zzz * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _IceColor.xyz;
    u_xlat16_12 = (-_Boundary) + 1.0;
    u_xlat16_2 = texture(_maskTex, vs_TEXCOORD0.xy).y;
    u_xlat16_3.xy = (-vec2(u_xlat16_12)) * vec2(u_xlat16_2) + vec2(1.0, 0.930000007);
    u_xlat16_3.xz = vs_TEXCOORD3.xy * u_xlat16_3.xx + vs_TEXCOORD0.xy;
    u_xlat16_12 = (-u_xlat16_3.y) + vs_TEXCOORD2.x;
    u_xlat16_12 = u_xlat16_12 * 7.14285707;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
#else
    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
#endif
    u_xlat16_6 = texture(_maskTex, u_xlat16_3.xz).x;
    u_xlat16_13 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = u_xlat16_13 * _lineDensity;
    u_xlat16_0.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz + (-_IceColor.xyz);
    u_xlat16_1.x = u_xlat16_12 * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_1.x;
    u_xlat16_12 = u_xlat16_2 * u_xlat16_12;
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + _IceColor.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _shadeColor.xyz;
    u_xlat16_0.xyz = (-u_xlat16_0.xyz) * _shadeColor.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = vs_TEXCOORD2.yyy * u_xlat16_0.xyz + u_xlat16_1.xyz;
    u_xlat16_2 = texture(_matcapTex, vs_TEXCOORD1.xy).x;
    u_xlat16_0.xyz = vec3(u_xlat16_2) * _rimColor.xyz + u_xlat16_0.xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * _AOColor.xyz;
    u_xlat16_0.xyz = (-_AOColor.xyz) * u_xlat16_0.xyz + u_xlat16_0.xyz;
    u_xlat16_12 = log2(vs_COLOR0.w);
    u_xlat16_12 = u_xlat16_12 * _AOPower;
    u_xlat16_12 = exp2(u_xlat16_12);
    u_xlat16_0.xyz = vec3(u_xlat16_12) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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