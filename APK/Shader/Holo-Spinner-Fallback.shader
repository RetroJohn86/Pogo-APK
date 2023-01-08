//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Spinner without Refraction" {
Properties {
 _Color ("    Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Specularity ("Specularity", Range(0.000000,2.000000)) = 1.000000
 _Glossiness ("Specular Glossiness", Range(0.025000,1.000000)) = 0.950000
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
 _RefractionAmount ("Refraction Amount", Float) = 100.000000
}
SubShader { 
 LOD 1
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 14395
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_3.x)
   + 
    (v_14.xyz * tmpvar_3.y)
  ) + (v_15.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_12);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_3.x)
   + 
    (v_14.xyz * tmpvar_3.y)
  ) + (v_15.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_12);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_3.x)
   + 
    (v_14.xyz * tmpvar_3.y)
  ) + (v_15.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_11);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_12);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].x;
  v_12.y = unity_WorldToObject[1].x;
  v_12.z = unity_WorldToObject[2].x;
  v_12.w = unity_WorldToObject[3].x;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].y;
  v_13.y = unity_WorldToObject[1].y;
  v_13.z = unity_WorldToObject[2].y;
  v_13.w = unity_WorldToObject[3].y;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].z;
  v_14.y = unity_WorldToObject[1].z;
  v_14.z = unity_WorldToObject[2].z;
  v_14.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * tmpvar_3.x)
   + 
    (v_13.xyz * tmpvar_3.y)
  ) + (v_14.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_15;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * _CharacterColor);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].x;
  v_12.y = unity_WorldToObject[1].x;
  v_12.z = unity_WorldToObject[2].x;
  v_12.w = unity_WorldToObject[3].x;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].y;
  v_13.y = unity_WorldToObject[1].y;
  v_13.z = unity_WorldToObject[2].y;
  v_13.w = unity_WorldToObject[3].y;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].z;
  v_14.y = unity_WorldToObject[1].z;
  v_14.z = unity_WorldToObject[2].z;
  v_14.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * tmpvar_3.x)
   + 
    (v_13.xyz * tmpvar_3.y)
  ) + (v_14.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_15;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * _CharacterColor);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
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
  highp vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump float unityFogFactor_5;
  mediump vec4 coord_6;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  coord_6 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * coord_6.z);
  unityFogFactor_5 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(unityFogFactor_5) * unityFogFactor_5));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].x;
  v_12.y = unity_WorldToObject[1].x;
  v_12.z = unity_WorldToObject[2].x;
  v_12.w = unity_WorldToObject[3].x;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].y;
  v_13.y = unity_WorldToObject[1].y;
  v_13.z = unity_WorldToObject[2].y;
  v_13.w = unity_WorldToObject[3].y;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].z;
  v_14.y = unity_WorldToObject[1].z;
  v_14.z = unity_WorldToObject[2].z;
  v_14.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(((
    (v_12.xyz * tmpvar_3.x)
   + 
    (v_13.xyz * tmpvar_3.y)
  ) + (v_14.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_15;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * _CharacterColor);
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
  specular_8.w = tmpvar_10.w;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (dot (viewDir_7, tmpvar_9), 0.0, 1.0);
  mediump float roughness_12;
  roughness_12 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = (-(viewDir_7) - ((2.0 * tmpvar_9) * -(tmpvar_11)));
  tmpvar_13.w = ((roughness_12 * (1.7 - 
    (0.7 * roughness_12)
  )) * 6.0);
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_13.xyz, tmpvar_13.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = tmpvar_14;
  specular_8.xyz = (tmpvar_10.xyz + ((
    (tmpvar_15.w * unity_SpecCube0_HDR.x)
   * tmpvar_15.xyz) * mix (
    pow ((1.0 - tmpvar_11), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_8.xyz = (specular_8.xyz * vec3(_Specularity));
  specular_8.w = ((specular_8.x + specular_8.y) + (specular_8.z * 0.333));
  c_1 = specular_8;
  c_1.xyz = c_1.xyz;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  color_16.xyz = (c_1.xyz * _Color.xyz);
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix ((xlv_TEXCOORD3.xyz * c_1.w), color_16.xyz, xlv_TEXCOORD3.www);
  color_16.xyz = tmpvar_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}