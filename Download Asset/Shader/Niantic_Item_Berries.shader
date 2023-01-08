//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Item/Berries" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_NoiseTex ("Noise Texture", 2D) = "white" { }
_ReflectTex ("Reflection Texture", 2D) = "white" { }
[Header(NOISE)] _NoiseContrast ("Small Noise Contrast", Range(0, 3)) = 1.4
_NoiseScale ("Small Noise Scale", Range(0, 50)) = 1
_NoiseYscale ("Small Noise Y", Range(0, 10)) = 1
_BlotchStrength ("Large Noise Strength", Range(0, 1)) = 1
_BlotchContrast ("Large Noise Contrast", Range(0, 3)) = 1.4
_BlotchScale ("Large Noise Scale", Range(0, 10)) = 1
[Header(VERTEX_COLOR_FEATURES)] _SecondaryColor ("Secondary Color (vert.g)", Color) = (1,1,1,1)
_BounceLightColor ("Bounce Light Color (Vert.b)", Color) = (0,0,0,0)
_AOColor ("AO Color (vert.a)", Color) = (0.2,0.2,0.2,1)
_AOStrength ("AO Strength", Range(0, 2)) = 0
[Header(GLOBAL SETTINGS)] _LightColor ("Light Color", Color) = (1,1,1,1)
_Lighting ("Light Amount", Range(0.001, 1)) = 1
_OutlineColor2 ("Secondary Rim Color", Color) = (1,1,1,1)
_RefScale ("Reflection Scale", Range(0, 3)) = 1
_Emissive ("Emissive Color", Color) = (0,0,0,0)
[Header(COLOR_1)] [MaterialToggle] _AllUseColor1 ("***ALL USE COLOR 1 Settings***", Float) = 0
[MaterialToggle] _UseTex1 ("Color1 Use Texture", Float) = 1
_Color ("Color1 Primary", Color) = (1,1,1,1)
_NoiseStrength1 ("Noise1 Strength", Range(0, 1)) = 0.5
_Color1b ("Color1 Secondary", Color) = (1,1,1,1)
_Color1s ("Color1 Specular", Color) = (1,1,1,1)
_Color1r ("Color1 Rim (.a = Falloff)", Color) = (1,1,1,1)
_Color1rt ("Color1 Rim Texture", Range(0, 1)) = 0
[MaterialToggle] _KillRim1 ("Kill Color1 Rim2", Float) = 0
_DiffuseBrightness1 ("Diffuse1 Brightness", Range(0, 5)) = 1
_Color1specPower ("Color1 Specular Falloff", Range(0, 10)) = 2
_ReflectStrength ("Reflection Strength", Range(0, 1)) = 0.5
[Header(COLOR_2)] [MaterialToggle] _UseTex2 ("Color2 Use Texture", Float) = 1
_Color2a ("Color2 Primary", Color) = (1,1,1,1)
_NoiseStrength2 ("Noise2 Strength", Range(0, 1)) = 0.5
_Color2b ("Color2 Secondary", Color) = (1,1,1,1)
_Color2s ("Color2 Specular", Color) = (1,1,1,1)
_Color2r ("Color2 Rim (.a = Falloff)", Color) = (1,1,1,1)
_Color2rt ("Color2 Rim Texture", Range(0, 1)) = 0
[MaterialToggle] _KillRim2 ("Kill Color2 Rim2", Float) = 0
_DiffuseBrightness2 ("Diffuse2 Brightness", Range(0, 5)) = 1
_Color2specPower ("Color2 Specular Falloff", Range(0, 10)) = 2
_ReflectStrength2 ("Reflection Strength 2", Range(0, 1)) = 0.5
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 40263
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
lowp float u_xlat10_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
lowp float u_xlat10_22;
float u_xlat27;
lowp float u_xlat10_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat10_11 = texture2D(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat10_11 + u_xlat10_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat10_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat10_33 = texture2D(_NoiseTex, u_xlat4.xy).y;
    u_xlat10_22 = texture2D(_NoiseTex, u_xlat0.xz).y;
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat10_22 * 0.5;
    u_xlat16_1.x = u_xlat10_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat10_0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat10_5.xyz = texture2D(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat10_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
lowp float u_xlat10_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
lowp float u_xlat10_22;
float u_xlat27;
lowp float u_xlat10_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat10_11 = texture2D(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat10_11 + u_xlat10_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat10_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat10_33 = texture2D(_NoiseTex, u_xlat4.xy).y;
    u_xlat10_22 = texture2D(_NoiseTex, u_xlat0.xz).y;
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat10_22 * 0.5;
    u_xlat16_1.x = u_xlat10_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat10_0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat10_5.xyz = texture2D(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat10_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
attribute highp vec4 in_POSITION0;
attribute highp vec3 in_NORMAL0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ReflectTex;
varying highp vec3 vs_NORMAL0;
varying mediump vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec3 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_TEXCOORD3;
varying mediump vec4 vs_TEXCOORD4;
varying mediump vec4 vs_TEXCOORD6;
varying mediump vec4 vs_TEXCOORD7;
varying mediump vec4 vs_TEXCOORD9;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
lowp float u_xlat10_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
lowp float u_xlat10_22;
float u_xlat27;
lowp float u_xlat10_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat10_11 = texture2D(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat10_11 + u_xlat10_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat10_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat10_33 = texture2D(_NoiseTex, u_xlat4.xy).y;
    u_xlat10_22 = texture2D(_NoiseTex, u_xlat0.xz).y;
    u_xlat10_0.x = texture2D(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat10_22 * 0.5;
    u_xlat16_1.x = u_xlat10_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat10_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat10_0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat10_5.xyz = texture2D(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat10_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
out mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat0.y>=9.99999975e-05);
#else
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=9.99999975e-05);
#else
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xy = min(max(u_xlat6.xy, 0.0), 1.0);
#else
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.z = !!(u_xlat6.y>=9.99999975e-05);
#else
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=9.99999975e-05);
#else
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ReflectTex;
in highp vec3 vs_NORMAL0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD9;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_11 = texture(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat16_11 + u_xlat16_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat16_33 = texture(_NoiseTex, u_xlat4.xy).y;
    u_xlat16_22 = texture(_NoiseTex, u_xlat0.xz).y;
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat16_22 * 0.5;
    u_xlat16_1.x = u_xlat16_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat16_5.xyz = texture(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat16_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
out mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat0.y>=9.99999975e-05);
#else
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=9.99999975e-05);
#else
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xy = min(max(u_xlat6.xy, 0.0), 1.0);
#else
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.z = !!(u_xlat6.y>=9.99999975e-05);
#else
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=9.99999975e-05);
#else
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ReflectTex;
in highp vec3 vs_NORMAL0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD9;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_11 = texture(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat16_11 + u_xlat16_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat16_33 = texture(_NoiseTex, u_xlat4.xy).y;
    u_xlat16_22 = texture(_NoiseTex, u_xlat0.xz).y;
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat16_22 * 0.5;
    u_xlat16_1.x = u_xlat16_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat16_5.xyz = texture(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat16_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _AllUseColor1;
uniform 	mediump float _UseTex1;
uniform 	mediump vec4 _Color;
uniform 	mediump float _NoiseStrength1;
uniform 	mediump vec4 _Color1b;
uniform 	mediump vec4 _Color1s;
uniform 	mediump vec4 _Color1r;
uniform 	mediump float _Color1rt;
uniform 	mediump float _KillRim1;
uniform 	mediump float _Color1specPower;
uniform 	mediump float _DiffuseBrightness1;
uniform 	mediump float _ReflectStrength;
uniform 	mediump float _UseTex2;
uniform 	mediump vec4 _Color2a;
uniform 	mediump float _NoiseStrength2;
uniform 	mediump vec4 _Color2b;
uniform 	mediump vec4 _Color2s;
uniform 	mediump vec4 _Color2r;
uniform 	mediump float _Color2rt;
uniform 	mediump float _KillRim2;
uniform 	mediump float _Color2specPower;
uniform 	mediump float _DiffuseBrightness2;
uniform 	mediump float _ReflectStrength2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD6;
out mediump vec4 vs_TEXCOORD7;
out mediump vec4 vs_TEXCOORD9;
vec4 u_xlat0;
bvec2 u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec2 u_xlat16_2;
vec2 u_xlat3;
bvec3 u_xlatb3;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
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
    vs_NORMAL0.xyz = in_NORMAL0.xyz;
    vs_COLOR0.yzw = in_COLOR0.yzw;
    u_xlat0.xy = (-in_TEXCOORD0.xx) + vec2(2.0, 1.0);
    u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.y = !!(u_xlat0.y>=9.99999975e-05);
#else
    u_xlatb0.y = u_xlat0.y>=9.99999975e-05;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat0.x>=9.99999975e-05);
#else
    u_xlatb0.x = u_xlat0.x>=9.99999975e-05;
#endif
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
;
    u_xlat16_2.x = (-_AllUseColor1) + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_2.x;
    u_xlat6.xy = in_TEXCOORD0.xx + vec2(-3.9999001, -0.999899983);
#ifdef UNITY_ADRENO_ES3
    u_xlat6.xy = min(max(u_xlat6.xy, 0.0), 1.0);
#else
    u_xlat6.xy = clamp(u_xlat6.xy, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.z = !!(u_xlat6.y>=9.99999975e-05);
#else
    u_xlatb3.z = u_xlat6.y>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlat6.x + u_xlat0.y;
    u_xlat3.x = u_xlat3.x + _AllUseColor1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=9.99999975e-05);
#else
    u_xlatb3.x = u_xlat3.x>=9.99999975e-05;
#endif
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.z ? float(1.0) : 0.0;
;
    u_xlat0.x = u_xlat0.x * u_xlat3.y;
    u_xlat16_2.xy = (-vec2(_Color1rt, _KillRim1)) * u_xlat3.xx + vec2(1.0, 1.0);
    u_xlat16_2.xy = vec2(_Color2rt, _KillRim2) * u_xlat0.xx + u_xlat16_2.xy;
    vs_COLOR0.x = u_xlat16_2.x;
    vs_TEXCOORD2.w = u_xlat16_2.y;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    vs_TEXCOORD0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat6.x = in_POSITION0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * in_POSITION0.x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * in_POSITION0.z + u_xlat6.x;
    vs_TEXCOORD0.w = hlslcc_mtx4x4unity_MatrixV[3].z * in_POSITION0.w + u_xlat6.x;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_2.x = u_xlat0.x * _ReflectStrength2;
    u_xlat16_2.x = _ReflectStrength * u_xlat3.x + u_xlat16_2.x;
    vs_TEXCOORD1.z = u_xlat16_2.x;
    vs_TEXCOORD2.xyz = in_POSITION0.xyz;
    u_xlat16_1 = u_xlat0.xxxx * _Color2a;
    vs_TEXCOORD3 = _Color * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2b;
    vs_TEXCOORD4 = _Color1b * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2s;
    vs_TEXCOORD6 = _Color1s * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_1 = u_xlat0.xxxx * _Color2r;
    vs_TEXCOORD7 = _Color1r * u_xlat3.xxxx + u_xlat16_1;
    u_xlat16_2.x = u_xlat0.x * _NoiseStrength2;
    vs_TEXCOORD9.y = _NoiseStrength1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = u_xlat0.x * _UseTex2;
    u_xlat16_5.xy = u_xlat0.xx * vec2(_DiffuseBrightness2, _Color2specPower);
    vs_TEXCOORD9.w = _UseTex1 * u_xlat3.x + u_xlat16_2.x;
    u_xlat16_2.x = _Color1specPower * u_xlat3.x + u_xlat16_5.y;
    vs_TEXCOORD9.x = _DiffuseBrightness1 * u_xlat3.x + u_xlat16_5.x;
    vs_TEXCOORD9.z = exp2(u_xlat16_2.x);
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 _LightColor;
uniform 	mediump float _Lighting;
uniform 	mediump float _NoiseContrast;
uniform 	mediump float _NoiseScale;
uniform 	mediump float _NoiseYscale;
uniform 	mediump float _BlotchScale;
uniform 	mediump float _BlotchContrast;
uniform 	mediump float _BlotchStrength;
uniform 	mediump vec4 _SecondaryColor;
uniform 	mediump vec4 _BounceLightColor;
uniform 	mediump vec4 _AOColor;
uniform 	mediump float _AOStrength;
uniform 	mediump vec4 _OutlineColor2;
uniform 	mediump float _RefScale;
uniform 	mediump vec4 _Emissive;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _ReflectTex;
in highp vec3 vs_NORMAL0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD3;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD6;
in mediump vec4 vs_TEXCOORD7;
in mediump vec4 vs_TEXCOORD9;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_10;
mediump float u_xlat16_11;
mediump vec3 u_xlat16_12;
mediump float u_xlat16_16;
mediump float u_xlat16_18;
mediump float u_xlat16_22;
float u_xlat27;
mediump float u_xlat16_33;
mediump float u_xlat16_34;
mediump float u_xlat16_36;
float u_xlat38;
mediump float u_xlat16_40;
void main()
{
    u_xlat0 = vs_TEXCOORD2.xyzy * vec4(vec4(_BlotchScale, _BlotchScale, _BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_11 = texture(_NoiseTex, u_xlat0.zw).x;
    u_xlat16_1.x = u_xlat16_11 + u_xlat16_0.x;
    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(vec2(_BlotchScale, _BlotchScale));
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat16_1.x = u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * 0.75;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _BlotchContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_12.x = (-_BlotchStrength) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_1.x = u_xlat16_1.x * _BlotchStrength + u_xlat16_12.x;
    u_xlat16_12.xy = (-vs_TEXCOORD9.yw) + vec2(1.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_34 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * vec3(u_xlat16_34) + u_xlat16_2.xyz;
    u_xlat16_3.xy = ceil(vs_TEXCOORD2.xz);
    u_xlat16_3.z = floor(vs_TEXCOORD2.y);
    u_xlat0.x = dot(u_xlat16_3.xz, vec2(12.9898005, 78.2330017));
    u_xlat0.y = dot(u_xlat16_3.yz, vec2(12.9898005, 78.2330017));
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat16_1.xw = u_xlat0.yy * vec2(0.150000006, 0.5);
    u_xlat16_3.xy = u_xlat0.xx * vec2(0.150000006, 0.5);
    u_xlat0.x = vs_TEXCOORD2.x * _NoiseScale + u_xlat16_3.x;
    u_xlat4.xy = vs_TEXCOORD2.yz * vec2(vec2(_NoiseYscale, _NoiseYscale));
    u_xlat0.yz = u_xlat4.xy * vec2(vec2(_NoiseScale, _NoiseScale)) + u_xlat16_3.yy;
    u_xlat4.y = u_xlat4.x * _NoiseScale + u_xlat16_1.w;
    u_xlat4.x = vs_TEXCOORD2.z * _NoiseScale + u_xlat16_1.x;
    u_xlat16_33 = texture(_NoiseTex, u_xlat4.xy).y;
    u_xlat16_22 = texture(_NoiseTex, u_xlat0.xz).y;
    u_xlat16_0.x = texture(_NoiseTex, u_xlat0.xy).y;
    u_xlat16_1.x = u_xlat16_22 * 0.5;
    u_xlat16_1.x = u_xlat16_0.x * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_33 * 0.25 + u_xlat16_1.x;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _NoiseContrast;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD9.y + u_xlat16_12.x;
    u_xlat16_12.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_3.xyz = u_xlat16_1.xxx * vs_TEXCOORD4.xyz;
    u_xlat16_3.xyz = vs_TEXCOORD3.xyz * u_xlat16_12.xxx + u_xlat16_3.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_3.xyz;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat0 = u_xlat16_12.yyyy + u_xlat16_0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat16_4 = vs_COLOR0.yyyy + _SecondaryColor;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat0 * u_xlat16_4;
    u_xlat16_12.xyz = u_xlat16_0.xyz * _LightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_2.xyz * u_xlat16_12.xyz;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vs_TEXCOORD9.xxx;
    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat5.x = inversesqrt(u_xlat5.x);
    u_xlat5.xyz = u_xlat5.xxx * _WorldSpaceLightPos0.xyz;
    u_xlat2.xyz = vs_NORMAL0.xyz;
    u_xlat2.w = 1.0;
    u_xlat6.x = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[0]);
    u_xlat6.y = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[1]);
    u_xlat6.z = dot(u_xlat2, hlslcc_mtx4x4unity_WorldToObject[2]);
    u_xlat38 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat6.xyz = vec3(u_xlat38) * u_xlat6.xyz;
    u_xlat38 = dot(u_xlat6.xyz, u_xlat5.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat38 = min(max(u_xlat38, 0.0), 1.0);
#else
    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
#endif
    u_xlat16_36 = (-_Lighting) + 1.0;
    u_xlat38 = u_xlat38 * _Lighting + u_xlat16_36;
    u_xlat16_12.xyz = u_xlat16_12.xyz * vec3(u_xlat38);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_36 = max(u_xlat38, 0.0);
    u_xlat16_12.xyz = u_xlat16_3.xyz * u_xlat16_12.xyz;
    u_xlat16_3.x = vs_COLOR0.z + (-_BounceLightColor.w);
    u_xlat16_3.x = u_xlat16_3.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_12.xyz = min(max(u_xlat16_12.xyz, 0.0), 1.0);
#else
    u_xlat16_12.xyz = clamp(u_xlat16_12.xyz, 0.0, 1.0);
#endif
    u_xlat16_3.xy = (-vs_COLOR0.zw) + vec2(1.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_3.xxx * _BounceLightColor.xyz;
    u_xlat16_12.xyz = u_xlat16_7.xyz * _BounceLightColor.www + u_xlat16_12.xyz;
    u_xlat16_7.xyz = (-_AOColor.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat16_7.xyz) * u_xlat16_3.yyy + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = log2(u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_AOStrength);
    u_xlat16_3.xyz = exp2(u_xlat16_3.xyz);
    u_xlat16_7.x = u_xlat16_36 * vs_TEXCOORD7.w;
    u_xlat16_36 = (-u_xlat16_36) + 1.0;
    u_xlat16_18 = (-vs_TEXCOORD2.w) + 1.0;
    u_xlat16_7.x = u_xlat16_18 * u_xlat16_7.x;
    u_xlat16_18 = (-_OutlineColor2.w) + 1.0;
    u_xlat16_36 = u_xlat16_18 * u_xlat16_36 + u_xlat16_7.x;
    u_xlat16_36 = vs_TEXCOORD7.w * vs_TEXCOORD2.w + u_xlat16_36;
    u_xlat16_36 = u_xlat16_36 * 5.0;
    u_xlat16_7.xyz = u_xlat16_0.xyz * vs_TEXCOORD7.xyz + vs_TEXCOORD7.xyz;
    u_xlat8.xyz = (-vs_TEXCOORD0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat38 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat38 = inversesqrt(u_xlat38);
    u_xlat9.xyz = vec3(u_xlat38) * u_xlat8.xyz;
    u_xlat16_10.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat5.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat9.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_40 = (-u_xlat5.x) + 1.0;
    u_xlat16_7.xyz = vec3(u_xlat16_40) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = log2(u_xlat16_7.xyz);
    u_xlat16_7.xyz = vec3(u_xlat16_36) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = exp2(u_xlat16_7.xyz);
    u_xlat16_12.xyz = u_xlat16_12.xyz * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_3.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_10.xyz;
    u_xlat5.x = dot(u_xlat6.xyz, u_xlat16_3.xyz);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat16_3.x = log2(u_xlat5.x);
    u_xlat16_3.x = u_xlat16_3.x * vs_TEXCOORD9.z;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xyz = u_xlat16_3.xxx * vs_TEXCOORD6.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vs_TEXCOORD6.www;
    u_xlat16_3.xyz = u_xlat16_1.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat5.x = dot((-u_xlat9.xyz), u_xlat6.xyz);
    u_xlat5.x = u_xlat5.x + u_xlat5.x;
    u_xlat5.xyz = u_xlat6.xyz * (-u_xlat5.xxx) + (-u_xlat9.xyz);
    u_xlat16_1.x = u_xlat5.x * _RefScale;
    u_xlat16_7.y = u_xlat5.y * 0.5;
    u_xlat16_7.x = u_xlat16_1.x * 0.5;
    u_xlat5.xy = u_xlat16_7.xy;
    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat5.xy = vec2(u_xlat27) * u_xlat5.xy;
    u_xlat16_16 = u_xlat5.y * 0.889999986 + 0.5;
    u_xlat5.y = u_xlat16_16;
    u_xlat16_5.xyz = texture(_ReflectTex, u_xlat5.xy).xyz;
    u_xlat38 = (-vs_TEXCOORD1.z) + 1.0;
    u_xlat5.xyz = u_xlat16_5.xyz * vs_TEXCOORD1.zzz + vec3(u_xlat38);
    u_xlat16_1.xyz = u_xlat16_12.xyz * u_xlat5.xyz + u_xlat16_3.xyz;
    u_xlat16_1.xyz = u_xlat16_0.www * _Emissive.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
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