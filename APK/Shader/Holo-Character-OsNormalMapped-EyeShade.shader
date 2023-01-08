//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye Shade/OS Normal Mapped" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit, SpecularColor)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _OsNormalMap ("Object-space Normal Map (RGB, A=Eye Mask)", 2D) = "gray" { }
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
 _EyeSpec ("Eye Specular", Range(0.000000,1.000000)) = 1.000000
 _EyeGloss ("Eye Glossiness", Range(0.025000,1.000000)) = 0.950000
 _EyeTiles ("Eye Tile Count 'U', 'V', 'U Scale', 'V Scale'", Vector) = (2.000000,4.000000,1.000000,1.000000)
 _Roundness ("Eye Roundness UV 'Offset', 'UNUSED', and 'Strength'", Vector) = (0.000000,0.000000,1.000000,1.000000)
 _EyeShadowOffset ("Eye Shadow 'Offset', 'ShadowBlur', and 'AoBlur'", Vector) = (0.012500,2.000000,2.000000,1.000000)
 _EyeMirrorOffset ("Eye Mirror U Offset", Range(0.000000,2.000000)) = 1.000000
[Toggle(BRB_EYE_SHADE_DEBUG)]  _EyeShadeDebug ("Debug Eye Shading", Float) = 0.000000
[Toggle(BRB_EYE_SHADE_DISABLE)]  _EyeShadeDisable ("Disable Roundness", Float) = 0.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 350
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 9295
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
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 v_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[0].x;
  v_25.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[1].x;
  v_25.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[2].x;
  v_25.z = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[3].x;
  v_25.w = tmpvar_29;
  highp vec4 v_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[0].y;
  v_30.x = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[1].y;
  v_30.y = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[2].y;
  v_30.z = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[3].y;
  v_30.w = tmpvar_34;
  highp vec4 v_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[0].z;
  v_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[1].z;
  v_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[2].z;
  v_35.z = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[3].z;
  v_35.w = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((
    (v_25.xyz * tmpvar_5.x)
   + 
    (v_30.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_9 = tmpvar_40;
  highp float tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_41 = clamp ((1.0 - (
    (tmpvar_42.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_43;
  tmpvar_43 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_44;
  tmpvar_44.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_41 * tmpvar_41)
   * tmpvar_43))) * tmpvar_7.x);
  tmpvar_44.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_45;
  tmpvar_45 = vsNormal_10.x;
  rim_8 = tmpvar_45;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_42.xyz;
  highp vec4 v_48;
  v_48.x = tmpvar_26;
  v_48.y = tmpvar_27;
  v_48.z = tmpvar_28;
  v_48.w = tmpvar_29;
  highp vec4 v_49;
  v_49.x = tmpvar_31;
  v_49.y = tmpvar_32;
  v_49.z = tmpvar_33;
  v_49.w = tmpvar_34;
  highp vec4 v_50;
  v_50.x = tmpvar_36;
  v_50.y = tmpvar_37;
  v_50.z = tmpvar_38;
  v_50.w = tmpvar_39;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((
    (v_48.xyz * tmpvar_5.x)
   + 
    (v_49.xyz * tmpvar_5.y)
  ) + (v_50.xyz * tmpvar_5.z)));
  worldNormal_3 = tmpvar_51;
  highp mat3 tmpvar_52;
  tmpvar_52[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_52[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_52[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize((tmpvar_52 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_56;
  tmpvar_56.x = worldTangent_2.x;
  tmpvar_56.y = tmpvar_55.x;
  tmpvar_56.z = worldNormal_3.x;
  tmpvar_56.w = tmpvar_47.x;
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.y;
  tmpvar_57.y = tmpvar_55.y;
  tmpvar_57.z = worldNormal_3.y;
  tmpvar_57.w = tmpvar_47.y;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.z;
  tmpvar_58.y = tmpvar_55.z;
  tmpvar_58.z = worldNormal_3.z;
  tmpvar_58.w = tmpvar_47.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_46);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_56;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_44;
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_42.xyz);
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
varying highp vec3 xlv_TEXCOORD6;
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
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD6);
  worldViewDir_8 = tmpvar_13;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  tmpvar_21 = tmpvar_7;
  mediump vec3 tsNormal_22;
  mediump vec2 uv2normal_23;
  mediump vec2 shadeoffset_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_10.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD4;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD5.xyz;
  vlight_26 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = vlight_26;
  tmpvar_32.w = leftRim_27.w;
  tmpvar_19 = tmpvar_32;
  lowp vec3 tmpvar_33;
  if ((leftRim_27.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  tmpvar_20 = (tmpvar_33 * abs(leftRim_27.x));
  lowp vec4 tmpvar_34;
  tmpvar_34 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(tmpvar_34.xyz);
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = tmpvar_35;
  tmpvar_36.w = tmpvar_34.w;
  osNormal_25.w = tmpvar_36.w;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_10.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize((tmpvar_38 * osNormal_25.xyz));
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = c_28.w;
  tmpvar_21 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.xy = tmpvar_11;
  lowp vec4 tmpvar_42;
  tmpvar_42.xz = vec2(0.0, 0.0);
  tmpvar_42.y = _EyeShadowOffset.x;
  tmpvar_42.w = _EyeShadowOffset.y;
  highp vec4 coord_43;
  coord_43 = (tmpvar_41 + tmpvar_42);
  highp vec4 tmpvar_44;
  tmpvar_44.z = 0.0;
  tmpvar_44.xy = tmpvar_11;
  tmpvar_44.w = _EyeShadowOffset.z;
  lowp float y_45;
  y_45 = (((impl_low_texture2DLodEXT (_MainTex, coord_43.xy, coord_43.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_44.w).w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(mix (1.0, y_45, c_28.w));
  tmpvar_16.w = tmpvar_46.w;
  mediump vec3 tmpvar_47;
  tmpvar_47 = vec3((c_28.w * _EyeSpec));
  tmpvar_16.xyz = tmpvar_47;
  tmpvar_17 = _EyeGloss;
  lowp float tmpvar_48;
  if ((leftRim_27.z >= 0.0)) {
    tmpvar_48 = -(_Roundness.x);
  } else {
    tmpvar_48 = _Roundness.x;
  };
  lowp vec2 tmpvar_49;
  tmpvar_49.x = tmpvar_48;
  tmpvar_49.y = _Roundness.y;
  shadeoffset_24 = tmpvar_49;
  highp vec2 tmpvar_50;
  tmpvar_50 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_24)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_23 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51.z = 0.0;
  tmpvar_51.xy = ((uv2normal_23 * 2.0) - 1.0);
  tsNormal_22.xy = tmpvar_51.xy;
  tsNormal_22.z = sqrt((1.0 - clamp (
    dot (tmpvar_51.xy, tmpvar_51.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_22;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  tmpvar_7 = tmpvar_21;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
  worldN_1.x = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.y = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.z = tmpvar_54;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_55;
  lowp vec3 tmpvar_56;
  mediump vec3 lightDir_57;
  lightDir_57 = lightDir_9;
  mediump vec3 viewDir_58;
  viewDir_58 = worldViewDir_8;
  lowp float nh_59;
  lowp vec4 specular_60;
  lowp vec3 color_61;
  lowp vec3 worldRefl_62;
  lowp vec4 ramp_63;
  lowp float vdn_64;
  lowp vec4 ldn_65;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_16.w);
  tmpvar_56 = mix (tmpvar_21.xyz, worldN_1, vec3((tmpvar_21.w * min (1.0, _Roundness.w))));
  tmpvar_56 = normalize(tmpvar_56);
  mediump vec4 tmpvar_66;
  tmpvar_66 = vec4(dot (tmpvar_56, lightDir_57));
  ldn_65 = tmpvar_66;
  ldn_65.w = ((ldn_65.x * 0.5) + 0.5);
  ldn_65.y = max (0.0, ldn_65.x);
  mediump float tmpvar_67;
  tmpvar_67 = mix (ldn_65.y, ldn_65.w, tmpvar_14.w);
  ldn_65.z = tmpvar_67;
  mediump float tmpvar_68;
  tmpvar_68 = dot (viewDir_58, tmpvar_56);
  vdn_64 = tmpvar_68;
  lowp vec2 tmpvar_69;
  tmpvar_69.x = ldn_65.z;
  tmpvar_69.y = tmpvar_19.w;
  lowp vec4 tmpvar_70;
  tmpvar_70 = texture2D (_Ramp, tmpvar_69);
  ramp_63.w = tmpvar_70.w;
  ramp_63.xyz = ((tmpvar_70.xyz * (1.0 - tmpvar_21.w)) + (ldn_65.zzz * tmpvar_21.w));
  lowp vec4 tmpvar_71;
  tmpvar_71.w = 1.0;
  tmpvar_71.xyz = ((ramp_63.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_70.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (-(viewDir_58) - ((2.0 * tmpvar_56) * -(vdn_64)));
  worldRefl_62 = tmpvar_72;
  mediump vec3 worldNormal_73;
  worldNormal_73 = worldRefl_62;
  mediump float roughness_74;
  roughness_74 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = worldNormal_73;
  tmpvar_75.w = ((roughness_74 * (1.7 - 
    (0.7 * roughness_74)
  )) * 6.0);
  lowp vec4 tmpvar_76;
  tmpvar_76 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_73, tmpvar_75.w);
  mediump vec4 tmpvar_77;
  tmpvar_77 = tmpvar_76;
  lowp vec3 tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_77.w * unity_SpecCube0_HDR.x) * tmpvar_77.xyz), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  lowp float tmpvar_80;
  tmpvar_80 = (1.0 - clamp (vdn_64, 0.0, 1.0));
  mediump vec3 tmpvar_81;
  tmpvar_81 = (tmpvar_14.xyz * tmpvar_71.xyz);
  color_61 = tmpvar_81;
  lowp vec4 tmpvar_82;
  tmpvar_82.w = 1.0;
  tmpvar_82.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_83;
  tmpvar_83 = max (0.0, dot (tmpvar_56, normalize(
    (viewDir_58 + lightDir_57)
  )));
  nh_59 = tmpvar_83;
  mediump float tmpvar_84;
  tmpvar_84 = pow (nh_59, (tmpvar_17 * 128.0));
  specular_60 = (tmpvar_82 * tmpvar_84);
  specular_60.xyz = (specular_60.xyz + ((
    ((tmpvar_78 * (tmpvar_16.w * tmpvar_21.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_80) * tmpvar_80));
  specular_60.xyz = (specular_60.xyz * tmpvar_16.xyz);
  color_61 = (color_61 + specular_60.xyz);
  lowp vec4 tmpvar_85;
  tmpvar_85.xyz = color_61;
  tmpvar_85.w = tmpvar_18;
  tmpvar_55 = tmpvar_85;
  c_2 = tmpvar_55;
  lowp vec4 color_86;
  color_86.w = c_2.w;
  mediump vec4 envFogColor_87;
  highp vec4 tmpvar_88;
  lowp vec4 tmpvar_89;
  tmpvar_89.w = 1.0;
  tmpvar_89.xyz = unity_FogColor.xyz;
  tmpvar_88 = tmpvar_89;
  envFogColor_87 = tmpvar_88;
  envFogColor_87.w = (envFogColor_87.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_90;
  tmpvar_90 = mix (envFogColor_87.xyz, c_2.xyz, envFogColor_87.www);
  color_86.xyz = tmpvar_90;
  c_2.xyz = color_86.xyz;
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
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 v_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[0].x;
  v_25.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[1].x;
  v_25.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[2].x;
  v_25.z = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[3].x;
  v_25.w = tmpvar_29;
  highp vec4 v_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[0].y;
  v_30.x = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[1].y;
  v_30.y = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[2].y;
  v_30.z = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[3].y;
  v_30.w = tmpvar_34;
  highp vec4 v_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[0].z;
  v_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[1].z;
  v_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[2].z;
  v_35.z = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[3].z;
  v_35.w = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((
    (v_25.xyz * tmpvar_5.x)
   + 
    (v_30.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_9 = tmpvar_40;
  highp float tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_41 = clamp ((1.0 - (
    (tmpvar_42.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_43;
  tmpvar_43 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_44;
  tmpvar_44.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_41 * tmpvar_41)
   * tmpvar_43))) * tmpvar_7.x);
  tmpvar_44.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_45;
  tmpvar_45 = vsNormal_10.x;
  rim_8 = tmpvar_45;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_42.xyz;
  highp vec4 v_48;
  v_48.x = tmpvar_26;
  v_48.y = tmpvar_27;
  v_48.z = tmpvar_28;
  v_48.w = tmpvar_29;
  highp vec4 v_49;
  v_49.x = tmpvar_31;
  v_49.y = tmpvar_32;
  v_49.z = tmpvar_33;
  v_49.w = tmpvar_34;
  highp vec4 v_50;
  v_50.x = tmpvar_36;
  v_50.y = tmpvar_37;
  v_50.z = tmpvar_38;
  v_50.w = tmpvar_39;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((
    (v_48.xyz * tmpvar_5.x)
   + 
    (v_49.xyz * tmpvar_5.y)
  ) + (v_50.xyz * tmpvar_5.z)));
  worldNormal_3 = tmpvar_51;
  highp mat3 tmpvar_52;
  tmpvar_52[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_52[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_52[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize((tmpvar_52 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_56;
  tmpvar_56.x = worldTangent_2.x;
  tmpvar_56.y = tmpvar_55.x;
  tmpvar_56.z = worldNormal_3.x;
  tmpvar_56.w = tmpvar_47.x;
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.y;
  tmpvar_57.y = tmpvar_55.y;
  tmpvar_57.z = worldNormal_3.y;
  tmpvar_57.w = tmpvar_47.y;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.z;
  tmpvar_58.y = tmpvar_55.z;
  tmpvar_58.z = worldNormal_3.z;
  tmpvar_58.w = tmpvar_47.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_46);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_56;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_44;
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_42.xyz);
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
varying highp vec3 xlv_TEXCOORD6;
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
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD6);
  worldViewDir_8 = tmpvar_13;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  tmpvar_21 = tmpvar_7;
  mediump vec3 tsNormal_22;
  mediump vec2 uv2normal_23;
  mediump vec2 shadeoffset_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_10.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD4;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD5.xyz;
  vlight_26 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = vlight_26;
  tmpvar_32.w = leftRim_27.w;
  tmpvar_19 = tmpvar_32;
  lowp vec3 tmpvar_33;
  if ((leftRim_27.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  tmpvar_20 = (tmpvar_33 * abs(leftRim_27.x));
  lowp vec4 tmpvar_34;
  tmpvar_34 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(tmpvar_34.xyz);
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = tmpvar_35;
  tmpvar_36.w = tmpvar_34.w;
  osNormal_25.w = tmpvar_36.w;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_10.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize((tmpvar_38 * osNormal_25.xyz));
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = c_28.w;
  tmpvar_21 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.xy = tmpvar_11;
  lowp vec4 tmpvar_42;
  tmpvar_42.xz = vec2(0.0, 0.0);
  tmpvar_42.y = _EyeShadowOffset.x;
  tmpvar_42.w = _EyeShadowOffset.y;
  highp vec4 coord_43;
  coord_43 = (tmpvar_41 + tmpvar_42);
  highp vec4 tmpvar_44;
  tmpvar_44.z = 0.0;
  tmpvar_44.xy = tmpvar_11;
  tmpvar_44.w = _EyeShadowOffset.z;
  lowp float y_45;
  y_45 = (((impl_low_texture2DLodEXT (_MainTex, coord_43.xy, coord_43.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_44.w).w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(mix (1.0, y_45, c_28.w));
  tmpvar_16.w = tmpvar_46.w;
  mediump vec3 tmpvar_47;
  tmpvar_47 = vec3((c_28.w * _EyeSpec));
  tmpvar_16.xyz = tmpvar_47;
  tmpvar_17 = _EyeGloss;
  lowp float tmpvar_48;
  if ((leftRim_27.z >= 0.0)) {
    tmpvar_48 = -(_Roundness.x);
  } else {
    tmpvar_48 = _Roundness.x;
  };
  lowp vec2 tmpvar_49;
  tmpvar_49.x = tmpvar_48;
  tmpvar_49.y = _Roundness.y;
  shadeoffset_24 = tmpvar_49;
  highp vec2 tmpvar_50;
  tmpvar_50 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_24)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_23 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51.z = 0.0;
  tmpvar_51.xy = ((uv2normal_23 * 2.0) - 1.0);
  tsNormal_22.xy = tmpvar_51.xy;
  tsNormal_22.z = sqrt((1.0 - clamp (
    dot (tmpvar_51.xy, tmpvar_51.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_22;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  tmpvar_7 = tmpvar_21;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
  worldN_1.x = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.y = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.z = tmpvar_54;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_55;
  lowp vec3 tmpvar_56;
  mediump vec3 lightDir_57;
  lightDir_57 = lightDir_9;
  mediump vec3 viewDir_58;
  viewDir_58 = worldViewDir_8;
  lowp float nh_59;
  lowp vec4 specular_60;
  lowp vec3 color_61;
  lowp vec3 worldRefl_62;
  lowp vec4 ramp_63;
  lowp float vdn_64;
  lowp vec4 ldn_65;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_16.w);
  tmpvar_56 = mix (tmpvar_21.xyz, worldN_1, vec3((tmpvar_21.w * min (1.0, _Roundness.w))));
  tmpvar_56 = normalize(tmpvar_56);
  mediump vec4 tmpvar_66;
  tmpvar_66 = vec4(dot (tmpvar_56, lightDir_57));
  ldn_65 = tmpvar_66;
  ldn_65.w = ((ldn_65.x * 0.5) + 0.5);
  ldn_65.y = max (0.0, ldn_65.x);
  mediump float tmpvar_67;
  tmpvar_67 = mix (ldn_65.y, ldn_65.w, tmpvar_14.w);
  ldn_65.z = tmpvar_67;
  mediump float tmpvar_68;
  tmpvar_68 = dot (viewDir_58, tmpvar_56);
  vdn_64 = tmpvar_68;
  lowp vec2 tmpvar_69;
  tmpvar_69.x = ldn_65.z;
  tmpvar_69.y = tmpvar_19.w;
  lowp vec4 tmpvar_70;
  tmpvar_70 = texture2D (_Ramp, tmpvar_69);
  ramp_63.w = tmpvar_70.w;
  ramp_63.xyz = ((tmpvar_70.xyz * (1.0 - tmpvar_21.w)) + (ldn_65.zzz * tmpvar_21.w));
  lowp vec4 tmpvar_71;
  tmpvar_71.w = 1.0;
  tmpvar_71.xyz = ((ramp_63.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_70.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (-(viewDir_58) - ((2.0 * tmpvar_56) * -(vdn_64)));
  worldRefl_62 = tmpvar_72;
  mediump vec3 worldNormal_73;
  worldNormal_73 = worldRefl_62;
  mediump float roughness_74;
  roughness_74 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = worldNormal_73;
  tmpvar_75.w = ((roughness_74 * (1.7 - 
    (0.7 * roughness_74)
  )) * 6.0);
  lowp vec4 tmpvar_76;
  tmpvar_76 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_73, tmpvar_75.w);
  mediump vec4 tmpvar_77;
  tmpvar_77 = tmpvar_76;
  lowp vec3 tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_77.w * unity_SpecCube0_HDR.x) * tmpvar_77.xyz), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  lowp float tmpvar_80;
  tmpvar_80 = (1.0 - clamp (vdn_64, 0.0, 1.0));
  mediump vec3 tmpvar_81;
  tmpvar_81 = (tmpvar_14.xyz * tmpvar_71.xyz);
  color_61 = tmpvar_81;
  lowp vec4 tmpvar_82;
  tmpvar_82.w = 1.0;
  tmpvar_82.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_83;
  tmpvar_83 = max (0.0, dot (tmpvar_56, normalize(
    (viewDir_58 + lightDir_57)
  )));
  nh_59 = tmpvar_83;
  mediump float tmpvar_84;
  tmpvar_84 = pow (nh_59, (tmpvar_17 * 128.0));
  specular_60 = (tmpvar_82 * tmpvar_84);
  specular_60.xyz = (specular_60.xyz + ((
    ((tmpvar_78 * (tmpvar_16.w * tmpvar_21.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_80) * tmpvar_80));
  specular_60.xyz = (specular_60.xyz * tmpvar_16.xyz);
  color_61 = (color_61 + specular_60.xyz);
  lowp vec4 tmpvar_85;
  tmpvar_85.xyz = color_61;
  tmpvar_85.w = tmpvar_18;
  tmpvar_55 = tmpvar_85;
  c_2 = tmpvar_55;
  lowp vec4 color_86;
  color_86.w = c_2.w;
  mediump vec4 envFogColor_87;
  highp vec4 tmpvar_88;
  lowp vec4 tmpvar_89;
  tmpvar_89.w = 1.0;
  tmpvar_89.xyz = unity_FogColor.xyz;
  tmpvar_88 = tmpvar_89;
  envFogColor_87 = tmpvar_88;
  envFogColor_87.w = (envFogColor_87.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_90;
  tmpvar_90 = mix (envFogColor_87.xyz, c_2.xyz, envFogColor_87.www);
  color_86.xyz = tmpvar_90;
  c_2.xyz = color_86.xyz;
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
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 v_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[0].x;
  v_25.x = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[1].x;
  v_25.y = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[2].x;
  v_25.z = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[3].x;
  v_25.w = tmpvar_29;
  highp vec4 v_30;
  highp float tmpvar_31;
  tmpvar_31 = unity_WorldToObject[0].y;
  v_30.x = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[1].y;
  v_30.y = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[2].y;
  v_30.z = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[3].y;
  v_30.w = tmpvar_34;
  highp vec4 v_35;
  highp float tmpvar_36;
  tmpvar_36 = unity_WorldToObject[0].z;
  v_35.x = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[1].z;
  v_35.y = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[2].z;
  v_35.z = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[3].z;
  v_35.w = tmpvar_39;
  highp vec3 tmpvar_40;
  tmpvar_40 = normalize(((
    (v_25.xyz * tmpvar_5.x)
   + 
    (v_30.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_9 = tmpvar_40;
  highp float tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_41 = clamp ((1.0 - (
    (tmpvar_42.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_43;
  tmpvar_43 = max (0.0, -(worldNormal_9.y));
  highp vec4 tmpvar_44;
  tmpvar_44.xyz = (mix (tmpvar_11.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_41 * tmpvar_41)
   * tmpvar_43))) * tmpvar_7.x);
  tmpvar_44.w = (tmpvar_22 * tmpvar_23).w;
  lowp float tmpvar_45;
  tmpvar_45 = vsNormal_10.x;
  rim_8 = tmpvar_45;
  tmpvar_7.x = rim_8;
  highp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec3 tmpvar_47;
  tmpvar_47 = tmpvar_42.xyz;
  highp vec4 v_48;
  v_48.x = tmpvar_26;
  v_48.y = tmpvar_27;
  v_48.z = tmpvar_28;
  v_48.w = tmpvar_29;
  highp vec4 v_49;
  v_49.x = tmpvar_31;
  v_49.y = tmpvar_32;
  v_49.z = tmpvar_33;
  v_49.w = tmpvar_34;
  highp vec4 v_50;
  v_50.x = tmpvar_36;
  v_50.y = tmpvar_37;
  v_50.z = tmpvar_38;
  v_50.w = tmpvar_39;
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize(((
    (v_48.xyz * tmpvar_5.x)
   + 
    (v_49.xyz * tmpvar_5.y)
  ) + (v_50.xyz * tmpvar_5.z)));
  worldNormal_3 = tmpvar_51;
  highp mat3 tmpvar_52;
  tmpvar_52[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_52[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_52[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize((tmpvar_52 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_54;
  lowp vec3 tmpvar_55;
  tmpvar_55 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_56;
  tmpvar_56.x = worldTangent_2.x;
  tmpvar_56.y = tmpvar_55.x;
  tmpvar_56.z = worldNormal_3.x;
  tmpvar_56.w = tmpvar_47.x;
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.y;
  tmpvar_57.y = tmpvar_55.y;
  tmpvar_57.z = worldNormal_3.y;
  tmpvar_57.w = tmpvar_47.y;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.z;
  tmpvar_58.y = tmpvar_55.z;
  tmpvar_58.z = worldNormal_3.z;
  tmpvar_58.w = tmpvar_47.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_46);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_56;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_44;
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_42.xyz);
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
varying highp vec3 xlv_TEXCOORD6;
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
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD6);
  worldViewDir_8 = tmpvar_13;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  tmpvar_21 = tmpvar_7;
  mediump vec3 tsNormal_22;
  mediump vec2 uv2normal_23;
  mediump vec2 shadeoffset_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_10.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD4;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD5.xyz;
  vlight_26 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = vlight_26;
  tmpvar_32.w = leftRim_27.w;
  tmpvar_19 = tmpvar_32;
  lowp vec3 tmpvar_33;
  if ((leftRim_27.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  tmpvar_20 = (tmpvar_33 * abs(leftRim_27.x));
  lowp vec4 tmpvar_34;
  tmpvar_34 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_35;
  tmpvar_35 = normalize(tmpvar_34.xyz);
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = tmpvar_35;
  tmpvar_36.w = tmpvar_34.w;
  osNormal_25.w = tmpvar_36.w;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_10.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_39;
  tmpvar_39 = normalize((tmpvar_38 * osNormal_25.xyz));
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = tmpvar_39;
  tmpvar_40.w = c_28.w;
  tmpvar_21 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.xy = tmpvar_11;
  lowp vec4 tmpvar_42;
  tmpvar_42.xz = vec2(0.0, 0.0);
  tmpvar_42.y = _EyeShadowOffset.x;
  tmpvar_42.w = _EyeShadowOffset.y;
  highp vec4 coord_43;
  coord_43 = (tmpvar_41 + tmpvar_42);
  highp vec4 tmpvar_44;
  tmpvar_44.z = 0.0;
  tmpvar_44.xy = tmpvar_11;
  tmpvar_44.w = _EyeShadowOffset.z;
  lowp float y_45;
  y_45 = (((impl_low_texture2DLodEXT (_MainTex, coord_43.xy, coord_43.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_44.w).w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(mix (1.0, y_45, c_28.w));
  tmpvar_16.w = tmpvar_46.w;
  mediump vec3 tmpvar_47;
  tmpvar_47 = vec3((c_28.w * _EyeSpec));
  tmpvar_16.xyz = tmpvar_47;
  tmpvar_17 = _EyeGloss;
  lowp float tmpvar_48;
  if ((leftRim_27.z >= 0.0)) {
    tmpvar_48 = -(_Roundness.x);
  } else {
    tmpvar_48 = _Roundness.x;
  };
  lowp vec2 tmpvar_49;
  tmpvar_49.x = tmpvar_48;
  tmpvar_49.y = _Roundness.y;
  shadeoffset_24 = tmpvar_49;
  highp vec2 tmpvar_50;
  tmpvar_50 = (((
    (fract((xlv_TEXCOORD0.xy * _EyeTiles.xy)) + shadeoffset_24)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_23 = tmpvar_50;
  mediump vec3 tmpvar_51;
  tmpvar_51.z = 0.0;
  tmpvar_51.xy = ((uv2normal_23 * 2.0) - 1.0);
  tsNormal_22.xy = tmpvar_51.xy;
  tsNormal_22.z = sqrt((1.0 - clamp (
    dot (tmpvar_51.xy, tmpvar_51.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_22;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  tmpvar_7 = tmpvar_21;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
  worldN_1.x = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.y = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.z = tmpvar_54;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_55;
  lowp vec3 tmpvar_56;
  mediump vec3 lightDir_57;
  lightDir_57 = lightDir_9;
  mediump vec3 viewDir_58;
  viewDir_58 = worldViewDir_8;
  lowp float nh_59;
  lowp vec4 specular_60;
  lowp vec3 color_61;
  lowp vec3 worldRefl_62;
  lowp vec4 ramp_63;
  lowp float vdn_64;
  lowp vec4 ldn_65;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_16.w);
  tmpvar_56 = mix (tmpvar_21.xyz, worldN_1, vec3((tmpvar_21.w * min (1.0, _Roundness.w))));
  tmpvar_56 = normalize(tmpvar_56);
  mediump vec4 tmpvar_66;
  tmpvar_66 = vec4(dot (tmpvar_56, lightDir_57));
  ldn_65 = tmpvar_66;
  ldn_65.w = ((ldn_65.x * 0.5) + 0.5);
  ldn_65.y = max (0.0, ldn_65.x);
  mediump float tmpvar_67;
  tmpvar_67 = mix (ldn_65.y, ldn_65.w, tmpvar_14.w);
  ldn_65.z = tmpvar_67;
  mediump float tmpvar_68;
  tmpvar_68 = dot (viewDir_58, tmpvar_56);
  vdn_64 = tmpvar_68;
  lowp vec2 tmpvar_69;
  tmpvar_69.x = ldn_65.z;
  tmpvar_69.y = tmpvar_19.w;
  lowp vec4 tmpvar_70;
  tmpvar_70 = texture2D (_Ramp, tmpvar_69);
  ramp_63.w = tmpvar_70.w;
  ramp_63.xyz = ((tmpvar_70.xyz * (1.0 - tmpvar_21.w)) + (ldn_65.zzz * tmpvar_21.w));
  lowp vec4 tmpvar_71;
  tmpvar_71.w = 1.0;
  tmpvar_71.xyz = ((ramp_63.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_70.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_72;
  tmpvar_72 = (-(viewDir_58) - ((2.0 * tmpvar_56) * -(vdn_64)));
  worldRefl_62 = tmpvar_72;
  mediump vec3 worldNormal_73;
  worldNormal_73 = worldRefl_62;
  mediump float roughness_74;
  roughness_74 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_75;
  tmpvar_75.xyz = worldNormal_73;
  tmpvar_75.w = ((roughness_74 * (1.7 - 
    (0.7 * roughness_74)
  )) * 6.0);
  lowp vec4 tmpvar_76;
  tmpvar_76 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_73, tmpvar_75.w);
  mediump vec4 tmpvar_77;
  tmpvar_77 = tmpvar_76;
  lowp vec3 tmpvar_78;
  mediump vec3 tmpvar_79;
  tmpvar_79 = clamp (((tmpvar_77.w * unity_SpecCube0_HDR.x) * tmpvar_77.xyz), 0.0, 1.0);
  tmpvar_78 = tmpvar_79;
  lowp float tmpvar_80;
  tmpvar_80 = (1.0 - clamp (vdn_64, 0.0, 1.0));
  mediump vec3 tmpvar_81;
  tmpvar_81 = (tmpvar_14.xyz * tmpvar_71.xyz);
  color_61 = tmpvar_81;
  lowp vec4 tmpvar_82;
  tmpvar_82.w = 1.0;
  tmpvar_82.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_83;
  tmpvar_83 = max (0.0, dot (tmpvar_56, normalize(
    (viewDir_58 + lightDir_57)
  )));
  nh_59 = tmpvar_83;
  mediump float tmpvar_84;
  tmpvar_84 = pow (nh_59, (tmpvar_17 * 128.0));
  specular_60 = (tmpvar_82 * tmpvar_84);
  specular_60.xyz = (specular_60.xyz + ((
    ((tmpvar_78 * (tmpvar_16.w * tmpvar_21.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_80) * tmpvar_80));
  specular_60.xyz = (specular_60.xyz * tmpvar_16.xyz);
  color_61 = (color_61 + specular_60.xyz);
  lowp vec4 tmpvar_85;
  tmpvar_85.xyz = color_61;
  tmpvar_85.w = tmpvar_18;
  tmpvar_55 = tmpvar_85;
  c_2 = tmpvar_55;
  lowp vec4 color_86;
  color_86.w = c_2.w;
  mediump vec4 envFogColor_87;
  highp vec4 tmpvar_88;
  lowp vec4 tmpvar_89;
  tmpvar_89.w = 1.0;
  tmpvar_89.xyz = unity_FogColor.xyz;
  tmpvar_88 = tmpvar_89;
  envFogColor_87 = tmpvar_88;
  envFogColor_87.w = (envFogColor_87.w * xlv_TEXCOORD5.w);
  mediump vec3 tmpvar_90;
  tmpvar_90 = mix (envFogColor_87.xyz, c_2.xyz, envFogColor_87.www);
  color_86.xyz = tmpvar_90;
  c_2.xyz = color_86.xyz;
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