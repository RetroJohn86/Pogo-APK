//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye Shade/OS Normal Mapped - Skin" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_EyeMask ("EyeMask (RGB=Eye Mask)", 2D) = "white" { }
_OsNormalMap ("Object-space Normal Map (RGB, A=Eye Mask)", 2D) = "gray" { }
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
 LOD 350
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 350
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha One
  ZClip Off
  Cull Off
  GpuProgramID 30878
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_28);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_28);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp float tangentSign_1;
  lowp vec3 worldTangent_2;
  lowp vec3 worldNormal_3;
  highp vec4 tmpvar_4;
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
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_27 = clamp ((1.0 - (
    (tmpvar_28.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_27 * tmpvar_27)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_30.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_31;
  tmpvar_31 = vsNormal_10.x;
  rim_8 = tmpvar_31;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = tmpvar_28.xyz;
  highp mat3 tmpvar_34;
  tmpvar_34[0] = unity_WorldToObject[0].xyz;
  tmpvar_34[1] = unity_WorldToObject[1].xyz;
  tmpvar_34[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((tmpvar_5 * tmpvar_34));
  worldNormal_3 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_2.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_3.x;
  tmpvar_40.w = tmpvar_33.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_2.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_3.y;
  tmpvar_41.w = tmpvar_33.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_2.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_3.z;
  tmpvar_42.w = tmpvar_33.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_40;
  xlv_TEXCOORD2 = tmpvar_41;
  xlv_TEXCOORD3 = tmpvar_42;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_30;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_28);
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
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp vec4 _Roundness;
uniform lowp vec4 _EyeTiles;
uniform lowp float _EyeSpec;
uniform lowp float _EyeGloss;
uniform sampler2D _MainTex;
uniform sampler2D _EyeMask;
uniform sampler2D _OsNormalMap;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  tmpvar_11 = xlv_TEXCOORD0.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD1.w;
  tmpvar_12.y = xlv_TEXCOORD2.w;
  tmpvar_12.z = xlv_TEXCOORD3.w;
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
  lowp vec4 osNormal_26;
  mediump vec3 vlight_27;
  lowp vec4 leftRim_28;
  mediump vec4 c_29;
  mediump float eyemask_30;
  lowp float tmpvar_31;
  tmpvar_31 = texture2D (_EyeMask, xlv_TEXCOORD0.xy).x;
  eyemask_30 = tmpvar_31;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_29 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = c_29.xyz;
  tmpvar_33.w = tmpvar_10.w;
  tmpvar_15 = tmpvar_33;
  tmpvar_19 = eyemask_30;
  leftRim_28 = xlv_TEXCOORD4;
  highp vec3 tmpvar_34;
  tmpvar_34 = xlv_TEXCOORD5.xyz;
  vlight_27 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = vlight_27;
  tmpvar_35.w = leftRim_28.w;
  tmpvar_20 = tmpvar_35;
  lowp vec3 tmpvar_36;
  if ((leftRim_28.x < 0.0)) {
    tmpvar_36 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_36 = unity_AmbientSky.xyz;
  };
  tmpvar_21 = (tmpvar_36 * abs(leftRim_28.x));
  lowp vec4 tmpvar_37;
  tmpvar_37 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_38;
  tmpvar_38 = normalize(tmpvar_37.xyz);
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = tmpvar_38;
  tmpvar_39.w = tmpvar_37.w;
  osNormal_26.w = tmpvar_39.w;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize((tmpvar_38 - tmpvar_10.xyz));
  osNormal_26.xyz = tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_41[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_41[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_42;
  tmpvar_42 = normalize((tmpvar_41 * osNormal_26.xyz));
  mediump vec4 tmpvar_43;
  tmpvar_43.xyz = tmpvar_42;
  tmpvar_43.w = c_29.w;
  tmpvar_22 = tmpvar_43;
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.xy = tmpvar_11;
  lowp vec4 tmpvar_45;
  tmpvar_45.xz = vec2(0.0, 0.0);
  tmpvar_45.y = _EyeShadowOffset.x;
  tmpvar_45.w = _EyeShadowOffset.y;
  highp vec4 coord_46;
  coord_46 = (tmpvar_44 + tmpvar_45);
  highp vec4 tmpvar_47;
  tmpvar_47.z = 0.0;
  tmpvar_47.xy = tmpvar_11;
  tmpvar_47.w = _EyeShadowOffset.z;
  lowp float y_48;
  y_48 = (((impl_low_texture2DLodEXT (_MainTex, coord_46.xy, coord_46.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_47.w).w);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(mix (1.0, y_48, c_29.w));
  tmpvar_17.w = tmpvar_49.w;
  mediump vec3 tmpvar_50;
  tmpvar_50 = vec3((c_29.w * _EyeSpec));
  tmpvar_17.xyz = tmpvar_50;
  tmpvar_18 = _EyeGloss;
  lowp float tmpvar_51;
  if ((leftRim_28.z >= 0.0)) {
    tmpvar_51 = -(_Roundness.x);
  } else {
    tmpvar_51 = _Roundness.x;
  };
  lowp vec2 tmpvar_52;
  tmpvar_52.x = tmpvar_51;
  tmpvar_52.y = _Roundness.y;
  shadeoffset_25 = tmpvar_52;
  highp vec2 tmpvar_53;
  tmpvar_53 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_25)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_24 = tmpvar_53;
  mediump vec3 tmpvar_54;
  tmpvar_54.z = 0.0;
  tmpvar_54.xy = ((uv2normal_24 * 2.0) - 1.0);
  tsNormal_23.xy = tmpvar_54.xy;
  tsNormal_23.z = sqrt((1.0 - clamp (
    dot (tmpvar_54.xy, tmpvar_54.xy)
  , 0.0, 1.0)));
  tmpvar_16 = tsNormal_23;
  tmpvar_4 = tmpvar_17;
  tmpvar_5 = tmpvar_18;
  tmpvar_6 = tmpvar_21;
  tmpvar_7 = tmpvar_22;
  c_2 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_55;
  tmpvar_55 = dot (xlv_TEXCOORD1.xyz, tmpvar_16);
  worldN_1.x = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = dot (xlv_TEXCOORD2.xyz, tmpvar_16);
  worldN_1.y = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = dot (xlv_TEXCOORD3.xyz, tmpvar_16);
  worldN_1.z = tmpvar_57;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_58;
  lowp vec3 tmpvar_59;
  mediump vec3 lightDir_60;
  lightDir_60 = lightDir_9;
  mediump vec3 viewDir_61;
  viewDir_61 = worldViewDir_8;
  lowp float nh_62;
  lowp vec4 specular_63;
  lowp vec3 color_64;
  lowp vec3 worldRefl_65;
  lowp vec4 ramp_66;
  lowp float vdn_67;
  lowp vec4 ldn_68;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_17.w);
  tmpvar_59 = mix (tmpvar_22.xyz, worldN_1, vec3((tmpvar_22.w * min (1.0, _Roundness.w))));
  tmpvar_59 = normalize(tmpvar_59);
  mediump vec4 tmpvar_69;
  tmpvar_69 = vec4(dot (tmpvar_59, lightDir_60));
  ldn_68 = tmpvar_69;
  ldn_68.w = ((ldn_68.x * 0.5) + 0.5);
  ldn_68.y = max (0.0, ldn_68.x);
  mediump float tmpvar_70;
  tmpvar_70 = mix (ldn_68.y, ldn_68.w, tmpvar_15.w);
  ldn_68.z = tmpvar_70;
  mediump float tmpvar_71;
  tmpvar_71 = dot (viewDir_61, tmpvar_59);
  vdn_67 = tmpvar_71;
  lowp vec2 tmpvar_72;
  tmpvar_72.x = ldn_68.z;
  tmpvar_72.y = tmpvar_20.w;
  lowp vec4 tmpvar_73;
  tmpvar_73 = texture2D (_Ramp, tmpvar_72);
  ramp_66.w = tmpvar_73.w;
  ramp_66.xyz = ((tmpvar_73.xyz * (1.0 - tmpvar_22.w)) + (ldn_68.zzz * tmpvar_22.w));
  lowp vec4 tmpvar_74;
  tmpvar_74.w = 1.0;
  tmpvar_74.xyz = ((ramp_66.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_21 * tmpvar_73.www) + tmpvar_20.xyz));
  mediump vec3 tmpvar_75;
  tmpvar_75 = (-(viewDir_61) - ((2.0 * tmpvar_59) * -(vdn_67)));
  worldRefl_65 = tmpvar_75;
  mediump vec3 worldNormal_76;
  worldNormal_76 = worldRefl_65;
  mediump float perceptualRoughness_77;
  perceptualRoughness_77 = (1.0 - tmpvar_18);
  mediump vec4 tmpvar_78;
  tmpvar_78.xyz = worldNormal_76;
  tmpvar_78.w = ((perceptualRoughness_77 * (1.7 - 
    (0.7 * perceptualRoughness_77)
  )) * 6.0);
  lowp vec4 tmpvar_79;
  tmpvar_79 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_76, tmpvar_78.w);
  mediump vec4 tmpvar_80;
  tmpvar_80 = tmpvar_79;
  mediump float tmpvar_81;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_81 = tmpvar_80.w;
  } else {
    tmpvar_81 = 1.0;
  };
  lowp vec3 tmpvar_82;
  mediump vec3 tmpvar_83;
  tmpvar_83 = clamp (((unity_SpecCube0_HDR.x * tmpvar_81) * tmpvar_80.xyz), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  lowp float tmpvar_84;
  tmpvar_84 = (1.0 - clamp (vdn_67, 0.0, 1.0));
  mediump vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_15.xyz * tmpvar_74.xyz);
  color_64 = tmpvar_85;
  lowp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_87;
  tmpvar_87 = max (0.0, dot (tmpvar_59, normalize(
    (viewDir_61 + lightDir_60)
  )));
  nh_62 = tmpvar_87;
  mediump float tmpvar_88;
  tmpvar_88 = pow (nh_62, (tmpvar_18 * 128.0));
  specular_63 = (tmpvar_86 * tmpvar_88);
  specular_63.xyz = (specular_63.xyz + ((
    ((tmpvar_82 * (tmpvar_17.w * tmpvar_22.w)) * (1.0 - tmpvar_20.w))
   * tmpvar_84) * tmpvar_84));
  specular_63.xyz = (specular_63.xyz * tmpvar_17.xyz);
  color_64 = (color_64 + specular_63.xyz);
  lowp vec4 tmpvar_89;
  tmpvar_89.xyz = color_64;
  tmpvar_89.w = tmpvar_19;
  tmpvar_58 = tmpvar_89;
  c_2 = tmpvar_58;
  lowp vec4 color_90;
  color_90.w = c_2.w;
  mediump vec4 envFogColor_91;
  highp vec4 tmpvar_92;
  lowp vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = unity_FogColor.xyz;
  tmpvar_92 = tmpvar_93;
  envFogColor_91 = tmpvar_92;
  envFogColor_91.w = (envFogColor_91.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_94;
  tmpvar_94 = mix (envFogColor_91.xyz, c_2.xyz, envFogColor_91.www);
  color_90.xyz = tmpvar_94;
  c_2 = color_90;
  gl_FragData[0] = color_90;
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
}
Fallback "Holo/Character/Eye Shade/Pixel Lit - Skin"
CustomEditor "CustomMaterialInspector"
}