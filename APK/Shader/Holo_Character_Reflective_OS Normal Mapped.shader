//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Reflective/OS Normal Mapped" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[KeywordEnum(None,, Cubemap)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
[Toggle(BRB_METAL)] _Metal ("Metal", Float) = 0
_Metalness ("    Metalness", Range(0, 1)) = 1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 275
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 275
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 53202
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float rim_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = normalize(tmpvar_16.xyz);
  tmpvar_17.w = tmpvar_16.w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_5;
  tmpvar_6 = (tmpvar_17 - tmpvar_18);
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_19[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_19[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * tmpvar_5));
  vsNormal_10 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  highp vec4 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = unity_FogColor.xyz;
  tmpvar_23 = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_5 * tmpvar_25));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_29.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_10.x;
  rim_8 = tmpvar_30;
  lowp vec3 tmpvar_31;
  if ((rim_8 < 0.0)) {
    tmpvar_31 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_31 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_2 = tmpvar_35;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_29;
  xlv_TEXCOORD5 = (tmpvar_31 * abs(rim_8));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_33);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_9 = tmpvar_19;
  tmpvar_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_9.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp vec3 color_32;
  lowp vec3 worldRefl_33;
  lowp vec4 ldn_34;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_34 = tmpvar_35;
  ldn_34.w = ((ldn_34.x * 0.5) + 0.5);
  ldn_34.y = max (0.0, ldn_34.x);
  mediump float tmpvar_36;
  tmpvar_36 = mix (ldn_34.y, ldn_34.w, tmpvar_7.w);
  ldn_34.z = tmpvar_36;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_9.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_37;
  tmpvar_37.x = ldn_34.z;
  tmpvar_37.y = tmpvar_29.w;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_Ramp, tmpvar_37);
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_38.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_38.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (-(viewDir_31) - ((2.0 * tmpvar_28) * -(tmpvar_9.w)));
  worldRefl_33 = tmpvar_40;
  mediump vec3 worldNormal_41;
  worldNormal_41 = worldRefl_33;
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_41, 0.4995);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump float tmpvar_44;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_44 = tmpvar_43.w;
  } else {
    tmpvar_44 = 1.0;
  };
  lowp vec3 tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46 = clamp (((unity_SpecCube0_HDR.x * tmpvar_44) * tmpvar_43.xyz), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_32 = tmpvar_47;
  color_32 = (color_32 + tmpvar_45);
  lowp vec4 tmpvar_48;
  tmpvar_48.xyz = color_32;
  tmpvar_48.w = tmpvar_8;
  tmpvar_27 = tmpvar_48;
  c_1 = tmpvar_27;
  lowp vec4 color_49;
  color_49.w = c_1.w;
  mediump vec4 envFogColor_50;
  highp vec4 tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = unity_FogColor.xyz;
  tmpvar_51 = tmpvar_52;
  envFogColor_50 = tmpvar_51;
  envFogColor_50.w = (envFogColor_50.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_53;
  tmpvar_53 = mix (envFogColor_50.xyz, c_1.xyz, envFogColor_50.www);
  color_49.xyz = tmpvar_53;
  c_1.xyz = color_49.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float rim_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = normalize(tmpvar_16.xyz);
  tmpvar_17.w = tmpvar_16.w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_5;
  tmpvar_6 = (tmpvar_17 - tmpvar_18);
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_19[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_19[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * tmpvar_5));
  vsNormal_10 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  highp vec4 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = unity_FogColor.xyz;
  tmpvar_23 = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_5 * tmpvar_25));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_29.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_10.x;
  rim_8 = tmpvar_30;
  lowp vec3 tmpvar_31;
  if ((rim_8 < 0.0)) {
    tmpvar_31 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_31 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_2 = tmpvar_35;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_29;
  xlv_TEXCOORD5 = (tmpvar_31 * abs(rim_8));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_33);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_9 = tmpvar_19;
  tmpvar_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_9.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp vec3 color_32;
  lowp vec3 worldRefl_33;
  lowp vec4 ldn_34;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_34 = tmpvar_35;
  ldn_34.w = ((ldn_34.x * 0.5) + 0.5);
  ldn_34.y = max (0.0, ldn_34.x);
  mediump float tmpvar_36;
  tmpvar_36 = mix (ldn_34.y, ldn_34.w, tmpvar_7.w);
  ldn_34.z = tmpvar_36;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_9.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_37;
  tmpvar_37.x = ldn_34.z;
  tmpvar_37.y = tmpvar_29.w;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_Ramp, tmpvar_37);
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_38.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_38.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (-(viewDir_31) - ((2.0 * tmpvar_28) * -(tmpvar_9.w)));
  worldRefl_33 = tmpvar_40;
  mediump vec3 worldNormal_41;
  worldNormal_41 = worldRefl_33;
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_41, 0.4995);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump float tmpvar_44;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_44 = tmpvar_43.w;
  } else {
    tmpvar_44 = 1.0;
  };
  lowp vec3 tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46 = clamp (((unity_SpecCube0_HDR.x * tmpvar_44) * tmpvar_43.xyz), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_32 = tmpvar_47;
  color_32 = (color_32 + tmpvar_45);
  lowp vec4 tmpvar_48;
  tmpvar_48.xyz = color_32;
  tmpvar_48.w = tmpvar_8;
  tmpvar_27 = tmpvar_48;
  c_1 = tmpvar_27;
  lowp vec4 color_49;
  color_49.w = c_1.w;
  mediump vec4 envFogColor_50;
  highp vec4 tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = unity_FogColor.xyz;
  tmpvar_51 = tmpvar_52;
  envFogColor_50 = tmpvar_51;
  envFogColor_50.w = (envFogColor_50.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_53;
  tmpvar_53 = mix (envFogColor_50.xyz, c_1.xyz, envFogColor_50.www);
  color_49.xyz = tmpvar_53;
  c_1.xyz = color_49.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float rim_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = normalize(tmpvar_16.xyz);
  tmpvar_17.w = tmpvar_16.w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_5;
  tmpvar_6 = (tmpvar_17 - tmpvar_18);
  highp mat3 tmpvar_19;
  tmpvar_19[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_19[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_19[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_19 * tmpvar_5));
  vsNormal_10 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  highp vec4 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = unity_FogColor.xyz;
  tmpvar_23 = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_WorldToObject[0].xyz;
  tmpvar_25[1] = unity_WorldToObject[1].xyz;
  tmpvar_25[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_5 * tmpvar_25));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_29.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_10.x;
  rim_8 = tmpvar_30;
  lowp vec3 tmpvar_31;
  if ((rim_8 < 0.0)) {
    tmpvar_31 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_31 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_2 = tmpvar_35;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_29;
  xlv_TEXCOORD5 = (tmpvar_31 * abs(rim_8));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_33);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_9 = tmpvar_19;
  tmpvar_10 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_9.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp vec3 color_32;
  lowp vec3 worldRefl_33;
  lowp vec4 ldn_34;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_34 = tmpvar_35;
  ldn_34.w = ((ldn_34.x * 0.5) + 0.5);
  ldn_34.y = max (0.0, ldn_34.x);
  mediump float tmpvar_36;
  tmpvar_36 = mix (ldn_34.y, ldn_34.w, tmpvar_7.w);
  ldn_34.z = tmpvar_36;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_9.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_37;
  tmpvar_37.x = ldn_34.z;
  tmpvar_37.y = tmpvar_29.w;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_Ramp, tmpvar_37);
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((tmpvar_38.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_38.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_40;
  tmpvar_40 = (-(viewDir_31) - ((2.0 * tmpvar_28) * -(tmpvar_9.w)));
  worldRefl_33 = tmpvar_40;
  mediump vec3 worldNormal_41;
  worldNormal_41 = worldRefl_33;
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_41, 0.4995);
  mediump vec4 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump float tmpvar_44;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_44 = tmpvar_43.w;
  } else {
    tmpvar_44 = 1.0;
  };
  lowp vec3 tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46 = clamp (((unity_SpecCube0_HDR.x * tmpvar_44) * tmpvar_43.xyz), 0.0, 1.0);
  tmpvar_45 = tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_32 = tmpvar_47;
  color_32 = (color_32 + tmpvar_45);
  lowp vec4 tmpvar_48;
  tmpvar_48.xyz = color_32;
  tmpvar_48.w = tmpvar_8;
  tmpvar_27 = tmpvar_48;
  c_1 = tmpvar_27;
  lowp vec4 color_49;
  color_49.w = c_1.w;
  mediump vec4 envFogColor_50;
  highp vec4 tmpvar_51;
  lowp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = unity_FogColor.xyz;
  tmpvar_51 = tmpvar_52;
  envFogColor_50 = tmpvar_51;
  envFogColor_50.w = (envFogColor_50.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_53;
  tmpvar_53 = mix (envFogColor_50.xyz, c_1.xyz, envFogColor_50.www);
  color_49.xyz = tmpvar_53;
  c_1.xyz = color_49.xyz;
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
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Holo/Character/Reflective/Pixel Lit"
CustomEditor "CustomMaterialInspector"
}