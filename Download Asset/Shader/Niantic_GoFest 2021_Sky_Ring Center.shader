//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/GoFest 2021/Sky/Ring Center" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_WarpTex ("Warp Texture", 2D) = "white" { }
_RampTex ("Ramp Texture", 2D) = "white" { }
_BaseColor ("Base Color", Color) = (1,1,1,1)
_OuterGlowColor ("Outer Glow Color", Color) = (1,1,1,1)
_OuterGlowPower ("Outer Glow Power", Float) = 8
_OuterGlowIntensity ("Outer Glow Intensity", Float) = 2
_InnerGlowPower ("Inner Glow Power", Float) = 3
_InnerGlowIntensity ("Inner Glow Intensity", Float) = 1
_WarpIntensity ("Warp Intensity", Float) = 1.2
_WarpScrollSpeedA ("Warp Scroll Speed A", Float) = 1
_WarpScrollSpeedB ("Warp Scroll Speed B", Float) = 0.7
_WarpBias ("Warp Bias", Float) = -0.1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 1419
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump float in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
lowp float u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat10_1.x = texture2D(_MainTex, u_xlat1.xy).x;
    u_xlat10_5 = texture2D(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat10_5, u_xlat10_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
    u_xlatb1 = 0.5>=u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump float in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
lowp float u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat10_1.x = texture2D(_MainTex, u_xlat1.xy).x;
    u_xlat10_5 = texture2D(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat10_5, u_xlat10_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
    u_xlatb1 = 0.5>=u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump float in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _RampTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
lowp float u_xlat10_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat10_1.x = texture2D(_MainTex, u_xlat1.xy).x;
    u_xlat10_5 = texture2D(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat10_5, u_xlat10_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
    u_xlatb1 = 0.5>=u_xlat16_4.x;
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat10_1 = texture2D(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat10_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump float in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat16_0.x)<abs(u_xlat16_0.y));
#else
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
#endif
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_8<(-u_xlat16_8));
#else
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
#endif
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_8>=(-u_xlat16_8));
#else
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
#endif
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat16_1.x = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_5.x = texture(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat16_5.x, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat16_4.x);
#else
    u_xlatb1 = 0.5>=u_xlat16_4.x;
#endif
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump float in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat16_0.x)<abs(u_xlat16_0.y));
#else
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
#endif
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_8<(-u_xlat16_8));
#else
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
#endif
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_8>=(-u_xlat16_8));
#else
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
#endif
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat16_1.x = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_5.x = texture(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat16_5.x, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat16_4.x);
#else
    u_xlatb1 = 0.5>=u_xlat16_4.x;
#endif
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump float in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = vec4(in_COLOR0);
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
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _OuterGlowColor;
uniform 	mediump float _OuterGlowPower;
uniform 	mediump float _OuterGlowIntensity;
uniform 	mediump float _InnerGlowPower;
uniform 	mediump float _InnerGlowIntensity;
uniform 	mediump float _WarpIntensity;
uniform 	mediump float _WarpScrollSpeedA;
uniform 	mediump float _WarpScrollSpeedB;
uniform 	mediump float _WarpBias;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RampTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
bool u_xlatb1;
mediump float u_xlat16_2;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec2 u_xlat16_5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_8;
bool u_xlatb9;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat16_8 = max(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = float(1.0) / u_xlat16_8;
    u_xlat16_12 = min(abs(u_xlat16_0.x), abs(u_xlat16_0.y));
    u_xlat16_8 = u_xlat16_8 * u_xlat16_12;
    u_xlat16_12 = u_xlat16_8 * u_xlat16_8;
    u_xlat1.x = u_xlat16_12 * 0.0208350997 + -0.0851330012;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.180141002;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + -0.330299497;
    u_xlat1.x = u_xlat16_12 * u_xlat1.x + 0.999866009;
    u_xlat5 = u_xlat16_8 * u_xlat1.x;
    u_xlat5 = u_xlat5 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(u_xlat16_0.x)<abs(u_xlat16_0.y));
#else
    u_xlatb9 = abs(u_xlat16_0.x)<abs(u_xlat16_0.y);
#endif
    u_xlat5 = u_xlatb9 ? u_xlat5 : float(0.0);
    u_xlat1.x = u_xlat16_8 * u_xlat1.x + u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_0.x<(-u_xlat16_0.x));
#else
    u_xlatb5 = u_xlat16_0.x<(-u_xlat16_0.x);
#endif
    u_xlat5 = u_xlatb5 ? -3.14159274 : float(0.0);
    u_xlat1.x = u_xlat5 + u_xlat1.x;
    u_xlat16_8 = min(u_xlat16_0.x, u_xlat16_0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat16_8<(-u_xlat16_8));
#else
    u_xlatb5 = u_xlat16_8<(-u_xlat16_8);
#endif
    u_xlat16_8 = max(u_xlat16_0.x, u_xlat16_0.y);
    u_xlat16_0.xy = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_0.x = dot(u_xlat16_0.xy, u_xlat16_0.xy);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_8>=(-u_xlat16_8));
#else
    u_xlatb9 = u_xlat16_8>=(-u_xlat16_8);
#endif
    u_xlatb5 = u_xlatb9 && u_xlatb5;
    u_xlat1.x = (u_xlatb5) ? (-u_xlat1.x) : u_xlat1.x;
    u_xlat16_4.x = u_xlat16_0.x * _WarpIntensity + u_xlat1.x;
    u_xlat16_2 = sin(u_xlat16_4.x);
    u_xlat16_3.x = cos(u_xlat16_4.x);
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_5.xy = u_xlat16_0.xx * u_xlat16_3.yx;
    u_xlat1.xw = _Time.yy * vec2(_WarpScrollSpeedA, _WarpScrollSpeedB) + u_xlat16_5.yx;
    u_xlat1.yz = u_xlat16_5.xy;
    u_xlat16_1.x = texture(_MainTex, u_xlat1.xy).x;
    u_xlat16_5.x = texture(_MainTex, u_xlat1.zw).x;
    u_xlat1.x = max(u_xlat16_5.x, u_xlat16_1.x);
    u_xlat16_4.x = u_xlat1.x + _WarpBias;
    u_xlat16_4.yz = u_xlat16_4.xx + vec2(0.5, -0.5);
    u_xlat16_4.xz = (-u_xlat16_4.xz) + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5>=u_xlat16_4.x);
#else
    u_xlatb1 = 0.5>=u_xlat16_4.x;
#endif
    u_xlat16_4.x = (u_xlatb1) ? 1.0 : 0.0;
    u_xlat16_2 = (-u_xlat16_0.x) + 1.0;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * _OuterGlowPower;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_2 = log2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowPower;
    u_xlat16_2 = exp2(u_xlat16_2);
    u_xlat16_2 = u_xlat16_2 * _InnerGlowIntensity;
    u_xlat16_2 = _OuterGlowIntensity * u_xlat16_0.x + u_xlat16_2;
    u_xlat16_6 = (-u_xlat16_2) + 1.0;
    u_xlat16_12 = (-u_xlat16_6) * u_xlat16_4.z + 1.0;
    u_xlat16_12 = (-u_xlat16_2) * u_xlat16_4.y + u_xlat16_12;
    u_xlat16_8 = u_xlat16_4.y * u_xlat16_2;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_12 + u_xlat16_8;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_1 = texture(_RampTex, u_xlat16_4.xx);
    u_xlat16_0 = _OuterGlowColor * u_xlat16_0.xxxx + u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 + _BaseColor;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}