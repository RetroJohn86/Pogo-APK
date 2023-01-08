//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "FX/Animated-Spiral-Additive" {
Properties {
[Header(Blend Mode)] [Spacing(10)] [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend Mode 1", Float) = 2
[Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend Mode 2", Float) = 0
[Space] [Header(Main Texture)] [Spacing(10)] _MainTex ("Main Texture", 2D) = "white" { }
_MainScale ("Main Texture Scale", Vector) = (1,1,1,1)
_TintColor ("Tint Color", Color) = (1,1,1,1)
_PanSpeedX ("Warp X Pan Speed", Float) = 0
_PanSpeedY ("Warp Y Pan Speed", Float) = 0
[Space] [Header(Alpha Mask Texture)] [Spacing(10)] _AlphaTex ("Mask Texture", 2D) = "white" { }
_MaskScale ("Texture Scale", Vector) = (1,1,1,1)
[Space] [Header(Warp Distortion Texture)] [Spacing(10)] _WarpTex ("Warp Texture", 2D) = "bump" { }
_WarpStrength ("Warp Strength", Float) = 1
_WarpScale ("Warp Texture Scale", Vector) = (1,1,1,1)
[Space] [Header(Properties)] [Spacing(10)] _AddPower ("Additive Power", Float) = 1
_RotateSpeed ("Rotate Speed", Float) = 1
_PivotOffset ("Rotation Pivot Offset", Vector) = (0,0,0,1)
_ScaleUVAmount ("UV Scale Amount", Float) = 0
[Space] _Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 5
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 2
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Toggle(SCREENSPACE_ON)] _ScreenSpaceOn ("Screenspace On", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  Lighting On
  GpuProgramID 16055
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
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
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
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
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
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
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
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
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
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
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat6.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat6.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
    u_xlat6.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    u_xlat0.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat0.xy + u_xlat6.xy;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SCREENSPACE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SCREENSPACE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SCREENSPACE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
uniform lowp sampler2D _WarpTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _AlphaTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture2D(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
    u_xlat10_1 = texture2D(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SCREENSPACE_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SCREENSPACE_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SCREENSPACE_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _WarpTex_ST;
uniform 	mediump float _PanSpeedX;
uniform 	mediump float _PanSpeedY;
uniform 	mediump float _RotateSpeed;
uniform 	mediump vec2 _PivotOffset;
uniform 	mediump float _ScaleUVAmount;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec2 u_xlat6;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat6.xy = _Time.xx * vec2(_PanSpeedX, _PanSpeedY);
    u_xlat6.xy = fract(u_xlat6.xy);
    vs_TEXCOORD0.xy = u_xlat6.xy + u_xlat0.xy;
    u_xlat0.x = _Time.y * (-_RotateSpeed);
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2.x = (-u_xlat0.x);
    u_xlat2.y = u_xlat1.x;
    u_xlat2.z = u_xlat0.x;
    u_xlat0.xy = in_TEXCOORD0.xy + (-_PivotOffset.xy);
    u_xlat6.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount));
    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(vec2(_ScaleUVAmount, _ScaleUVAmount)) + _PivotOffset.xy;
    u_xlat7.x = dot(u_xlat2.yx, u_xlat6.xy);
    u_xlat7.y = dot(u_xlat2.zy, u_xlat6.xy);
    u_xlat0.xy = u_xlat7.xy + _PivotOffset.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _WarpTex_ST.xy + _WarpTex_ST.zw;
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
uniform 	mediump float _AddPower;
uniform 	mediump vec2 _MainScale;
uniform 	mediump vec2 _WarpScale;
uniform 	mediump float _WarpStrength;
UNITY_LOCATION(0) uniform mediump sampler2D _WarpTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _AlphaTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat10_1;
vec3 u_xlat3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy * _WarpScale.xy;
    u_xlat10_0.xyz = texture(_WarpTex, u_xlat0.xy).xyz;
    u_xlat0.xw = u_xlat10_0.xy * vec2(vec2(_WarpStrength, _WarpStrength)) + vs_TEXCOORD0.xy;
    u_xlat3.xy = u_xlat10_0.yz * vec2(vec2(_WarpStrength, _WarpStrength));
    u_xlat3.z = u_xlat3.y * 2.0;
    u_xlat0.xy = u_xlat0.xw + (-u_xlat3.zx);
    u_xlat0.xy = u_xlat0.xy * _MainScale.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = vs_COLOR0.wwww * vs_COLOR0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat10_1 = texture(_AlphaTex, vs_TEXCOORD2.xy);
    u_xlat16_1 = u_xlat10_1 * _TintColor;
    u_xlat16_1 = u_xlat16_1 * vec4(vec4(_AddPower, _AddPower, _AddPower, _AddPower));
    SV_Target0 = u_xlat16_0 * u_xlat16_1;
    return;
}

#endif
"
}
}
}
}
Fallback "FX/Additive-Mask"
}