//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/GiftBalloon/GiftBalloon-Animated" {
Properties {
[Header(Bob Animation)] [KeywordEnum(X, Y, Z)] _Translate ("Bob Axis", Float) = 0
_Bob_Speed ("Bob Speed", Float) = 1
_Bob_Amount ("Bob Amount", Float) = 0.5
[Header(Twist Animation)] [KeywordEnum(X, Y, Z)] _Twist ("Twist Axis", Float) = 0
_Twist_Degrees ("Twist Degrees", Range(1, 360)) = 10
_Twist_Speed ("Twist Speed", Float) = 0.78
[Header(Lighting)] _MainTex ("Texture", 2D) = "white" { }
_TextureTint ("Texture Tint", Color) = (1,1,1,1)
_Color_AmbientSky ("Sky Ambient Light (.a = brightness)", Color) = (0,0.5,1,1)
_Color_AmbientGround ("Ground Ambient Light (.a = brightness)", Color) = (0,1,0,1)
_FresnelFalloff ("Rim Light Falloff", Range(0, 10)) = 1
_Spec_Amount ("Specular Amount", Range(0, 1)) = 0.5
_Spec_Gloss ("Specular Glossiness", Range(1, 10)) = 1
_AmbientOcclusionAmount ("Ambient Occlusion Amount (Vertex G)", Range(0, 1)) = 0.5
[Header(Emission)] _Color_EmissionTint ("Emission Tint", Color) = (1,1,1,1)
_Emission ("Emission", Range(0, 5)) = 0
_Emission_PulseSpeed ("Emission Pulse Speed", Float) = 0
[Header(Other)] _RopeThicknessBump ("_RopeThicknessBump (Vertex R)", Range(0, 0.05)) = 0.01
}
SubShader {
 Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
 Pass {
  Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" }
  GpuProgramID 1611
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_X" "_TWIST_X" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
mediump float u_xlat16_9;
float u_xlat24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat8.x = u_xlat0.y * _Twist_Degrees;
    u_xlat8.y = u_xlat0.z + 1.0;
    u_xlat8.xy = u_xlat8.xy * vec2(0.0174532924, 0.5);
    u_xlat16_1.x = u_xlat8.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_1.xxx * _Color_EmissionTint.xyz;
    u_xlat16_1.x = sin(u_xlat8.x);
    u_xlat16_2 = cos(u_xlat8.x);
    u_xlat16_3.z = u_xlat16_1.x;
    u_xlat16_3.y = u_xlat16_2;
    u_xlat16_3.x = (-u_xlat16_1.x);
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.yz);
    u_xlat16_1.y = dot(in_NORMAL0.yz, u_xlat16_3.yz);
    u_xlat2 = u_xlat8.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat2;
    u_xlat8.x = dot(in_POSITION0.yz, u_xlat16_3.xy);
    u_xlat16_1.z = dot(in_NORMAL0.yz, u_xlat16_3.xy);
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat8.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat2;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat2.x;
    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat2.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat2.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_1.x = in_NORMAL0.x;
    u_xlat4.xyz = u_xlat16_1.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat4.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_25 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_25 = min(max(u_xlat16_25, 0.0), 1.0);
#else
    u_xlat16_25 = clamp(u_xlat16_25, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat2.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat24 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat4.xyz = vec3(u_xlat24) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat4.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat4.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat4.xxx + u_xlat5.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat4.zzz + u_xlat4.xyw;
    u_xlat24 = dot((-u_xlat4.xyz), u_xlat16_1.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat4.xyz = u_xlat16_1.xyz * (-vec3(u_xlat24)) + (-u_xlat4.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(u_xlat4.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_1.xyz);
    u_xlat8.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_1.xyz);
    u_xlat8.x = u_xlat8.x + 1.0;
    u_xlat8.x = u_xlat8.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelFalloff;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_9 = log2(u_xlat24);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_1.y = exp2(u_xlat16_9);
    u_xlat16_1.xy = min(u_xlat16_1.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_1.y * _Spec_Amount;
    u_xlat16_6.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    vs_COLOR0.xyz = u_xlat16_6.xyz;
    u_xlat16_6.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_7.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = u_xlat8.xxx * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_6.xyz * u_xlat16_1.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
attribute mediump vec3 in_NORMAL0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
varying mediump vec3 vs_COLOR0;
varying mediump vec3 vs_NORMAL0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LINEAR" "_TRANSLATE_Y" "_TWIST_Y" }
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_FogParams;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _FresnelFalloff;
uniform 	mediump float _Bob_Amount;
uniform 	mediump float _Bob_Speed;
uniform 	mediump vec4 _Color_AmbientSky;
uniform 	mediump vec4 _Color_AmbientGround;
uniform 	mediump float _Spec_Amount;
uniform 	mediump float _Spec_Gloss;
uniform 	mediump float _AmbientOcclusionAmount;
uniform 	mediump float _RopeThicknessBump;
uniform 	mediump vec4 _Color_EmissionTint;
uniform 	mediump float _Emission;
uniform 	mediump float _Emission_PulseSpeed;
uniform 	mediump float _Twist_Degrees;
uniform 	mediump float _Twist_Speed;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec3 vs_COLOR0;
out mediump vec3 vs_NORMAL0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
mediump vec2 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
mediump float u_xlat16_9;
float u_xlat21;
mediump float u_xlat16_23;
void main()
{
    u_xlat0.x = _Time.y * _Bob_Speed;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0.yz = _Time.yy * vec2(_Twist_Speed, _Emission_PulseSpeed);
    u_xlat0.xyz = sin(u_xlat0.xyz);
    u_xlat7.x = u_xlat0.y * _Twist_Degrees;
    u_xlat7.y = u_xlat0.z + 1.0;
    u_xlat7.xy = u_xlat7.xy * vec2(0.0174532924, 0.5);
    u_xlat16_2.x = u_xlat7.y * _Emission;
    vs_NORMAL0.xyz = u_xlat16_2.xxx * _Color_EmissionTint.xyz;
    u_xlat16_2.x = sin(u_xlat7.x);
    u_xlat16_3.x = cos(u_xlat7.x);
    u_xlat16_4.x = (-u_xlat16_2.x);
    u_xlat16_4.y = u_xlat16_3.x;
    u_xlat16_4.z = u_xlat16_2.x;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.xy);
    u_xlat16_2.x = dot(in_NORMAL0.zx, u_xlat16_4.xy);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat7.xxxx + u_xlat1;
    u_xlat7.x = dot(in_POSITION0.zx, u_xlat16_4.yz);
    u_xlat16_2.z = dot(in_NORMAL0.zx, u_xlat16_4.yz);
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat7.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat0.x = _Bob_Amount * u_xlat0.x + u_xlat1.y;
    u_xlat0.xyz = u_xlat0.xxx * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * u_xlat1.www + u_xlat0.xyz;
    u_xlat16_3.xy = (-in_COLOR0.xy) + vec2(1.0, 1.0);
    u_xlat16_2.y = in_NORMAL0.y;
    u_xlat1.xyz = u_xlat16_2.xyz * vec3(vec3(_RopeThicknessBump, _RopeThicknessBump, _RopeThicknessBump));
    u_xlat0.xyz = u_xlat1.xyz * u_xlat16_3.xxx + u_xlat0.xyz;
    u_xlat16_23 = u_xlat16_3.y * _AmbientOcclusionAmount;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_23 = (-u_xlat16_23) + 1.0;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat3;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat3;
    vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat5.xyz = u_xlat1.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat1.xyw = hlslcc_mtx4x4unity_WorldToObject[0].xyz * u_xlat1.xxx + u_xlat5.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
    u_xlat21 = dot((-u_xlat1.xyz), u_xlat16_2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat16_2.xyz * (-vec3(u_xlat21)) + (-u_xlat1.xyz);
    u_xlat5.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat5.xyz;
    u_xlat5.xyz = u_xlat5.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat5.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat7.x = dot(hlslcc_mtx4x4unity_WorldToObject[1].xyz, u_xlat16_2.xyz);
    u_xlat7.x = u_xlat7.x + 1.0;
    u_xlat7.x = u_xlat7.x * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_2.x = -abs(u_xlat0.x) + 1.0;
    u_xlat16_2.x = log2(u_xlat16_2.x);
    u_xlat16_2.x = u_xlat16_2.x * _FresnelFalloff;
    u_xlat16_2.x = exp2(u_xlat16_2.x);
    u_xlat16_9 = log2(u_xlat21);
    u_xlat16_9 = u_xlat16_9 * _Spec_Gloss;
    u_xlat16_2.y = exp2(u_xlat16_9);
    u_xlat16_2.xy = min(u_xlat16_2.xy, vec2(1.0, 1.0));
    u_xlat16_9 = u_xlat16_2.y * _Spec_Amount;
    u_xlat16_4.xyz = glstate_lightmodel_ambient.xyz * vec3(4.0, 4.0, 4.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_9 * u_xlat16_4.x;
    vs_COLOR0.xyz = u_xlat16_4.xyz;
    u_xlat16_4.xyz = _Color_AmbientGround.www * _Color_AmbientGround.xyz;
    u_xlat16_6.xyz = _Color_AmbientSky.xyz * _Color_AmbientSky.www + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat7.xxx * u_xlat16_6.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat16_2.xxx + vec3(u_xlat16_9);
    vs_TEXCOORD2.xyz = vec3(u_xlat16_23) * u_xlat16_2.xyz;
    vs_TEXCOORD2.w = 1.0;
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
uniform 	mediump vec4 _TextureTint;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
in mediump vec3 vs_COLOR0;
in mediump vec3 vs_NORMAL0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
float u_xlat11;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _TextureTint;
    u_xlat16_1.xyz = u_xlat0.www * vs_NORMAL0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + vs_TEXCOORD2.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
    u_xlat11 = vs_TEXCOORD1;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}