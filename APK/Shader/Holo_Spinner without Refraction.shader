//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Spinner without Refraction" {
Properties {
_Color ("    Color", Color) = (1,1,1,1)
_Specularity ("Specularity", Range(0, 2)) = 1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.95
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 1
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 1
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ColorMask RGB 0
  ZClip Off
  ZWrite Off
  GpuProgramID 11198
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_11);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_11);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((normalize(_glesNormal) * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_11);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((normalize(_glesNormal) * tmpvar_11));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * _CharacterColor);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_10);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((normalize(_glesNormal) * tmpvar_11));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * _CharacterColor);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_10);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float unityFogFactor_4;
  mediump vec4 coord_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  coord_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * coord_5.z);
  unityFogFactor_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(unityFogFactor_4) * unityFogFactor_4));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((normalize(_glesNormal) * tmpvar_11));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (tmpvar_8 * _CharacterColor);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_10);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_5;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_6;
  lightDir_6 = lightDir_3;
  mediump vec3 viewDir_7;
  viewDir_7 = worldViewDir_2;
  mediump vec4 specular_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (pow (vec3(clamp (
    dot (tmpvar_9, normalize((viewDir_7 + lightDir_6)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_8 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float perceptualRoughness_12;
  perceptualRoughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((perceptualRoughness_12 * (1.7 - 
    (0.7 * perceptualRoughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  mediump float tmpvar_16;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_16 = tmpvar_15.w;
  } else {
    tmpvar_16 = 1.0;
  };
  specular_8.xyz = (tmpvar_10.xyz + ((
    (unity_SpecCube0_HDR.x * tmpvar_16)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_17;
  color_17.w = c_1.w;
  color_17.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_17.xyz, xlv_TEXCOORD3.www);
  color_17.xyz = tmpvar_18;
  c_1 = color_17;
  gl_FragData[0] = color_17;
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
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "BRB_CHAR_FX" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}