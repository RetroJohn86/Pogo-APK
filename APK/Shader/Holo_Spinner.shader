//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Spinner" {
Properties {
_Color ("    Color", Color) = (1,1,1,1)
_Specularity ("Specularity", Range(0, 2)) = 1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.95
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 400
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 GrabPass {
}
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 1873
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump vec3 vsNormal_5;
  mediump float unityFogFactor_6;
  mediump vec4 coord_7;
  mediump vec2 vdn_8;
  mediump vec3 osView_9;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((unity_WorldToObject * tmpvar_10).xyz - _glesVertex.xyz));
  osView_9 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(dot (osView_9, tmpvar_3));
  vdn_8 = tmpvar_12;
  vdn_8.y = (1.0 - max (vec2(0.0, 0.0), vdn_8)).x;
  tmpvar_4.w = vdn_8.y;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  coord_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * coord_7.z);
  unityFogFactor_6 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(unityFogFactor_6) * unityFogFactor_6));
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = unity_FogColor.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_3));
  vsNormal_5 = tmpvar_18;
  highp vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
  worldNormal_1 = tmpvar_23;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_19 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_19.zw;
  gl_Position = tmpvar_19;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = o_24;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = ((vsNormal_5.xy * vsNormal_5.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (tmpvar_15 * tmpvar_16);
  xlv_TEXCOORD5 = (_WorldSpaceCameraPos - tmpvar_21);
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
uniform sampler2D _GrabTexture;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD5);
  worldViewDir_2 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_8;
  tmpvar_8 = vec3((_Specularity * xlv_TEXCOORD4.w));
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_9;
  lightDir_9 = lightDir_3;
  mediump vec3 viewDir_10;
  viewDir_10 = worldViewDir_2;
  mediump vec4 specular_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (pow (vec3(clamp (
    dot (tmpvar_12, normalize((viewDir_10 + lightDir_9)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_11 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (viewDir_10, tmpvar_12), 0.0, 1.0);
  mediump float perceptualRoughness_15;
  perceptualRoughness_15 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = (-(viewDir_10) - ((2.0 * tmpvar_12) * -(tmpvar_14)));
  tmpvar_16.w = ((perceptualRoughness_15 * (1.7 - 
    (0.7 * perceptualRoughness_15)
  )) * 6.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16.xyz, tmpvar_16.w);
  mediump vec4 tmpvar_18;
  tmpvar_18 = tmpvar_17;
  mediump float tmpvar_19;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_19 = tmpvar_18.w;
  } else {
    tmpvar_19 = 1.0;
  };
  specular_11.xyz = (tmpvar_13.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_19) * tmpvar_18.xyz)
  , 0.0, 1.0) * mix (
    pow ((1.0 - tmpvar_14), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_11.xyz = (specular_11.xyz * tmpvar_8);
  specular_11.w = ((specular_11.x + specular_11.y) + (specular_11.z * 0.333));
  c_1 = specular_11;
  lowp vec4 color_20;
  lowp vec4 refractColor_21;
  mediump vec2 uvgrab_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_5.xy / tmpvar_5.w);
  uvgrab_22 = (tmpvar_23 - ((xlv_TEXCOORD3 / tmpvar_5.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_23 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_GrabTexture, uvgrab_22);
  refractColor_21.w = tmpvar_24.w;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - pow (tmpvar_4.w, _FresnelPower));
  refractColor_21.xyz = (tmpvar_24.xyz * tmpvar_25);
  refractColor_21.xyz = (refractColor_21.xyz * _Color.xyz);
  color_20 = (c_1 + refractColor_21);
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix ((xlv_TEXCOORD4.xyz * color_20.w), color_20.xyz, xlv_TEXCOORD4.www);
  color_20.xyz = tmpvar_26;
  c_1 = color_20;
  gl_FragData[0] = color_20;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump vec3 vsNormal_5;
  mediump float unityFogFactor_6;
  mediump vec4 coord_7;
  mediump vec2 vdn_8;
  mediump vec3 osView_9;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((unity_WorldToObject * tmpvar_10).xyz - _glesVertex.xyz));
  osView_9 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(dot (osView_9, tmpvar_3));
  vdn_8 = tmpvar_12;
  vdn_8.y = (1.0 - max (vec2(0.0, 0.0), vdn_8)).x;
  tmpvar_4.w = vdn_8.y;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  coord_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * coord_7.z);
  unityFogFactor_6 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(unityFogFactor_6) * unityFogFactor_6));
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = unity_FogColor.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_3));
  vsNormal_5 = tmpvar_18;
  highp vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
  worldNormal_1 = tmpvar_23;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_19 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_19.zw;
  gl_Position = tmpvar_19;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = o_24;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = ((vsNormal_5.xy * vsNormal_5.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (tmpvar_15 * tmpvar_16);
  xlv_TEXCOORD5 = (_WorldSpaceCameraPos - tmpvar_21);
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
uniform sampler2D _GrabTexture;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD5);
  worldViewDir_2 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_8;
  tmpvar_8 = vec3((_Specularity * xlv_TEXCOORD4.w));
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_9;
  lightDir_9 = lightDir_3;
  mediump vec3 viewDir_10;
  viewDir_10 = worldViewDir_2;
  mediump vec4 specular_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (pow (vec3(clamp (
    dot (tmpvar_12, normalize((viewDir_10 + lightDir_9)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_11 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (viewDir_10, tmpvar_12), 0.0, 1.0);
  mediump float perceptualRoughness_15;
  perceptualRoughness_15 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = (-(viewDir_10) - ((2.0 * tmpvar_12) * -(tmpvar_14)));
  tmpvar_16.w = ((perceptualRoughness_15 * (1.7 - 
    (0.7 * perceptualRoughness_15)
  )) * 6.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16.xyz, tmpvar_16.w);
  mediump vec4 tmpvar_18;
  tmpvar_18 = tmpvar_17;
  mediump float tmpvar_19;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_19 = tmpvar_18.w;
  } else {
    tmpvar_19 = 1.0;
  };
  specular_11.xyz = (tmpvar_13.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_19) * tmpvar_18.xyz)
  , 0.0, 1.0) * mix (
    pow ((1.0 - tmpvar_14), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_11.xyz = (specular_11.xyz * tmpvar_8);
  specular_11.w = ((specular_11.x + specular_11.y) + (specular_11.z * 0.333));
  c_1 = specular_11;
  lowp vec4 color_20;
  lowp vec4 refractColor_21;
  mediump vec2 uvgrab_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_5.xy / tmpvar_5.w);
  uvgrab_22 = (tmpvar_23 - ((xlv_TEXCOORD3 / tmpvar_5.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_23 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_GrabTexture, uvgrab_22);
  refractColor_21.w = tmpvar_24.w;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - pow (tmpvar_4.w, _FresnelPower));
  refractColor_21.xyz = (tmpvar_24.xyz * tmpvar_25);
  refractColor_21.xyz = (refractColor_21.xyz * _Color.xyz);
  color_20 = (c_1 + refractColor_21);
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix ((xlv_TEXCOORD4.xyz * color_20.w), color_20.xyz, xlv_TEXCOORD4.www);
  color_20.xyz = tmpvar_26;
  c_1 = color_20;
  gl_FragData[0] = color_20;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  mediump vec3 vsNormal_5;
  mediump float unityFogFactor_6;
  mediump vec4 coord_7;
  mediump vec2 vdn_8;
  mediump vec3 osView_9;
  tmpvar_3 = normalize(_glesNormal);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((unity_WorldToObject * tmpvar_10).xyz - _glesVertex.xyz));
  osView_9 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(dot (osView_9, tmpvar_3));
  vdn_8 = tmpvar_12;
  vdn_8.y = (1.0 - max (vec2(0.0, 0.0), vdn_8)).x;
  tmpvar_4.w = vdn_8.y;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  coord_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * coord_7.z);
  unityFogFactor_6 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(unityFogFactor_6) * unityFogFactor_6));
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = unity_FogColor.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_3));
  vsNormal_5 = tmpvar_18;
  highp vec4 tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_19 = (glstate_matrix_mvp * tmpvar_20);
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
  worldNormal_1 = tmpvar_23;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_19 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_19.zw;
  gl_Position = tmpvar_19;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = o_24;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = ((vsNormal_5.xy * vsNormal_5.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (tmpvar_15 * tmpvar_16);
  xlv_TEXCOORD5 = (_WorldSpaceCameraPos - tmpvar_21);
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
uniform sampler2D _GrabTexture;
uniform mediump vec4 _Color;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD5);
  worldViewDir_2 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD2;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_8;
  tmpvar_8 = vec3((_Specularity * xlv_TEXCOORD4.w));
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_9;
  lightDir_9 = lightDir_3;
  mediump vec3 viewDir_10;
  viewDir_10 = worldViewDir_2;
  mediump vec4 specular_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (pow (vec3(clamp (
    dot (tmpvar_12, normalize((viewDir_10 + lightDir_9)))
  , 0.0, 1.0)), vec3((_Glossiness * 128.0))) * _LightColor0.xyz);
  specular_11 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (viewDir_10, tmpvar_12), 0.0, 1.0);
  mediump float perceptualRoughness_15;
  perceptualRoughness_15 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = (-(viewDir_10) - ((2.0 * tmpvar_12) * -(tmpvar_14)));
  tmpvar_16.w = ((perceptualRoughness_15 * (1.7 - 
    (0.7 * perceptualRoughness_15)
  )) * 6.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_16.xyz, tmpvar_16.w);
  mediump vec4 tmpvar_18;
  tmpvar_18 = tmpvar_17;
  mediump float tmpvar_19;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_19 = tmpvar_18.w;
  } else {
    tmpvar_19 = 1.0;
  };
  specular_11.xyz = (tmpvar_13.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_19) * tmpvar_18.xyz)
  , 0.0, 1.0) * mix (
    pow ((1.0 - tmpvar_14), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_11.xyz = (specular_11.xyz * tmpvar_8);
  specular_11.w = ((specular_11.x + specular_11.y) + (specular_11.z * 0.333));
  c_1 = specular_11;
  lowp vec4 color_20;
  lowp vec4 refractColor_21;
  mediump vec2 uvgrab_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = (tmpvar_5.xy / tmpvar_5.w);
  uvgrab_22 = (tmpvar_23 - ((xlv_TEXCOORD3 / tmpvar_5.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_23 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_GrabTexture, uvgrab_22);
  refractColor_21.w = tmpvar_24.w;
  mediump float tmpvar_25;
  tmpvar_25 = (1.0 - pow (tmpvar_4.w, _FresnelPower));
  refractColor_21.xyz = (tmpvar_24.xyz * tmpvar_25);
  refractColor_21.xyz = (refractColor_21.xyz * _Color.xyz);
  color_20 = (c_1 + refractColor_21);
  mediump vec3 tmpvar_26;
  tmpvar_26 = mix ((xlv_TEXCOORD4.xyz * color_20.w), color_20.xyz, xlv_TEXCOORD4.www);
  color_20.xyz = tmpvar_26;
  c_1 = color_20;
  gl_FragData[0] = color_20;
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
}
}
}
Fallback "Holo/Spinner without Refraction"
CustomEditor "CustomMaterialInspector"
}