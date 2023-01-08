//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye with Fresnel Pupil/OS Normal Mapped" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_OsNormalMap ("Object-space Normal Map (RGB)", 2D) = "gray" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_EyeSpec ("Eye Specular", Range(0, 1)) = 1
_EyeGloss ("Eye Glossiness", Range(0.025, 1)) = 0.95
_PupilColor ("Eye Pupil Color (RGB)", Color) = (0.1,0.1,0.1,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 350
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 350
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 6780
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_7.x = tmpvar_12.x;
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
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_7;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec4 osNormal_15;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_4.w;
  tmpvar_8 = tmpvar_20;
  tmpvar_11 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_12 = tmpvar_22;
  tmpvar_13 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_23;
  tmpvar_23 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = tmpvar_23.w;
  osNormal_15.w = tmpvar_25.w;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_24 - tmpvar_4.xyz));
  osNormal_15.xyz = tmpvar_26;
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_27[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_27[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_27 * osNormal_15.xyz));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = c_18.w;
  tmpvar_14 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = tmpvar_5;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = tmpvar_5;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_18.w));
  tmpvar_9.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = vec3((c_18.w * _EyeSpec));
  tmpvar_9.xyz = tmpvar_36;
  tmpvar_10 = _EyeGloss;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_37;
  mediump vec4 tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_38 = tmpvar_8;
  mediump vec3 lightDir_40;
  lightDir_40 = lightDir_3;
  mediump vec3 viewDir_41;
  viewDir_41 = worldViewDir_2;
  lowp float nh_42;
  lowp vec4 specular_43;
  lowp vec3 color_44;
  lowp vec3 worldRefl_45;
  lowp vec4 ramp_46;
  lowp float vdn_47;
  lowp vec4 ldn_48;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_9.w);
  tmpvar_39 = normalize(tmpvar_14.xyz);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(dot (tmpvar_39, lightDir_40));
  ldn_48 = tmpvar_49;
  ldn_48.w = ((ldn_48.x * 0.5) + 0.5);
  ldn_48.y = max (0.0, ldn_48.x);
  mediump float tmpvar_50;
  tmpvar_50 = mix (ldn_48.y, ldn_48.w, tmpvar_8.w);
  ldn_48.z = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = dot (viewDir_41, tmpvar_39);
  vdn_47 = tmpvar_51;
  lowp vec2 tmpvar_52;
  tmpvar_52.x = ldn_48.z;
  tmpvar_52.y = tmpvar_12.w;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_Ramp, tmpvar_52);
  ramp_46.w = tmpvar_53.w;
  ramp_46.xyz = ((tmpvar_53.xyz * (1.0 - tmpvar_14.w)) + (ldn_48.zzz * tmpvar_14.w));
  lowp vec4 tmpvar_54;
  tmpvar_54.w = 1.0;
  tmpvar_54.xyz = ((ramp_46.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_13 * tmpvar_53.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (-(viewDir_41) - ((2.0 * tmpvar_39) * -(vdn_47)));
  worldRefl_45 = tmpvar_55;
  mediump vec3 worldNormal_56;
  worldNormal_56 = worldRefl_45;
  mediump float perceptualRoughness_57;
  perceptualRoughness_57 = (1.0 - tmpvar_10);
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = worldNormal_56;
  tmpvar_58.w = ((perceptualRoughness_57 * (1.7 - 
    (0.7 * perceptualRoughness_57)
  )) * 6.0);
  lowp vec4 tmpvar_59;
  tmpvar_59 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_56, tmpvar_58.w);
  mediump vec4 tmpvar_60;
  tmpvar_60 = tmpvar_59;
  mediump float tmpvar_61;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_61 = tmpvar_60.w;
  } else {
    tmpvar_61 = 1.0;
  };
  lowp vec3 tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63 = clamp (((unity_SpecCube0_HDR.x * tmpvar_61) * tmpvar_60.xyz), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  lowp float tmpvar_64;
  tmpvar_64 = (1.0 - clamp (vdn_47, 0.0, 1.0));
  lowp vec3 tmpvar_65;
  tmpvar_65 = vec3((tmpvar_11 * (1.0 - clamp (
    ((tmpvar_64 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_38.xyz = mix (tmpvar_8.xyz, _PupilColor.xyz, tmpvar_65);
  mediump vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_38.xyz * tmpvar_54.xyz);
  color_44 = tmpvar_66;
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_68;
  tmpvar_68 = max (0.0, dot (tmpvar_39, normalize(
    (viewDir_41 + lightDir_40)
  )));
  nh_42 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = pow (nh_42, (tmpvar_10 * 128.0));
  specular_43 = (tmpvar_67 * tmpvar_69);
  specular_43.xyz = (specular_43.xyz + ((
    ((tmpvar_62 * (tmpvar_9.w * tmpvar_14.w)) * (1.0 - tmpvar_12.w))
   * tmpvar_64) * tmpvar_64));
  specular_43.xyz = (specular_43.xyz * tmpvar_9.xyz);
  color_44 = (color_44 + specular_43.xyz);
  lowp vec4 tmpvar_70;
  tmpvar_70.xyz = color_44;
  tmpvar_70.w = tmpvar_11;
  tmpvar_37 = tmpvar_70;
  c_1 = tmpvar_37;
  lowp vec4 color_71;
  color_71.w = c_1.w;
  mediump vec4 envFogColor_72;
  highp vec4 tmpvar_73;
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = unity_FogColor.xyz;
  tmpvar_73 = tmpvar_74;
  envFogColor_72 = tmpvar_73;
  envFogColor_72.w = (envFogColor_72.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_75;
  tmpvar_75 = mix (envFogColor_72.xyz, c_1.xyz, envFogColor_72.www);
  color_71.xyz = tmpvar_75;
  c_1.xyz = color_71.xyz;
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_7.x = tmpvar_12.x;
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
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_7;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec4 osNormal_15;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_4.w;
  tmpvar_8 = tmpvar_20;
  tmpvar_11 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_12 = tmpvar_22;
  tmpvar_13 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_23;
  tmpvar_23 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = tmpvar_23.w;
  osNormal_15.w = tmpvar_25.w;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_24 - tmpvar_4.xyz));
  osNormal_15.xyz = tmpvar_26;
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_27[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_27[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_27 * osNormal_15.xyz));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = c_18.w;
  tmpvar_14 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = tmpvar_5;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = tmpvar_5;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_18.w));
  tmpvar_9.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = vec3((c_18.w * _EyeSpec));
  tmpvar_9.xyz = tmpvar_36;
  tmpvar_10 = _EyeGloss;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_37;
  mediump vec4 tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_38 = tmpvar_8;
  mediump vec3 lightDir_40;
  lightDir_40 = lightDir_3;
  mediump vec3 viewDir_41;
  viewDir_41 = worldViewDir_2;
  lowp float nh_42;
  lowp vec4 specular_43;
  lowp vec3 color_44;
  lowp vec3 worldRefl_45;
  lowp vec4 ramp_46;
  lowp float vdn_47;
  lowp vec4 ldn_48;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_9.w);
  tmpvar_39 = normalize(tmpvar_14.xyz);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(dot (tmpvar_39, lightDir_40));
  ldn_48 = tmpvar_49;
  ldn_48.w = ((ldn_48.x * 0.5) + 0.5);
  ldn_48.y = max (0.0, ldn_48.x);
  mediump float tmpvar_50;
  tmpvar_50 = mix (ldn_48.y, ldn_48.w, tmpvar_8.w);
  ldn_48.z = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = dot (viewDir_41, tmpvar_39);
  vdn_47 = tmpvar_51;
  lowp vec2 tmpvar_52;
  tmpvar_52.x = ldn_48.z;
  tmpvar_52.y = tmpvar_12.w;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_Ramp, tmpvar_52);
  ramp_46.w = tmpvar_53.w;
  ramp_46.xyz = ((tmpvar_53.xyz * (1.0 - tmpvar_14.w)) + (ldn_48.zzz * tmpvar_14.w));
  lowp vec4 tmpvar_54;
  tmpvar_54.w = 1.0;
  tmpvar_54.xyz = ((ramp_46.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_13 * tmpvar_53.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (-(viewDir_41) - ((2.0 * tmpvar_39) * -(vdn_47)));
  worldRefl_45 = tmpvar_55;
  mediump vec3 worldNormal_56;
  worldNormal_56 = worldRefl_45;
  mediump float perceptualRoughness_57;
  perceptualRoughness_57 = (1.0 - tmpvar_10);
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = worldNormal_56;
  tmpvar_58.w = ((perceptualRoughness_57 * (1.7 - 
    (0.7 * perceptualRoughness_57)
  )) * 6.0);
  lowp vec4 tmpvar_59;
  tmpvar_59 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_56, tmpvar_58.w);
  mediump vec4 tmpvar_60;
  tmpvar_60 = tmpvar_59;
  mediump float tmpvar_61;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_61 = tmpvar_60.w;
  } else {
    tmpvar_61 = 1.0;
  };
  lowp vec3 tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63 = clamp (((unity_SpecCube0_HDR.x * tmpvar_61) * tmpvar_60.xyz), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  lowp float tmpvar_64;
  tmpvar_64 = (1.0 - clamp (vdn_47, 0.0, 1.0));
  lowp vec3 tmpvar_65;
  tmpvar_65 = vec3((tmpvar_11 * (1.0 - clamp (
    ((tmpvar_64 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_38.xyz = mix (tmpvar_8.xyz, _PupilColor.xyz, tmpvar_65);
  mediump vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_38.xyz * tmpvar_54.xyz);
  color_44 = tmpvar_66;
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_68;
  tmpvar_68 = max (0.0, dot (tmpvar_39, normalize(
    (viewDir_41 + lightDir_40)
  )));
  nh_42 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = pow (nh_42, (tmpvar_10 * 128.0));
  specular_43 = (tmpvar_67 * tmpvar_69);
  specular_43.xyz = (specular_43.xyz + ((
    ((tmpvar_62 * (tmpvar_9.w * tmpvar_14.w)) * (1.0 - tmpvar_12.w))
   * tmpvar_64) * tmpvar_64));
  specular_43.xyz = (specular_43.xyz * tmpvar_9.xyz);
  color_44 = (color_44 + specular_43.xyz);
  lowp vec4 tmpvar_70;
  tmpvar_70.xyz = color_44;
  tmpvar_70.w = tmpvar_11;
  tmpvar_37 = tmpvar_70;
  c_1 = tmpvar_37;
  lowp vec4 color_71;
  color_71.w = c_1.w;
  mediump vec4 envFogColor_72;
  highp vec4 tmpvar_73;
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = unity_FogColor.xyz;
  tmpvar_73 = tmpvar_74;
  envFogColor_72 = tmpvar_73;
  envFogColor_72.w = (envFogColor_72.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_75;
  tmpvar_75 = mix (envFogColor_72.xyz, c_1.xyz, envFogColor_72.www);
  color_71.xyz = tmpvar_75;
  c_1.xyz = color_71.xyz;
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
uniform lowp float _EyeMirrorOffset;
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
  tmpvar_7.x = tmpvar_12.x;
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
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform lowp vec4 _PupilColor;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_7;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec4 osNormal_15;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_18 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_4.w;
  tmpvar_8 = tmpvar_20;
  tmpvar_11 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = xlv_TEXCOORD4.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.w;
  tmpvar_12 = tmpvar_22;
  tmpvar_13 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_23;
  tmpvar_23 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_24;
  tmpvar_24 = normalize(tmpvar_23.xyz);
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_24;
  tmpvar_25.w = tmpvar_23.w;
  osNormal_15.w = tmpvar_25.w;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_24 - tmpvar_4.xyz));
  osNormal_15.xyz = tmpvar_26;
  highp mat3 tmpvar_27;
  tmpvar_27[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_27[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_27[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_28;
  tmpvar_28 = normalize((tmpvar_27 * osNormal_15.xyz));
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = c_18.w;
  tmpvar_14 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = tmpvar_5;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = tmpvar_5;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_18.w));
  tmpvar_9.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = vec3((c_18.w * _EyeSpec));
  tmpvar_9.xyz = tmpvar_36;
  tmpvar_10 = _EyeGloss;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_37;
  mediump vec4 tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_38 = tmpvar_8;
  mediump vec3 lightDir_40;
  lightDir_40 = lightDir_3;
  mediump vec3 viewDir_41;
  viewDir_41 = worldViewDir_2;
  lowp float nh_42;
  lowp vec4 specular_43;
  lowp vec3 color_44;
  lowp vec3 worldRefl_45;
  lowp vec4 ramp_46;
  lowp float vdn_47;
  lowp vec4 ldn_48;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_9.w);
  tmpvar_39 = normalize(tmpvar_14.xyz);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(dot (tmpvar_39, lightDir_40));
  ldn_48 = tmpvar_49;
  ldn_48.w = ((ldn_48.x * 0.5) + 0.5);
  ldn_48.y = max (0.0, ldn_48.x);
  mediump float tmpvar_50;
  tmpvar_50 = mix (ldn_48.y, ldn_48.w, tmpvar_8.w);
  ldn_48.z = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = dot (viewDir_41, tmpvar_39);
  vdn_47 = tmpvar_51;
  lowp vec2 tmpvar_52;
  tmpvar_52.x = ldn_48.z;
  tmpvar_52.y = tmpvar_12.w;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_Ramp, tmpvar_52);
  ramp_46.w = tmpvar_53.w;
  ramp_46.xyz = ((tmpvar_53.xyz * (1.0 - tmpvar_14.w)) + (ldn_48.zzz * tmpvar_14.w));
  lowp vec4 tmpvar_54;
  tmpvar_54.w = 1.0;
  tmpvar_54.xyz = ((ramp_46.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_13 * tmpvar_53.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_55;
  tmpvar_55 = (-(viewDir_41) - ((2.0 * tmpvar_39) * -(vdn_47)));
  worldRefl_45 = tmpvar_55;
  mediump vec3 worldNormal_56;
  worldNormal_56 = worldRefl_45;
  mediump float perceptualRoughness_57;
  perceptualRoughness_57 = (1.0 - tmpvar_10);
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = worldNormal_56;
  tmpvar_58.w = ((perceptualRoughness_57 * (1.7 - 
    (0.7 * perceptualRoughness_57)
  )) * 6.0);
  lowp vec4 tmpvar_59;
  tmpvar_59 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_56, tmpvar_58.w);
  mediump vec4 tmpvar_60;
  tmpvar_60 = tmpvar_59;
  mediump float tmpvar_61;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_61 = tmpvar_60.w;
  } else {
    tmpvar_61 = 1.0;
  };
  lowp vec3 tmpvar_62;
  mediump vec3 tmpvar_63;
  tmpvar_63 = clamp (((unity_SpecCube0_HDR.x * tmpvar_61) * tmpvar_60.xyz), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  lowp float tmpvar_64;
  tmpvar_64 = (1.0 - clamp (vdn_47, 0.0, 1.0));
  lowp vec3 tmpvar_65;
  tmpvar_65 = vec3((tmpvar_11 * (1.0 - clamp (
    ((tmpvar_64 * 50.0) - 8.0)
  , 0.0, 1.0))));
  tmpvar_38.xyz = mix (tmpvar_8.xyz, _PupilColor.xyz, tmpvar_65);
  mediump vec3 tmpvar_66;
  tmpvar_66 = (tmpvar_38.xyz * tmpvar_54.xyz);
  color_44 = tmpvar_66;
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_68;
  tmpvar_68 = max (0.0, dot (tmpvar_39, normalize(
    (viewDir_41 + lightDir_40)
  )));
  nh_42 = tmpvar_68;
  mediump float tmpvar_69;
  tmpvar_69 = pow (nh_42, (tmpvar_10 * 128.0));
  specular_43 = (tmpvar_67 * tmpvar_69);
  specular_43.xyz = (specular_43.xyz + ((
    ((tmpvar_62 * (tmpvar_9.w * tmpvar_14.w)) * (1.0 - tmpvar_12.w))
   * tmpvar_64) * tmpvar_64));
  specular_43.xyz = (specular_43.xyz * tmpvar_9.xyz);
  color_44 = (color_44 + specular_43.xyz);
  lowp vec4 tmpvar_70;
  tmpvar_70.xyz = color_44;
  tmpvar_70.w = tmpvar_11;
  tmpvar_37 = tmpvar_70;
  c_1 = tmpvar_37;
  lowp vec4 color_71;
  color_71.w = c_1.w;
  mediump vec4 envFogColor_72;
  highp vec4 tmpvar_73;
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = unity_FogColor.xyz;
  tmpvar_73 = tmpvar_74;
  envFogColor_72 = tmpvar_73;
  envFogColor_72.w = (envFogColor_72.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_75;
  tmpvar_75 = mix (envFogColor_72.xyz, c_1.xyz, envFogColor_72.www);
  color_71.xyz = tmpvar_75;
  c_1.xyz = color_71.xyz;
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
Fallback "Holo/Character/Eye with Fresnel Pupil/Pixel Lit"
CustomEditor "CustomMaterialInspector"
}