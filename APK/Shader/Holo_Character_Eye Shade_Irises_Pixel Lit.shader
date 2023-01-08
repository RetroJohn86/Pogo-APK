//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye Shade/Irises/Pixel Lit" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
_lIris ("Left Iris/Pupil (RGBA)", 2D) = "black" { }
_rIris ("Right Iris/Pupil (RGBA)", 2D) = "black" { }
_OsNormalMap ("Eye Mask (Alpha)", 2D) = "gray" { }
[Toggle(BRB_EYE_ADD_MASKS)] _AddMask ("    Add Base Alpha with Eye Mask (special eye case)", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_EyeSpec ("Eye Specular", Range(0, 1)) = 1
_EyeGloss ("Eye Glossiness", Range(0.025, 1)) = 0.95
_EyeTiles ("Eye Tile Count 'U', 'V', 'U Scale', 'V Scale'", Vector) = (2,4,1,1)
_Roundness ("Eye Roundness UV 'Offset', 'UNUSED', and 'Strength'", Vector) = (0,0,1,1)
_EyeShadowOffset ("Eye Shadow 'Offset', 'ShadowBlur', and 'AoBlur'", Vector) = (0.0125,2,2,1)
_EyeMirrorOffset ("Eye Mirror U Offset", Range(0, 2)) = 1
[Toggle(BRB_EYE_SHADE_DEBUG)] _EyeShadeDebug ("Debug Eye Shading", Float) = 0
[Toggle(BRB_EYE_SHADE_DISABLE)] _EyeShadeDisable ("Disable Roundness", Float) = 0
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
  GpuProgramID 28710
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _EyeMirrorOffset;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp float rim_9;
  highp vec3 vlight_10;
  lowp vec3 worldNormal_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_8.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_17;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_7.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_6));
  vsNormal_12 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_6 * tmpvar_24));
  worldNormal_11 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_11.y));
  vlight_10 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_8.x);
  tmpvar_7.xyz = vlight_10;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_12.x;
  rim_9 = tmpvar_29;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_31;
  tmpvar_31 = tmpvar_27.xyz;
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_6 * tmpvar_32));
  worldNormal_3 = tmpvar_33;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_34[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_34[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_34 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_38;
  tmpvar_38.x = worldTangent_2.x;
  tmpvar_38.y = tmpvar_37.x;
  tmpvar_38.z = worldNormal_3.x;
  tmpvar_38.w = tmpvar_31.x;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_2.y;
  tmpvar_39.y = tmpvar_37.y;
  tmpvar_39.z = worldNormal_3.y;
  tmpvar_39.w = tmpvar_31.y;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.z;
  tmpvar_40.y = tmpvar_37.z;
  tmpvar_40.z = worldNormal_3.z;
  tmpvar_40.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_38;
  xlv_TEXCOORD3 = tmpvar_39;
  xlv_TEXCOORD4 = tmpvar_40;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (tmpvar_21 * tmpvar_22);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  mediump float tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec4 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD3.w;
  tmpvar_12.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
  worldViewDir_8 = tmpvar_14;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_15;
  lowp vec3 tmpvar_16;
  lowp vec4 tmpvar_17;
  mediump float tmpvar_18;
  lowp float tmpvar_19;
  lowp vec4 tmpvar_20;
  lowp vec3 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_16 = tmpvar_3;
  tmpvar_17 = tmpvar_4;
  tmpvar_18 = tmpvar_5;
  tmpvar_21 = tmpvar_6;
  tmpvar_22 = tmpvar_7;
  mediump vec3 tsNormal_23;
  mediump vec2 uv2normal_24;
  mediump vec2 shadeoffset_25;
  mediump vec4 irises_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = c_29.xyz;
  tmpvar_31.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_31;
  tmpvar_19 = c_29.w;
  leftRim_28 = xlv_TEXCOORD5;
  highp vec3 tmpvar_32;
  tmpvar_32 = tmpvar_10.xyz;
  vlight_27 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = vlight_27;
  tmpvar_33.w = leftRim_28.w;
  tmpvar_20 = tmpvar_33;
  lowp vec3 tmpvar_34;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_34 * abs(leftRim_28.x));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_OsNormalMap, xlv_TEXCOORD0.zw);
  tmpvar_22.w = tmpvar_35.w;
  highp vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 0.0);
  tmpvar_36.xy = tmpvar_11;
  lowp vec4 tmpvar_37;
  tmpvar_37.xz = vec2(0.0, 0.0);
  tmpvar_37.y = _EyeShadowOffset.x;
  tmpvar_37.w = _EyeShadowOffset.y;
  highp vec4 coord_38;
  coord_38 = (tmpvar_36 + tmpvar_37);
  highp vec4 tmpvar_39;
  tmpvar_39.z = 0.0;
  tmpvar_39.xy = tmpvar_11;
  tmpvar_39.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_38.xy, coord_38.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_39.w).w), tmpvar_35.w));
  tmpvar_17.w = tmpvar_40.w;
  tmpvar_17.xyz = vec3((tmpvar_35.w * _EyeSpec));
  tmpvar_18 = _EyeGloss;
  bool tmpvar_41;
  tmpvar_41 = (leftRim_28.z >= 0.0);
  lowp vec4 tmpvar_42;
  if (tmpvar_41) {
    tmpvar_42 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_42 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_26 = tmpvar_42;
  tmpvar_15.xyz = mix (tmpvar_15.xyz, irises_26.xyz, vec3((irises_26.w * tmpvar_35.w)));
  lowp float tmpvar_43;
  if (tmpvar_41) {
    tmpvar_43 = -(_Roundness.x);
  } else {
    tmpvar_43 = _Roundness.x;
  };
  lowp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_43;
  tmpvar_44.y = _Roundness.y;
  shadeoffset_25 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46.z = 0.0;
  tmpvar_46.xy = ((uv2normal_24 * 2.0) - 1.0);
  mediump vec3 tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * _Roundness.w) * tmpvar_35.w);
  tsNormal_23.xy = tmpvar_47.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_47.xy, tmpvar_47.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.x = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.y = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD4.xyz, tmpvar_16);
  worldN_1.z = tmpvar_50;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_51;
  lowp vec3 tmpvar_52;
  mediump vec3 lightDir_53;
  lightDir_53 = lightDir_9;
  mediump vec3 viewDir_54;
  viewDir_54 = worldViewDir_8;
  lowp float nh_55;
  lowp vec4 specular_56;
  lowp vec3 color_57;
  lowp vec3 worldRefl_58;
  lowp vec4 ramp_59;
  lowp float vdn_60;
  lowp vec4 ldn_61;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_40.w);
  tmpvar_52 = normalize(worldN_1);
  mediump vec4 tmpvar_62;
  tmpvar_62 = vec4(dot (tmpvar_52, lightDir_53));
  ldn_61 = tmpvar_62;
  ldn_61.w = ((ldn_61.x * 0.5) + 0.5);
  ldn_61.y = max (0.0, ldn_61.x);
  mediump float tmpvar_63;
  tmpvar_63 = mix (ldn_61.y, ldn_61.w, tmpvar_15.w);
  ldn_61.z = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = dot (viewDir_54, tmpvar_52);
  vdn_60 = tmpvar_64;
  lowp vec2 tmpvar_65;
  tmpvar_65.x = ldn_61.z;
  tmpvar_65.y = tmpvar_20.w;
  lowp vec4 tmpvar_66;
  tmpvar_66 = texture2D (_Ramp, tmpvar_65);
  ramp_59.w = tmpvar_66.w;
  ramp_59.xyz = ((tmpvar_66.xyz * (1.0 - tmpvar_35.w)) + (ldn_61.zzz * tmpvar_35.w));
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = ((ramp_59.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_66.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_68;
  tmpvar_68 = (-(viewDir_54) - ((2.0 * tmpvar_52) * -(vdn_60)));
  worldRefl_58 = tmpvar_68;
  mediump vec3 worldNormal_69;
  worldNormal_69 = worldRefl_58;
  mediump float perceptualRoughness_70;
  perceptualRoughness_70 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_71;
  tmpvar_71.xyz = worldNormal_69;
  tmpvar_71.w = ((perceptualRoughness_70 * (1.7 - 
    (0.7 * perceptualRoughness_70)
  )) * 6.0);
  lowp vec4 tmpvar_72;
  tmpvar_72 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_69, tmpvar_71.w);
  mediump vec4 tmpvar_73;
  tmpvar_73 = tmpvar_72;
  mediump float tmpvar_74;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_74 = tmpvar_73.w;
  } else {
    tmpvar_74 = 1.0;
  };
  lowp vec3 tmpvar_75;
  mediump vec3 tmpvar_76;
  tmpvar_76 = clamp (((unity_SpecCube0_HDR.x * tmpvar_74) * tmpvar_73.xyz), 0.0, 1.0);
  tmpvar_75 = tmpvar_76;
  lowp float tmpvar_77;
  tmpvar_77 = (1.0 - clamp (vdn_60, 0.0, 1.0));
  mediump vec3 tmpvar_78;
  tmpvar_78 = (tmpvar_15.xyz * tmpvar_67.xyz);
  color_57 = tmpvar_78;
  lowp vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_80;
  tmpvar_80 = max (0.0, dot (tmpvar_52, normalize(
    (viewDir_54 + lightDir_53)
  )));
  nh_55 = tmpvar_80;
  mediump float tmpvar_81;
  tmpvar_81 = pow (nh_55, (tmpvar_18 * 128.0));
  specular_56 = (tmpvar_79 * tmpvar_81);
  specular_56.xyz = (specular_56.xyz + ((
    ((tmpvar_75 * (tmpvar_40.w * tmpvar_35.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_77) * tmpvar_77));
  specular_56.xyz = (specular_56.xyz * tmpvar_17.xyz);
  color_57 = (color_57 + specular_56.xyz);
  lowp vec4 tmpvar_82;
  tmpvar_82.xyz = color_57;
  tmpvar_82.w = tmpvar_19;
  tmpvar_51 = tmpvar_82;
  c_2 = tmpvar_51;
  lowp vec4 color_83;
  color_83.w = c_2.w;
  highp vec3 tmpvar_84;
  tmpvar_84 = mix (xlv_TEXCOORD6.xyz, c_2.xyz, xlv_TEXCOORD6.www);
  color_83.xyz = tmpvar_84;
  c_2.xyz = color_83.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _EyeMirrorOffset;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp float rim_9;
  highp vec3 vlight_10;
  lowp vec3 worldNormal_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_8.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_17;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_7.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_6));
  vsNormal_12 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_6 * tmpvar_24));
  worldNormal_11 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_11.y));
  vlight_10 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_8.x);
  tmpvar_7.xyz = vlight_10;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_12.x;
  rim_9 = tmpvar_29;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_31;
  tmpvar_31 = tmpvar_27.xyz;
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_6 * tmpvar_32));
  worldNormal_3 = tmpvar_33;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_34[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_34[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_34 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_38;
  tmpvar_38.x = worldTangent_2.x;
  tmpvar_38.y = tmpvar_37.x;
  tmpvar_38.z = worldNormal_3.x;
  tmpvar_38.w = tmpvar_31.x;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_2.y;
  tmpvar_39.y = tmpvar_37.y;
  tmpvar_39.z = worldNormal_3.y;
  tmpvar_39.w = tmpvar_31.y;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.z;
  tmpvar_40.y = tmpvar_37.z;
  tmpvar_40.z = worldNormal_3.z;
  tmpvar_40.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_38;
  xlv_TEXCOORD3 = tmpvar_39;
  xlv_TEXCOORD4 = tmpvar_40;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (tmpvar_21 * tmpvar_22);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  mediump float tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec4 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD3.w;
  tmpvar_12.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
  worldViewDir_8 = tmpvar_14;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_15;
  lowp vec3 tmpvar_16;
  lowp vec4 tmpvar_17;
  mediump float tmpvar_18;
  lowp float tmpvar_19;
  lowp vec4 tmpvar_20;
  lowp vec3 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_16 = tmpvar_3;
  tmpvar_17 = tmpvar_4;
  tmpvar_18 = tmpvar_5;
  tmpvar_21 = tmpvar_6;
  tmpvar_22 = tmpvar_7;
  mediump vec3 tsNormal_23;
  mediump vec2 uv2normal_24;
  mediump vec2 shadeoffset_25;
  mediump vec4 irises_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = c_29.xyz;
  tmpvar_31.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_31;
  tmpvar_19 = c_29.w;
  leftRim_28 = xlv_TEXCOORD5;
  highp vec3 tmpvar_32;
  tmpvar_32 = tmpvar_10.xyz;
  vlight_27 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = vlight_27;
  tmpvar_33.w = leftRim_28.w;
  tmpvar_20 = tmpvar_33;
  lowp vec3 tmpvar_34;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_34 * abs(leftRim_28.x));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_OsNormalMap, xlv_TEXCOORD0.zw);
  tmpvar_22.w = tmpvar_35.w;
  highp vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 0.0);
  tmpvar_36.xy = tmpvar_11;
  lowp vec4 tmpvar_37;
  tmpvar_37.xz = vec2(0.0, 0.0);
  tmpvar_37.y = _EyeShadowOffset.x;
  tmpvar_37.w = _EyeShadowOffset.y;
  highp vec4 coord_38;
  coord_38 = (tmpvar_36 + tmpvar_37);
  highp vec4 tmpvar_39;
  tmpvar_39.z = 0.0;
  tmpvar_39.xy = tmpvar_11;
  tmpvar_39.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_38.xy, coord_38.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_39.w).w), tmpvar_35.w));
  tmpvar_17.w = tmpvar_40.w;
  tmpvar_17.xyz = vec3((tmpvar_35.w * _EyeSpec));
  tmpvar_18 = _EyeGloss;
  bool tmpvar_41;
  tmpvar_41 = (leftRim_28.z >= 0.0);
  lowp vec4 tmpvar_42;
  if (tmpvar_41) {
    tmpvar_42 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_42 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_26 = tmpvar_42;
  tmpvar_15.xyz = mix (tmpvar_15.xyz, irises_26.xyz, vec3((irises_26.w * tmpvar_35.w)));
  lowp float tmpvar_43;
  if (tmpvar_41) {
    tmpvar_43 = -(_Roundness.x);
  } else {
    tmpvar_43 = _Roundness.x;
  };
  lowp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_43;
  tmpvar_44.y = _Roundness.y;
  shadeoffset_25 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46.z = 0.0;
  tmpvar_46.xy = ((uv2normal_24 * 2.0) - 1.0);
  mediump vec3 tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * _Roundness.w) * tmpvar_35.w);
  tsNormal_23.xy = tmpvar_47.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_47.xy, tmpvar_47.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.x = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.y = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD4.xyz, tmpvar_16);
  worldN_1.z = tmpvar_50;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_51;
  lowp vec3 tmpvar_52;
  mediump vec3 lightDir_53;
  lightDir_53 = lightDir_9;
  mediump vec3 viewDir_54;
  viewDir_54 = worldViewDir_8;
  lowp float nh_55;
  lowp vec4 specular_56;
  lowp vec3 color_57;
  lowp vec3 worldRefl_58;
  lowp vec4 ramp_59;
  lowp float vdn_60;
  lowp vec4 ldn_61;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_40.w);
  tmpvar_52 = normalize(worldN_1);
  mediump vec4 tmpvar_62;
  tmpvar_62 = vec4(dot (tmpvar_52, lightDir_53));
  ldn_61 = tmpvar_62;
  ldn_61.w = ((ldn_61.x * 0.5) + 0.5);
  ldn_61.y = max (0.0, ldn_61.x);
  mediump float tmpvar_63;
  tmpvar_63 = mix (ldn_61.y, ldn_61.w, tmpvar_15.w);
  ldn_61.z = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = dot (viewDir_54, tmpvar_52);
  vdn_60 = tmpvar_64;
  lowp vec2 tmpvar_65;
  tmpvar_65.x = ldn_61.z;
  tmpvar_65.y = tmpvar_20.w;
  lowp vec4 tmpvar_66;
  tmpvar_66 = texture2D (_Ramp, tmpvar_65);
  ramp_59.w = tmpvar_66.w;
  ramp_59.xyz = ((tmpvar_66.xyz * (1.0 - tmpvar_35.w)) + (ldn_61.zzz * tmpvar_35.w));
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = ((ramp_59.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_66.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_68;
  tmpvar_68 = (-(viewDir_54) - ((2.0 * tmpvar_52) * -(vdn_60)));
  worldRefl_58 = tmpvar_68;
  mediump vec3 worldNormal_69;
  worldNormal_69 = worldRefl_58;
  mediump float perceptualRoughness_70;
  perceptualRoughness_70 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_71;
  tmpvar_71.xyz = worldNormal_69;
  tmpvar_71.w = ((perceptualRoughness_70 * (1.7 - 
    (0.7 * perceptualRoughness_70)
  )) * 6.0);
  lowp vec4 tmpvar_72;
  tmpvar_72 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_69, tmpvar_71.w);
  mediump vec4 tmpvar_73;
  tmpvar_73 = tmpvar_72;
  mediump float tmpvar_74;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_74 = tmpvar_73.w;
  } else {
    tmpvar_74 = 1.0;
  };
  lowp vec3 tmpvar_75;
  mediump vec3 tmpvar_76;
  tmpvar_76 = clamp (((unity_SpecCube0_HDR.x * tmpvar_74) * tmpvar_73.xyz), 0.0, 1.0);
  tmpvar_75 = tmpvar_76;
  lowp float tmpvar_77;
  tmpvar_77 = (1.0 - clamp (vdn_60, 0.0, 1.0));
  mediump vec3 tmpvar_78;
  tmpvar_78 = (tmpvar_15.xyz * tmpvar_67.xyz);
  color_57 = tmpvar_78;
  lowp vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_80;
  tmpvar_80 = max (0.0, dot (tmpvar_52, normalize(
    (viewDir_54 + lightDir_53)
  )));
  nh_55 = tmpvar_80;
  mediump float tmpvar_81;
  tmpvar_81 = pow (nh_55, (tmpvar_18 * 128.0));
  specular_56 = (tmpvar_79 * tmpvar_81);
  specular_56.xyz = (specular_56.xyz + ((
    ((tmpvar_75 * (tmpvar_40.w * tmpvar_35.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_77) * tmpvar_77));
  specular_56.xyz = (specular_56.xyz * tmpvar_17.xyz);
  color_57 = (color_57 + specular_56.xyz);
  lowp vec4 tmpvar_82;
  tmpvar_82.xyz = color_57;
  tmpvar_82.w = tmpvar_19;
  tmpvar_51 = tmpvar_82;
  c_2 = tmpvar_51;
  lowp vec4 color_83;
  color_83.w = c_2.w;
  highp vec3 tmpvar_84;
  tmpvar_84 = mix (xlv_TEXCOORD6.xyz, c_2.xyz, xlv_TEXCOORD6.www);
  color_83.xyz = tmpvar_84;
  c_2.xyz = color_83.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _EyeMirrorOffset;
uniform highp float _Ground;
uniform lowp vec4 _Ambient;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp float rim_9;
  highp vec3 vlight_10;
  lowp vec3 worldNormal_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_8.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_17;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_7.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_6));
  vsNormal_12 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_6 * tmpvar_24));
  worldNormal_11 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_11.y));
  vlight_10 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_8.x);
  tmpvar_7.xyz = vlight_10;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_12.x;
  rim_9 = tmpvar_29;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_31;
  tmpvar_31 = tmpvar_27.xyz;
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_6 * tmpvar_32));
  worldNormal_3 = tmpvar_33;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_34[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_34[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_34 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_36;
  lowp vec3 tmpvar_37;
  tmpvar_37 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_38;
  tmpvar_38.x = worldTangent_2.x;
  tmpvar_38.y = tmpvar_37.x;
  tmpvar_38.z = worldNormal_3.x;
  tmpvar_38.w = tmpvar_31.x;
  highp vec4 tmpvar_39;
  tmpvar_39.x = worldTangent_2.y;
  tmpvar_39.y = tmpvar_37.y;
  tmpvar_39.z = worldNormal_3.y;
  tmpvar_39.w = tmpvar_31.y;
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.z;
  tmpvar_40.y = tmpvar_37.z;
  tmpvar_40.z = worldNormal_3.z;
  tmpvar_40.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_38;
  xlv_TEXCOORD3 = tmpvar_39;
  xlv_TEXCOORD4 = tmpvar_40;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = (tmpvar_21 * tmpvar_22);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  mediump float tmpvar_5;
  lowp vec3 tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec4 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD2.w;
  tmpvar_12.y = xlv_TEXCOORD3.w;
  tmpvar_12.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_13;
  tmpvar_13 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
  worldViewDir_8 = tmpvar_14;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_15;
  lowp vec3 tmpvar_16;
  lowp vec4 tmpvar_17;
  mediump float tmpvar_18;
  lowp float tmpvar_19;
  lowp vec4 tmpvar_20;
  lowp vec3 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_16 = tmpvar_3;
  tmpvar_17 = tmpvar_4;
  tmpvar_18 = tmpvar_5;
  tmpvar_21 = tmpvar_6;
  tmpvar_22 = tmpvar_7;
  mediump vec3 tsNormal_23;
  mediump vec2 uv2normal_24;
  mediump vec2 shadeoffset_25;
  mediump vec4 irises_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.xyz = c_29.xyz;
  tmpvar_31.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_31;
  tmpvar_19 = c_29.w;
  leftRim_28 = xlv_TEXCOORD5;
  highp vec3 tmpvar_32;
  tmpvar_32 = tmpvar_10.xyz;
  vlight_27 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.xyz = vlight_27;
  tmpvar_33.w = leftRim_28.w;
  tmpvar_20 = tmpvar_33;
  lowp vec3 tmpvar_34;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_34 * abs(leftRim_28.x));
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_OsNormalMap, xlv_TEXCOORD0.zw);
  tmpvar_22.w = tmpvar_35.w;
  highp vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 0.0);
  tmpvar_36.xy = tmpvar_11;
  lowp vec4 tmpvar_37;
  tmpvar_37.xz = vec2(0.0, 0.0);
  tmpvar_37.y = _EyeShadowOffset.x;
  tmpvar_37.w = _EyeShadowOffset.y;
  highp vec4 coord_38;
  coord_38 = (tmpvar_36 + tmpvar_37);
  highp vec4 tmpvar_39;
  tmpvar_39.z = 0.0;
  tmpvar_39.xy = tmpvar_11;
  tmpvar_39.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_40;
  tmpvar_40 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_38.xy, coord_38.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_39.w).w), tmpvar_35.w));
  tmpvar_17.w = tmpvar_40.w;
  tmpvar_17.xyz = vec3((tmpvar_35.w * _EyeSpec));
  tmpvar_18 = _EyeGloss;
  bool tmpvar_41;
  tmpvar_41 = (leftRim_28.z >= 0.0);
  lowp vec4 tmpvar_42;
  if (tmpvar_41) {
    tmpvar_42 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_42 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_26 = tmpvar_42;
  tmpvar_15.xyz = mix (tmpvar_15.xyz, irises_26.xyz, vec3((irises_26.w * tmpvar_35.w)));
  lowp float tmpvar_43;
  if (tmpvar_41) {
    tmpvar_43 = -(_Roundness.x);
  } else {
    tmpvar_43 = _Roundness.x;
  };
  lowp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_43;
  tmpvar_44.y = _Roundness.y;
  shadeoffset_25 = tmpvar_44;
  highp vec2 tmpvar_45;
  tmpvar_45 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_45;
  mediump vec3 tmpvar_46;
  tmpvar_46.z = 0.0;
  tmpvar_46.xy = ((uv2normal_24 * 2.0) - 1.0);
  mediump vec3 tmpvar_47;
  tmpvar_47 = ((tmpvar_46 * _Roundness.w) * tmpvar_35.w);
  tsNormal_23.xy = tmpvar_47.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_47.xy, tmpvar_47.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_48;
  tmpvar_48 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.x = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.y = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (xlv_TEXCOORD4.xyz, tmpvar_16);
  worldN_1.z = tmpvar_50;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_51;
  lowp vec3 tmpvar_52;
  mediump vec3 lightDir_53;
  lightDir_53 = lightDir_9;
  mediump vec3 viewDir_54;
  viewDir_54 = worldViewDir_8;
  lowp float nh_55;
  lowp vec4 specular_56;
  lowp vec3 color_57;
  lowp vec3 worldRefl_58;
  lowp vec4 ramp_59;
  lowp float vdn_60;
  lowp vec4 ldn_61;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_40.w);
  tmpvar_52 = normalize(worldN_1);
  mediump vec4 tmpvar_62;
  tmpvar_62 = vec4(dot (tmpvar_52, lightDir_53));
  ldn_61 = tmpvar_62;
  ldn_61.w = ((ldn_61.x * 0.5) + 0.5);
  ldn_61.y = max (0.0, ldn_61.x);
  mediump float tmpvar_63;
  tmpvar_63 = mix (ldn_61.y, ldn_61.w, tmpvar_15.w);
  ldn_61.z = tmpvar_63;
  mediump float tmpvar_64;
  tmpvar_64 = dot (viewDir_54, tmpvar_52);
  vdn_60 = tmpvar_64;
  lowp vec2 tmpvar_65;
  tmpvar_65.x = ldn_61.z;
  tmpvar_65.y = tmpvar_20.w;
  lowp vec4 tmpvar_66;
  tmpvar_66 = texture2D (_Ramp, tmpvar_65);
  ramp_59.w = tmpvar_66.w;
  ramp_59.xyz = ((tmpvar_66.xyz * (1.0 - tmpvar_35.w)) + (ldn_61.zzz * tmpvar_35.w));
  lowp vec4 tmpvar_67;
  tmpvar_67.w = 1.0;
  tmpvar_67.xyz = ((ramp_59.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_66.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_68;
  tmpvar_68 = (-(viewDir_54) - ((2.0 * tmpvar_52) * -(vdn_60)));
  worldRefl_58 = tmpvar_68;
  mediump vec3 worldNormal_69;
  worldNormal_69 = worldRefl_58;
  mediump float perceptualRoughness_70;
  perceptualRoughness_70 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_71;
  tmpvar_71.xyz = worldNormal_69;
  tmpvar_71.w = ((perceptualRoughness_70 * (1.7 - 
    (0.7 * perceptualRoughness_70)
  )) * 6.0);
  lowp vec4 tmpvar_72;
  tmpvar_72 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_69, tmpvar_71.w);
  mediump vec4 tmpvar_73;
  tmpvar_73 = tmpvar_72;
  mediump float tmpvar_74;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_74 = tmpvar_73.w;
  } else {
    tmpvar_74 = 1.0;
  };
  lowp vec3 tmpvar_75;
  mediump vec3 tmpvar_76;
  tmpvar_76 = clamp (((unity_SpecCube0_HDR.x * tmpvar_74) * tmpvar_73.xyz), 0.0, 1.0);
  tmpvar_75 = tmpvar_76;
  lowp float tmpvar_77;
  tmpvar_77 = (1.0 - clamp (vdn_60, 0.0, 1.0));
  mediump vec3 tmpvar_78;
  tmpvar_78 = (tmpvar_15.xyz * tmpvar_67.xyz);
  color_57 = tmpvar_78;
  lowp vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_80;
  tmpvar_80 = max (0.0, dot (tmpvar_52, normalize(
    (viewDir_54 + lightDir_53)
  )));
  nh_55 = tmpvar_80;
  mediump float tmpvar_81;
  tmpvar_81 = pow (nh_55, (tmpvar_18 * 128.0));
  specular_56 = (tmpvar_79 * tmpvar_81);
  specular_56.xyz = (specular_56.xyz + ((
    ((tmpvar_75 * (tmpvar_40.w * tmpvar_35.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_77) * tmpvar_77));
  specular_56.xyz = (specular_56.xyz * tmpvar_17.xyz);
  color_57 = (color_57 + specular_56.xyz);
  lowp vec4 tmpvar_82;
  tmpvar_82.xyz = color_57;
  tmpvar_82.w = tmpvar_19;
  tmpvar_51 = tmpvar_82;
  c_2 = tmpvar_51;
  lowp vec4 color_83;
  color_83.w = c_2.w;
  highp vec3 tmpvar_84;
  tmpvar_84 = mix (xlv_TEXCOORD6.xyz, c_2.xyz, xlv_TEXCOORD6.www);
  color_83.xyz = tmpvar_84;
  c_2.xyz = color_83.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
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
Fallback "Holo/Character/Eye Shade/Irises/Vertex Lit"
CustomEditor "CustomMaterialInspector"
}