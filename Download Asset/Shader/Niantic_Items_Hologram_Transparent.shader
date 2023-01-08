//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Items/Hologram_Transparent" {
Properties {
[Header(Place this material on any item texture)] [Space(10)] _Color ("Tint Color", Color) = (1,1,1,1)
_MainTex ("Item (Main Texture)", 2D) = "white" { }
_Background ("Background", 2D) = "white" { }
[Header(Active Hologram)] [Space(10)] _ScanColor ("Scan Line Color", Color) = (0.29411766,0.6509804,0.7137255,0.3647059)
_ActiveBackgroundOpacity ("Background Opacity", Range(0, 2)) = 1
_ActiveItemSaturation ("Item Saturation", Range(0, 1)) = 1
_ScanFrequency ("Scan Line Frequency", Float) = 1.5
_ScanSpeed ("Scan Line Speed", Float) = 100
_ScanMin ("Scan Strength (Minimum)", Float) = 0.5
_ScanMax ("Scan Strength (Maximum)", Float) = 1
_RandomOffset ("Random Offset (set by code per instance)", Vector) = (1,2,1,0)
_FlickerOffsetTime ("Flicker Offset Time", Float) = 20
_FlickerSpeed ("Flicker Speed", Float) = 1
_PhaseSpeed ("Phase Speed", Float) = 1
_PhaseEndBias ("Phase End Bias", Float) = 1
_PhaseInBias ("Phase In Bias", Range(0, 1)) = 0.1
[Header(Static Hologram)] [Space(10)] [Toggle] _StaticLines ("Static Lines", Float) = 0
_StaticScanColor ("Static Scan Line Color", Color) = (1,1,1,1)
_LargeScanLineColor ("Large Scan Line Color", Color) = (1,1,1,1)
_StaticScanFrequency ("Static Scan Line Frequency", Float) = 1.5
_BackgroundOpacity ("Background Opacity", Range(0, 2)) = 1
_ItemOpacity ("Item Opacity", Range(0, 2)) = 1
_ItemSaturation ("Item Saturation", Range(0, 1)) = 1
_ItemLighten ("Item Lighten", Range(0, 1)) = 0
_AllLighten ("Overall Lighten", Range(0, 1)) = 0
_LargeScanOpacity ("Large Scan Opacity", Range(0, 1)) = 1
_UseRampTex ("Use Ramp Tex", Float) = 0
}
SubShader {
 Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "DisableBatching" = "true" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 21554
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = unity_roundEven(u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb4 = _StaticLines==1.0;
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Background;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlatb3 = _StaticLines==1.0;
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat10_0.www) + u_xlat10_0.xyz;
        u_xlat16_5.w = (-u_xlat10_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat10_0.wwww * u_xlat16_5 + u_xlat10_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat10_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat10_0.w;
        u_xlat16_11.xyz = u_xlat10_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat10_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat10_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat10_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat10_1.xyz;
        u_xlat16_6.w = u_xlat10_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat10_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat10_0.w * u_xlat16_2.x + u_xlat10_0.w;
        u_xlat16_3 = u_xlat10_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat10_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat10_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat16_1.w = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = unity_roundEven(u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb4 = _StaticLines==1.0;
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Background;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlatb3 = _StaticLines==1.0;
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat10_0.www) + u_xlat10_0.xyz;
        u_xlat16_5.w = (-u_xlat10_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat10_0.wwww * u_xlat16_5 + u_xlat10_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat10_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat10_0.w;
        u_xlat16_11.xyz = u_xlat10_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat10_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat10_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat10_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat10_1.xyz;
        u_xlat16_6.w = u_xlat10_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat10_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat10_0.w * u_xlat16_2.x + u_xlat10_0.w;
        u_xlat16_3 = u_xlat10_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat10_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat10_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat16_1.w = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat0.x = unity_roundEven(u_xlat0.x);
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb4 = _StaticLines==1.0;
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Background;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
float unity_roundEven(float x) { float y = floor(x + 0.5); return (y - x == 0.5) ? floor(0.5*y) * 2.0 : y; }
vec2 unity_roundEven(vec2 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); return a; }
vec3 unity_roundEven(vec3 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); return a; }
vec4 unity_roundEven(vec4 a) { a.x = unity_roundEven(a.x); a.y = unity_roundEven(a.y); a.z = unity_roundEven(a.z); a.w = unity_roundEven(a.w); return a; }

void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1 = texture2D(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat10_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlatb3 = _StaticLines==1.0;
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = unity_roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat10_0.www) + u_xlat10_0.xyz;
        u_xlat16_5.w = (-u_xlat10_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat10_0.wwww * u_xlat16_5 + u_xlat10_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat10_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat10_0.w;
        u_xlat16_11.xyz = u_xlat10_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat10_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat10_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat10_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat10_0.www * u_xlat16_5.xyz + u_xlat10_1.xyz;
        u_xlat16_6.w = u_xlat10_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat10_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat10_0.w * u_xlat16_2.x + u_xlat10_0.w;
        u_xlat16_3 = u_xlat10_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat10_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat10_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat10_0.www * u_xlat16_2.xyz + u_xlat10_1.xyz;
        u_xlat16_1.w = u_xlat10_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = roundEven(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_StaticLines==1.0);
#else
    u_xlatb4 = _StaticLines==1.0;
#endif
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Background;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_StaticLines==1.0);
#else
    u_xlatb3 = _StaticLines==1.0;
#endif
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat16_0.www) + u_xlat16_0.xyz;
        u_xlat16_5.w = (-u_xlat16_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat16_0.wwww * u_xlat16_5 + u_xlat16_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat16_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat16_0.w;
        u_xlat16_11.xyz = u_xlat16_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat16_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat16_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat16_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
        u_xlat16_6.w = u_xlat16_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat16_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x + u_xlat16_0.w;
        u_xlat16_3 = u_xlat16_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat16_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat16_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
        u_xlat16_1.w = u_xlat16_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = roundEven(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_StaticLines==1.0);
#else
    u_xlatb4 = _StaticLines==1.0;
#endif
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Background;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_StaticLines==1.0);
#else
    u_xlatb3 = _StaticLines==1.0;
#endif
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat16_0.www) + u_xlat16_0.xyz;
        u_xlat16_5.w = (-u_xlat16_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat16_0.wwww * u_xlat16_5 + u_xlat16_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat16_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat16_0.w;
        u_xlat16_11.xyz = u_xlat16_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat16_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat16_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat16_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
        u_xlat16_6.w = u_xlat16_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat16_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x + u_xlat16_0.w;
        u_xlat16_3 = u_xlat16_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat16_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat16_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
        u_xlat16_1.w = u_xlat16_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _RandomOffset;
uniform 	mediump float _FlickerSpeed;
uniform 	mediump float _PhaseSpeed;
uniform 	mediump float _PhaseEndBias;
uniform 	mediump float _StaticLines;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y + _RandomOffset.y;
    u_xlat0.x = u_xlat0.x * _FlickerSpeed;
    u_xlat0.x = u_xlat0.x * _PhaseSpeed;
    u_xlat2 = u_xlat0.x * 3.4000001;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat2 = cos(u_xlat2);
    u_xlat2 = u_xlat2 * _PhaseEndBias;
    u_xlat0.x = u_xlat0.x * _PhaseEndBias + u_xlat2;
    u_xlat0.x = u_xlat0.x + _PhaseEndBias;
    u_xlat2 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat0.x = roundEven(u_xlat0.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(_StaticLines==1.0);
#else
    u_xlatb4 = _StaticLines==1.0;
#endif
    vs_TEXCOORD1 = (u_xlatb4) ? u_xlat0.x : u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _ScanColor;
uniform 	mediump float _ActiveBackgroundOpacity;
uniform 	mediump float _ActiveItemSaturation;
uniform 	mediump float _ScanFrequency;
uniform 	mediump float _ScanSpeed;
uniform 	mediump float _ScanMax;
uniform 	mediump float _StaticLines;
uniform 	mediump vec4 _StaticScanColor;
uniform 	mediump vec4 _LargeScanLineColor;
uniform 	mediump float _StaticScanFrequency;
uniform 	mediump float _BackgroundOpacity;
uniform 	mediump float _ItemOpacity;
uniform 	mediump float _ItemSaturation;
uniform 	mediump float _ItemLighten;
uniform 	mediump float _AllLighten;
uniform 	mediump float _LargeScanOpacity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Background;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
mediump vec4 u_xlat16_3;
bool u_xlatb3;
float u_xlat4;
mediump vec4 u_xlat16_4;
mediump vec4 u_xlat16_5;
mediump vec4 u_xlat16_6;
mediump vec4 u_xlat16_7;
float u_xlat8;
mediump vec3 u_xlat16_11;
void main()
{
vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = texture(_Background, vs_TEXCOORD0.xy);
    u_xlat16_2.x = dot(u_xlat16_0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(_StaticLines==1.0);
#else
    u_xlatb3 = _StaticLines==1.0;
#endif
    if(u_xlatb3){
        u_xlat3.xy = _Time.xx * vec2(45.0, 15.0);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0399999991 + (-u_xlat3.x);
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = hlslcc_FragCoord.y * 0.0133333337 + u_xlat3.x;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = fract(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = hlslcc_FragCoord.y * -0.00400000019 + u_xlat3.y;
        u_xlat3.x = sin(u_xlat3.x);
        u_xlat3.x = roundEven(u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + (-u_xlat3.x);
        u_xlat16_11.x = u_xlat16_11.x + 1.0;
        u_xlat16_11.x = min(u_xlat16_11.x, 1.0);
        u_xlat3.x = max(u_xlat16_11.x, vs_TEXCOORD1);
        u_xlat3.x = min(u_xlat3.x, 5.0);
        u_xlat16_3 = u_xlat3.xxxx * (-_LargeScanLineColor) + _LargeScanLineColor;
        u_xlat4 = hlslcc_FragCoord.y * _StaticScanFrequency;
        u_xlat4 = sin(u_xlat4);
        u_xlat4 = max(u_xlat4, 0.0);
        u_xlat16_5.xyz = (-u_xlat16_0.www) + u_xlat16_0.xyz;
        u_xlat16_5.w = (-u_xlat16_0.w) + _ItemOpacity;
        u_xlat16_5 = u_xlat16_0.wwww * u_xlat16_5 + u_xlat16_0.wwww;
        u_xlat16_6.xyz = (-u_xlat16_2.xxx);
        u_xlat16_6.w = (-u_xlat16_0.w);
        u_xlat16_5 = u_xlat16_5 + u_xlat16_6;
        u_xlat16_6.xyz = vec3(vec3(_ItemSaturation, _ItemSaturation, _ItemSaturation)) * u_xlat16_5.xyz + u_xlat16_2.xxx;
        u_xlat16_6.w = _ItemSaturation * u_xlat16_5.w + u_xlat16_0.w;
        u_xlat16_11.xyz = u_xlat16_0.xyz + _Color.xyz;
        u_xlat16_5.x = _Color.w + _ItemOpacity;
        u_xlat16_7.xyz = vec3(_ItemLighten) * u_xlat16_11.xyz + u_xlat16_0.xyz;
        u_xlat16_7.w = _ItemLighten * u_xlat16_5.x + _ItemOpacity;
        u_xlat16_11.x = u_xlat16_1.w * _BackgroundOpacity;
        u_xlat16_5.xyz = (-u_xlat16_1.xyz);
        u_xlat16_5.w = (-u_xlat16_11.x);
        u_xlat16_5 = u_xlat16_7 * u_xlat16_6 + u_xlat16_5;
        u_xlat16_6.xyz = u_xlat16_0.www * u_xlat16_5.xyz + u_xlat16_1.xyz;
        u_xlat16_6.w = u_xlat16_0.w * u_xlat16_5.w + u_xlat16_11.x;
        u_xlat16_5 = vec4(u_xlat4) * _StaticScanColor;
        u_xlat16_7 = max(u_xlat16_5, _StaticScanColor.wwww);
        u_xlat16_4 = (-_StaticScanColor) * vec4(u_xlat4) + u_xlat16_6;
        u_xlat16_4 = u_xlat16_7 * u_xlat16_4 + u_xlat16_5;
        u_xlat16_4 = _Color * vec4(vec4(_AllLighten, _AllLighten, _AllLighten, _AllLighten)) + u_xlat16_4;
        u_xlat16_5 = _Color * vec4(vec4(_LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity, _LargeScanOpacity));
        SV_Target0 = u_xlat16_3 * u_xlat16_5 + u_xlat16_4;
        return;
    } else {
        u_xlat8 = _Time.x * _ScanSpeed;
        u_xlat8 = hlslcc_FragCoord.y * _ScanFrequency + u_xlat8;
        u_xlat8 = sin(u_xlat8);
        u_xlat8 = max(u_xlat8, 0.0);
        u_xlat8 = max(u_xlat8, vs_TEXCOORD1);
        u_xlat8 = min(u_xlat8, _ScanMax);
        u_xlat16_2.x = (-u_xlat16_0.w) + u_xlat16_2.x;
        u_xlat16_2.x = u_xlat16_0.w * u_xlat16_2.x + u_xlat16_0.w;
        u_xlat16_3 = u_xlat16_0 + (-u_xlat16_2.xxxx);
        u_xlat16_2 = vec4(vec4(_ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation, _ActiveItemSaturation)) * u_xlat16_3 + u_xlat16_2.xxxx;
        u_xlat16_5.x = u_xlat16_1.w * _ActiveBackgroundOpacity;
        u_xlat16_3.xyz = (-u_xlat16_1.xyz);
        u_xlat16_3.w = (-u_xlat16_5.x);
        u_xlat16_2 = u_xlat16_2 + u_xlat16_3;
        u_xlat16_1.xyz = u_xlat16_0.www * u_xlat16_2.xyz + u_xlat16_1.xyz;
        u_xlat16_1.w = u_xlat16_0.w * u_xlat16_2.w + u_xlat16_5.x;
        u_xlat16_2.x = max(u_xlat8, _ScanColor.w);
        u_xlat16_0 = u_xlat16_1 + (-_ScanColor);
        SV_Target0 = u_xlat16_2.xxxx * u_xlat16_0 + _ScanColor;
        return;
    }
    return;
}

#endif
"
}
}
}
}
}