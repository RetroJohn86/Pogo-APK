//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Pixel Lit" {
Properties {
[KeywordEnum(Opaque, Cutout)] _Render ("Rendering Mode", Float) = 0
[KeywordEnum(Off, Diffuse)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
[Toggle(BRB_RAMP)] _RampEnable ("Use Toon Ramp", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle(BRB_LIGHTING_TWOSIDED)] _LightingDoubleSided ("    Two-sided lighting", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 13775
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ramp_21;
  lowp vec4 ldn_22;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_23;
  tmpvar_23 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_22 = tmpvar_23;
  ldn_22.w = ((ldn_22.x * 0.5) + 0.5);
  mediump vec4 tmpvar_24;
  tmpvar_24 = ldn_22.wwww;
  ramp_21 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((ramp_21.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  lowp float tmpvar_17;
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_18);
  tmpvar_17 = tmpvar_20;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  mediump vec3 lightDir_23;
  lightDir_23 = lightDir_4;
  mediump float atten_24;
  atten_24 = tmpvar_17;
  lowp vec3 color_25;
  lowp vec4 ramp_26;
  lowp vec4 ldn_27;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_22, lightDir_23));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp float tmpvar_29;
  tmpvar_29 = abs(ldn_27.x);
  mediump vec4 tmpvar_30;
  tmpvar_30 = mix (ldn_27.wwww, (ldn_27.wwww * atten_24), vec4(tmpvar_29));
  ramp_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((ramp_26.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_7.xyz * tmpvar_31.xyz);
  color_25 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33.xyz = color_25;
  tmpvar_33.w = tmpvar_8;
  tmpvar_21 = tmpvar_33;
  c_1 = tmpvar_21;
  lowp vec4 color_34;
  color_34.w = c_1.w;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_34.xyz = tmpvar_35;
  c_1.xyz = color_34.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  lowp float tmpvar_17;
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_18);
  tmpvar_17 = tmpvar_20;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  mediump vec3 lightDir_23;
  lightDir_23 = lightDir_4;
  mediump float atten_24;
  atten_24 = tmpvar_17;
  lowp vec3 color_25;
  lowp vec4 ramp_26;
  lowp vec4 ldn_27;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_22, lightDir_23));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp float tmpvar_29;
  tmpvar_29 = abs(ldn_27.x);
  mediump vec4 tmpvar_30;
  tmpvar_30 = mix (ldn_27.wwww, (ldn_27.wwww * atten_24), vec4(tmpvar_29));
  ramp_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((ramp_26.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_7.xyz * tmpvar_31.xyz);
  color_25 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33.xyz = color_25;
  tmpvar_33.w = tmpvar_8;
  tmpvar_21 = tmpvar_33;
  c_1 = tmpvar_21;
  lowp vec4 color_34;
  color_34.w = c_1.w;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_34.xyz = tmpvar_35;
  c_1.xyz = color_34.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * _EnvironmentColor);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  lowp float tmpvar_17;
  highp float lightShadowDataX_18;
  mediump float tmpvar_19;
  tmpvar_19 = _LightShadowData.x;
  lightShadowDataX_18 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_18);
  tmpvar_17 = tmpvar_20;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  mediump vec3 lightDir_23;
  lightDir_23 = lightDir_4;
  mediump float atten_24;
  atten_24 = tmpvar_17;
  lowp vec3 color_25;
  lowp vec4 ramp_26;
  lowp vec4 ldn_27;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_22, lightDir_23));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp float tmpvar_29;
  tmpvar_29 = abs(ldn_27.x);
  mediump vec4 tmpvar_30;
  tmpvar_30 = mix (ldn_27.wwww, (ldn_27.wwww * atten_24), vec4(tmpvar_29));
  ramp_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((ramp_26.xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = (tmpvar_7.xyz * tmpvar_31.xyz);
  color_25 = tmpvar_32;
  lowp vec4 tmpvar_33;
  tmpvar_33.xyz = color_25;
  tmpvar_33.w = tmpvar_8;
  tmpvar_21 = tmpvar_33;
  c_1 = tmpvar_21;
  lowp vec4 color_34;
  color_34.w = c_1.w;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (xlv_TEXCOORD2.xyz, c_1.xyz, xlv_TEXCOORD2.www);
  color_34.xyz = tmpvar_35;
  c_1.xyz = color_34.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 85588
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_1 = (tmpvar_3 * _EnvironmentColor);
  highp vec3 vertex_4;
  vertex_4 = _glesVertex.xyz;
  highp vec4 clipPos_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_6;
    tmpvar_6.w = 1.0;
    tmpvar_6.xyz = vertex_4;
    highp vec3 tmpvar_7;
    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = (tmpvar_7 - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
    clipPos_5 = (unity_MatrixVP * tmpvar_11);
  } else {
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = vertex_4;
    clipPos_5 = (glstate_matrix_mvp * tmpvar_12);
  };
  highp vec4 clipPos_13;
  clipPos_13.xyw = clipPos_5.xyw;
  clipPos_13.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(clipPos_5.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_1 = (tmpvar_3 * _EnvironmentColor);
  highp vec3 vertex_4;
  vertex_4 = _glesVertex.xyz;
  highp vec4 clipPos_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_6;
    tmpvar_6.w = 1.0;
    tmpvar_6.xyz = vertex_4;
    highp vec3 tmpvar_7;
    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = (tmpvar_7 - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
    clipPos_5 = (unity_MatrixVP * tmpvar_11);
  } else {
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = vertex_4;
    clipPos_5 = (glstate_matrix_mvp * tmpvar_12);
  };
  highp vec4 clipPos_13;
  clipPos_13.xyw = clipPos_5.xyw;
  clipPos_13.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(clipPos_5.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_1 = (tmpvar_3 * _EnvironmentColor);
  highp vec3 vertex_4;
  vertex_4 = _glesVertex.xyz;
  highp vec4 clipPos_5;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_6;
    tmpvar_6.w = 1.0;
    tmpvar_6.xyz = vertex_4;
    highp vec3 tmpvar_7;
    tmpvar_7 = (unity_ObjectToWorld * tmpvar_6).xyz;
    highp mat3 tmpvar_8;
    tmpvar_8[0] = unity_WorldToObject[0].xyz;
    tmpvar_8[1] = unity_WorldToObject[1].xyz;
    tmpvar_8[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_9;
    tmpvar_9 = normalize((_glesNormal * tmpvar_8));
    highp float tmpvar_10;
    tmpvar_10 = dot (tmpvar_9, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_7 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = (tmpvar_7 - (tmpvar_9 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_10 * tmpvar_10)))
    )));
    clipPos_5 = (unity_MatrixVP * tmpvar_11);
  } else {
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = vertex_4;
    clipPos_5 = (glstate_matrix_mvp * tmpvar_12);
  };
  highp vec4 clipPos_13;
  clipPos_13.xyw = clipPos_5.xyw;
  clipPos_13.z = (clipPos_5.z + clamp ((unity_LightShadowBias.x / clipPos_5.w), 0.0, 1.0));
  clipPos_13.z = mix (clipPos_13.z, max (clipPos_13.z, -(clipPos_5.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_13;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD1 = (tmpvar_2 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD1 = (tmpvar_2 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD1 = (tmpvar_2 * _EnvironmentColor);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
Fallback "Holo/Environment/Vertex Lit"
CustomEditor "CustomMaterialInspector"
}