//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Combat/LayerFillFromBaseToTop" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_EdgeColor ("Edge Color", Color) = (1,1,1,0.4)
_EdgeWeight ("Edge Weight", Float) = 6
_LimitHit ("Limit Hit", Float) = 0
_UnfillColor ("Unfilled Color", Color) = (1,1,1,1)
_UnfillOuter ("Unfilled Outer", Range(0, 1)) = 0.5
_UnfilledOuterFeather ("Unfilled Outer Feather", Float) = 0.1
_UnfilledOuterThickness ("Unfilled Outer Thickness", Float) = 0.1
_FillAmt ("Fill Amount", Range(0, 1)) = 0
_TimerFillValue ("Attack Wait Fill Value", Range(0, 1)) = 0
_ScreenExtends ("Extends of Icon on Screen", Vector) = (0,0,1,1)
}
SubShader {
 Tags { "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+100" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 44961
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
    u_xlatb15 = _TimerFillValue>=u_xlat15;
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
    u_xlatb1 = _LimitHit>=0.100000001;
    u_xlat16_2 = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat10_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat10_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat10_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
    u_xlatb15 = _TimerFillValue>=u_xlat15;
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
    u_xlatb1 = _LimitHit>=0.100000001;
    u_xlat16_2 = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat10_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat10_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat10_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump float u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
    u_xlatb15 = _TimerFillValue>=u_xlat15;
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
    u_xlatb1 = _LimitHit>=0.100000001;
    u_xlat16_2 = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat10_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat10_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat10_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat10_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6.x>=(-u_xlat6.x));
#else
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
#endif
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_TimerFillValue>=u_xlat15);
#else
    u_xlatb15 = _TimerFillValue>=u_xlat15;
#endif
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_LimitHit>=0.100000001);
#else
    u_xlatb1 = _LimitHit>=0.100000001;
#endif
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat16_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat16_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6.x>=(-u_xlat6.x));
#else
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
#endif
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_TimerFillValue>=u_xlat15);
#else
    u_xlatb15 = _TimerFillValue>=u_xlat15;
#endif
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_LimitHit>=0.100000001);
#else
    u_xlatb1 = _LimitHit>=0.100000001;
#endif
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat16_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat16_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    vs_TEXCOORD1.xy = u_xlat0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	mediump vec4 _EdgeColor;
uniform 	mediump float _EdgeWeight;
uniform 	mediump float _LimitHit;
uniform 	mediump vec4 _UnfillColor;
uniform 	mediump float _UnfillOuter;
uniform 	float _UnfilledOuterFeather;
uniform 	float _UnfilledOuterThickness;
uniform 	float _FillAmt;
uniform 	float _TimerFillValue;
uniform 	vec4 _ScreenExtends;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec2 u_xlat1;
bool u_xlatb1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
bool u_xlatb6;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
float u_xlat15;
bool u_xlatb15;
void main()
{
    u_xlat0.xyz = vs_TEXCOORD1.yxy + (-_ScreenExtends.yxy);
    u_xlat0.xyz = u_xlat0.xyz / _ScreenExtends.wzw;
    u_xlat0.xyz = (-u_xlat0.xyz) + vec3(1.0, 0.5, 0.5);
    u_xlat15 = max(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat1.x = min(abs(u_xlat0.z), abs(u_xlat0.y));
    u_xlat15 = u_xlat15 * u_xlat1.x;
    u_xlat1.x = u_xlat15 * u_xlat15;
    u_xlat6.x = u_xlat1.x * 0.0208350997 + -0.0851330012;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + 0.180141002;
    u_xlat6.x = u_xlat1.x * u_xlat6.x + -0.330299497;
    u_xlat1.x = u_xlat1.x * u_xlat6.x + 0.999866009;
    u_xlat6.x = u_xlat15 * u_xlat1.x;
    u_xlat6.x = u_xlat6.x * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(abs(u_xlat0.z)<abs(u_xlat0.y));
#else
    u_xlatb11 = abs(u_xlat0.z)<abs(u_xlat0.y);
#endif
    u_xlat6.x = u_xlatb11 ? u_xlat6.x : float(0.0);
    u_xlat15 = u_xlat15 * u_xlat1.x + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!((-u_xlat0.z)<u_xlat0.z);
#else
    u_xlatb1 = (-u_xlat0.z)<u_xlat0.z;
#endif
    u_xlat1.x = u_xlatb1 ? -3.14159274 : float(0.0);
    u_xlat15 = u_xlat15 + u_xlat1.x;
    u_xlat1.x = min((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.x<(-u_xlat1.x));
#else
    u_xlatb1 = u_xlat1.x<(-u_xlat1.x);
#endif
    u_xlat6.x = max((-u_xlat0.z), (-u_xlat0.y));
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6.x>=(-u_xlat6.x));
#else
    u_xlatb6 = u_xlat6.x>=(-u_xlat6.x);
#endif
    u_xlatb1 = u_xlatb6 && u_xlatb1;
    u_xlat15 = (u_xlatb1) ? (-u_xlat15) : u_xlat15;
    u_xlat15 = u_xlat15 + 3.14159274;
    u_xlat15 = u_xlat15 * 0.159154937;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(_TimerFillValue>=u_xlat15);
#else
    u_xlatb15 = _TimerFillValue>=u_xlat15;
#endif
    u_xlat15 = u_xlatb15 ? 0.200000003 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(_LimitHit>=0.100000001);
#else
    u_xlatb1 = _LimitHit>=0.100000001;
#endif
    u_xlat16_2.x = (u_xlatb1) ? 0.0 : 0.0399999991;
    u_xlat1.xy = (bool(u_xlatb1)) ? vec2(-0.0, -0.0299999993) : vec2(-0.0399999991, -0.0);
    u_xlat11 = u_xlat0.x + u_xlat16_2.x;
    u_xlat0.x = u_xlat0.x + u_xlat1.x;
    u_xlat5 = dot(u_xlat0.yz, u_xlat0.yz);
    u_xlat5 = sqrt(u_xlat5);
    u_xlat10 = (-u_xlat0.x) + u_xlat11;
    u_xlat0.x = (-u_xlat0.x) + _FillAmt;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat1.x = u_xlat0.x * u_xlat10;
    u_xlat0.x = u_xlat10 * u_xlat0.x + 0.100000001;
    u_xlat0.x = u_xlat1.y + u_xlat0.x;
    u_xlat10 = (-_UnfilledOuterFeather) + _UnfilledOuterThickness;
    u_xlat5 = (-u_xlat10) + u_xlat5;
    u_xlat6.x = _UnfilledOuterFeather + _UnfilledOuterThickness;
    u_xlat10 = (-u_xlat10) + u_xlat6.x;
    u_xlat10 = float(1.0) / u_xlat10;
    u_xlat5 = u_xlat10 * u_xlat5;
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat5 * -2.0 + 3.0;
    u_xlat5 = u_xlat5 * u_xlat5;
    u_xlat5 = u_xlat5 * u_xlat10;
    u_xlat10 = _UnfillOuter + -1.0;
    u_xlat10 = u_xlat5 * u_xlat10 + 1.0;
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat16_2.xyz * _UnfillColor.xyz;
    u_xlat6.xyz = (-u_xlat16_3.xyz) * vec3(u_xlat10) + u_xlat16_2.xyz;
    u_xlat4.xyz = vec3(u_xlat10) * u_xlat16_3.xyz;
    u_xlat6.xyz = u_xlat1.xxx * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat16_2.xyz + (-_EdgeColor.xyz);
    u_xlat10 = u_xlat16_2.w * vs_COLOR0.w;
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz + _EdgeColor.xyz;
    u_xlat4.xyz = u_xlat4.xyz * vec3(_EdgeWeight);
    u_xlat16_3.x = max(_EdgeWeight, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat6.xyz = u_xlat6.xyz * u_xlat16_3.xxx + u_xlat4.xyz;
    u_xlat4.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat6.xyz = vec3(u_xlat5) * u_xlat4.xyz + u_xlat6.xyz;
    SV_Target0.xyz = vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.x = (-_UnfillColor.w) + 1.0;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + _UnfillColor.w;
    SV_Target0.w = min(u_xlat0.x, u_xlat10);
    return;
}

#endif
"
}
}
}
}
Fallback "Diffuse"
}