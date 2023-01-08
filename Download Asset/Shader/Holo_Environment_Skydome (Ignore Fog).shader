//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Skydome (Ignore Fog)" {
Properties {
_SkyColor ("Sky Main Color", Color) = (1,1,1,1)
_HorizonColor ("Horizon Color", Color) = (1,1,1,1)
_HorizonPinch ("Horizon Pinch", Float) = 1
_HorizonHeight ("Horizon Height", Float) = 0
_FogPinch ("Fog Pinch", Float) = 1
_FogHeight ("Fog Height", Float) = 0
_SunFalloff ("Sun Falloff", Float) = 0.01
_SunSize ("Sun Size", Float) = 0.2
_SunPinch ("Sun Pinch", Float) = 10
_SunStrength ("Sun Strength", Range(0, 1)) = 1
_SunColor ("Sun Color", Color) = (1,1,1,1)
_AtmosphereRedWeight ("Atmosphere Red Weight", Float) = 0.75
_AtmosphereGreenWeight ("Atmosphere Green Weight", Float) = 0.5
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  GpuProgramID 37698
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
        u_xlatb7 = u_xlat29>=0.0;
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlatb5 = u_xlat5.x<6371000.0;
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
    u_xlatb3 = u_xlat3.x>=0.0;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
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
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
        u_xlatb7 = u_xlat29>=0.0;
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlatb5 = u_xlat5.x<6371000.0;
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
    u_xlatb3 = u_xlat3.x>=0.0;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
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
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
varying mediump float vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
        u_xlatb7 = u_xlat29>=0.0;
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlatb5 = u_xlat5.x<6371000.0;
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
    u_xlatb3 = u_xlat3.x>=0.0;
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
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
in highp vec2 in_TEXCOORD0;
out mediump float vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
in mediump float vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat29>=0.0);
#else
        u_xlatb7 = u_xlat29>=0.0;
#endif
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x<6371000.0);
#else
        u_xlatb5 = u_xlat5.x<6371000.0;
#endif
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x>=0.0);
#else
    u_xlatb3 = u_xlat3.x>=0.0;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
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
in highp vec2 in_TEXCOORD0;
out mediump float vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
in mediump float vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat29>=0.0);
#else
        u_xlatb7 = u_xlat29>=0.0;
#endif
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x<6371000.0);
#else
        u_xlatb5 = u_xlat5.x<6371000.0;
#endif
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x>=0.0);
#else
    u_xlatb3 = u_xlat3.x>=0.0;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
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
in highp vec2 in_TEXCOORD0;
out mediump float vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.x = (-in_TEXCOORD0.y) + 1.0;
    vs_TEXCOORD0 = u_xlat0.x;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
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
uniform 	mediump vec4 _SkyColor;
uniform 	mediump vec4 _HorizonColor;
uniform 	mediump float _HorizonPinch;
uniform 	mediump float _HorizonHeight;
uniform 	mediump float _FogPinch;
uniform 	mediump float _FogHeight;
uniform 	vec3 _SunDirection;
uniform 	float _SunFalloff;
uniform 	float _SunSize;
uniform 	float _SunPinch;
uniform 	mediump vec4 _SunColor;
uniform 	mediump float _SunStrength;
uniform 	mediump float _SunScatteringStrength;
uniform 	float _Hdr;
uniform 	float _AtmosphereRedWeight;
uniform 	float _AtmosphereGreenWeight;
in mediump float vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
vec2 u_xlat6;
bool u_xlatb7;
float u_xlat11;
vec2 u_xlat12;
vec2 u_xlat13;
vec2 u_xlat19;
vec2 u_xlat22;
float u_xlat26;
int u_xlati28;
float u_xlat29;
void main()
{
    u_xlat16_0.xy = vec2(vs_TEXCOORD0) + vec2(_HorizonHeight, _FogHeight);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xy = min(max(u_xlat16_0.xy, 0.0), 1.0);
#else
    u_xlat16_0.xy = clamp(u_xlat16_0.xy, 0.0, 1.0);
#endif
    u_xlat16_0.xy = log2(u_xlat16_0.xy);
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(_HorizonPinch, _FogPinch);
    u_xlat16_0.xy = exp2(u_xlat16_0.xy);
    u_xlat16_1 = (-_SkyColor) + _HorizonColor;
    u_xlat16_1 = u_xlat16_0.xxxx * u_xlat16_1 + _SkyColor;
    u_xlat2.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * vs_TEXCOORD2.xyz;
    u_xlat26 = u_xlat2.y * -6371000.0;
    u_xlat26 = u_xlat26 * u_xlat26 + 1.27519425e+11;
    u_xlat26 = sqrt(u_xlat26);
    u_xlat26 = u_xlat2.y * -6371000.0 + u_xlat26;
    u_xlat3.x = dot(u_xlat2.xyz, _SunDirection.xyz);
    u_xlat11 = u_xlat3.x * u_xlat3.x + 1.0;
    u_xlat3.x = (-u_xlat3.x) * 1.79999995 + 1.80999994;
    u_xlat3.x = log2(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * 1.5;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = 0.000795774744 / u_xlat3.x;
    u_xlat4.xyz = vec3(u_xlat26) * vec3(0.5, -1.40529792e-05, -1.85640183e-05);
    u_xlat19.xy = exp2(u_xlat4.yz);
    u_xlat3.x = u_xlat3.x * 1.57351933e-05;
    u_xlat3.xy = vec2(u_xlat11) * vec2(2.23595109e-07, 5.96831001e-07) + u_xlat3.xx;
    u_xlat3.xy = u_xlat3.xy * vec2(250.0, 235.0);
    u_xlat12.x = float(0.0);
    u_xlat12.y = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
    {
        u_xlat5.x = float(u_xlati_loop_1);
        u_xlat5.x = u_xlat5.x + 0.5;
        u_xlat5.x = (-u_xlat5.x) * 0.5 + 1.0;
        u_xlat5.x = u_xlat26 * u_xlat5.x;
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat2.xyz + vec3(0.0, -6371000.0, 0.0);
        u_xlat29 = dot(_SunDirection.xyz, u_xlat5.xyz);
        u_xlat6.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat6.x = u_xlat29 * u_xlat29 + (-u_xlat6.x);
        u_xlat6.x = u_xlat6.x + 4.07171624e+13;
        u_xlat6.x = sqrt(u_xlat6.x);
        u_xlat6.x = u_xlat29 + u_xlat6.x;
        u_xlat6.xy = u_xlat6.xx * vec2(-2.81059583e-05, -3.71280366e-05);
        u_xlat6.xy = exp2(u_xlat6.xy);
        u_xlat6.xy = u_xlat3.xy * u_xlat6.xy;
        u_xlat22.xy = u_xlat19.xy * u_xlat12.xy;
#ifdef UNITY_ADRENO_ES3
        u_xlatb7 = !!(u_xlat29>=0.0);
#else
        u_xlatb7 = u_xlat29>=0.0;
#endif
        u_xlat5.xyz = (-vec3(u_xlat29)) * _SunDirection.xyz + u_xlat5.xyz;
        u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
#ifdef UNITY_ADRENO_ES3
        u_xlatb5 = !!(u_xlat5.x<6371000.0);
#else
        u_xlatb5 = u_xlat5.x<6371000.0;
#endif
        u_xlatb5 = u_xlatb5 && u_xlatb7;
        u_xlat13.xy = u_xlat6.xy * u_xlat4.xx + u_xlat22.xy;
        u_xlat12.xy = (bool(u_xlatb5)) ? u_xlat22.xy : u_xlat13.xy;
    }
    u_xlat2.xy = u_xlat12.xy * (-vec2(_Hdr));
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.xy = (-u_xlat2.xy) + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * vec2(_AtmosphereRedWeight, _AtmosphereGreenWeight);
    u_xlat2.z = 0.0;
    u_xlat3.xyz = (-u_xlat16_1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat2.xyz) * vec3(vec3(_SunScatteringStrength, _SunScatteringStrength, _SunScatteringStrength)) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = (-u_xlat3.xyz) * u_xlat2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat3.xyz = vs_TEXCOORD2.zxy * _SunDirection.yzx;
    u_xlat3.xyz = vs_TEXCOORD2.yzx * _SunDirection.zxy + (-u_xlat3.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat3.x = _SunSize + 1.0;
    u_xlat26 = (-u_xlat26) * _SunFalloff + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat26 = log2(u_xlat26);
    u_xlat26 = u_xlat26 * _SunPinch;
    u_xlat26 = exp2(u_xlat26);
    u_xlat3.x = dot(vs_TEXCOORD2.xyz, _SunDirection.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x>=0.0);
#else
    u_xlatb3 = u_xlat3.x>=0.0;
#endif
    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat3.x * _SunStrength;
    u_xlat26 = u_xlat26 * u_xlat3.x;
    u_xlat3.xyz = (-u_xlat2.xyz);
    u_xlat3.w = (-u_xlat16_1.w);
    u_xlat3 = u_xlat3 + _SunColor;
    u_xlat4.xyz = vec3(u_xlat26) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat4.w = u_xlat26 * u_xlat3.w + u_xlat16_1.w;
    u_xlat16_1 = (-u_xlat4) + unity_FogColor;
    SV_Target0 = u_xlat16_0.yyyy * u_xlat16_1 + u_xlat4;
    return;
}

#endif
"
}
}
}
}
}