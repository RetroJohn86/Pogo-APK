//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Halfarc" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_PowerUpColor ("Power Up Color", Color) = (1,1,1,1)
_Progress ("Progress", Range(0, 1)) = 0.5
_Progress2 ("Progress2", Range(0, 1)) = 0.75
_Radius ("Radius", Range(0, 1)) = 0.975
_DotRadius ("Dot Radius", Range(0, 0.1)) = 0.012
_PowerUpDotRadius ("Power Up Dot Radius", Range(0, 0.1)) = 0.009
_Width ("Width", Range(0, 0.1)) = 0.01
_Width2 ("Width Power Up", Range(0, 0.1)) = 0.015
_InnerWidthPowerUp ("Inner Width Power Up", Range(0, 0.1)) = 0.01
_BaseAlpha ("Backgound Alpha", Range(0, 1)) = 0.4
_Feather ("Feather", Range(0, 0.01)) = 0.004
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
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
  GpuProgramID 34580
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb11 = u_xlat11<(-u_xlat11);
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb22 = u_xlat22>=(-u_xlat22);
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
    u_xlatb0.x = u_xlat0.x>=_Progress;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
    u_xlatb22 = _Progress2>=_Progress;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
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
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb11 = u_xlat11<(-u_xlat11);
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb22 = u_xlat22>=(-u_xlat22);
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
    u_xlatb0.x = u_xlat0.x>=_Progress;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
    u_xlatb22 = _Progress2>=_Progress;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
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
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb11 = u_xlat11<(-u_xlat11);
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
    u_xlatb22 = u_xlat22>=(-u_xlat22);
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
    u_xlatb0.x = u_xlat0.x>=_Progress;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
    u_xlatb22 = _Progress2>=_Progress;
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
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
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!((-vs_TEXCOORD0.x)<vs_TEXCOORD0.x);
#else
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
#endif
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11<(-u_xlat11));
#else
    u_xlatb11 = u_xlat11<(-u_xlat11);
#endif
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22>=(-u_xlat22));
#else
    u_xlatb22 = u_xlat22>=(-u_xlat22);
#endif
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=_Progress);
#else
    u_xlatb0.x = u_xlat0.x>=_Progress;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xz = min(max(u_xlat7.xz, 0.0), 1.0);
#else
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_Progress2>=_Progress);
#else
    u_xlatb22 = _Progress2>=_Progress;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
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
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!((-vs_TEXCOORD0.x)<vs_TEXCOORD0.x);
#else
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
#endif
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11<(-u_xlat11));
#else
    u_xlatb11 = u_xlat11<(-u_xlat11);
#endif
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22>=(-u_xlat22));
#else
    u_xlatb22 = u_xlat22>=(-u_xlat22);
#endif
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=_Progress);
#else
    u_xlatb0.x = u_xlat0.x>=_Progress;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xz = min(max(u_xlat7.xz, 0.0), 1.0);
#else
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_Progress2>=_Progress);
#else
    u_xlatb22 = _Progress2>=_Progress;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
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
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.x = in_TEXCOORD0.x + -0.5;
    vs_TEXCOORD0.y = in_TEXCOORD0.y * 0.519999981 + -0.0140000004;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Progress;
uniform 	float _Progress2;
uniform 	float _Radius;
uniform 	float _DotRadius;
uniform 	float _PowerUpDotRadius;
uniform 	float _Width;
uniform 	float _Width2;
uniform 	float _InnerWidthPowerUp;
uniform 	float _BaseAlpha;
uniform 	float _Feather;
uniform 	mediump vec4 _PowerUpColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump vec4 u_xlat16_4;
vec4 u_xlat5;
mediump vec4 u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
vec2 u_xlat8;
vec2 u_xlat9;
float u_xlat10;
float u_xlat11;
bool u_xlatb11;
mediump vec3 u_xlat16_17;
float u_xlat22;
bool u_xlatb22;
mediump vec2 u_xlat16_28;
vec2 u_xlat29;
float u_xlat33;
bool u_xlatb33;
float u_xlat40;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat11 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat11;
    u_xlat11 = u_xlat0.x * u_xlat0.x;
    u_xlat22 = u_xlat11 * 0.0208350997 + -0.0851330012;
    u_xlat22 = u_xlat11 * u_xlat22 + 0.180141002;
    u_xlat22 = u_xlat11 * u_xlat22 + -0.330299497;
    u_xlat11 = u_xlat11 * u_xlat22 + 0.999866009;
    u_xlat22 = u_xlat11 * u_xlat0.x;
    u_xlat22 = u_xlat22 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb33 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat22 = u_xlatb33 ? u_xlat22 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat11 + u_xlat22;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!((-vs_TEXCOORD0.x)<vs_TEXCOORD0.x);
#else
    u_xlatb11 = (-vs_TEXCOORD0.x)<vs_TEXCOORD0.x;
#endif
    u_xlat11 = u_xlatb11 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat11 + u_xlat0.x;
    u_xlat11 = min((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(u_xlat11<(-u_xlat11));
#else
    u_xlatb11 = u_xlat11<(-u_xlat11);
#endif
    u_xlat22 = max((-vs_TEXCOORD0.x), vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(u_xlat22>=(-u_xlat22));
#else
    u_xlatb22 = u_xlat22>=(-u_xlat22);
#endif
    u_xlatb11 = u_xlatb22 && u_xlatb11;
    u_xlat0.x = (u_xlatb11) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.318309873;
    u_xlatb0.yz = greaterThanEqual(vec4(_Progress2, _Progress2, _Progress, _Progress2), u_xlat0.xxxx).yz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=_Progress);
#else
    u_xlatb0.x = u_xlat0.x>=_Progress;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat33 = (-_BaseAlpha) + 1.0;
    u_xlat22 = u_xlat33 * u_xlat0.z + _BaseAlpha;
    u_xlat33 = _Feather * 0.5 + 0.00499999989;
    u_xlat1.x = (-_Feather) * 0.5 + 0.00499999989;
    u_xlat33 = u_xlat33 + (-u_xlat1.x);
    u_xlat1.x = (-u_xlat1.x) + vs_TEXCOORD0.y;
    u_xlat33 = float(1.0) / u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat33 = min(max(u_xlat33, 0.0), 1.0);
#else
    u_xlat33 = clamp(u_xlat33, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat33 * -2.0 + 3.0;
    u_xlat33 = u_xlat33 * u_xlat33;
    u_xlat33 = u_xlat33 * u_xlat1.x;
    u_xlat1.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + (-vec3(_Width, _Width2, _InnerWidthPowerUp));
    u_xlat2.xyz = u_xlat1.zxy + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat1.xyz = u_xlat1.zxy + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.xz = u_xlat2.yz;
    u_xlat4.xyz = vec3(vec3(_Radius, _Radius, _Radius)) + vec3(_Width, _Width2, _InnerWidthPowerUp);
    u_xlat5.xyz = u_xlat4.xyz + vec3(vec3(_Feather, _Feather, _Feather));
    u_xlat4.xyz = u_xlat4.xyz + (-vec3(vec3(_Feather, _Feather, _Feather)));
    u_xlat3.yw = u_xlat5.xy;
    u_xlat2.yw = u_xlat5.zy;
    u_xlat5.xz = u_xlat1.yz;
    u_xlat5.yw = u_xlat4.xy;
    u_xlat1.yw = u_xlat4.zy;
    u_xlat16_3 = u_xlat3 + (-u_xlat5);
    u_xlat16_3 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_3;
    u_xlat4.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat16_5 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat5);
    u_xlat16_4 = u_xlat4.xxxx * vec4(2.0, 2.0, 2.0, 2.0) + (-u_xlat1);
    u_xlat16_1 = (-u_xlat1) + u_xlat2;
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_4;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = u_xlat16_3 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat16_2 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_2 = u_xlat16_2 * u_xlat16_2;
    u_xlat16_6.xy = u_xlat16_2.xz * u_xlat16_3.xz;
    u_xlat16_28.xy = (-u_xlat16_3.yw) * u_xlat16_2.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat7.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat7.x = u_xlat0.y * u_xlat7.x;
    u_xlat22 = u_xlat22 * u_xlat16_6.x;
    u_xlat16_6.x = max(u_xlat7.x, u_xlat22);
    u_xlat7.xy = vec2(_Progress, _Progress2) + vec2(-0.5, -0.5);
    u_xlat7.xy = u_xlat7.xy * vec2(3.14159274, 3.14159274);
    u_xlat8.x = sin(u_xlat7.x);
    u_xlat7.x = cos(u_xlat7.x);
    u_xlat9.x = sin(u_xlat7.y);
    u_xlat10 = cos(u_xlat7.y);
    u_xlat8.y = u_xlat7.x;
    u_xlat22 = _Radius * 0.5;
    u_xlat7.xy = vec2(u_xlat22) * u_xlat8.xy + (-vs_TEXCOORD0.xy);
    u_xlat7.x = dot(u_xlat7.xy, u_xlat7.xy);
    u_xlat7.x = sqrt(u_xlat7.x);
    u_xlat9.y = u_xlat10;
    u_xlat29.xy = vec2(u_xlat22) * u_xlat9.xy + (-vs_TEXCOORD0.xy);
    u_xlat22 = dot(u_xlat29.xy, u_xlat29.xy);
    u_xlat7.y = sqrt(u_xlat22);
    u_xlat22 = (-_Feather) * 0.5 + _DotRadius;
    u_xlat7.xz = (-vec2(u_xlat22)) + u_xlat7.xy;
    u_xlat40 = _Feather * 0.5 + _DotRadius;
    u_xlat22 = (-u_xlat22) + u_xlat40;
    u_xlat22 = float(1.0) / u_xlat22;
    u_xlat7.xz = vec2(u_xlat22) * u_xlat7.xz;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.xz = min(max(u_xlat7.xz, 0.0), 1.0);
#else
    u_xlat7.xz = clamp(u_xlat7.xz, 0.0, 1.0);
#endif
    u_xlat8.xy = u_xlat7.xz * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
    u_xlat7.xz = u_xlat7.xz * u_xlat7.xz;
    u_xlat7.xz = (-u_xlat8.xy) * u_xlat7.xz + vec2(1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb22 = !!(_Progress2>=_Progress);
#else
    u_xlatb22 = _Progress2>=_Progress;
#endif
    u_xlat22 = u_xlatb22 ? 1.0 : float(0.0);
    u_xlat29.x = u_xlat22 * u_xlat7.z;
    u_xlat16_17.x = max(u_xlat29.x, u_xlat7.x);
    SV_Target0.w = max(u_xlat16_17.x, u_xlat16_6.x);
    u_xlat16_2 = u_xlat16_1 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_6.xy = u_xlat16_1.xz * u_xlat16_2.xz;
    u_xlat16_28.xy = (-u_xlat16_2.yw) * u_xlat16_1.yw + vec2(1.0, 1.0);
    u_xlat16_6.xy = min(u_xlat16_28.xy, u_xlat16_6.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_6.y;
    u_xlat16_6.x = u_xlat33 * u_xlat16_6.x;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_6.x = min(u_xlat0.x, u_xlat16_6.x);
    u_xlat16_6.x = (-u_xlat7.x) + u_xlat16_6.x;
    u_xlat0.x = (-_Feather) * 0.5 + _PowerUpDotRadius;
    u_xlat11 = (-u_xlat0.x) + u_xlat7.y;
    u_xlat33 = _Feather * 0.5 + _PowerUpDotRadius;
    u_xlat0.x = (-u_xlat0.x) + u_xlat33;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat11 = u_xlat0.x * -2.0 + 3.0;
    u_xlat0.x = u_xlat0.x * u_xlat0.x;
    u_xlat0.x = (-u_xlat11) * u_xlat0.x + 1.0;
    u_xlat16_6.x = u_xlat0.x * u_xlat22 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.x = min(max(u_xlat16_6.x, 0.0), 1.0);
#else
    u_xlat16_6.x = clamp(u_xlat16_6.x, 0.0, 1.0);
#endif
    u_xlat16_17.xyz = (-vs_COLOR0.xyz) + _PowerUpColor.xyz;
    SV_Target0.xyz = u_xlat16_6.xxx * u_xlat16_17.xyz + vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}