//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/Flipbook" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Columns ("Columns", Float) = 1
_Rows ("Rows", Float) = 1
_FPS ("Frames Per Second", Float) = 30
[Header(UI COMPONENTS)] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
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
  GpuProgramID 43430
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlat0 = u_xlat0 * vs_COLOR0;
    SV_Target0 = u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat16_2<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat16_2<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	int _Columns;
uniform 	int _Rows;
uniform 	int _FPS;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
int u_xlatu0;
vec4 u_xlat1;
int u_xlatu1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
int u_xlati4;
int u_xlatu4;
int u_xlatu7;
mediump float u_xlat16_8;
float u_xlat9;
int u_xlati9;
vec4 null;
const int BITWISE_BIT_COUNT = 32;
int op_modi(int x, int y) { return x - y * (x / y); }
ivec2 op_modi(ivec2 a, ivec2 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); return a; }
ivec3 op_modi(ivec3 a, ivec3 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); return a; }
ivec4 op_modi(ivec4 a, ivec4 b) { a.x = op_modi(a.x, b.x); a.y = op_modi(a.y, b.y); a.z = op_modi(a.z, b.z); a.w = op_modi(a.w, b.w); return a; }

int op_and(int a, int b) { int result = 0; int n = 1; for (int i = 0; i < BITWISE_BIT_COUNT; i++) { if ((op_modi(a, 2) != 0) && (op_modi(b, 2) != 0)) { result += n; } a = a / 2; b = b / 2; n = n * 2; if (!(a > 0 && b > 0)) { break; } } return result; }
ivec2 op_and(ivec2 a, ivec2 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); return a; }
ivec3 op_and(ivec3 a, ivec3 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); return a; }
ivec4 op_and(ivec4 a, ivec4 b) { a.x = op_and(a.x, b.x); a.y = op_and(a.y, b.y); a.z = op_and(a.z, b.z); a.w = op_and(a.w, b.w); return a; }

int op_xor(int a, int b) { return (a + b - 2 * op_and(a, b)); }
ivec2 op_xor(ivec2 a, ivec2 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); return a; }
ivec3 op_xor(ivec3 a, ivec3 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); return a; }
ivec4 op_xor(ivec4 a, ivec4 b) { a.x = op_xor(a.x, b.x); a.y = op_xor(a.y, b.y); a.z = op_xor(a.z, b.z); a.w = op_xor(a.w, b.w); return a; }

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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlati0 = _Rows * _Columns;
    u_xlatu0 =  int(max(float(u_xlati0), (-float(u_xlati0))));
    u_xlat3.xyz = vec3(ivec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlati9 = int(u_xlat9);
    u_xlatu1 =  int(max(float(u_xlati9), (-float(u_xlati9))));
    u_xlati9 = op_and(u_xlati9, -2147483648);
    null = vec4(int(u_xlatu1) / int(u_xlatu0));
    null = vec4(op_modi(int(u_xlatu0), int(u_xlatu1)));
    u_xlatu4 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu4) : int(u_xlatu0);
    u_xlati4 = op_xor(int(u_xlatu0), _Columns);
    u_xlatu0 =  int(max(float(u_xlatu0), (-float(u_xlatu0))));
    u_xlati4 = op_and(u_xlati4, -2147483648);
    u_xlatu7 =  int(max(float(_Columns), (-float(_Columns))));
    u_xlatu0 =  int(op_modi(int(null.x), int(u_xlatu0)));
    u_xlatu0 = int(u_xlatu0) / int(u_xlatu7);
    null = vec4(int(u_xlatu1) / int(u_xlatu7));
    null = vec4(op_modi(int(u_xlatu1), int(u_xlatu1)));
    u_xlatu7 =  int(0 - int(u_xlatu0));
    u_xlatu0 = (u_xlati4 != 0) ? int(u_xlatu7) : int(u_xlatu0);
    u_xlat0.x = float(int(u_xlatu0));
    u_xlat16_2.y = u_xlat0.x * (-u_xlat3.y);
    u_xlatu0 =  int(0 - int(u_xlatu1));
    u_xlatu0 = (u_xlati9 != 0) ? int(u_xlatu0) : int(u_xlatu1);
    u_xlat16_8 = float(int(u_xlatu0));
    u_xlat16_2.x = u_xlat3.x * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat10_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
    u_xlatb0.x = u_xlat16_2<0.0;
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
uniform 	uint _Columns;
uniform 	uint _Rows;
uniform 	uint _FPS;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
uint u_xlatu0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_8;
float u_xlat9;
uint u_xlatu9;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlatu0 = _Rows * _Columns;
    u_xlat3.xyz = vec3(uvec3(_Columns, _Rows, _FPS));
    u_xlat9 = u_xlat3.z * _Time.y;
    u_xlat3.xy = vec2(1.0, 1.0) / u_xlat3.xy;
    u_xlatu9 = uint(u_xlat9);
    //null = uintBitsToFloat(u_xlatu9 / u_xlatu0);
    u_xlatu0 = u_xlatu9 % u_xlatu0;
    //null = uintBitsToFloat(u_xlatu9 / _Columns);
    u_xlatu9 = u_xlatu9 % _Columns;
    u_xlat16_2.x = float(u_xlatu9);
    u_xlat16_2.x = u_xlat3.x * u_xlat16_2.x;
    //null = uintBitsToFloat(u_xlatu0 % _Columns);
    u_xlatu0 = u_xlatu0 / _Columns;
    u_xlat16_8 = float(u_xlatu0);
    u_xlat16_2.y = (-u_xlat3.y) * u_xlat16_8;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * u_xlat3.xy + u_xlat16_2.xy;
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
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
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
    u_xlat1 = u_xlat16_1 + _TextureSampleAdd;
    u_xlat1 = u_xlat1 * vs_COLOR0;
    u_xlat16_2 = u_xlat1.w * u_xlat0.x + -0.00100000005;
    u_xlat1.w = u_xlat0.x * u_xlat1.w;
    SV_Target0 = u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_2<0.0);
#else
    u_xlatb0.x = u_xlat16_2<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
}
}
}
}