//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/UI-Badge" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_InsetTex ("Inset Texture", 2D) = "black" { }
_DetailTex ("Detail Texture", 2D) = "black" { }
_ColorR ("R Channel Tint", Color) = (1,1,1,1)
_ColorG ("G Channel Tint", Color) = (1,1,1,1)
_ColorB ("B Channel Tint", Color) = (1,1,1,1)
_Interval ("Gap Between Each Repeat", Float) = 0
_Rate ("Show Rate On Each Repeat", Range(0, 1)) = 1
_ShineColorPower ("Shine Color Power", Range(0, 20)) = 0.5
_MetalColorPower ("Metal Color Power", Range(0, 10)) = 0.5
_MetalSaturation ("Metal Saturation", Range(0, 2)) = 1
_RotationSpeed ("Rotation Speed", Float) = 2
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
[Toggle(USE_FRAME_COLOR)] _UseFrameColor ("Use Frame Color", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 50608
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
float u_xlat18;
mediump float u_xlat16_19;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_6.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_0.w = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_1.xyz;
    u_xlat16_1.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_0.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_0.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_0.w = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    u_xlat16_1.w = vs_COLOR0.w * vs_COLOR0.w;
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    SV_Target0.w = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_0.z + -0.00100000005;
    u_xlatb18 = u_xlat16_1.x<0.0;
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat10_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat10_0.xy + u_xlat10_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_0.z + -0.00100000005;
    u_xlatb18 = u_xlat16_1.x<0.0;
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat10_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat10_0.xy + u_xlat10_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat10_0.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_0.z + -0.00100000005;
    u_xlatb18 = u_xlat16_1.x<0.0;
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat10_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat10_0.xy + u_xlat10_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat10_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_0.z + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb18 = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat18>=(-u_xlat18));
#else
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
#endif
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=u_xlat16_1.x);
#else
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_0.z + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb18 = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat18>=(-u_xlat18));
#else
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
#endif
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=u_xlat16_1.x);
#else
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
float u_xlat6;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_19;
void main()
{
    u_xlat16_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_0.z + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb18 = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb18){discard;}
    u_xlat18 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat18 = u_xlat18 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat18>=(-u_xlat18));
#else
    u_xlatb2.x = u_xlat18>=(-u_xlat18);
#endif
    u_xlat18 = fract(abs(u_xlat18));
    u_xlat18 = (u_xlatb2.x) ? u_xlat18 : (-u_xlat18);
    u_xlat18 = u_xlat16_1.x * u_xlat18;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat18>=u_xlat16_1.x);
#else
    u_xlatb18 = u_xlat18>=u_xlat16_1.x;
#endif
    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xy = (-u_xlat16_0.xy) + vec2(1.0, 1.0);
    u_xlat16_3.xy = u_xlat16_3.xy + u_xlat16_3.xy;
    u_xlat16_1.xyz = (-u_xlat16_3.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xz = u_xlat16_0.xy + u_xlat16_0.xy;
    u_xlat16_4.xyz = u_xlat16_3.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb2.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_0.xyxx).xy;
    u_xlat16_3.x = (u_xlatb2.x) ? float(1.0) : float(0.0);
    u_xlat16_3.w = (u_xlatb2.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_3.xxx * u_xlat16_4.xyz + u_xlat16_1.xyz;
    u_xlat2.xyz = log2(u_xlat16_1.xyz);
    u_xlat2.xyz = u_xlat2.xyz * vec3(_MetalColorPower);
    u_xlat2.xyz = exp2(u_xlat2.xyz);
    u_xlat6 = _Time.x * _RotationSpeed;
    u_xlat6 = sin(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat6) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_0.xxx * u_xlat16_1.xyz;
    u_xlat16_19 = u_xlat16_0.z * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_19 * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_3.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_3.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_3.www * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_3.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlatb12 = u_xlat16_5.x<0.0;
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
    u_xlatb2 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat10_6.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlatb12 = u_xlat16_5.x<0.0;
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
    u_xlatb2 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat10_6.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec3 u_xlat10_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlatb12 = u_xlat16_5.x<0.0;
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
    u_xlatb2 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat10_6.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat10_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_0.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb12 = u_xlat16_5.x<0.0;
#endif
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb2 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=u_xlat16_5.x);
#else
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat16_6.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb12 = u_xlat16_5.x<0.0;
#endif
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb2 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=u_xlat16_5.x);
#else
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat16_6.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat16_0.w * vs_COLOR0.w;
    u_xlat16_5.x = u_xlat16_1 * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat16_5.x<0.0);
#else
    u_xlatb12 = u_xlat16_5.x<0.0;
#endif
    if(u_xlatb12){discard;}
    u_xlat12 = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_5.x = _Interval + 1.0;
    u_xlat12 = u_xlat12 / u_xlat16_5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb2 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb2) ? u_xlat12 : (-u_xlat12);
    u_xlat12 = u_xlat16_5.x * u_xlat12;
    u_xlat16_5.x = (-_Rate) + 1.0;
    u_xlat16_5.x = u_xlat16_5.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=u_xlat16_5.x);
#else
    u_xlatb12 = u_xlat12>=u_xlat16_5.x;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat2.x = _Time.x * _RotationSpeed;
    u_xlat2.x = sin(u_xlat2.x);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat16_6.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat2.xxx * u_xlat16_6.xyz;
    u_xlat16_5.xyz = log2(u_xlat2.xyz);
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_5.xyz = exp2(u_xlat16_5.xyz);
    u_xlat2.xyz = u_xlat16_5.xyz * vec3(u_xlat12) + vec3(1.0, 1.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat16_5.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_0.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_3.xyz;
    u_xlat16_0.w = vs_COLOR0.w;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
    SV_Target0.w = u_xlat16_1 * u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat10_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec2 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bvec2 u_xlatb4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
bool u_xlatb6;
float u_xlat12;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb6 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb6) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb4.xy = greaterThanEqual(vec4(0.5, 0.5, 0.0, 0.0), u_xlat16_6.xyxx).xy;
    u_xlat16_2.x = (u_xlatb4.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb4.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat4.xxx);
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + u_xlat4.xxx;
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlatb4.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat4.x = u_xlatb4.x ? float(1.0) : 0.0;
    u_xlat4.y = u_xlatb4.y ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.xy * u_xlat4.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_18 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_18 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_2.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_18 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_3.xyz = u_xlat10_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_18 = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_18 = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_2.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_2.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_18 = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_18 = u_xlat16_18 * vs_COLOR0.w;
    u_xlat16_4.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_3.xyz = (-u_xlat16_3.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_3.xyz = u_xlat16_0.www * u_xlat16_3.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vs_COLOR0.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_18;
    u_xlat16_3.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_3.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_1.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat10_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_1.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat10_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
lowp vec3 u_xlat10_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_6.xyz = texture2D(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat10_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat10_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_1.x<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat10_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat10_6.xy + u_xlat10_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat10_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat10_5.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat10_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat10_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat10_1 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat10_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0.x = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat16_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0.x = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat16_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump vec3 _ColorG;
uniform 	mediump vec3 _ColorB;
uniform 	mediump float _ShineColorPower;
uniform 	float _MetalColorPower;
uniform 	float _MetalSaturation;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform 	vec3 INTENSITY_DOT;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_7;
float u_xlat12;
bvec2 u_xlatb12;
float u_xlat18;
bool u_xlatb18;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.xyz = texture(_MainTex, vs_TEXCOORD0.xy).yzw;
    u_xlat16_1.x = u_xlat16_6.z * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_6.z;
    u_xlat16_7 = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_7 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_1.x<0.0);
#else
    u_xlatb0.x = u_xlat16_1.x<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb18 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb18) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat16_1.xyz = (-_ColorG.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xy = (-u_xlat16_6.xy) + vec2(1.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.xy + u_xlat16_2.xy;
    u_xlat16_1.xyz = (-u_xlat16_2.xxx) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xz = u_xlat16_6.xy + u_xlat16_6.xy;
    u_xlat16_3.xyz = u_xlat16_2.xxx * _ColorG.xyz + (-u_xlat16_1.xyz);
    u_xlatb12.xy = greaterThanEqual(vec4(0.5, 0.5, 0.5, 0.5), u_xlat16_6.xyxy).xy;
    u_xlat16_2.x = (u_xlatb12.x) ? float(1.0) : float(0.0);
    u_xlat16_2.w = (u_xlatb12.y) ? float(1.0) : float(0.0);
    u_xlat16_1.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat4.xyz = log2(u_xlat16_1.xyz);
    u_xlat4.xyz = u_xlat4.xyz * vec3(_MetalColorPower);
    u_xlat4.xyz = exp2(u_xlat4.xyz);
    u_xlat12 = _Time.x * _RotationSpeed;
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat16_5.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = vec3(u_xlat12) * u_xlat16_5.xyz;
    u_xlat16_1.xyz = log2(u_xlat5.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_6.xxx * u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat16_1.xyz * u_xlat0.xxx + u_xlat4.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(INTENSITY_DOT.x, INTENSITY_DOT.y, INTENSITY_DOT.z));
    u_xlat0.xyz = (-vec3(u_xlat18)) + u_xlat0.xyz;
    u_xlat0.xyz = vec3(vec3(_MetalSaturation, _MetalSaturation, _MetalSaturation)) * u_xlat0.xyz + vec3(u_xlat18);
    u_xlat16_1.xyz = (-_ColorB.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_2.yyy) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat16_2.zzz * _ColorB.xyz + (-u_xlat16_1.xyz);
    u_xlat16_1.xyz = u_xlat16_2.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat16_2.xyz = u_xlat16_1.www * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_7<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_3.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_7<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_3.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _InsetTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bvec4 u_xlatb0;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
    u_xlatb0.x = u_xlat16_7<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat10_3.xyz = texture2D(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat10_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat10_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat10_0 = texture2D(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat10_0.xyz;
    u_xlat16_2.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_FRAME_COLOR" }
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _InsetTex_ST;
uniform 	float _RotationSpeed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat7;
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
    u_xlat0.x = _Time.x * _RotationSpeed;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat3.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat7.y = dot(u_xlat2.zy, u_xlat3.xy);
    u_xlat7.x = dot(u_xlat2.yx, u_xlat3.xy);
    vs_TEXCOORD2.xy = u_xlat7.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD1 = in_POSITION0;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _InsetTex_ST.xy + _InsetTex_ST.zw;
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
uniform 	mediump float _ShineColorPower;
uniform 	mediump float _Rate;
uniform 	mediump float _Interval;
uniform 	vec4 _ClipRect;
uniform 	float _RotationSpeed;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
UNITY_LOCATION(2) uniform mediump sampler2D _InsetTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.x = u_xlat16_1.w * vs_COLOR0.w;
    u_xlat16_2.x = u_xlat16_2.x * vs_COLOR0.w;
    u_xlat16_7 = u_xlat16_2.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_2.x * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = floor(abs(vs_TEXCOORD2.x));
    u_xlat16_2.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb5 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb5) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_2.x * u_xlat0.x;
    u_xlat16_2.x = (-_Rate) + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=u_xlat16_2.x);
#else
    u_xlatb0.x = u_xlat0.x>=u_xlat16_2.x;
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat5.x = _Time.x * _RotationSpeed;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.xyz = texture(_DetailTex, vs_TEXCOORD2.xy).xyz;
    u_xlat5.xyz = u_xlat5.xxx * u_xlat16_3.xyz;
    u_xlat16_2.xyz = log2(u_xlat5.xyz);
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(vec3(_ShineColorPower, _ShineColorPower, _ShineColorPower));
    u_xlat16_2.xyz = exp2(u_xlat16_2.xyz);
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat0.xxx + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_4.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    u_xlat16_0 = texture(_InsetTex, vs_TEXCOORD3.xy);
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vs_COLOR0.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_4.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}