//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Specular/Eye Shade/Pixel Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit, SpecularColor)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
 _EyeSpec ("Eye Specular", Range(0.000000,1.000000)) = 1.000000
 _EyeGloss ("Eye Glossiness", Range(0.025000,1.000000)) = 0.950000
 _EyeTiles ("Eye Tile Count 'U', 'V', 'U Scale', 'V Scale'", Vector) = (2.000000,4.000000,1.000000,1.000000)
 _Roundness ("Eye Roundness UV 'Offset', 'UNUSED', and 'Strength'", Vector) = (0.000000,0.000000,1.000000,1.000000)
 _EyeShadowOffset ("Eye Shadow 'Offset', 'ShadowBlur', and 'AoBlur'", Vector) = (0.012500,2.000000,2.000000,1.000000)
 _EyeMirrorOffset ("Eye Mirror U Offset", Range(0.000000,2.000000)) = 1.000000
[Toggle(BRB_EYE_SHADE_DEBUG)]  _EyeShadeDebug ("Debug Eye Shading", Float) = 0.000000
[Toggle(BRB_EYE_SHADE_DISABLE)]  _EyeShadeDisable ("Disable Roundness", Float) = 0.000000
 _Specularity ("Specularity", Range(0.000000,2.000000)) = 0.100000
 _Glossiness ("Specular Glossiness", Range(0.025000,1.000000)) = 0.100000
[KeywordEnum(None, Specularity)]  _Fresnel ("Fresnel Mode", Float) = 0.000000
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
[Toggle(BRB_METAL)]  _Metal ("Metal", Float) = 0.000000
 _Metalness ("    Metalness", Range(0.000000,1.000000)) = 1.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 375
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 18879
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_6.x = tmpvar_12.x;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_15;
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_4));
  vsNormal_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].x;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].x;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].x;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].x;
  v_22.w = tmpvar_26;
  highp vec4 v_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[0].y;
  v_27.x = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[1].y;
  v_27.y = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[2].y;
  v_27.z = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[3].y;
  v_27.w = tmpvar_31;
  highp vec4 v_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[0].z;
  v_32.x = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[1].z;
  v_32.y = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[2].z;
  v_32.z = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[3].z;
  v_32.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_22.xyz * tmpvar_4.x)
   + 
    (v_27.xyz * tmpvar_4.y)
  ) + (v_32.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_37;
  highp float tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_38 = clamp ((1.0 - (
    (tmpvar_39.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_40;
  tmpvar_40 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_38 * tmpvar_38)
   * tmpvar_40))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_41;
  tmpvar_41 = vsNormal_10.x;
  rim_7 = tmpvar_41;
  tmpvar_6.x = rim_7;
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_43;
  tmpvar_43 = tmpvar_39.xyz;
  highp vec4 v_44;
  v_44.x = tmpvar_23;
  v_44.y = tmpvar_24;
  v_44.z = tmpvar_25;
  v_44.w = tmpvar_26;
  highp vec4 v_45;
  v_45.x = tmpvar_28;
  v_45.y = tmpvar_29;
  v_45.z = tmpvar_30;
  v_45.w = tmpvar_31;
  highp vec4 v_46;
  v_46.x = tmpvar_33;
  v_46.y = tmpvar_34;
  v_46.z = tmpvar_35;
  v_46.w = tmpvar_36;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize(((
    (v_44.xyz * tmpvar_4.x)
   + 
    (v_45.xyz * tmpvar_4.y)
  ) + (v_46.xyz * tmpvar_4.z)));
  worldNormal_3 = tmpvar_47;
  highp mat3 tmpvar_48;
  tmpvar_48[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_48[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_48[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize((tmpvar_48 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_52;
  tmpvar_52.x = worldTangent_2.x;
  tmpvar_52.y = tmpvar_51.x;
  tmpvar_52.z = worldNormal_3.x;
  tmpvar_52.w = tmpvar_43.x;
  highp vec4 tmpvar_53;
  tmpvar_53.x = worldTangent_2.y;
  tmpvar_53.y = tmpvar_51.y;
  tmpvar_53.z = worldNormal_3.y;
  tmpvar_53.w = tmpvar_43.y;
  highp vec4 tmpvar_54;
  tmpvar_54.x = worldTangent_2.z;
  tmpvar_54.y = tmpvar_51.z;
  tmpvar_54.z = worldNormal_3.z;
  tmpvar_54.w = tmpvar_43.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_42);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_52;
  xlv_TEXCOORD2 = tmpvar_53;
  xlv_TEXCOORD3 = tmpvar_54;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (tmpvar_19 * tmpvar_20);
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_39.xyz);
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD6);
  worldViewDir_7 = tmpvar_11;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp float tmpvar_15;
  lowp vec4 tmpvar_16;
  lowp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_13 = tmpvar_3;
  tmpvar_14 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_18 = tmpvar_6;
  mediump vec3 tsNormal_19;
  mediump vec2 uv2normal_20;
  mediump vec2 shadeoffset_21;
  mediump vec3 vlight_22;
  lowp vec4 leftRim_23;
  mediump vec4 c_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = c_24.xyz;
  tmpvar_26.w = tmpvar_9.w;
  tmpvar_12 = tmpvar_26;
  tmpvar_15 = c_24.w;
  leftRim_23 = xlv_TEXCOORD4;
  highp vec3 tmpvar_27;
  tmpvar_27 = tmpvar_9.xyz;
  vlight_22 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = vlight_22;
  tmpvar_28.w = leftRim_23.w;
  tmpvar_16 = tmpvar_28;
  lowp vec3 tmpvar_29;
  if ((leftRim_23.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  tmpvar_17 = (tmpvar_29 * abs(leftRim_23.x));
  tmpvar_18.w = c_24.w;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = xlv_TEXCOORD0;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_24.w));
  tmpvar_14.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (vec3(_Specularity), vec3(_EyeSpec), c_24.www);
  tmpvar_14.xyz = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = mix (_Glossiness, _EyeGloss, c_24.w);
  lowp float tmpvar_38;
  if ((leftRim_23.z >= 0.0)) {
    tmpvar_38 = -(_Roundness.x);
  } else {
    tmpvar_38 = _Roundness.x;
  };
  lowp vec2 tmpvar_39;
  tmpvar_39.x = tmpvar_38;
  tmpvar_39.y = _Roundness.y;
  shadeoffset_21 = tmpvar_39;
  highp vec2 tmpvar_40;
  tmpvar_40 = (((
    (fract((xlv_TEXCOORD0 * _EyeTiles.xy)) + shadeoffset_21)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_20 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.z = 0.0;
  tmpvar_41.xy = ((uv2normal_20 * 2.0) - 1.0);
  mediump vec3 tmpvar_42;
  tmpvar_42 = ((tmpvar_41 * _Roundness.w) * c_24.w);
  tsNormal_19.xy = tmpvar_42.xy;
  tsNormal_19.z = sqrt((1.0 - clamp (
    dot (tmpvar_42.xy, tmpvar_42.xy)
  , 0.0, 1.0)));
  tmpvar_13 = tsNormal_19;
  tmpvar_4 = tmpvar_14;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_18;
  highp float tmpvar_43;
  tmpvar_43 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
  worldN_1.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
  worldN_1.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
  worldN_1.z = tmpvar_45;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_46;
  lowp vec3 tmpvar_47;
  mediump vec3 lightDir_48;
  lightDir_48 = lightDir_8;
  mediump vec3 viewDir_49;
  viewDir_49 = worldViewDir_7;
  lowp float nh_50;
  lowp vec4 specular_51;
  lowp vec3 color_52;
  lowp vec3 worldRefl_53;
  lowp vec4 ramp_54;
  lowp float vdn_55;
  lowp vec4 ldn_56;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_14.w);
  tmpvar_47 = normalize(worldN_1);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(dot (tmpvar_47, lightDir_48));
  ldn_56 = tmpvar_57;
  ldn_56.w = ((ldn_56.x * 0.5) + 0.5);
  ldn_56.y = max (0.0, ldn_56.x);
  mediump float tmpvar_58;
  tmpvar_58 = mix (ldn_56.y, ldn_56.w, tmpvar_12.w);
  ldn_56.z = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = dot (viewDir_49, tmpvar_47);
  vdn_55 = tmpvar_59;
  lowp vec2 tmpvar_60;
  tmpvar_60.x = ldn_56.z;
  tmpvar_60.y = tmpvar_16.w;
  lowp vec4 tmpvar_61;
  tmpvar_61 = texture2D (_Ramp, tmpvar_60);
  ramp_54.w = tmpvar_61.w;
  ramp_54.xyz = ((tmpvar_61.xyz * (1.0 - tmpvar_18.w)) + (ldn_56.zzz * tmpvar_18.w));
  lowp vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = ((ramp_54.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_17 * tmpvar_61.www) + tmpvar_16.xyz));
  mediump vec3 tmpvar_63;
  tmpvar_63 = (-(viewDir_49) - ((2.0 * tmpvar_47) * -(vdn_55)));
  worldRefl_53 = tmpvar_63;
  mediump vec3 worldNormal_64;
  worldNormal_64 = worldRefl_53;
  mediump float roughness_65;
  roughness_65 = (1.0 - tmpvar_37);
  mediump vec4 tmpvar_66;
  tmpvar_66.xyz = worldNormal_64;
  tmpvar_66.w = ((roughness_65 * (1.7 - 
    (0.7 * roughness_65)
  )) * 6.0);
  lowp vec4 tmpvar_67;
  tmpvar_67 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_64, tmpvar_66.w);
  mediump vec4 tmpvar_68;
  tmpvar_68 = tmpvar_67;
  lowp vec3 tmpvar_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_68.w * unity_SpecCube0_HDR.x) * tmpvar_68.xyz), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  lowp float tmpvar_71;
  tmpvar_71 = (1.0 - clamp (vdn_55, 0.0, 1.0));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (tmpvar_12.xyz * tmpvar_62.xyz);
  color_52 = tmpvar_72;
  lowp vec4 tmpvar_73;
  tmpvar_73.w = 1.0;
  tmpvar_73.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_74;
  tmpvar_74 = max (0.0, dot (tmpvar_47, normalize(
    (viewDir_49 + lightDir_48)
  )));
  nh_50 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = pow (nh_50, (tmpvar_37 * 128.0));
  specular_51 = (tmpvar_73 * tmpvar_75);
  specular_51.xyz = (specular_51.xyz + ((
    ((tmpvar_69 * (tmpvar_14.w * tmpvar_18.w)) * (1.0 - tmpvar_16.w))
   * tmpvar_71) * tmpvar_71));
  specular_51.xyz = (specular_51.xyz * tmpvar_14.xyz);
  color_52 = (color_52 + specular_51.xyz);
  lowp vec4 tmpvar_76;
  tmpvar_76.xyz = color_52;
  tmpvar_76.w = tmpvar_15;
  tmpvar_46 = tmpvar_76;
  c_2 = tmpvar_46;
  lowp vec4 color_77;
  color_77.w = c_2.w;
  highp vec3 tmpvar_78;
  tmpvar_78 = mix (xlv_TEXCOORD5.xyz, c_2.xyz, xlv_TEXCOORD5.www);
  color_77.xyz = tmpvar_78;
  c_2.xyz = color_77.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_6.x = tmpvar_12.x;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_15;
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_4));
  vsNormal_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].x;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].x;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].x;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].x;
  v_22.w = tmpvar_26;
  highp vec4 v_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[0].y;
  v_27.x = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[1].y;
  v_27.y = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[2].y;
  v_27.z = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[3].y;
  v_27.w = tmpvar_31;
  highp vec4 v_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[0].z;
  v_32.x = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[1].z;
  v_32.y = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[2].z;
  v_32.z = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[3].z;
  v_32.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_22.xyz * tmpvar_4.x)
   + 
    (v_27.xyz * tmpvar_4.y)
  ) + (v_32.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_37;
  highp float tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_38 = clamp ((1.0 - (
    (tmpvar_39.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_40;
  tmpvar_40 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_38 * tmpvar_38)
   * tmpvar_40))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_41;
  tmpvar_41 = vsNormal_10.x;
  rim_7 = tmpvar_41;
  tmpvar_6.x = rim_7;
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_43;
  tmpvar_43 = tmpvar_39.xyz;
  highp vec4 v_44;
  v_44.x = tmpvar_23;
  v_44.y = tmpvar_24;
  v_44.z = tmpvar_25;
  v_44.w = tmpvar_26;
  highp vec4 v_45;
  v_45.x = tmpvar_28;
  v_45.y = tmpvar_29;
  v_45.z = tmpvar_30;
  v_45.w = tmpvar_31;
  highp vec4 v_46;
  v_46.x = tmpvar_33;
  v_46.y = tmpvar_34;
  v_46.z = tmpvar_35;
  v_46.w = tmpvar_36;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize(((
    (v_44.xyz * tmpvar_4.x)
   + 
    (v_45.xyz * tmpvar_4.y)
  ) + (v_46.xyz * tmpvar_4.z)));
  worldNormal_3 = tmpvar_47;
  highp mat3 tmpvar_48;
  tmpvar_48[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_48[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_48[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize((tmpvar_48 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_52;
  tmpvar_52.x = worldTangent_2.x;
  tmpvar_52.y = tmpvar_51.x;
  tmpvar_52.z = worldNormal_3.x;
  tmpvar_52.w = tmpvar_43.x;
  highp vec4 tmpvar_53;
  tmpvar_53.x = worldTangent_2.y;
  tmpvar_53.y = tmpvar_51.y;
  tmpvar_53.z = worldNormal_3.y;
  tmpvar_53.w = tmpvar_43.y;
  highp vec4 tmpvar_54;
  tmpvar_54.x = worldTangent_2.z;
  tmpvar_54.y = tmpvar_51.z;
  tmpvar_54.z = worldNormal_3.z;
  tmpvar_54.w = tmpvar_43.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_42);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_52;
  xlv_TEXCOORD2 = tmpvar_53;
  xlv_TEXCOORD3 = tmpvar_54;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (tmpvar_19 * tmpvar_20);
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_39.xyz);
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD6);
  worldViewDir_7 = tmpvar_11;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp float tmpvar_15;
  lowp vec4 tmpvar_16;
  lowp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_13 = tmpvar_3;
  tmpvar_14 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_18 = tmpvar_6;
  mediump vec3 tsNormal_19;
  mediump vec2 uv2normal_20;
  mediump vec2 shadeoffset_21;
  mediump vec3 vlight_22;
  lowp vec4 leftRim_23;
  mediump vec4 c_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = c_24.xyz;
  tmpvar_26.w = tmpvar_9.w;
  tmpvar_12 = tmpvar_26;
  tmpvar_15 = c_24.w;
  leftRim_23 = xlv_TEXCOORD4;
  highp vec3 tmpvar_27;
  tmpvar_27 = tmpvar_9.xyz;
  vlight_22 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = vlight_22;
  tmpvar_28.w = leftRim_23.w;
  tmpvar_16 = tmpvar_28;
  lowp vec3 tmpvar_29;
  if ((leftRim_23.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  tmpvar_17 = (tmpvar_29 * abs(leftRim_23.x));
  tmpvar_18.w = c_24.w;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = xlv_TEXCOORD0;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_24.w));
  tmpvar_14.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (vec3(_Specularity), vec3(_EyeSpec), c_24.www);
  tmpvar_14.xyz = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = mix (_Glossiness, _EyeGloss, c_24.w);
  lowp float tmpvar_38;
  if ((leftRim_23.z >= 0.0)) {
    tmpvar_38 = -(_Roundness.x);
  } else {
    tmpvar_38 = _Roundness.x;
  };
  lowp vec2 tmpvar_39;
  tmpvar_39.x = tmpvar_38;
  tmpvar_39.y = _Roundness.y;
  shadeoffset_21 = tmpvar_39;
  highp vec2 tmpvar_40;
  tmpvar_40 = (((
    (fract((xlv_TEXCOORD0 * _EyeTiles.xy)) + shadeoffset_21)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_20 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.z = 0.0;
  tmpvar_41.xy = ((uv2normal_20 * 2.0) - 1.0);
  mediump vec3 tmpvar_42;
  tmpvar_42 = ((tmpvar_41 * _Roundness.w) * c_24.w);
  tsNormal_19.xy = tmpvar_42.xy;
  tsNormal_19.z = sqrt((1.0 - clamp (
    dot (tmpvar_42.xy, tmpvar_42.xy)
  , 0.0, 1.0)));
  tmpvar_13 = tsNormal_19;
  tmpvar_4 = tmpvar_14;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_18;
  highp float tmpvar_43;
  tmpvar_43 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
  worldN_1.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
  worldN_1.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
  worldN_1.z = tmpvar_45;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_46;
  lowp vec3 tmpvar_47;
  mediump vec3 lightDir_48;
  lightDir_48 = lightDir_8;
  mediump vec3 viewDir_49;
  viewDir_49 = worldViewDir_7;
  lowp float nh_50;
  lowp vec4 specular_51;
  lowp vec3 color_52;
  lowp vec3 worldRefl_53;
  lowp vec4 ramp_54;
  lowp float vdn_55;
  lowp vec4 ldn_56;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_14.w);
  tmpvar_47 = normalize(worldN_1);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(dot (tmpvar_47, lightDir_48));
  ldn_56 = tmpvar_57;
  ldn_56.w = ((ldn_56.x * 0.5) + 0.5);
  ldn_56.y = max (0.0, ldn_56.x);
  mediump float tmpvar_58;
  tmpvar_58 = mix (ldn_56.y, ldn_56.w, tmpvar_12.w);
  ldn_56.z = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = dot (viewDir_49, tmpvar_47);
  vdn_55 = tmpvar_59;
  lowp vec2 tmpvar_60;
  tmpvar_60.x = ldn_56.z;
  tmpvar_60.y = tmpvar_16.w;
  lowp vec4 tmpvar_61;
  tmpvar_61 = texture2D (_Ramp, tmpvar_60);
  ramp_54.w = tmpvar_61.w;
  ramp_54.xyz = ((tmpvar_61.xyz * (1.0 - tmpvar_18.w)) + (ldn_56.zzz * tmpvar_18.w));
  lowp vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = ((ramp_54.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_17 * tmpvar_61.www) + tmpvar_16.xyz));
  mediump vec3 tmpvar_63;
  tmpvar_63 = (-(viewDir_49) - ((2.0 * tmpvar_47) * -(vdn_55)));
  worldRefl_53 = tmpvar_63;
  mediump vec3 worldNormal_64;
  worldNormal_64 = worldRefl_53;
  mediump float roughness_65;
  roughness_65 = (1.0 - tmpvar_37);
  mediump vec4 tmpvar_66;
  tmpvar_66.xyz = worldNormal_64;
  tmpvar_66.w = ((roughness_65 * (1.7 - 
    (0.7 * roughness_65)
  )) * 6.0);
  lowp vec4 tmpvar_67;
  tmpvar_67 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_64, tmpvar_66.w);
  mediump vec4 tmpvar_68;
  tmpvar_68 = tmpvar_67;
  lowp vec3 tmpvar_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_68.w * unity_SpecCube0_HDR.x) * tmpvar_68.xyz), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  lowp float tmpvar_71;
  tmpvar_71 = (1.0 - clamp (vdn_55, 0.0, 1.0));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (tmpvar_12.xyz * tmpvar_62.xyz);
  color_52 = tmpvar_72;
  lowp vec4 tmpvar_73;
  tmpvar_73.w = 1.0;
  tmpvar_73.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_74;
  tmpvar_74 = max (0.0, dot (tmpvar_47, normalize(
    (viewDir_49 + lightDir_48)
  )));
  nh_50 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = pow (nh_50, (tmpvar_37 * 128.0));
  specular_51 = (tmpvar_73 * tmpvar_75);
  specular_51.xyz = (specular_51.xyz + ((
    ((tmpvar_69 * (tmpvar_14.w * tmpvar_18.w)) * (1.0 - tmpvar_16.w))
   * tmpvar_71) * tmpvar_71));
  specular_51.xyz = (specular_51.xyz * tmpvar_14.xyz);
  color_52 = (color_52 + specular_51.xyz);
  lowp vec4 tmpvar_76;
  tmpvar_76.xyz = color_52;
  tmpvar_76.w = tmpvar_15;
  tmpvar_46 = tmpvar_76;
  c_2 = tmpvar_46;
  lowp vec4 color_77;
  color_77.w = c_2.w;
  highp vec3 tmpvar_78;
  tmpvar_78 = mix (xlv_TEXCOORD5.xyz, c_2.xyz, xlv_TEXCOORD5.www);
  color_77.xyz = tmpvar_78;
  c_2.xyz = color_77.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float rim_7;
  highp vec3 vlight_8;
  lowp vec3 worldNormal_9;
  lowp vec3 vsNormal_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = (unity_AmbientEquator * _Ambient);
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(((_glesColor.w * (1.0 - tmpvar_11.w)) + tmpvar_11.w));
  tmpvar_6.x = tmpvar_12.x;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = ((1.0 - max (0.0, tmpvar_14)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_15;
  tmpvar_6.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_5.w = _glesColor.w;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_4));
  vsNormal_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].x;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].x;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].x;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].x;
  v_22.w = tmpvar_26;
  highp vec4 v_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[0].y;
  v_27.x = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[1].y;
  v_27.y = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[2].y;
  v_27.z = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[3].y;
  v_27.w = tmpvar_31;
  highp vec4 v_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[0].z;
  v_32.x = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[1].z;
  v_32.y = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[2].z;
  v_32.z = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[3].z;
  v_32.w = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_22.xyz * tmpvar_4.x)
   + 
    (v_27.xyz * tmpvar_4.y)
  ) + (v_32.xyz * tmpvar_4.z)));
  worldNormal_9 = tmpvar_37;
  highp float tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_38 = clamp ((1.0 - (
    (tmpvar_39.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_40;
  tmpvar_40 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_38 * tmpvar_38)
   * tmpvar_40))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_41;
  tmpvar_41 = vsNormal_10.x;
  rim_7 = tmpvar_41;
  tmpvar_6.x = rim_7;
  highp vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_43;
  tmpvar_43 = tmpvar_39.xyz;
  highp vec4 v_44;
  v_44.x = tmpvar_23;
  v_44.y = tmpvar_24;
  v_44.z = tmpvar_25;
  v_44.w = tmpvar_26;
  highp vec4 v_45;
  v_45.x = tmpvar_28;
  v_45.y = tmpvar_29;
  v_45.z = tmpvar_30;
  v_45.w = tmpvar_31;
  highp vec4 v_46;
  v_46.x = tmpvar_33;
  v_46.y = tmpvar_34;
  v_46.z = tmpvar_35;
  v_46.w = tmpvar_36;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize(((
    (v_44.xyz * tmpvar_4.x)
   + 
    (v_45.xyz * tmpvar_4.y)
  ) + (v_46.xyz * tmpvar_4.z)));
  worldNormal_3 = tmpvar_47;
  highp mat3 tmpvar_48;
  tmpvar_48[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_48[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_48[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize((tmpvar_48 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_50;
  lowp vec3 tmpvar_51;
  tmpvar_51 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_52;
  tmpvar_52.x = worldTangent_2.x;
  tmpvar_52.y = tmpvar_51.x;
  tmpvar_52.z = worldNormal_3.x;
  tmpvar_52.w = tmpvar_43.x;
  highp vec4 tmpvar_53;
  tmpvar_53.x = worldTangent_2.y;
  tmpvar_53.y = tmpvar_51.y;
  tmpvar_53.z = worldNormal_3.y;
  tmpvar_53.w = tmpvar_43.y;
  highp vec4 tmpvar_54;
  tmpvar_54.x = worldTangent_2.z;
  tmpvar_54.y = tmpvar_51.z;
  tmpvar_54.z = worldNormal_3.z;
  tmpvar_54.w = tmpvar_43.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_42);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_52;
  xlv_TEXCOORD2 = tmpvar_53;
  xlv_TEXCOORD3 = tmpvar_54;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = (tmpvar_19 * tmpvar_20);
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_39.xyz);
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD6);
  worldViewDir_7 = tmpvar_11;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp float tmpvar_15;
  lowp vec4 tmpvar_16;
  lowp vec3 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_13 = tmpvar_3;
  tmpvar_14 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_18 = tmpvar_6;
  mediump vec3 tsNormal_19;
  mediump vec2 uv2normal_20;
  mediump vec2 shadeoffset_21;
  mediump vec3 vlight_22;
  lowp vec4 leftRim_23;
  mediump vec4 c_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.xyz = c_24.xyz;
  tmpvar_26.w = tmpvar_9.w;
  tmpvar_12 = tmpvar_26;
  tmpvar_15 = c_24.w;
  leftRim_23 = xlv_TEXCOORD4;
  highp vec3 tmpvar_27;
  tmpvar_27 = tmpvar_9.xyz;
  vlight_22 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = vlight_22;
  tmpvar_28.w = leftRim_23.w;
  tmpvar_16 = tmpvar_28;
  lowp vec3 tmpvar_29;
  if ((leftRim_23.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  tmpvar_17 = (tmpvar_29 * abs(leftRim_23.x));
  tmpvar_18.w = c_24.w;
  highp vec4 tmpvar_30;
  tmpvar_30.zw = vec2(0.0, 0.0);
  tmpvar_30.xy = xlv_TEXCOORD0;
  lowp vec4 tmpvar_31;
  tmpvar_31.xz = vec2(0.0, 0.0);
  tmpvar_31.y = _EyeShadowOffset.x;
  tmpvar_31.w = _EyeShadowOffset.y;
  highp vec4 coord_32;
  coord_32 = (tmpvar_30 + tmpvar_31);
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = xlv_TEXCOORD0;
  tmpvar_33.w = _EyeShadowOffset.z;
  lowp float y_34;
  y_34 = (((impl_low_texture2DLodEXT (_MainTex, coord_32.xy, coord_32.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, tmpvar_33.w).w);
  mediump vec4 tmpvar_35;
  tmpvar_35 = vec4(mix (1.0, y_34, c_24.w));
  tmpvar_14.w = tmpvar_35.w;
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (vec3(_Specularity), vec3(_EyeSpec), c_24.www);
  tmpvar_14.xyz = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = mix (_Glossiness, _EyeGloss, c_24.w);
  lowp float tmpvar_38;
  if ((leftRim_23.z >= 0.0)) {
    tmpvar_38 = -(_Roundness.x);
  } else {
    tmpvar_38 = _Roundness.x;
  };
  lowp vec2 tmpvar_39;
  tmpvar_39.x = tmpvar_38;
  tmpvar_39.y = _Roundness.y;
  shadeoffset_21 = tmpvar_39;
  highp vec2 tmpvar_40;
  tmpvar_40 = (((
    (fract((xlv_TEXCOORD0 * _EyeTiles.xy)) + shadeoffset_21)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_20 = tmpvar_40;
  mediump vec3 tmpvar_41;
  tmpvar_41.z = 0.0;
  tmpvar_41.xy = ((uv2normal_20 * 2.0) - 1.0);
  mediump vec3 tmpvar_42;
  tmpvar_42 = ((tmpvar_41 * _Roundness.w) * c_24.w);
  tsNormal_19.xy = tmpvar_42.xy;
  tsNormal_19.z = sqrt((1.0 - clamp (
    dot (tmpvar_42.xy, tmpvar_42.xy)
  , 0.0, 1.0)));
  tmpvar_13 = tsNormal_19;
  tmpvar_4 = tmpvar_14;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_18;
  highp float tmpvar_43;
  tmpvar_43 = dot (xlv_TEXCOORD1.xyz, tmpvar_13);
  worldN_1.x = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = dot (xlv_TEXCOORD2.xyz, tmpvar_13);
  worldN_1.y = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = dot (xlv_TEXCOORD3.xyz, tmpvar_13);
  worldN_1.z = tmpvar_45;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_46;
  lowp vec3 tmpvar_47;
  mediump vec3 lightDir_48;
  lightDir_48 = lightDir_8;
  mediump vec3 viewDir_49;
  viewDir_49 = worldViewDir_7;
  lowp float nh_50;
  lowp vec4 specular_51;
  lowp vec3 color_52;
  lowp vec3 worldRefl_53;
  lowp vec4 ramp_54;
  lowp float vdn_55;
  lowp vec4 ldn_56;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_14.w);
  tmpvar_47 = normalize(worldN_1);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(dot (tmpvar_47, lightDir_48));
  ldn_56 = tmpvar_57;
  ldn_56.w = ((ldn_56.x * 0.5) + 0.5);
  ldn_56.y = max (0.0, ldn_56.x);
  mediump float tmpvar_58;
  tmpvar_58 = mix (ldn_56.y, ldn_56.w, tmpvar_12.w);
  ldn_56.z = tmpvar_58;
  mediump float tmpvar_59;
  tmpvar_59 = dot (viewDir_49, tmpvar_47);
  vdn_55 = tmpvar_59;
  lowp vec2 tmpvar_60;
  tmpvar_60.x = ldn_56.z;
  tmpvar_60.y = tmpvar_16.w;
  lowp vec4 tmpvar_61;
  tmpvar_61 = texture2D (_Ramp, tmpvar_60);
  ramp_54.w = tmpvar_61.w;
  ramp_54.xyz = ((tmpvar_61.xyz * (1.0 - tmpvar_18.w)) + (ldn_56.zzz * tmpvar_18.w));
  lowp vec4 tmpvar_62;
  tmpvar_62.w = 1.0;
  tmpvar_62.xyz = ((ramp_54.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_17 * tmpvar_61.www) + tmpvar_16.xyz));
  mediump vec3 tmpvar_63;
  tmpvar_63 = (-(viewDir_49) - ((2.0 * tmpvar_47) * -(vdn_55)));
  worldRefl_53 = tmpvar_63;
  mediump vec3 worldNormal_64;
  worldNormal_64 = worldRefl_53;
  mediump float roughness_65;
  roughness_65 = (1.0 - tmpvar_37);
  mediump vec4 tmpvar_66;
  tmpvar_66.xyz = worldNormal_64;
  tmpvar_66.w = ((roughness_65 * (1.7 - 
    (0.7 * roughness_65)
  )) * 6.0);
  lowp vec4 tmpvar_67;
  tmpvar_67 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_64, tmpvar_66.w);
  mediump vec4 tmpvar_68;
  tmpvar_68 = tmpvar_67;
  lowp vec3 tmpvar_69;
  mediump vec3 tmpvar_70;
  tmpvar_70 = clamp (((tmpvar_68.w * unity_SpecCube0_HDR.x) * tmpvar_68.xyz), 0.0, 1.0);
  tmpvar_69 = tmpvar_70;
  lowp float tmpvar_71;
  tmpvar_71 = (1.0 - clamp (vdn_55, 0.0, 1.0));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (tmpvar_12.xyz * tmpvar_62.xyz);
  color_52 = tmpvar_72;
  lowp vec4 tmpvar_73;
  tmpvar_73.w = 1.0;
  tmpvar_73.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_74;
  tmpvar_74 = max (0.0, dot (tmpvar_47, normalize(
    (viewDir_49 + lightDir_48)
  )));
  nh_50 = tmpvar_74;
  mediump float tmpvar_75;
  tmpvar_75 = pow (nh_50, (tmpvar_37 * 128.0));
  specular_51 = (tmpvar_73 * tmpvar_75);
  specular_51.xyz = (specular_51.xyz + ((
    ((tmpvar_69 * (tmpvar_14.w * tmpvar_18.w)) * (1.0 - tmpvar_16.w))
   * tmpvar_71) * tmpvar_71));
  specular_51.xyz = (specular_51.xyz * tmpvar_14.xyz);
  color_52 = (color_52 + specular_51.xyz);
  lowp vec4 tmpvar_76;
  tmpvar_76.xyz = color_52;
  tmpvar_76.w = tmpvar_15;
  tmpvar_46 = tmpvar_76;
  c_2 = tmpvar_46;
  lowp vec4 color_77;
  color_77.w = c_2.w;
  highp vec3 tmpvar_78;
  tmpvar_78 = mix (xlv_TEXCOORD5.xyz, c_2.xyz, xlv_TEXCOORD5.www);
  color_77.xyz = tmpvar_78;
  c_2.xyz = color_77.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
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
Fallback "Holo/Character/Eye Shade/Pixel Lit"
}