//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/Egg" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_Ramp2D ("BRDF Ramp", 2D) = "grey" { }
_Amount_Blend ("BRDF Amount", Range(0, 2)) = 1
_Amount_Wrap ("Lambert Wrap Amount", Range(0, 1)) = 0
_cTint ("Tint", Color) = (0,0,0,0.5)
_cDiff ("Diffuse", Color) = (1,1,1,0.5)
_cAmbn ("Ambient", Color) = (0,0,0,0.5)
_cKeyf ("Shine Color (.a=0.5)", Color) = (1,1,1,0.5)
_cRimt ("RimTop   (.a=0.5)", Color) = (1,1,0,0.5)
_cRimb ("RimBottom(.a=0.5)", Color) = (0.5,0.5,0.5,0.5)
_Amount_RimLt ("RimLight Mult", Range(0, 2)) = 1
[Space] [Header(SPECULAR____________)] [Space] _Spec ("Specular", Range(0, 1)) = 1
_Gloss ("Glossiness", Range(0.025, 100)) = 0.95
[Space] [Header(FRESNEL_____________)] [Space] _FresnelEdge ("Fresnel Outer Color", Color) = (1,1,1,0)
_FresnelCenter ("Fresnel Center Color", Color) = (0,0,0,0)
_FresnelBias ("Fresnel Bias", Float) = 0
_FresnelPinch ("Fresnel Pinch", Float) = 1
_FresnelPower ("Fresnel Power", Float) = 1
[Space] [Header(FX_____________)] [Space] _cOverride ("Color override (rgb = color, a = blend)", Color) = (1,1,1,0)
_CrackTex ("Crack Texture", 2D) = "black" { }
_CrackAmount ("Crack Amount", Range(0, 0.999)) = 0
}
SubShader {
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 21432
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = (((tmpvar_15 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_16;
  tmpvar_6.z = ((tmpvar_15 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_14);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_7 = tmpvar_18;
  tmpvar_4 = tmpvar_7;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_1;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((norm_20 * tmpvar_21));
  worldNormal_2 = tmpvar_22;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_4;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_2 = tmpvar_5;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_3;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_2;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD0);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  mediump float tmpvar_27;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_27 = tmpvar_26.w;
  } else {
    tmpvar_27 = 1.0;
  };
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_27) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = (((tmpvar_15 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_16;
  tmpvar_6.z = ((tmpvar_15 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_14);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_7 = tmpvar_18;
  tmpvar_4 = tmpvar_7;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_1;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((norm_20 * tmpvar_21));
  worldNormal_2 = tmpvar_22;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_4;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_2 = tmpvar_5;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_3;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_2;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD0);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  mediump float tmpvar_27;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_27 = tmpvar_26.w;
  } else {
    tmpvar_27 = 1.0;
  };
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_27) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _CrackTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_1;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  mediump float tmpvar_15;
  tmpvar_15 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = (((tmpvar_15 * 0.5) + 0.5) * 0.95);
  tmpvar_6.xy = tmpvar_16;
  tmpvar_6.z = ((tmpvar_15 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.w = (1.0 - tmpvar_14);
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  tmpvar_7 = tmpvar_18;
  tmpvar_4 = tmpvar_7;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  highp vec3 norm_20;
  norm_20 = tmpvar_1;
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((norm_20 * tmpvar_21));
  worldNormal_2 = tmpvar_22;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_4;
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
uniform mediump vec4 _cOverride;
uniform lowp vec4 _FresnelEdge;
uniform lowp vec4 _FresnelCenter;
uniform lowp float _FresnelBias;
uniform lowp float _FresnelPinch;
uniform lowp float _FresnelPower;
uniform sampler2D _CrackTex;
uniform lowp float _CrackAmount;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump float _Spec;
uniform mediump float _Gloss;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_2 = tmpvar_5;
  mediump vec3 finalColor_6;
  mediump vec4 brdf_7;
  mediump vec4 crackTex_8;
  mediump vec4 tex_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_9 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CrackTex, xlv_TEXCOORD3);
  crackTex_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_7 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (_FresnelEdge, _FresnelCenter, vec4(pow (clamp (
    (xlv_TEXCOORD4.x + _FresnelBias)
  , 0.0, 1.0), _FresnelPinch)));
  lowp float edge_14;
  edge_14 = (1.0 - _CrackAmount);
  lowp float edge_15;
  edge_15 = (1.05 - _CrackAmount);
  mediump float tmpvar_16;
  tmpvar_16 = float((crackTex_8.x >= edge_15));
  finalColor_6 = (mix ((
    ((tex_9.xyz * (clamp (
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_7.yyy) + ((_cRimb.xyz * brdf_7.w) * (_cRimb.w * 2.0)))
    , 0.0, 1.0) + (
      (((_cKeyf.xyz * brdf_7.z) * (_cKeyf.w * 2.0)) + ((_cRimt.xyz * brdf_7.x) * (_cRimt.w * 2.0)))
     * _Amount_RimLt))) * _Amount_Blend)
   * xlv_TEXCOORD4.z), (tmpvar_13.xyz * _FresnelPower), tmpvar_13.www) * max ((
    (1.0 - float((crackTex_8.x >= edge_14)))
   + tmpvar_16), 0.75));
  finalColor_6 = (finalColor_6 + ((tmpvar_16 * 2.0) * crackTex_8.y));
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (finalColor_6, _cOverride.xyz, _cOverride.www);
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec3 lightDir_18;
  lightDir_18 = lightDir_3;
  mediump vec3 viewDir_19;
  viewDir_19 = worldViewDir_2;
  mediump vec4 specular_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD0);
  specular_20.w = 0.0;
  specular_20.xyz = (pow (vec3(clamp (
    dot (tmpvar_21, normalize((viewDir_19 + lightDir_18)))
  , 0.0, 1.0)), vec3((_Gloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_22;
  tmpvar_22 = clamp (dot (viewDir_19, tmpvar_21), 0.0, 1.0);
  mediump float perceptualRoughness_23;
  perceptualRoughness_23 = (1.0 - _Gloss);
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = (-(viewDir_19) - ((2.0 * tmpvar_21) * -(tmpvar_22)));
  tmpvar_24.w = ((perceptualRoughness_23 * (1.7 - 
    (0.7 * perceptualRoughness_23)
  )) * 6.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_24.xyz, tmpvar_24.w);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  mediump float tmpvar_27;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_27 = tmpvar_26.w;
  } else {
    tmpvar_27 = 1.0;
  };
  specular_20.xyz = (specular_20.xyz + (clamp (
    ((unity_SpecCube0_HDR.x * tmpvar_27) * tmpvar_26.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_22)));
  specular_20.xyz = (specular_20.xyz * vec3(_Spec));
  c_1 = specular_20;
  c_1.xyz = (c_1.xyz + tmpvar_17);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Mobile/Diffuse"
}