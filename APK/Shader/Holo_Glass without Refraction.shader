//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass without Refraction" {
Properties {
[Toggle(BRB_GLASS_BASE)] _GlassMode ("Glass with Diffuse", Float) = 0
[KeywordEnum(Off, Diffuse, GlassTint, GlassBlend)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit, SpecularColor)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Specularity ("Specularity", Range(0, 2)) = 1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.95
[KeywordEnum(None, Specularity, Cubemap)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "TINT"
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend DstColor Zero, DstAlpha One
  ZClip Off
  ZWrite Off
  GpuProgramID 14094
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles " {
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  GpuProgramID 83569
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = exp2((-(tmpvar_5) * tmpvar_5));
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = unity_FogColor.xyz;
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((normalize(_glesNormal) * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_6 * tmpvar_7);
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = exp2((-(tmpvar_5) * tmpvar_5));
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = unity_FogColor.xyz;
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((normalize(_glesNormal) * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_6 * tmpvar_7);
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = exp2((-(tmpvar_5) * tmpvar_5));
  highp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = unity_FogColor.xyz;
  tmpvar_7 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((normalize(_glesNormal) * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_6 * tmpvar_7);
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float perceptualRoughness_18;
  perceptualRoughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((perceptualRoughness_18 * (1.7 - 
    (0.7 * perceptualRoughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  mediump float tmpvar_22;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_22 = tmpvar_21.w;
  } else {
    tmpvar_22 = 1.0;
  };
  lowp vec3 tmpvar_23;
  mediump vec3 tmpvar_24;
  tmpvar_24 = clamp (((unity_SpecCube0_HDR.x * tmpvar_22) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _LightColor0.xyz;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_25 * tmpvar_27);
  specular_14.xyz = (specular_14.xyz + tmpvar_23);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_28;
  tmpvar_28.xyz = specular_14.xyz;
  tmpvar_28.w = 0.0;
  tmpvar_9 = tmpvar_28;
  c_1 = tmpvar_9;
  lowp vec4 color_29;
  color_29.w = c_1.w;
  highp vec3 tmpvar_30;
  tmpvar_30 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_29.xyz = tmpvar_30;
  c_1 = color_29;
  gl_FragData[0] = color_29;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Hidden/Holo/Glass Fallback"
CustomEditor "CustomMaterialInspector"
}