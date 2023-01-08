//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye Shade/Irises/OS Normal Mapped" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _lIris ("Left Iris/Pupil (RGBA)", 2D) = "black" { }
 _rIris ("Right Iris/Pupil (RGBA)", 2D) = "black" { }
 _OsNormalMap ("Object-space Normal Map (RGB, A=Eye Mask)", 2D) = "gray" { }
[Toggle(BRB_EYE_ADD_MASKS)]  _AddMask ("    Add alpha from Base with OS Normal (special eye case)", Float) = 0.000000
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
  GpuProgramID 45733
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
  lowp vec3 worldNormal_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_8.x = tmpvar_13.x;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_16;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = normalize(tmpvar_17.xyz);
  tmpvar_18.w = tmpvar_17.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = tmpvar_6;
  tmpvar_7 = (tmpvar_18 - tmpvar_19);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * tmpvar_6));
  vsNormal_11 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_23.w = exp2((-(tmpvar_22) * tmpvar_22));
  highp vec4 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = unity_FogColor.xyz;
  tmpvar_24 = tmpvar_25;
  highp vec4 v_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[0].x;
  v_26.x = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[1].x;
  v_26.y = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[2].x;
  v_26.z = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[3].x;
  v_26.w = tmpvar_30;
  highp vec4 v_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[0].y;
  v_31.x = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[1].y;
  v_31.y = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[2].y;
  v_31.z = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[3].y;
  v_31.w = tmpvar_35;
  highp vec4 v_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[0].z;
  v_36.x = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[1].z;
  v_36.y = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[2].z;
  v_36.z = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = unity_WorldToObject[3].z;
  v_36.w = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = normalize(((
    (v_26.xyz * tmpvar_6.x)
   + 
    (v_31.xyz * tmpvar_6.y)
  ) + (v_36.xyz * tmpvar_6.z)));
  worldNormal_10 = tmpvar_41;
  highp float tmpvar_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_42 = clamp ((1.0 - (
    (tmpvar_43.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_44;
  tmpvar_44 = max (0.0, -(worldNormal_10.y));
  highp vec4 tmpvar_45;
  tmpvar_45.xyz = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_42 * tmpvar_42)
   * tmpvar_44))) * tmpvar_8.x);
  tmpvar_45.w = (tmpvar_23 * tmpvar_24).w;
  lowp float tmpvar_46;
  tmpvar_46 = vsNormal_11.x;
  rim_9 = tmpvar_46;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_48;
  tmpvar_48 = tmpvar_43.xyz;
  highp vec4 v_49;
  v_49.x = tmpvar_27;
  v_49.y = tmpvar_28;
  v_49.z = tmpvar_29;
  v_49.w = tmpvar_30;
  highp vec4 v_50;
  v_50.x = tmpvar_32;
  v_50.y = tmpvar_33;
  v_50.z = tmpvar_34;
  v_50.w = tmpvar_35;
  highp vec4 v_51;
  v_51.x = tmpvar_37;
  v_51.y = tmpvar_38;
  v_51.z = tmpvar_39;
  v_51.w = tmpvar_40;
  highp vec3 tmpvar_52;
  tmpvar_52 = normalize(((
    (v_49.xyz * tmpvar_6.x)
   + 
    (v_50.xyz * tmpvar_6.y)
  ) + (v_51.xyz * tmpvar_6.z)));
  worldNormal_3 = tmpvar_52;
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.x;
  tmpvar_57.y = tmpvar_56.x;
  tmpvar_57.z = worldNormal_3.x;
  tmpvar_57.w = tmpvar_48.x;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.y;
  tmpvar_58.y = tmpvar_56.y;
  tmpvar_58.z = worldNormal_3.y;
  tmpvar_58.w = tmpvar_48.y;
  highp vec4 tmpvar_59;
  tmpvar_59.x = worldTangent_2.z;
  tmpvar_59.y = tmpvar_56.z;
  tmpvar_59.z = worldNormal_3.z;
  tmpvar_59.w = tmpvar_48.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_47);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_TEXCOORD4 = tmpvar_59;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_45;
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
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_11));
  worldViewDir_7 = tmpvar_13;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  mediump vec3 tsNormal_21;
  mediump vec2 uv2normal_22;
  mediump vec2 shadeoffset_23;
  mediump vec4 irises_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_9.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD5;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD6.xyz;
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
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_9.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = normalize((tmpvar_38 * osNormal_25.xyz));
  tmpvar_39.w = osNormal_25.w;
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.xy = tmpvar_10;
  lowp vec4 tmpvar_41;
  tmpvar_41.xz = vec2(0.0, 0.0);
  tmpvar_41.y = _EyeShadowOffset.x;
  tmpvar_41.w = _EyeShadowOffset.y;
  highp vec4 coord_42;
  coord_42 = (tmpvar_40 + tmpvar_41);
  highp vec4 tmpvar_43;
  tmpvar_43.z = 0.0;
  tmpvar_43.xy = tmpvar_10;
  tmpvar_43.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_44;
  tmpvar_44 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_42.xy, coord_42.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_43.w).w), tmpvar_34.w));
  tmpvar_16.w = tmpvar_44.w;
  tmpvar_16.xyz = vec3((tmpvar_34.w * _EyeSpec));
  tmpvar_17 = _EyeGloss;
  bool tmpvar_45;
  tmpvar_45 = (leftRim_27.z >= 0.0);
  lowp vec4 tmpvar_46;
  if (tmpvar_45) {
    tmpvar_46 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_46 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_24 = tmpvar_46;
  tmpvar_14.xyz = mix (tmpvar_14.xyz, irises_24.xyz, vec3((irises_24.w * tmpvar_34.w)));
  lowp float tmpvar_47;
  if (tmpvar_45) {
    tmpvar_47 = -(_Roundness.x);
  } else {
    tmpvar_47 = _Roundness.x;
  };
  lowp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_47;
  tmpvar_48.y = _Roundness.y;
  shadeoffset_23 = tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((
    (fract((xlv_TEXCOORD0.zw * 4.0)) + shadeoffset_23)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_22 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50.z = 0.0;
  tmpvar_50.xy = ((uv2normal_22 * 2.0) - 1.0);
  tsNormal_21.xy = tmpvar_50.xy;
  tsNormal_21.z = sqrt((1.0 - clamp (
    dot (tmpvar_50.xy, tmpvar_50.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_21;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.x = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.y = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD4.xyz, tmpvar_15);
  worldN_1.z = tmpvar_53;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_54;
  lowp vec3 tmpvar_55;
  mediump vec3 lightDir_56;
  lightDir_56 = lightDir_8;
  mediump vec3 viewDir_57;
  viewDir_57 = worldViewDir_7;
  lowp float nh_58;
  lowp vec4 specular_59;
  lowp vec3 color_60;
  lowp vec3 worldRefl_61;
  lowp vec4 ramp_62;
  lowp float vdn_63;
  lowp vec4 ldn_64;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_44.w);
  tmpvar_55 = mix (tmpvar_39.xyz, worldN_1, vec3((tmpvar_34.w * min (1.0, _Roundness.w))));
  tmpvar_55 = normalize(tmpvar_55);
  mediump vec4 tmpvar_65;
  tmpvar_65 = vec4(dot (tmpvar_55, lightDir_56));
  ldn_64 = tmpvar_65;
  ldn_64.w = ((ldn_64.x * 0.5) + 0.5);
  ldn_64.y = max (0.0, ldn_64.x);
  mediump float tmpvar_66;
  tmpvar_66 = mix (ldn_64.y, ldn_64.w, tmpvar_14.w);
  ldn_64.z = tmpvar_66;
  mediump float tmpvar_67;
  tmpvar_67 = dot (viewDir_57, tmpvar_55);
  vdn_63 = tmpvar_67;
  lowp vec2 tmpvar_68;
  tmpvar_68.x = ldn_64.z;
  tmpvar_68.y = tmpvar_19.w;
  lowp vec4 tmpvar_69;
  tmpvar_69 = texture2D (_Ramp, tmpvar_68);
  ramp_62.w = tmpvar_69.w;
  ramp_62.xyz = ((tmpvar_69.xyz * (1.0 - tmpvar_34.w)) + (ldn_64.zzz * tmpvar_34.w));
  lowp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = ((ramp_62.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_69.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_71;
  tmpvar_71 = (-(viewDir_57) - ((2.0 * tmpvar_55) * -(vdn_63)));
  worldRefl_61 = tmpvar_71;
  mediump vec3 worldNormal_72;
  worldNormal_72 = worldRefl_61;
  mediump float roughness_73;
  roughness_73 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = worldNormal_72;
  tmpvar_74.w = ((roughness_73 * (1.7 - 
    (0.7 * roughness_73)
  )) * 6.0);
  lowp vec4 tmpvar_75;
  tmpvar_75 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_72, tmpvar_74.w);
  mediump vec4 tmpvar_76;
  tmpvar_76 = tmpvar_75;
  lowp vec3 tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = clamp (((tmpvar_76.w * unity_SpecCube0_HDR.x) * tmpvar_76.xyz), 0.0, 1.0);
  tmpvar_77 = tmpvar_78;
  lowp float tmpvar_79;
  tmpvar_79 = (1.0 - clamp (vdn_63, 0.0, 1.0));
  mediump vec3 tmpvar_80;
  tmpvar_80 = (tmpvar_14.xyz * tmpvar_70.xyz);
  color_60 = tmpvar_80;
  lowp vec4 tmpvar_81;
  tmpvar_81.w = 1.0;
  tmpvar_81.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_82;
  tmpvar_82 = max (0.0, dot (tmpvar_55, normalize(
    (viewDir_57 + lightDir_56)
  )));
  nh_58 = tmpvar_82;
  mediump float tmpvar_83;
  tmpvar_83 = pow (nh_58, (tmpvar_17 * 128.0));
  specular_59 = (tmpvar_81 * tmpvar_83);
  specular_59.xyz = (specular_59.xyz + ((
    ((tmpvar_77 * (tmpvar_44.w * tmpvar_34.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_79) * tmpvar_79));
  specular_59.xyz = (specular_59.xyz * tmpvar_16.xyz);
  color_60 = (color_60 + specular_59.xyz);
  lowp vec4 tmpvar_84;
  tmpvar_84.xyz = color_60;
  tmpvar_84.w = tmpvar_18;
  tmpvar_54 = tmpvar_84;
  c_2 = tmpvar_54;
  lowp vec4 color_85;
  color_85.w = c_2.w;
  mediump vec4 envFogColor_86;
  highp vec4 tmpvar_87;
  lowp vec4 tmpvar_88;
  tmpvar_88.w = 1.0;
  tmpvar_88.xyz = unity_FogColor.xyz;
  tmpvar_87 = tmpvar_88;
  envFogColor_86 = tmpvar_87;
  envFogColor_86.w = (envFogColor_86.w * xlv_TEXCOORD6.w);
  mediump vec3 tmpvar_89;
  tmpvar_89 = mix (envFogColor_86.xyz, c_2.xyz, envFogColor_86.www);
  color_85.xyz = tmpvar_89;
  c_2.xyz = color_85.xyz;
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
  lowp vec3 worldNormal_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_8.x = tmpvar_13.x;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_16;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = normalize(tmpvar_17.xyz);
  tmpvar_18.w = tmpvar_17.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = tmpvar_6;
  tmpvar_7 = (tmpvar_18 - tmpvar_19);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * tmpvar_6));
  vsNormal_11 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_23.w = exp2((-(tmpvar_22) * tmpvar_22));
  highp vec4 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = unity_FogColor.xyz;
  tmpvar_24 = tmpvar_25;
  highp vec4 v_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[0].x;
  v_26.x = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[1].x;
  v_26.y = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[2].x;
  v_26.z = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[3].x;
  v_26.w = tmpvar_30;
  highp vec4 v_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[0].y;
  v_31.x = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[1].y;
  v_31.y = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[2].y;
  v_31.z = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[3].y;
  v_31.w = tmpvar_35;
  highp vec4 v_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[0].z;
  v_36.x = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[1].z;
  v_36.y = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[2].z;
  v_36.z = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = unity_WorldToObject[3].z;
  v_36.w = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = normalize(((
    (v_26.xyz * tmpvar_6.x)
   + 
    (v_31.xyz * tmpvar_6.y)
  ) + (v_36.xyz * tmpvar_6.z)));
  worldNormal_10 = tmpvar_41;
  highp float tmpvar_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_42 = clamp ((1.0 - (
    (tmpvar_43.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_44;
  tmpvar_44 = max (0.0, -(worldNormal_10.y));
  highp vec4 tmpvar_45;
  tmpvar_45.xyz = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_42 * tmpvar_42)
   * tmpvar_44))) * tmpvar_8.x);
  tmpvar_45.w = (tmpvar_23 * tmpvar_24).w;
  lowp float tmpvar_46;
  tmpvar_46 = vsNormal_11.x;
  rim_9 = tmpvar_46;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_48;
  tmpvar_48 = tmpvar_43.xyz;
  highp vec4 v_49;
  v_49.x = tmpvar_27;
  v_49.y = tmpvar_28;
  v_49.z = tmpvar_29;
  v_49.w = tmpvar_30;
  highp vec4 v_50;
  v_50.x = tmpvar_32;
  v_50.y = tmpvar_33;
  v_50.z = tmpvar_34;
  v_50.w = tmpvar_35;
  highp vec4 v_51;
  v_51.x = tmpvar_37;
  v_51.y = tmpvar_38;
  v_51.z = tmpvar_39;
  v_51.w = tmpvar_40;
  highp vec3 tmpvar_52;
  tmpvar_52 = normalize(((
    (v_49.xyz * tmpvar_6.x)
   + 
    (v_50.xyz * tmpvar_6.y)
  ) + (v_51.xyz * tmpvar_6.z)));
  worldNormal_3 = tmpvar_52;
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.x;
  tmpvar_57.y = tmpvar_56.x;
  tmpvar_57.z = worldNormal_3.x;
  tmpvar_57.w = tmpvar_48.x;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.y;
  tmpvar_58.y = tmpvar_56.y;
  tmpvar_58.z = worldNormal_3.y;
  tmpvar_58.w = tmpvar_48.y;
  highp vec4 tmpvar_59;
  tmpvar_59.x = worldTangent_2.z;
  tmpvar_59.y = tmpvar_56.z;
  tmpvar_59.z = worldNormal_3.z;
  tmpvar_59.w = tmpvar_48.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_47);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_TEXCOORD4 = tmpvar_59;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_45;
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
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_11));
  worldViewDir_7 = tmpvar_13;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  mediump vec3 tsNormal_21;
  mediump vec2 uv2normal_22;
  mediump vec2 shadeoffset_23;
  mediump vec4 irises_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_9.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD5;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD6.xyz;
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
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_9.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = normalize((tmpvar_38 * osNormal_25.xyz));
  tmpvar_39.w = osNormal_25.w;
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.xy = tmpvar_10;
  lowp vec4 tmpvar_41;
  tmpvar_41.xz = vec2(0.0, 0.0);
  tmpvar_41.y = _EyeShadowOffset.x;
  tmpvar_41.w = _EyeShadowOffset.y;
  highp vec4 coord_42;
  coord_42 = (tmpvar_40 + tmpvar_41);
  highp vec4 tmpvar_43;
  tmpvar_43.z = 0.0;
  tmpvar_43.xy = tmpvar_10;
  tmpvar_43.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_44;
  tmpvar_44 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_42.xy, coord_42.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_43.w).w), tmpvar_34.w));
  tmpvar_16.w = tmpvar_44.w;
  tmpvar_16.xyz = vec3((tmpvar_34.w * _EyeSpec));
  tmpvar_17 = _EyeGloss;
  bool tmpvar_45;
  tmpvar_45 = (leftRim_27.z >= 0.0);
  lowp vec4 tmpvar_46;
  if (tmpvar_45) {
    tmpvar_46 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_46 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_24 = tmpvar_46;
  tmpvar_14.xyz = mix (tmpvar_14.xyz, irises_24.xyz, vec3((irises_24.w * tmpvar_34.w)));
  lowp float tmpvar_47;
  if (tmpvar_45) {
    tmpvar_47 = -(_Roundness.x);
  } else {
    tmpvar_47 = _Roundness.x;
  };
  lowp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_47;
  tmpvar_48.y = _Roundness.y;
  shadeoffset_23 = tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((
    (fract((xlv_TEXCOORD0.zw * 4.0)) + shadeoffset_23)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_22 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50.z = 0.0;
  tmpvar_50.xy = ((uv2normal_22 * 2.0) - 1.0);
  tsNormal_21.xy = tmpvar_50.xy;
  tsNormal_21.z = sqrt((1.0 - clamp (
    dot (tmpvar_50.xy, tmpvar_50.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_21;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.x = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.y = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD4.xyz, tmpvar_15);
  worldN_1.z = tmpvar_53;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_54;
  lowp vec3 tmpvar_55;
  mediump vec3 lightDir_56;
  lightDir_56 = lightDir_8;
  mediump vec3 viewDir_57;
  viewDir_57 = worldViewDir_7;
  lowp float nh_58;
  lowp vec4 specular_59;
  lowp vec3 color_60;
  lowp vec3 worldRefl_61;
  lowp vec4 ramp_62;
  lowp float vdn_63;
  lowp vec4 ldn_64;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_44.w);
  tmpvar_55 = mix (tmpvar_39.xyz, worldN_1, vec3((tmpvar_34.w * min (1.0, _Roundness.w))));
  tmpvar_55 = normalize(tmpvar_55);
  mediump vec4 tmpvar_65;
  tmpvar_65 = vec4(dot (tmpvar_55, lightDir_56));
  ldn_64 = tmpvar_65;
  ldn_64.w = ((ldn_64.x * 0.5) + 0.5);
  ldn_64.y = max (0.0, ldn_64.x);
  mediump float tmpvar_66;
  tmpvar_66 = mix (ldn_64.y, ldn_64.w, tmpvar_14.w);
  ldn_64.z = tmpvar_66;
  mediump float tmpvar_67;
  tmpvar_67 = dot (viewDir_57, tmpvar_55);
  vdn_63 = tmpvar_67;
  lowp vec2 tmpvar_68;
  tmpvar_68.x = ldn_64.z;
  tmpvar_68.y = tmpvar_19.w;
  lowp vec4 tmpvar_69;
  tmpvar_69 = texture2D (_Ramp, tmpvar_68);
  ramp_62.w = tmpvar_69.w;
  ramp_62.xyz = ((tmpvar_69.xyz * (1.0 - tmpvar_34.w)) + (ldn_64.zzz * tmpvar_34.w));
  lowp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = ((ramp_62.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_69.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_71;
  tmpvar_71 = (-(viewDir_57) - ((2.0 * tmpvar_55) * -(vdn_63)));
  worldRefl_61 = tmpvar_71;
  mediump vec3 worldNormal_72;
  worldNormal_72 = worldRefl_61;
  mediump float roughness_73;
  roughness_73 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = worldNormal_72;
  tmpvar_74.w = ((roughness_73 * (1.7 - 
    (0.7 * roughness_73)
  )) * 6.0);
  lowp vec4 tmpvar_75;
  tmpvar_75 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_72, tmpvar_74.w);
  mediump vec4 tmpvar_76;
  tmpvar_76 = tmpvar_75;
  lowp vec3 tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = clamp (((tmpvar_76.w * unity_SpecCube0_HDR.x) * tmpvar_76.xyz), 0.0, 1.0);
  tmpvar_77 = tmpvar_78;
  lowp float tmpvar_79;
  tmpvar_79 = (1.0 - clamp (vdn_63, 0.0, 1.0));
  mediump vec3 tmpvar_80;
  tmpvar_80 = (tmpvar_14.xyz * tmpvar_70.xyz);
  color_60 = tmpvar_80;
  lowp vec4 tmpvar_81;
  tmpvar_81.w = 1.0;
  tmpvar_81.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_82;
  tmpvar_82 = max (0.0, dot (tmpvar_55, normalize(
    (viewDir_57 + lightDir_56)
  )));
  nh_58 = tmpvar_82;
  mediump float tmpvar_83;
  tmpvar_83 = pow (nh_58, (tmpvar_17 * 128.0));
  specular_59 = (tmpvar_81 * tmpvar_83);
  specular_59.xyz = (specular_59.xyz + ((
    ((tmpvar_77 * (tmpvar_44.w * tmpvar_34.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_79) * tmpvar_79));
  specular_59.xyz = (specular_59.xyz * tmpvar_16.xyz);
  color_60 = (color_60 + specular_59.xyz);
  lowp vec4 tmpvar_84;
  tmpvar_84.xyz = color_60;
  tmpvar_84.w = tmpvar_18;
  tmpvar_54 = tmpvar_84;
  c_2 = tmpvar_54;
  lowp vec4 color_85;
  color_85.w = c_2.w;
  mediump vec4 envFogColor_86;
  highp vec4 tmpvar_87;
  lowp vec4 tmpvar_88;
  tmpvar_88.w = 1.0;
  tmpvar_88.xyz = unity_FogColor.xyz;
  tmpvar_87 = tmpvar_88;
  envFogColor_86 = tmpvar_87;
  envFogColor_86.w = (envFogColor_86.w * xlv_TEXCOORD6.w);
  mediump vec3 tmpvar_89;
  tmpvar_89 = mix (envFogColor_86.xyz, c_2.xyz, envFogColor_86.www);
  color_85.xyz = tmpvar_89;
  c_2.xyz = color_85.xyz;
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
  lowp vec3 worldNormal_10;
  lowp vec3 vsNormal_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(((_glesColor.w * (1.0 - tmpvar_12.w)) + tmpvar_12.w));
  tmpvar_8.x = tmpvar_13.x;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_15;
  tmpvar_15 = dot (normalize((
    (unity_WorldToObject * tmpvar_14)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15;
  tmpvar_16.y = ((1.0 - max (0.0, tmpvar_15)) * _glesColor.w);
  tmpvar_8.yw = tmpvar_16;
  tmpvar_8.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = normalize(tmpvar_17.xyz);
  tmpvar_18.w = tmpvar_17.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 0.0;
  tmpvar_19.xyz = tmpvar_6;
  tmpvar_7 = (tmpvar_18 - tmpvar_19);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * tmpvar_6));
  vsNormal_11 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_23;
  tmpvar_23.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_23.w = exp2((-(tmpvar_22) * tmpvar_22));
  highp vec4 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = unity_FogColor.xyz;
  tmpvar_24 = tmpvar_25;
  highp vec4 v_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[0].x;
  v_26.x = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[1].x;
  v_26.y = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = unity_WorldToObject[2].x;
  v_26.z = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = unity_WorldToObject[3].x;
  v_26.w = tmpvar_30;
  highp vec4 v_31;
  highp float tmpvar_32;
  tmpvar_32 = unity_WorldToObject[0].y;
  v_31.x = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = unity_WorldToObject[1].y;
  v_31.y = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = unity_WorldToObject[2].y;
  v_31.z = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = unity_WorldToObject[3].y;
  v_31.w = tmpvar_35;
  highp vec4 v_36;
  highp float tmpvar_37;
  tmpvar_37 = unity_WorldToObject[0].z;
  v_36.x = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = unity_WorldToObject[1].z;
  v_36.y = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = unity_WorldToObject[2].z;
  v_36.z = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = unity_WorldToObject[3].z;
  v_36.w = tmpvar_40;
  highp vec3 tmpvar_41;
  tmpvar_41 = normalize(((
    (v_26.xyz * tmpvar_6.x)
   + 
    (v_31.xyz * tmpvar_6.y)
  ) + (v_36.xyz * tmpvar_6.z)));
  worldNormal_10 = tmpvar_41;
  highp float tmpvar_42;
  highp vec4 tmpvar_43;
  tmpvar_43 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_42 = clamp ((1.0 - (
    (tmpvar_43.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_44;
  tmpvar_44 = max (0.0, -(worldNormal_10.y));
  highp vec4 tmpvar_45;
  tmpvar_45.xyz = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_42 * tmpvar_42)
   * tmpvar_44))) * tmpvar_8.x);
  tmpvar_45.w = (tmpvar_23 * tmpvar_24).w;
  lowp float tmpvar_46;
  tmpvar_46 = vsNormal_11.x;
  rim_9 = tmpvar_46;
  tmpvar_8.x = rim_9;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_5.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  highp vec3 tmpvar_48;
  tmpvar_48 = tmpvar_43.xyz;
  highp vec4 v_49;
  v_49.x = tmpvar_27;
  v_49.y = tmpvar_28;
  v_49.z = tmpvar_29;
  v_49.w = tmpvar_30;
  highp vec4 v_50;
  v_50.x = tmpvar_32;
  v_50.y = tmpvar_33;
  v_50.z = tmpvar_34;
  v_50.w = tmpvar_35;
  highp vec4 v_51;
  v_51.x = tmpvar_37;
  v_51.y = tmpvar_38;
  v_51.z = tmpvar_39;
  v_51.w = tmpvar_40;
  highp vec3 tmpvar_52;
  tmpvar_52 = normalize(((
    (v_49.xyz * tmpvar_6.x)
   + 
    (v_50.xyz * tmpvar_6.y)
  ) + (v_51.xyz * tmpvar_6.z)));
  worldNormal_3 = tmpvar_52;
  highp mat3 tmpvar_53;
  tmpvar_53[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_53[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_53[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_54;
  tmpvar_54 = normalize((tmpvar_53 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_1 = tmpvar_55;
  lowp vec3 tmpvar_56;
  tmpvar_56 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
  highp vec4 tmpvar_57;
  tmpvar_57.x = worldTangent_2.x;
  tmpvar_57.y = tmpvar_56.x;
  tmpvar_57.z = worldNormal_3.x;
  tmpvar_57.w = tmpvar_48.x;
  highp vec4 tmpvar_58;
  tmpvar_58.x = worldTangent_2.y;
  tmpvar_58.y = tmpvar_56.y;
  tmpvar_58.z = worldNormal_3.y;
  tmpvar_58.w = tmpvar_48.y;
  highp vec4 tmpvar_59;
  tmpvar_59.x = worldTangent_2.z;
  tmpvar_59.y = tmpvar_56.z;
  tmpvar_59.z = worldNormal_3.z;
  tmpvar_59.w = tmpvar_48.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_47);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_57;
  xlv_TEXCOORD3 = tmpvar_58;
  xlv_TEXCOORD4 = tmpvar_59;
  xlv_COLOR0 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_45;
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
  lowp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  highp vec4 tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.zw;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD2.w;
  tmpvar_11.y = xlv_TEXCOORD3.w;
  tmpvar_11.z = xlv_TEXCOORD4.w;
  mediump vec3 tmpvar_12;
  tmpvar_12 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - tmpvar_11));
  worldViewDir_7 = tmpvar_13;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  mediump float tmpvar_17;
  lowp float tmpvar_18;
  lowp vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_15 = tmpvar_3;
  tmpvar_16 = tmpvar_4;
  tmpvar_17 = tmpvar_5;
  tmpvar_20 = tmpvar_6;
  mediump vec3 tsNormal_21;
  mediump vec2 uv2normal_22;
  mediump vec2 shadeoffset_23;
  mediump vec4 irises_24;
  lowp vec4 osNormal_25;
  mediump vec3 vlight_26;
  lowp vec4 leftRim_27;
  mediump vec4 c_28;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = c_28.xyz;
  tmpvar_30.w = tmpvar_9.w;
  tmpvar_14 = tmpvar_30;
  tmpvar_18 = c_28.w;
  leftRim_27 = xlv_TEXCOORD5;
  highp vec3 tmpvar_31;
  tmpvar_31 = xlv_TEXCOORD6.xyz;
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
  tmpvar_37 = normalize((tmpvar_35 - tmpvar_9.xyz));
  osNormal_25.xyz = tmpvar_37;
  highp mat3 tmpvar_38;
  tmpvar_38[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_38[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_38[2] = unity_ObjectToWorld[2].xyz;
  lowp vec4 tmpvar_39;
  tmpvar_39.xyz = normalize((tmpvar_38 * osNormal_25.xyz));
  tmpvar_39.w = osNormal_25.w;
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.xy = tmpvar_10;
  lowp vec4 tmpvar_41;
  tmpvar_41.xz = vec2(0.0, 0.0);
  tmpvar_41.y = _EyeShadowOffset.x;
  tmpvar_41.w = _EyeShadowOffset.y;
  highp vec4 coord_42;
  coord_42 = (tmpvar_40 + tmpvar_41);
  highp vec4 tmpvar_43;
  tmpvar_43.z = 0.0;
  tmpvar_43.xy = tmpvar_10;
  tmpvar_43.w = _EyeShadowOffset.z;
  lowp vec4 tmpvar_44;
  tmpvar_44 = vec4(mix (1.0, ((
    (impl_low_texture2DLodEXT (_OsNormalMap, coord_42.xy, coord_42.w).w * 0.5)
   + 0.5) * impl_low_texture2DLodEXT (_OsNormalMap, xlv_TEXCOORD0.zw, tmpvar_43.w).w), tmpvar_34.w));
  tmpvar_16.w = tmpvar_44.w;
  tmpvar_16.xyz = vec3((tmpvar_34.w * _EyeSpec));
  tmpvar_17 = _EyeGloss;
  bool tmpvar_45;
  tmpvar_45 = (leftRim_27.z >= 0.0);
  lowp vec4 tmpvar_46;
  if (tmpvar_45) {
    tmpvar_46 = texture2D (_lIris, xlv_TEXCOORD1.xy);
  } else {
    tmpvar_46 = texture2D (_rIris, xlv_TEXCOORD1.zw);
  };
  irises_24 = tmpvar_46;
  tmpvar_14.xyz = mix (tmpvar_14.xyz, irises_24.xyz, vec3((irises_24.w * tmpvar_34.w)));
  lowp float tmpvar_47;
  if (tmpvar_45) {
    tmpvar_47 = -(_Roundness.x);
  } else {
    tmpvar_47 = _Roundness.x;
  };
  lowp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_47;
  tmpvar_48.y = _Roundness.y;
  shadeoffset_23 = tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49 = (((
    (fract((xlv_TEXCOORD0.zw * 4.0)) + shadeoffset_23)
   - 0.5) * _EyeTiles.zw) + 0.5);
  uv2normal_22 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50.z = 0.0;
  tmpvar_50.xy = ((uv2normal_22 * 2.0) - 1.0);
  tsNormal_21.xy = tmpvar_50.xy;
  tsNormal_21.z = sqrt((1.0 - clamp (
    dot (tmpvar_50.xy, tmpvar_50.xy)
  , 0.0, 1.0)));
  tmpvar_15 = tsNormal_21;
  tmpvar_4 = tmpvar_16;
  tmpvar_5 = tmpvar_17;
  tmpvar_6 = tmpvar_20;
  highp float tmpvar_51;
  tmpvar_51 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
  worldN_1.x = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
  worldN_1.y = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (xlv_TEXCOORD4.xyz, tmpvar_15);
  worldN_1.z = tmpvar_53;
  tmpvar_3 = worldN_1;
  mediump vec4 tmpvar_54;
  lowp vec3 tmpvar_55;
  mediump vec3 lightDir_56;
  lightDir_56 = lightDir_8;
  mediump vec3 viewDir_57;
  viewDir_57 = worldViewDir_7;
  lowp float nh_58;
  lowp vec4 specular_59;
  lowp vec3 color_60;
  lowp vec3 worldRefl_61;
  lowp vec4 ramp_62;
  lowp float vdn_63;
  lowp vec4 ldn_64;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_44.w);
  tmpvar_55 = mix (tmpvar_39.xyz, worldN_1, vec3((tmpvar_34.w * min (1.0, _Roundness.w))));
  tmpvar_55 = normalize(tmpvar_55);
  mediump vec4 tmpvar_65;
  tmpvar_65 = vec4(dot (tmpvar_55, lightDir_56));
  ldn_64 = tmpvar_65;
  ldn_64.w = ((ldn_64.x * 0.5) + 0.5);
  ldn_64.y = max (0.0, ldn_64.x);
  mediump float tmpvar_66;
  tmpvar_66 = mix (ldn_64.y, ldn_64.w, tmpvar_14.w);
  ldn_64.z = tmpvar_66;
  mediump float tmpvar_67;
  tmpvar_67 = dot (viewDir_57, tmpvar_55);
  vdn_63 = tmpvar_67;
  lowp vec2 tmpvar_68;
  tmpvar_68.x = ldn_64.z;
  tmpvar_68.y = tmpvar_19.w;
  lowp vec4 tmpvar_69;
  tmpvar_69 = texture2D (_Ramp, tmpvar_68);
  ramp_62.w = tmpvar_69.w;
  ramp_62.xyz = ((tmpvar_69.xyz * (1.0 - tmpvar_34.w)) + (ldn_64.zzz * tmpvar_34.w));
  lowp vec4 tmpvar_70;
  tmpvar_70.w = 1.0;
  tmpvar_70.xyz = ((ramp_62.xyz * xlat_mutable_LightColor0.xyz) + ((tmpvar_20 * tmpvar_69.www) + tmpvar_19.xyz));
  mediump vec3 tmpvar_71;
  tmpvar_71 = (-(viewDir_57) - ((2.0 * tmpvar_55) * -(vdn_63)));
  worldRefl_61 = tmpvar_71;
  mediump vec3 worldNormal_72;
  worldNormal_72 = worldRefl_61;
  mediump float roughness_73;
  roughness_73 = (1.0 - tmpvar_17);
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = worldNormal_72;
  tmpvar_74.w = ((roughness_73 * (1.7 - 
    (0.7 * roughness_73)
  )) * 6.0);
  lowp vec4 tmpvar_75;
  tmpvar_75 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_72, tmpvar_74.w);
  mediump vec4 tmpvar_76;
  tmpvar_76 = tmpvar_75;
  lowp vec3 tmpvar_77;
  mediump vec3 tmpvar_78;
  tmpvar_78 = clamp (((tmpvar_76.w * unity_SpecCube0_HDR.x) * tmpvar_76.xyz), 0.0, 1.0);
  tmpvar_77 = tmpvar_78;
  lowp float tmpvar_79;
  tmpvar_79 = (1.0 - clamp (vdn_63, 0.0, 1.0));
  mediump vec3 tmpvar_80;
  tmpvar_80 = (tmpvar_14.xyz * tmpvar_70.xyz);
  color_60 = tmpvar_80;
  lowp vec4 tmpvar_81;
  tmpvar_81.w = 1.0;
  tmpvar_81.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_82;
  tmpvar_82 = max (0.0, dot (tmpvar_55, normalize(
    (viewDir_57 + lightDir_56)
  )));
  nh_58 = tmpvar_82;
  mediump float tmpvar_83;
  tmpvar_83 = pow (nh_58, (tmpvar_17 * 128.0));
  specular_59 = (tmpvar_81 * tmpvar_83);
  specular_59.xyz = (specular_59.xyz + ((
    ((tmpvar_77 * (tmpvar_44.w * tmpvar_34.w)) * (1.0 - tmpvar_19.w))
   * tmpvar_79) * tmpvar_79));
  specular_59.xyz = (specular_59.xyz * tmpvar_16.xyz);
  color_60 = (color_60 + specular_59.xyz);
  lowp vec4 tmpvar_84;
  tmpvar_84.xyz = color_60;
  tmpvar_84.w = tmpvar_18;
  tmpvar_54 = tmpvar_84;
  c_2 = tmpvar_54;
  lowp vec4 color_85;
  color_85.w = c_2.w;
  mediump vec4 envFogColor_86;
  highp vec4 tmpvar_87;
  lowp vec4 tmpvar_88;
  tmpvar_88.w = 1.0;
  tmpvar_88.xyz = unity_FogColor.xyz;
  tmpvar_87 = tmpvar_88;
  envFogColor_86 = tmpvar_87;
  envFogColor_86.w = (envFogColor_86.w * xlv_TEXCOORD6.w);
  mediump vec3 tmpvar_89;
  tmpvar_89 = mix (envFogColor_86.xyz, c_2.xyz, envFogColor_86.www);
  color_85.xyz = tmpvar_89;
  c_2.xyz = color_85.xyz;
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
Fallback "Holo/Character/Eye Shade/Irises/Pixel Lit"
}