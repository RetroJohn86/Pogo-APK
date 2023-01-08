//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye with Fresnel Pupil/Pixel Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
 _EyeSpec ("Eye Specular", Range(0.000000,1.000000)) = 1.000000
 _EyeGloss ("Eye Glossiness", Range(0.025000,1.000000)) = 0.950000
 _PupilColor ("Eye Pupil Color (RGB)", Color) = (0.100000,0.100000,0.100000,1.000000)
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 250
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 52516
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_6.x = tmpvar_13.x;
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
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
lowp vec4 impl_low_texture2DLodEXT(lowp sampler2D sampler, highp vec2 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return texture2DLodEXT(sampler, coord, lod);
#else
	return texture2D(sampler, coord, lod);
#endif
}

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
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
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
  lowp vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = xlv_TEXCOORD5;
  tmpvar_15.w = c_18.w;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_24;
  tmpvar_24.xz = vec2(0.0, 0.0);
  tmpvar_24.y = _EyeShadowOffset.x;
  tmpvar_24.w = _EyeShadowOffset.y;
  highp vec4 coord_25;
  coord_25 = (tmpvar_23 + tmpvar_24);
  highp vec4 tmpvar_26;
  tmpvar_26.z = 0.0;
  tmpvar_26.xy = xlv_TEXCOORD0;
  tmpvar_26.w = _EyeShadowOffset.z;
  lowp float y_27;
  y_27 = (((impl_low_texture2DLodEXT (_MainTex, coord_25.xy, coord_25.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_26.w).w);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(mix (1.0, y_27, c_18.w));
  tmpvar_10.w = tmpvar_28.w;
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3((c_18.w * _EyeSpec));
  tmpvar_10.xyz = tmpvar_29;
  tmpvar_11 = _EyeGloss;
  tmpvar_3 = tmpvar_15;
  mediump vec4 tmpvar_30;
  mediump vec4 tmpvar_31;
  lowp vec3 tmpvar_32;
  tmpvar_31.w = tmpvar_9.w;
  mediump vec3 lightDir_33;
  lightDir_33 = lightDir_5;
  mediump vec3 viewDir_34;
  viewDir_34 = worldViewDir_4;
  lowp float nh_35;
  lowp vec4 specular_36;
  lowp vec3 color_37;
  lowp vec3 worldRefl_38;
  lowp vec4 ramp_39;
  lowp float vdn_40;
  lowp vec4 ldn_41;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_10.w);
  tmpvar_32 = normalize(tmpvar_2);
  mediump vec4 tmpvar_42;
  tmpvar_42 = vec4(dot (tmpvar_32, lightDir_33));
  ldn_41 = tmpvar_42;
  ldn_41.w = ((ldn_41.x * 0.5) + 0.5);
  ldn_41.y = max (0.0, ldn_41.x);
  mediump float tmpvar_43;
  tmpvar_43 = mix (ldn_41.y, ldn_41.w, tmpvar_9.w);
  ldn_41.z = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (viewDir_34, tmpvar_32);
  vdn_40 = tmpvar_44;
  lowp vec2 tmpvar_45;
  tmpvar_45.x = ldn_41.z;
  tmpvar_45.y = tmpvar_13.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_Ramp, tmpvar_45);
  ramp_39.w = tmpvar_46.w;
  ramp_39.xyz = ((tmpvar_46.xyz * (1.0 - tmpvar_15.w)) + (ldn_41.zzz * tmpvar_15.w));
  lowp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = ((ramp_39.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_14 * tmpvar_46.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (-(viewDir_34) - ((2.0 * tmpvar_32) * -(vdn_40)));
  worldRefl_38 = tmpvar_48;
  mediump vec3 worldNormal_49;
  worldNormal_49 = worldRefl_38;
  mediump float roughness_50;
  roughness_50 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = worldNormal_49;
  tmpvar_51.w = ((roughness_50 * (1.7 - 
    (0.7 * roughness_50)
  )) * 6.0);
  lowp vec4 tmpvar_52;
  tmpvar_52 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_49, tmpvar_51.w);
  mediump vec4 tmpvar_53;
  tmpvar_53 = tmpvar_52;
  lowp vec3 tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_53.w * unity_SpecCube0_HDR.x) * tmpvar_53.xyz), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  lowp float tmpvar_56;
  tmpvar_56 = (1.0 - clamp (vdn_40, 0.0, 1.0));
  lowp vec3 tmpvar_57;
  tmpvar_57 = vec3((tmpvar_12 * (1.0 - clamp (
    ((tmpvar_56 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_31.xyz = mix (tmpvar_9.xyz, _PupilColor.xyz, tmpvar_57);
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_31.xyz * tmpvar_47.xyz);
  color_37 = tmpvar_58;
  lowp vec4 tmpvar_59;
  tmpvar_59.w = 1.0;
  tmpvar_59.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_60;
  tmpvar_60 = max (0.0, dot (tmpvar_32, normalize(
    (viewDir_34 + lightDir_33)
  )));
  nh_35 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = pow (nh_35, (tmpvar_11 * 128.0));
  specular_36 = (tmpvar_59 * tmpvar_61);
  specular_36.xyz = (specular_36.xyz + ((
    ((tmpvar_54 * (tmpvar_10.w * tmpvar_15.w)) * (1.0 - tmpvar_13.w))
   * tmpvar_56) * tmpvar_56));
  specular_36.xyz = (specular_36.xyz * tmpvar_10.xyz);
  color_37 = (color_37 + specular_36.xyz);
  lowp vec4 tmpvar_62;
  tmpvar_62.xyz = color_37;
  tmpvar_62.w = tmpvar_12;
  tmpvar_30 = tmpvar_62;
  c_1 = tmpvar_30;
  lowp vec4 color_63;
  color_63.w = c_1.w;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_63.xyz = tmpvar_64;
  c_1.xyz = color_63.xyz;
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_6.x = tmpvar_13.x;
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
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
lowp vec4 impl_low_texture2DLodEXT(lowp sampler2D sampler, highp vec2 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return texture2DLodEXT(sampler, coord, lod);
#else
	return texture2D(sampler, coord, lod);
#endif
}

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
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
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
  lowp vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = xlv_TEXCOORD5;
  tmpvar_15.w = c_18.w;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_24;
  tmpvar_24.xz = vec2(0.0, 0.0);
  tmpvar_24.y = _EyeShadowOffset.x;
  tmpvar_24.w = _EyeShadowOffset.y;
  highp vec4 coord_25;
  coord_25 = (tmpvar_23 + tmpvar_24);
  highp vec4 tmpvar_26;
  tmpvar_26.z = 0.0;
  tmpvar_26.xy = xlv_TEXCOORD0;
  tmpvar_26.w = _EyeShadowOffset.z;
  lowp float y_27;
  y_27 = (((impl_low_texture2DLodEXT (_MainTex, coord_25.xy, coord_25.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_26.w).w);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(mix (1.0, y_27, c_18.w));
  tmpvar_10.w = tmpvar_28.w;
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3((c_18.w * _EyeSpec));
  tmpvar_10.xyz = tmpvar_29;
  tmpvar_11 = _EyeGloss;
  tmpvar_3 = tmpvar_15;
  mediump vec4 tmpvar_30;
  mediump vec4 tmpvar_31;
  lowp vec3 tmpvar_32;
  tmpvar_31.w = tmpvar_9.w;
  mediump vec3 lightDir_33;
  lightDir_33 = lightDir_5;
  mediump vec3 viewDir_34;
  viewDir_34 = worldViewDir_4;
  lowp float nh_35;
  lowp vec4 specular_36;
  lowp vec3 color_37;
  lowp vec3 worldRefl_38;
  lowp vec4 ramp_39;
  lowp float vdn_40;
  lowp vec4 ldn_41;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_10.w);
  tmpvar_32 = normalize(tmpvar_2);
  mediump vec4 tmpvar_42;
  tmpvar_42 = vec4(dot (tmpvar_32, lightDir_33));
  ldn_41 = tmpvar_42;
  ldn_41.w = ((ldn_41.x * 0.5) + 0.5);
  ldn_41.y = max (0.0, ldn_41.x);
  mediump float tmpvar_43;
  tmpvar_43 = mix (ldn_41.y, ldn_41.w, tmpvar_9.w);
  ldn_41.z = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (viewDir_34, tmpvar_32);
  vdn_40 = tmpvar_44;
  lowp vec2 tmpvar_45;
  tmpvar_45.x = ldn_41.z;
  tmpvar_45.y = tmpvar_13.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_Ramp, tmpvar_45);
  ramp_39.w = tmpvar_46.w;
  ramp_39.xyz = ((tmpvar_46.xyz * (1.0 - tmpvar_15.w)) + (ldn_41.zzz * tmpvar_15.w));
  lowp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = ((ramp_39.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_14 * tmpvar_46.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (-(viewDir_34) - ((2.0 * tmpvar_32) * -(vdn_40)));
  worldRefl_38 = tmpvar_48;
  mediump vec3 worldNormal_49;
  worldNormal_49 = worldRefl_38;
  mediump float roughness_50;
  roughness_50 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = worldNormal_49;
  tmpvar_51.w = ((roughness_50 * (1.7 - 
    (0.7 * roughness_50)
  )) * 6.0);
  lowp vec4 tmpvar_52;
  tmpvar_52 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_49, tmpvar_51.w);
  mediump vec4 tmpvar_53;
  tmpvar_53 = tmpvar_52;
  lowp vec3 tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_53.w * unity_SpecCube0_HDR.x) * tmpvar_53.xyz), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  lowp float tmpvar_56;
  tmpvar_56 = (1.0 - clamp (vdn_40, 0.0, 1.0));
  lowp vec3 tmpvar_57;
  tmpvar_57 = vec3((tmpvar_12 * (1.0 - clamp (
    ((tmpvar_56 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_31.xyz = mix (tmpvar_9.xyz, _PupilColor.xyz, tmpvar_57);
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_31.xyz * tmpvar_47.xyz);
  color_37 = tmpvar_58;
  lowp vec4 tmpvar_59;
  tmpvar_59.w = 1.0;
  tmpvar_59.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_60;
  tmpvar_60 = max (0.0, dot (tmpvar_32, normalize(
    (viewDir_34 + lightDir_33)
  )));
  nh_35 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = pow (nh_35, (tmpvar_11 * 128.0));
  specular_36 = (tmpvar_59 * tmpvar_61);
  specular_36.xyz = (specular_36.xyz + ((
    ((tmpvar_54 * (tmpvar_10.w * tmpvar_15.w)) * (1.0 - tmpvar_13.w))
   * tmpvar_56) * tmpvar_56));
  specular_36.xyz = (specular_36.xyz * tmpvar_10.xyz);
  color_37 = (color_37 + specular_36.xyz);
  lowp vec4 tmpvar_62;
  tmpvar_62.xyz = color_37;
  tmpvar_62.w = tmpvar_12;
  tmpvar_30 = tmpvar_62;
  c_1 = tmpvar_30;
  lowp vec4 color_63;
  color_63.w = c_1.w;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_63.xyz = tmpvar_64;
  c_1.xyz = color_63.xyz;
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_6.x = tmpvar_13.x;
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
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
lowp vec4 impl_low_texture2DLodEXT(lowp sampler2D sampler, highp vec2 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return texture2DLodEXT(sampler, coord, lod);
#else
	return texture2D(sampler, coord, lod);
#endif
}

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
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
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
  lowp vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = xlv_TEXCOORD5;
  tmpvar_15.w = c_18.w;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_24;
  tmpvar_24.xz = vec2(0.0, 0.0);
  tmpvar_24.y = _EyeShadowOffset.x;
  tmpvar_24.w = _EyeShadowOffset.y;
  highp vec4 coord_25;
  coord_25 = (tmpvar_23 + tmpvar_24);
  highp vec4 tmpvar_26;
  tmpvar_26.z = 0.0;
  tmpvar_26.xy = xlv_TEXCOORD0;
  tmpvar_26.w = _EyeShadowOffset.z;
  lowp float y_27;
  y_27 = (((impl_low_texture2DLodEXT (_MainTex, coord_25.xy, coord_25.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_26.w).w);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(mix (1.0, y_27, c_18.w));
  tmpvar_10.w = tmpvar_28.w;
  mediump vec3 tmpvar_29;
  tmpvar_29 = vec3((c_18.w * _EyeSpec));
  tmpvar_10.xyz = tmpvar_29;
  tmpvar_11 = _EyeGloss;
  tmpvar_3 = tmpvar_15;
  mediump vec4 tmpvar_30;
  mediump vec4 tmpvar_31;
  lowp vec3 tmpvar_32;
  tmpvar_31.w = tmpvar_9.w;
  mediump vec3 lightDir_33;
  lightDir_33 = lightDir_5;
  mediump vec3 viewDir_34;
  viewDir_34 = worldViewDir_4;
  lowp float nh_35;
  lowp vec4 specular_36;
  lowp vec3 color_37;
  lowp vec3 worldRefl_38;
  lowp vec4 ramp_39;
  lowp float vdn_40;
  lowp vec4 ldn_41;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_10.w);
  tmpvar_32 = normalize(tmpvar_2);
  mediump vec4 tmpvar_42;
  tmpvar_42 = vec4(dot (tmpvar_32, lightDir_33));
  ldn_41 = tmpvar_42;
  ldn_41.w = ((ldn_41.x * 0.5) + 0.5);
  ldn_41.y = max (0.0, ldn_41.x);
  mediump float tmpvar_43;
  tmpvar_43 = mix (ldn_41.y, ldn_41.w, tmpvar_9.w);
  ldn_41.z = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (viewDir_34, tmpvar_32);
  vdn_40 = tmpvar_44;
  lowp vec2 tmpvar_45;
  tmpvar_45.x = ldn_41.z;
  tmpvar_45.y = tmpvar_13.w;
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_Ramp, tmpvar_45);
  ramp_39.w = tmpvar_46.w;
  ramp_39.xyz = ((tmpvar_46.xyz * (1.0 - tmpvar_15.w)) + (ldn_41.zzz * tmpvar_15.w));
  lowp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = ((ramp_39.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_14 * tmpvar_46.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_48;
  tmpvar_48 = (-(viewDir_34) - ((2.0 * tmpvar_32) * -(vdn_40)));
  worldRefl_38 = tmpvar_48;
  mediump vec3 worldNormal_49;
  worldNormal_49 = worldRefl_38;
  mediump float roughness_50;
  roughness_50 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_51;
  tmpvar_51.xyz = worldNormal_49;
  tmpvar_51.w = ((roughness_50 * (1.7 - 
    (0.7 * roughness_50)
  )) * 6.0);
  lowp vec4 tmpvar_52;
  tmpvar_52 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_49, tmpvar_51.w);
  mediump vec4 tmpvar_53;
  tmpvar_53 = tmpvar_52;
  lowp vec3 tmpvar_54;
  mediump vec3 tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_53.w * unity_SpecCube0_HDR.x) * tmpvar_53.xyz), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  lowp float tmpvar_56;
  tmpvar_56 = (1.0 - clamp (vdn_40, 0.0, 1.0));
  lowp vec3 tmpvar_57;
  tmpvar_57 = vec3((tmpvar_12 * (1.0 - clamp (
    ((tmpvar_56 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_31.xyz = mix (tmpvar_9.xyz, _PupilColor.xyz, tmpvar_57);
  mediump vec3 tmpvar_58;
  tmpvar_58 = (tmpvar_31.xyz * tmpvar_47.xyz);
  color_37 = tmpvar_58;
  lowp vec4 tmpvar_59;
  tmpvar_59.w = 1.0;
  tmpvar_59.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_60;
  tmpvar_60 = max (0.0, dot (tmpvar_32, normalize(
    (viewDir_34 + lightDir_33)
  )));
  nh_35 = tmpvar_60;
  mediump float tmpvar_61;
  tmpvar_61 = pow (nh_35, (tmpvar_11 * 128.0));
  specular_36 = (tmpvar_59 * tmpvar_61);
  specular_36.xyz = (specular_36.xyz + ((
    ((tmpvar_54 * (tmpvar_10.w * tmpvar_15.w)) * (1.0 - tmpvar_13.w))
   * tmpvar_56) * tmpvar_56));
  specular_36.xyz = (specular_36.xyz * tmpvar_10.xyz);
  color_37 = (color_37 + specular_36.xyz);
  lowp vec4 tmpvar_62;
  tmpvar_62.xyz = color_37;
  tmpvar_62.w = tmpvar_12;
  tmpvar_30 = tmpvar_62;
  c_1 = tmpvar_30;
  lowp vec4 color_63;
  color_63.w = c_1.w;
  highp vec3 tmpvar_64;
  tmpvar_64 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_63.xyz = tmpvar_64;
  c_1.xyz = color_63.xyz;
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
Fallback "Holo/Character/Eye with Fresnel Pupil/Vertex Lit"
}