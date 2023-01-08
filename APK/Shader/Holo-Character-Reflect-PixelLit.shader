//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Reflective/Pixel Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[KeywordEnum(None,, Cubemap)]  _Fresnel ("Fresnel Mode", Float) = 0.000000
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
[Toggle(BRB_METAL)]  _Metal ("Metal", Float) = 0.000000
 _Metalness ("    Metalness", Range(0.000000,1.000000)) = 1.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 275
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 13310
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_6.xz = tmpvar_13.xz;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_16;
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_4));
  vsNormal_11 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_20.w = exp2((-(tmpvar_19) * tmpvar_19));
  highp vec4 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_21 = tmpvar_22;
  envFogColor_10 = (tmpvar_20 * tmpvar_21);
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_4.x)
   + 
    (v_24.xyz * tmpvar_4.y)
  ) + (v_25.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_11.x;
  rim_7 = tmpvar_29;
  lowp vec3 tmpvar_30;
  if ((rim_7 < 0.0)) {
    tmpvar_30 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_30 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * tmpvar_4.x)
   + 
    (v_34.xyz * tmpvar_4.y)
  ) + (v_35.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_32;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_32);
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
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD6);
  worldViewDir_4 = tmpvar_8;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_9;
  lowp float tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = tmpvar_6.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_11 = tmpvar_20;
  tmpvar_12 = xlv_TEXCOORD5;
  tmpvar_13.w = c_16.w;
  tmpvar_3 = tmpvar_13;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_11.xyz;
  mediump vec3 lightDir_24;
  lightDir_24 = lightDir_5;
  mediump vec3 viewDir_25;
  viewDir_25 = worldViewDir_4;
  lowp vec3 color_26;
  lowp vec3 worldRefl_27;
  lowp vec4 ldn_28;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_29;
  tmpvar_29 = vec4(dot (tmpvar_22, lightDir_24));
  ldn_28 = tmpvar_29;
  ldn_28.w = ((ldn_28.x * 0.5) + 0.5);
  ldn_28.y = max (0.0, ldn_28.x);
  mediump float tmpvar_30;
  tmpvar_30 = mix (ldn_28.y, ldn_28.w, tmpvar_9.w);
  ldn_28.z = tmpvar_30;
  tmpvar_23.w = ((1.0 - clamp (tmpvar_11.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_28.z;
  tmpvar_31.y = tmpvar_23.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = ((tmpvar_32.xyz * _LightColor0.xyz) + ((tmpvar_12 * tmpvar_32.www) + tmpvar_11.xyz));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (-(viewDir_25) - ((2.0 * tmpvar_22) * -(tmpvar_11.w)));
  worldRefl_27 = tmpvar_34;
  mediump vec3 worldNormal_35;
  worldNormal_35 = worldRefl_27;
  lowp vec4 tmpvar_36;
  tmpvar_36 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_35, 0.4995);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  lowp vec3 tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = clamp (((tmpvar_37.w * unity_SpecCube0_HDR.x) * tmpvar_37.xyz), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_9.xyz * tmpvar_33.xyz);
  color_26 = tmpvar_40;
  color_26 = (color_26 + tmpvar_38);
  lowp vec4 tmpvar_41;
  tmpvar_41.xyz = color_26;
  tmpvar_41.w = tmpvar_10;
  tmpvar_21 = tmpvar_41;
  c_1 = tmpvar_21;
  lowp vec4 color_42;
  color_42.w = c_1.w;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_42.xyz = tmpvar_43;
  c_1.xyz = color_42.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_6.xz = tmpvar_13.xz;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_16;
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_4));
  vsNormal_11 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_20.w = exp2((-(tmpvar_19) * tmpvar_19));
  highp vec4 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_21 = tmpvar_22;
  envFogColor_10 = (tmpvar_20 * tmpvar_21);
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_4.x)
   + 
    (v_24.xyz * tmpvar_4.y)
  ) + (v_25.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_11.x;
  rim_7 = tmpvar_29;
  lowp vec3 tmpvar_30;
  if ((rim_7 < 0.0)) {
    tmpvar_30 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_30 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * tmpvar_4.x)
   + 
    (v_34.xyz * tmpvar_4.y)
  ) + (v_35.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_32;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_32);
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
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD6);
  worldViewDir_4 = tmpvar_8;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_9;
  lowp float tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = tmpvar_6.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_11 = tmpvar_20;
  tmpvar_12 = xlv_TEXCOORD5;
  tmpvar_13.w = c_16.w;
  tmpvar_3 = tmpvar_13;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_11.xyz;
  mediump vec3 lightDir_24;
  lightDir_24 = lightDir_5;
  mediump vec3 viewDir_25;
  viewDir_25 = worldViewDir_4;
  lowp vec3 color_26;
  lowp vec3 worldRefl_27;
  lowp vec4 ldn_28;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_29;
  tmpvar_29 = vec4(dot (tmpvar_22, lightDir_24));
  ldn_28 = tmpvar_29;
  ldn_28.w = ((ldn_28.x * 0.5) + 0.5);
  ldn_28.y = max (0.0, ldn_28.x);
  mediump float tmpvar_30;
  tmpvar_30 = mix (ldn_28.y, ldn_28.w, tmpvar_9.w);
  ldn_28.z = tmpvar_30;
  tmpvar_23.w = ((1.0 - clamp (tmpvar_11.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_28.z;
  tmpvar_31.y = tmpvar_23.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = ((tmpvar_32.xyz * _LightColor0.xyz) + ((tmpvar_12 * tmpvar_32.www) + tmpvar_11.xyz));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (-(viewDir_25) - ((2.0 * tmpvar_22) * -(tmpvar_11.w)));
  worldRefl_27 = tmpvar_34;
  mediump vec3 worldNormal_35;
  worldNormal_35 = worldRefl_27;
  lowp vec4 tmpvar_36;
  tmpvar_36 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_35, 0.4995);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  lowp vec3 tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = clamp (((tmpvar_37.w * unity_SpecCube0_HDR.x) * tmpvar_37.xyz), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_9.xyz * tmpvar_33.xyz);
  color_26 = tmpvar_40;
  color_26 = (color_26 + tmpvar_38);
  lowp vec4 tmpvar_41;
  tmpvar_41.xyz = color_26;
  tmpvar_41.w = tmpvar_10;
  tmpvar_21 = tmpvar_41;
  c_1 = tmpvar_21;
  lowp vec4 color_42;
  color_42.w = c_1.w;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_42.xyz = tmpvar_43;
  c_1.xyz = color_42.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
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
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_6.xz = tmpvar_13.xz;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_16;
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_17[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_17[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * tmpvar_4));
  vsNormal_11 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_20.w = exp2((-(tmpvar_19) * tmpvar_19));
  highp vec4 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_21 = tmpvar_22;
  envFogColor_10 = (tmpvar_20 * tmpvar_21);
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_4.x)
   + 
    (v_24.xyz * tmpvar_4.y)
  ) + (v_25.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_28))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_11.x;
  rim_7 = tmpvar_29;
  lowp vec3 tmpvar_30;
  if ((rim_7 < 0.0)) {
    tmpvar_30 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_30 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * tmpvar_4.x)
   + 
    (v_34.xyz * tmpvar_4.y)
  ) + (v_35.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_32;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_32);
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
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD6);
  worldViewDir_4 = tmpvar_8;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_9;
  lowp float tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec3 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = tmpvar_6.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_11 = tmpvar_20;
  tmpvar_12 = xlv_TEXCOORD5;
  tmpvar_13.w = c_16.w;
  tmpvar_3 = tmpvar_13;
  mediump vec4 tmpvar_21;
  lowp vec3 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_11.xyz;
  mediump vec3 lightDir_24;
  lightDir_24 = lightDir_5;
  mediump vec3 viewDir_25;
  viewDir_25 = worldViewDir_4;
  lowp vec3 color_26;
  lowp vec3 worldRefl_27;
  lowp vec4 ldn_28;
  tmpvar_22 = normalize(tmpvar_2);
  mediump vec4 tmpvar_29;
  tmpvar_29 = vec4(dot (tmpvar_22, lightDir_24));
  ldn_28 = tmpvar_29;
  ldn_28.w = ((ldn_28.x * 0.5) + 0.5);
  ldn_28.y = max (0.0, ldn_28.x);
  mediump float tmpvar_30;
  tmpvar_30 = mix (ldn_28.y, ldn_28.w, tmpvar_9.w);
  ldn_28.z = tmpvar_30;
  tmpvar_23.w = ((1.0 - clamp (tmpvar_11.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_28.z;
  tmpvar_31.y = tmpvar_23.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = ((tmpvar_32.xyz * _LightColor0.xyz) + ((tmpvar_12 * tmpvar_32.www) + tmpvar_11.xyz));
  mediump vec3 tmpvar_34;
  tmpvar_34 = (-(viewDir_25) - ((2.0 * tmpvar_22) * -(tmpvar_11.w)));
  worldRefl_27 = tmpvar_34;
  mediump vec3 worldNormal_35;
  worldNormal_35 = worldRefl_27;
  lowp vec4 tmpvar_36;
  tmpvar_36 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_35, 0.4995);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  lowp vec3 tmpvar_38;
  mediump vec3 tmpvar_39;
  tmpvar_39 = clamp (((tmpvar_37.w * unity_SpecCube0_HDR.x) * tmpvar_37.xyz), 0.0, 1.0);
  tmpvar_38 = tmpvar_39;
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_9.xyz * tmpvar_33.xyz);
  color_26 = tmpvar_40;
  color_26 = (color_26 + tmpvar_38);
  lowp vec4 tmpvar_41;
  tmpvar_41.xyz = color_26;
  tmpvar_41.w = tmpvar_10;
  tmpvar_21 = tmpvar_41;
  c_1 = tmpvar_21;
  lowp vec4 color_42;
  color_42.w = c_1.w;
  highp vec3 tmpvar_43;
  tmpvar_43 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_42.xyz = tmpvar_43;
  c_1.xyz = color_42.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback "Holo/Character/Pixel Lit"
}