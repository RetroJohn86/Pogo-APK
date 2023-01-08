//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Raid/Icon" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_AnglePerPip ("Angle Per Pip (dgr)", Float) = 27.5
_MaxPips ("Max Pip Count", Float) = 1
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_RendererColor ("RendererColor", Color) = (1,1,1,1)
_Flip ("Flip", Vector) = (1,1,1,1)
_AlphaTex ("External Alpha", 2D) = "white" { }
_EnableExternalAlpha ("Enable External Alpha", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 47261
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

int op_shl(int a, int b) { return int(floor(float(a) * pow(2.0, float(b)))); }
ivec2 op_shl(ivec2 a, ivec2 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); return a; }
ivec3 op_shl(ivec3 a, ivec3 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); return a; }
ivec4 op_shl(ivec4 a, ivec4 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); a.w = op_shl(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb12 = u_xlat12<(-u_xlat12);
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlatb4 = u_xlat1>=(-u_xlat1);
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
    u_xlatb1 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
    u_xlatb12 = u_xlat12>=0.0500000007;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = op_shl(u_xlati12, 1);
    u_xlati1 = int((0.0<u_xlat4.x) ? -1 : 0);
    u_xlati5 = int((u_xlat4.x<0.0) ? -1 : 0);
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
    u_xlatb1 = u_xlat12>=(-u_xlat8);
    u_xlat8 = u_xlat8 + -1.0;
    u_xlatb0.z = u_xlat8>=u_xlat12;
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb1 = u_xlat0.x>=0.25;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb5 = 0.349999994>=u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat10_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat10_1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

int op_shl(int a, int b) { return int(floor(float(a) * pow(2.0, float(b)))); }
ivec2 op_shl(ivec2 a, ivec2 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); return a; }
ivec3 op_shl(ivec3 a, ivec3 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); return a; }
ivec4 op_shl(ivec4 a, ivec4 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); a.w = op_shl(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb12 = u_xlat12<(-u_xlat12);
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlatb4 = u_xlat1>=(-u_xlat1);
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
    u_xlatb1 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
    u_xlatb12 = u_xlat12>=0.0500000007;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = op_shl(u_xlati12, 1);
    u_xlati1 = int((0.0<u_xlat4.x) ? -1 : 0);
    u_xlati5 = int((u_xlat4.x<0.0) ? -1 : 0);
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
    u_xlatb1 = u_xlat12>=(-u_xlat8);
    u_xlat8 = u_xlat8 + -1.0;
    u_xlatb0.z = u_xlat8>=u_xlat12;
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb1 = u_xlat0.x>=0.25;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb5 = 0.349999994>=u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat10_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat10_1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
lowp vec4 u_xlat10_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

int op_shl(int a, int b) { return int(floor(float(a) * pow(2.0, float(b)))); }
ivec2 op_shl(ivec2 a, ivec2 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); return a; }
ivec3 op_shl(ivec3 a, ivec3 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); return a; }
ivec4 op_shl(ivec4 a, ivec4 b) { a.x = op_shl(a.x, b.x); a.y = op_shl(a.y, b.y); a.z = op_shl(a.z, b.z); a.w = op_shl(a.w, b.w); return a; }

void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
    u_xlatb12 = u_xlat12<(-u_xlat12);
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlatb4 = u_xlat1>=(-u_xlat1);
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
    u_xlatb1 = u_xlat12>=(-u_xlat12);
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
    u_xlatb12 = u_xlat12>=0.0500000007;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = op_shl(u_xlati12, 1);
    u_xlati1 = int((0.0<u_xlat4.x) ? -1 : 0);
    u_xlati5 = int((u_xlat4.x<0.0) ? -1 : 0);
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
    u_xlatb1 = u_xlat12>=(-u_xlat8);
    u_xlat8 = u_xlat8 + -1.0;
    u_xlatb0.z = u_xlat8>=u_xlat12;
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb1 = u_xlat0.x>=0.25;
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
    u_xlatb5 = 0.349999994>=u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat10_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat10_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat10_1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb4 = u_xlat1>=(-u_xlat1);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=0.0500000007);
#else
    u_xlatb12 = u_xlat12>=0.0500000007;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = int(u_xlati12 << 1);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati1 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat8));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat8);
#endif
    u_xlat8 = u_xlat8 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8>=u_xlat12);
#else
    u_xlatb0.z = u_xlat8>=u_xlat12;
#endif
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat16_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb4 = u_xlat1>=(-u_xlat1);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=0.0500000007);
#else
    u_xlatb12 = u_xlat12>=0.0500000007;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = int(u_xlati12 << 1);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati1 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat8));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat8);
#endif
    u_xlat8 = u_xlat8 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8>=u_xlat12);
#else
    u_xlatb0.z = u_xlat8>=u_xlat12;
#endif
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat16_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat16_1;
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
uniform 	mediump vec4 _RendererColor;
uniform 	mediump vec4 _Color;
uniform 	float _AnglePerPip;
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
    u_xlat0.xyz = in_COLOR0.xyz * _Color.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _RendererColor.xyz;
    u_xlat0.w = in_COLOR0.w;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.x = _AnglePerPip * 0.0174532942;
    vs_TEXCOORD1.yzw = vec3(0.0, 0.0, 0.0);
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
uniform 	int _MaxPips;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bvec3 u_xlatb0;
float u_xlat1;
mediump vec4 u_xlat16_1;
int u_xlati1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
int u_xlati5;
bool u_xlatb5;
float u_xlat8;
float u_xlat12;
int u_xlati12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat8 = max(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = float(1.0) / u_xlat8;
    u_xlat12 = min(abs(u_xlat0.y), abs(u_xlat0.x));
    u_xlat8 = u_xlat8 * u_xlat12;
    u_xlat12 = u_xlat8 * u_xlat8;
    u_xlat1 = u_xlat12 * 0.0208350997 + -0.0851330012;
    u_xlat1 = u_xlat12 * u_xlat1 + 0.180141002;
    u_xlat1 = u_xlat12 * u_xlat1 + -0.330299497;
    u_xlat12 = u_xlat12 * u_xlat1 + 0.999866009;
    u_xlat1 = u_xlat12 * u_xlat8;
    u_xlat1 = u_xlat1 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(abs(u_xlat0.y)<abs(u_xlat0.x));
#else
    u_xlatb5 = abs(u_xlat0.y)<abs(u_xlat0.x);
#endif
    u_xlat1 = u_xlatb5 ? u_xlat1 : float(0.0);
    u_xlat8 = u_xlat8 * u_xlat12 + u_xlat1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!((-u_xlat0.y)<u_xlat0.y);
#else
    u_xlatb12 = (-u_xlat0.y)<u_xlat0.y;
#endif
    u_xlat12 = u_xlatb12 ? -3.14159274 : float(0.0);
    u_xlat8 = u_xlat12 + u_xlat8;
    u_xlat12 = min((-u_xlat0.y), u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12<(-u_xlat12));
#else
    u_xlatb12 = u_xlat12<(-u_xlat12);
#endif
    u_xlat1 = max((-u_xlat0.y), u_xlat0.x);
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat1>=(-u_xlat1));
#else
    u_xlatb4 = u_xlat1>=(-u_xlat1);
#endif
    u_xlatb4 = u_xlatb4 && u_xlatb12;
    u_xlat4.x = (u_xlatb4) ? (-u_xlat8) : u_xlat8;
    u_xlat8 = float(_MaxPips);
    u_xlat8 = u_xlat8 + 0.100000001;
    u_xlat8 = u_xlat8 * vs_COLOR0.w;
    u_xlat8 = floor(u_xlat8);
    u_xlat12 = u_xlat8 * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat12));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat12);
#endif
    u_xlat12 = fract(abs(u_xlat12));
    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat12>=0.0500000007);
#else
    u_xlatb12 = u_xlat12>=0.0500000007;
#endif
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat1 = vs_TEXCOORD1.x * 0.5;
    u_xlat4.x = (-u_xlat1) * u_xlat12 + u_xlat4.x;
    u_xlat4.x = u_xlat4.x / vs_TEXCOORD1.x;
    u_xlat12 = trunc(u_xlat4.x);
    u_xlat4.x = (-u_xlat12) + u_xlat4.x;
    u_xlati12 = int(u_xlat12);
    u_xlati12 = int(u_xlati12 << 1);
#ifdef UNITY_ADRENO_ES3
    { bool cond = 0.0<u_xlat4.x; u_xlati1 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati1 = int((0.0<u_xlat4.x) ? 0xFFFFFFFFu : uint(0));
#endif
#ifdef UNITY_ADRENO_ES3
    { bool cond = u_xlat4.x<0.0; u_xlati5 = int(!!cond ? 0xFFFFFFFFu : uint(0)); }
#else
    u_xlati5 = int((u_xlat4.x<0.0) ? 0xFFFFFFFFu : uint(0));
#endif
    u_xlat4.x = abs(u_xlat4.x) + -0.5;
    u_xlati1 = (-u_xlati1) + u_xlati5;
    u_xlati12 = u_xlati12 + u_xlati1;
    u_xlat12 = float(u_xlati12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat12>=(-u_xlat8));
#else
    u_xlatb1 = u_xlat12>=(-u_xlat8);
#endif
    u_xlat8 = u_xlat8 + -1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.z = !!(u_xlat8>=u_xlat12);
#else
    u_xlatb0.z = u_xlat8>=u_xlat12;
#endif
    u_xlat12 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat0.x>=0.25);
#else
    u_xlatb1 = u_xlat0.x>=0.25;
#endif
    u_xlat1 = u_xlatb1 ? 1.0 : float(0.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.349999994>=u_xlat0.x);
#else
    u_xlatb5 = 0.349999994>=u_xlat0.x;
#endif
    u_xlat0.x = u_xlat0.x * 2.0 + -0.5;
    u_xlat0.x = u_xlat0.x * 1.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=abs(u_xlat4.x));
#else
    u_xlatb0.x = u_xlat0.x>=abs(u_xlat4.x);
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
;
    u_xlat4.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat4.x * u_xlat1;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.x = u_xlat0.z * u_xlat0.x;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    u_xlat16_3.xyz = u_xlat16_1.www * u_xlat16_2.xyz;
    u_xlat4.xyz = (-u_xlat16_2.xyz) * u_xlat16_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xxx * u_xlat4.xyz + u_xlat16_3.xyz;
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
}
}
}
}