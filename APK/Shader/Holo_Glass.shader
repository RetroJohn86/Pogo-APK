//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass" {
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
  GpuProgramID 52548
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_4 * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = 0.0;
  mediump vec3 lightDir_12;
  lightDir_12 = lightDir_5;
  mediump vec3 viewDir_13;
  viewDir_13 = worldViewDir_4;
  lowp float nh_14;
  lowp vec4 specular_15;
  lowp vec3 worldRefl_16;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (-(viewDir_13) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_16 = tmpvar_17;
  mediump vec3 worldNormal_18;
  worldNormal_18 = worldRefl_16;
  mediump float perceptualRoughness_19;
  perceptualRoughness_19 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = worldNormal_18;
  tmpvar_20.w = ((perceptualRoughness_19 * (1.7 - 
    (0.7 * perceptualRoughness_19)
  )) * 6.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_18, tmpvar_20.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump float tmpvar_23;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_23 = tmpvar_22.w;
  } else {
    tmpvar_23 = 1.0;
  };
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (((unity_SpecCube0_HDR.x * tmpvar_23) * tmpvar_22.xyz), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _LightColor0.xyz;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_13 + lightDir_12)
  )));
  nh_14 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (nh_14, (tmpvar_8 * 128.0));
  specular_15 = (tmpvar_26 * tmpvar_28);
  specular_15.xyz = (specular_15.xyz + tmpvar_24);
  specular_15.xyz = (specular_15.xyz * vec3(_Specularity));
  tmpvar_11 = ((specular_15.x + specular_15.y) + (specular_15.z * 0.333));
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = specular_15.xyz;
  tmpvar_29.w = tmpvar_11;
  tmpvar_9 = tmpvar_29;
  c_1 = tmpvar_9;
  lowp vec4 color_30;
  lowp vec3 uvgrab_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_31 = tmpvar_32;
  uvgrab_31.xy = (uvgrab_31.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_31.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_30 = (c_1 + texture2D (_GrabTexture, uvgrab_31.xy));
  color_30.w = min (1.0, color_30.w);
  highp vec3 tmpvar_33;
  tmpvar_33 = mix ((xlv_TEXCOORD4.xyz * color_30.w), color_30.xyz, xlv_TEXCOORD4.www);
  color_30.xyz = tmpvar_33;
  color_30 = (color_30 + (tmpvar_3 * 0.0001));
  c_1 = color_30;
  gl_FragData[0] = color_30;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_4 * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = 0.0;
  mediump vec3 lightDir_12;
  lightDir_12 = lightDir_5;
  mediump vec3 viewDir_13;
  viewDir_13 = worldViewDir_4;
  lowp float nh_14;
  lowp vec4 specular_15;
  lowp vec3 worldRefl_16;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (-(viewDir_13) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_16 = tmpvar_17;
  mediump vec3 worldNormal_18;
  worldNormal_18 = worldRefl_16;
  mediump float perceptualRoughness_19;
  perceptualRoughness_19 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = worldNormal_18;
  tmpvar_20.w = ((perceptualRoughness_19 * (1.7 - 
    (0.7 * perceptualRoughness_19)
  )) * 6.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_18, tmpvar_20.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump float tmpvar_23;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_23 = tmpvar_22.w;
  } else {
    tmpvar_23 = 1.0;
  };
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (((unity_SpecCube0_HDR.x * tmpvar_23) * tmpvar_22.xyz), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _LightColor0.xyz;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_13 + lightDir_12)
  )));
  nh_14 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (nh_14, (tmpvar_8 * 128.0));
  specular_15 = (tmpvar_26 * tmpvar_28);
  specular_15.xyz = (specular_15.xyz + tmpvar_24);
  specular_15.xyz = (specular_15.xyz * vec3(_Specularity));
  tmpvar_11 = ((specular_15.x + specular_15.y) + (specular_15.z * 0.333));
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = specular_15.xyz;
  tmpvar_29.w = tmpvar_11;
  tmpvar_9 = tmpvar_29;
  c_1 = tmpvar_9;
  lowp vec4 color_30;
  lowp vec3 uvgrab_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_31 = tmpvar_32;
  uvgrab_31.xy = (uvgrab_31.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_31.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_30 = (c_1 + texture2D (_GrabTexture, uvgrab_31.xy));
  color_30.w = min (1.0, color_30.w);
  highp vec3 tmpvar_33;
  tmpvar_33 = mix ((xlv_TEXCOORD4.xyz * color_30.w), color_30.xyz, xlv_TEXCOORD4.www);
  color_30.xyz = tmpvar_33;
  color_30 = (color_30 + (tmpvar_3 * 0.0001));
  c_1 = color_30;
  gl_FragData[0] = color_30;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_4 * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_21;
  tmpvar_21.x = tmpvar_20.x;
  tmpvar_21.y = (tmpvar_20.y * _ProjectionParams.x);
  o_19.xy = (tmpvar_21 + tmpvar_20.w);
  o_19.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_19;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = 0.0;
  mediump vec3 lightDir_12;
  lightDir_12 = lightDir_5;
  mediump vec3 viewDir_13;
  viewDir_13 = worldViewDir_4;
  lowp float nh_14;
  lowp vec4 specular_15;
  lowp vec3 worldRefl_16;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_17;
  tmpvar_17 = (-(viewDir_13) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_16 = tmpvar_17;
  mediump vec3 worldNormal_18;
  worldNormal_18 = worldRefl_16;
  mediump float perceptualRoughness_19;
  perceptualRoughness_19 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = worldNormal_18;
  tmpvar_20.w = ((perceptualRoughness_19 * (1.7 - 
    (0.7 * perceptualRoughness_19)
  )) * 6.0);
  lowp vec4 tmpvar_21;
  tmpvar_21 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_18, tmpvar_20.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump float tmpvar_23;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_23 = tmpvar_22.w;
  } else {
    tmpvar_23 = 1.0;
  };
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (((unity_SpecCube0_HDR.x * tmpvar_23) * tmpvar_22.xyz), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = _LightColor0.xyz;
  mediump float tmpvar_27;
  tmpvar_27 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_13 + lightDir_12)
  )));
  nh_14 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (nh_14, (tmpvar_8 * 128.0));
  specular_15 = (tmpvar_26 * tmpvar_28);
  specular_15.xyz = (specular_15.xyz + tmpvar_24);
  specular_15.xyz = (specular_15.xyz * vec3(_Specularity));
  tmpvar_11 = ((specular_15.x + specular_15.y) + (specular_15.z * 0.333));
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = specular_15.xyz;
  tmpvar_29.w = tmpvar_11;
  tmpvar_9 = tmpvar_29;
  c_1 = tmpvar_9;
  lowp vec4 color_30;
  lowp vec3 uvgrab_31;
  highp vec3 tmpvar_32;
  tmpvar_32 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_31 = tmpvar_32;
  uvgrab_31.xy = (uvgrab_31.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_31.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_30 = (c_1 + texture2D (_GrabTexture, uvgrab_31.xy));
  color_30.w = min (1.0, color_30.w);
  highp vec3 tmpvar_33;
  tmpvar_33 = mix ((xlv_TEXCOORD4.xyz * color_30.w), color_30.xyz, xlv_TEXCOORD4.www);
  color_30.xyz = tmpvar_33;
  color_30 = (color_30 + (tmpvar_3 * 0.0001));
  c_1 = color_30;
  gl_FragData[0] = color_30;
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
Fallback "Holo/Glass without Refraction"
CustomEditor "CustomMaterialInspector"
}