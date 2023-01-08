//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Irises/Pixel Lit (No Cubemap)" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit, SpecularColor, DesaturatedRamp, LinearRamp)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _lIris ("Left Iris/Pupil (RGBA)", 2D) = "black" { }
 _rIris ("Right Iris/Pupil (RGBA)", 2D) = "black" { }
 _OsNormalMap ("Eye Mask (Alpha)", 2D) = "gray" { }
[Toggle(BRB_EYE_ADD_MASKS)]  _AddMask ("    Add Base Alpha with Eye Mask (special eye case)", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
 _EyeShadowOffset ("Eye Shadow 'Offset', 'ShadowBlur', and 'AoBlur'", Vector) = (0.012500,2.000000,2.000000,1.000000)
 _EyeMirrorOffset ("Eye Mirror U Offset", Range(0.000000,2.000000)) = 1.000000
 _Specularity ("Specularity", Range(0.000000,2.000000)) = 0.100000
 _Glossiness ("Specular Glossiness", Range(0.025000,1.000000)) = 0.100000
[KeywordEnum(None, Specularity)]  _Fresnel ("Fresnel Mode", Float) = 0.000000
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 275
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 4266
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec3 vlight_9;
  lowp vec3 worldNormal_10;
  highp vec4 envFogColor_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_7.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_17;
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_6.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
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
  envFogColor_11 = (tmpvar_21 * tmpvar_22);
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_10.y));
  vlight_9 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_9;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_12.x;
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
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
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
    (v_33.xyz * tmpvar_5.x)
   + 
    (v_34.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = envFogColor_11;
  xlv_TEXCOORD6 = (tmpvar_31 * abs(rim_8));
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  worldViewDir_4 = tmpvar_9;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD2;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  mediump float tmpvar_12;
  lowp float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = tmpvar_3.xyz;
  mediump vec4 irises_17;
  mediump vec3 vlight_18;
  lowp vec4 leftRim_19;
  mediump vec4 c_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = c_20.xyz;
  tmpvar_22.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_22;
  tmpvar_13 = c_20.w;
  leftRim_19 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_6.xyz;
  vlight_18 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_18;
  tmpvar_24.w = leftRim_19.y;
  tmpvar_14 = tmpvar_24;
  tmpvar_15 = xlv_TEXCOORD6;
  tmpvar_16.w = c_20.w;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = tmpvar_7;
  lowp vec4 tmpvar_26;
  tmpvar_26.xz = vec2(0.0, 0.0);
  tmpvar_26.y = _EyeShadowOffset.x;
  tmpvar_26.w = _EyeShadowOffset.y;
  highp vec4 coord_27;
  coord_27 = (tmpvar_25 + tmpvar_26);
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = tmpvar_7;
  tmpvar_28.w = _EyeShadowOffset.z;
  lowp float y_29;
  y_29 = (((impl_low_texture2DLodEXT (_MainTex, coord_27.xy, coord_27.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_28.w).w);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(mix (1.0, y_29, c_20.w));
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = vec3(_Specularity);
  tmpvar_12 = _Glossiness;
  lowp vec4 tmpvar_31;
  if ((leftRim_19.z >= 0.0)) {
    tmpvar_31 = texture2D (_lIris, xlv_TEXCOORD0.zw);
  } else {
    tmpvar_31 = texture2D (_rIris, xlv_TEXCOORD1);
  };
  irises_17 = tmpvar_31;
  tmpvar_10.xyz = mix (tmpvar_10.xyz, irises_17.xyz, vec3((irises_17.w * c_20.w)));
  tmpvar_3 = tmpvar_16;
  mediump vec4 tmpvar_32;
  lowp vec3 tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_35;
  lightDir_35 = lightDir_5;
  mediump vec3 viewDir_36;
  viewDir_36 = worldViewDir_4;
  lowp float nh_37;
  lowp vec4 specular_38;
  lowp vec3 color_39;
  lowp vec4 ldn_40;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_11.w);
  tmpvar_33 = normalize(tmpvar_2);
  mediump vec4 tmpvar_41;
  tmpvar_41 = vec4(dot (tmpvar_33, lightDir_35));
  ldn_40 = tmpvar_41;
  ldn_40.w = ((ldn_40.x * 0.5) + 0.5);
  ldn_40.y = max (0.0, ldn_40.x);
  mediump float tmpvar_42;
  tmpvar_42 = mix (ldn_40.y, ldn_40.w, tmpvar_10.w);
  ldn_40.z = tmpvar_42;
  tmpvar_34.w = ((1.0 - clamp (tmpvar_14.w, 0.0, 1.0)) * tmpvar_10.w);
  lowp vec2 tmpvar_43;
  tmpvar_43.x = ldn_40.z;
  tmpvar_43.y = tmpvar_34.w;
  lowp vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = ((ldn_40.zzz * xlat_mutable_LightColor0.xyz) + ((tmpvar_15 * texture2D (_Ramp, tmpvar_43).www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_10.xyz * tmpvar_44.xyz);
  color_39 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_33, normalize(
    (viewDir_36 + lightDir_35)
  )));
  nh_37 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (nh_37, (tmpvar_12 * 128.0));
  specular_38 = (tmpvar_46 * tmpvar_48);
  specular_38.xyz = (specular_38.xyz * vec3(_Specularity));
  color_39 = (color_39 + specular_38.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49.xyz = color_39;
  tmpvar_49.w = tmpvar_13;
  tmpvar_32 = tmpvar_49;
  c_1 = tmpvar_32;
  lowp vec4 color_50;
  color_50.w = c_1.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (xlv_TEXCOORD5.xyz, c_1.xyz, xlv_TEXCOORD5.www);
  color_50.xyz = tmpvar_51;
  c_1.xyz = color_50.xyz;
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec3 vlight_9;
  lowp vec3 worldNormal_10;
  highp vec4 envFogColor_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_7.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_17;
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_6.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
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
  envFogColor_11 = (tmpvar_21 * tmpvar_22);
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_10.y));
  vlight_9 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_9;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_12.x;
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
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
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
    (v_33.xyz * tmpvar_5.x)
   + 
    (v_34.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = envFogColor_11;
  xlv_TEXCOORD6 = (tmpvar_31 * abs(rim_8));
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  worldViewDir_4 = tmpvar_9;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD2;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  mediump float tmpvar_12;
  lowp float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = tmpvar_3.xyz;
  mediump vec4 irises_17;
  mediump vec3 vlight_18;
  lowp vec4 leftRim_19;
  mediump vec4 c_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = c_20.xyz;
  tmpvar_22.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_22;
  tmpvar_13 = c_20.w;
  leftRim_19 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_6.xyz;
  vlight_18 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_18;
  tmpvar_24.w = leftRim_19.y;
  tmpvar_14 = tmpvar_24;
  tmpvar_15 = xlv_TEXCOORD6;
  tmpvar_16.w = c_20.w;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = tmpvar_7;
  lowp vec4 tmpvar_26;
  tmpvar_26.xz = vec2(0.0, 0.0);
  tmpvar_26.y = _EyeShadowOffset.x;
  tmpvar_26.w = _EyeShadowOffset.y;
  highp vec4 coord_27;
  coord_27 = (tmpvar_25 + tmpvar_26);
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = tmpvar_7;
  tmpvar_28.w = _EyeShadowOffset.z;
  lowp float y_29;
  y_29 = (((impl_low_texture2DLodEXT (_MainTex, coord_27.xy, coord_27.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_28.w).w);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(mix (1.0, y_29, c_20.w));
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = vec3(_Specularity);
  tmpvar_12 = _Glossiness;
  lowp vec4 tmpvar_31;
  if ((leftRim_19.z >= 0.0)) {
    tmpvar_31 = texture2D (_lIris, xlv_TEXCOORD0.zw);
  } else {
    tmpvar_31 = texture2D (_rIris, xlv_TEXCOORD1);
  };
  irises_17 = tmpvar_31;
  tmpvar_10.xyz = mix (tmpvar_10.xyz, irises_17.xyz, vec3((irises_17.w * c_20.w)));
  tmpvar_3 = tmpvar_16;
  mediump vec4 tmpvar_32;
  lowp vec3 tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_35;
  lightDir_35 = lightDir_5;
  mediump vec3 viewDir_36;
  viewDir_36 = worldViewDir_4;
  lowp float nh_37;
  lowp vec4 specular_38;
  lowp vec3 color_39;
  lowp vec4 ldn_40;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_11.w);
  tmpvar_33 = normalize(tmpvar_2);
  mediump vec4 tmpvar_41;
  tmpvar_41 = vec4(dot (tmpvar_33, lightDir_35));
  ldn_40 = tmpvar_41;
  ldn_40.w = ((ldn_40.x * 0.5) + 0.5);
  ldn_40.y = max (0.0, ldn_40.x);
  mediump float tmpvar_42;
  tmpvar_42 = mix (ldn_40.y, ldn_40.w, tmpvar_10.w);
  ldn_40.z = tmpvar_42;
  tmpvar_34.w = ((1.0 - clamp (tmpvar_14.w, 0.0, 1.0)) * tmpvar_10.w);
  lowp vec2 tmpvar_43;
  tmpvar_43.x = ldn_40.z;
  tmpvar_43.y = tmpvar_34.w;
  lowp vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = ((ldn_40.zzz * xlat_mutable_LightColor0.xyz) + ((tmpvar_15 * texture2D (_Ramp, tmpvar_43).www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_10.xyz * tmpvar_44.xyz);
  color_39 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_33, normalize(
    (viewDir_36 + lightDir_35)
  )));
  nh_37 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (nh_37, (tmpvar_12 * 128.0));
  specular_38 = (tmpvar_46 * tmpvar_48);
  specular_38.xyz = (specular_38.xyz * vec3(_Specularity));
  color_39 = (color_39 + specular_38.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49.xyz = color_39;
  tmpvar_49.w = tmpvar_13;
  tmpvar_32 = tmpvar_49;
  c_1 = tmpvar_32;
  lowp vec4 color_50;
  color_50.w = c_1.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (xlv_TEXCOORD5.xyz, c_1.xyz, xlv_TEXCOORD5.www);
  color_50.xyz = tmpvar_51;
  c_1.xyz = color_50.xyz;
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec3 vlight_9;
  lowp vec3 worldNormal_10;
  highp vec4 envFogColor_11;
  lowp vec3 vsNormal_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(((_glesColor.w * (1.0 - tmpvar_13.w)) + tmpvar_13.w));
  tmpvar_7.x = tmpvar_14.x;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = ((1.0 - max (0.0, tmpvar_16)) * _glesColor.w);
  tmpvar_7.yw = tmpvar_17;
  tmpvar_7.z = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  tmpvar_6.w = _glesColor.w;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
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
  envFogColor_11 = (tmpvar_21 * tmpvar_22);
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_10.y));
  vlight_9 = (mix (tmpvar_13.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_9;
  lowp float tmpvar_30;
  tmpvar_30 = vsNormal_12.x;
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
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
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
    (v_33.xyz * tmpvar_5.x)
   + 
    (v_34.xyz * tmpvar_5.y)
  ) + (v_35.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_36;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = envFogColor_11;
  xlv_TEXCOORD6 = (tmpvar_31 * abs(rim_8));
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform lowp vec4 _EyeShadowOffset;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0 = _LightColor0;
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD0.xy;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  worldViewDir_4 = tmpvar_9;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD2;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  mediump float tmpvar_12;
  lowp float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = tmpvar_3.xyz;
  mediump vec4 irises_17;
  mediump vec3 vlight_18;
  lowp vec4 leftRim_19;
  mediump vec4 c_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_20 = tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = c_20.xyz;
  tmpvar_22.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_22;
  tmpvar_13 = c_20.w;
  leftRim_19 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_6.xyz;
  vlight_18 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_18;
  tmpvar_24.w = leftRim_19.y;
  tmpvar_14 = tmpvar_24;
  tmpvar_15 = xlv_TEXCOORD6;
  tmpvar_16.w = c_20.w;
  highp vec4 tmpvar_25;
  tmpvar_25.zw = vec2(0.0, 0.0);
  tmpvar_25.xy = tmpvar_7;
  lowp vec4 tmpvar_26;
  tmpvar_26.xz = vec2(0.0, 0.0);
  tmpvar_26.y = _EyeShadowOffset.x;
  tmpvar_26.w = _EyeShadowOffset.y;
  highp vec4 coord_27;
  coord_27 = (tmpvar_25 + tmpvar_26);
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = tmpvar_7;
  tmpvar_28.w = _EyeShadowOffset.z;
  lowp float y_29;
  y_29 = (((impl_low_texture2DLodEXT (_MainTex, coord_27.xy, coord_27.w).w * 0.5) + 0.5) * impl_low_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, tmpvar_28.w).w);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(mix (1.0, y_29, c_20.w));
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = vec3(_Specularity);
  tmpvar_12 = _Glossiness;
  lowp vec4 tmpvar_31;
  if ((leftRim_19.z >= 0.0)) {
    tmpvar_31 = texture2D (_lIris, xlv_TEXCOORD0.zw);
  } else {
    tmpvar_31 = texture2D (_rIris, xlv_TEXCOORD1);
  };
  irises_17 = tmpvar_31;
  tmpvar_10.xyz = mix (tmpvar_10.xyz, irises_17.xyz, vec3((irises_17.w * c_20.w)));
  tmpvar_3 = tmpvar_16;
  mediump vec4 tmpvar_32;
  lowp vec3 tmpvar_33;
  lowp vec4 tmpvar_34;
  tmpvar_34.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_35;
  lightDir_35 = lightDir_5;
  mediump vec3 viewDir_36;
  viewDir_36 = worldViewDir_4;
  lowp float nh_37;
  lowp vec4 specular_38;
  lowp vec3 color_39;
  lowp vec4 ldn_40;
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_11.w);
  tmpvar_33 = normalize(tmpvar_2);
  mediump vec4 tmpvar_41;
  tmpvar_41 = vec4(dot (tmpvar_33, lightDir_35));
  ldn_40 = tmpvar_41;
  ldn_40.w = ((ldn_40.x * 0.5) + 0.5);
  ldn_40.y = max (0.0, ldn_40.x);
  mediump float tmpvar_42;
  tmpvar_42 = mix (ldn_40.y, ldn_40.w, tmpvar_10.w);
  ldn_40.z = tmpvar_42;
  tmpvar_34.w = ((1.0 - clamp (tmpvar_14.w, 0.0, 1.0)) * tmpvar_10.w);
  lowp vec2 tmpvar_43;
  tmpvar_43.x = ldn_40.z;
  tmpvar_43.y = tmpvar_34.w;
  lowp vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = ((ldn_40.zzz * xlat_mutable_LightColor0.xyz) + ((tmpvar_15 * texture2D (_Ramp, tmpvar_43).www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_45;
  tmpvar_45 = (tmpvar_10.xyz * tmpvar_44.xyz);
  color_39 = tmpvar_45;
  lowp vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = xlat_mutable_LightColor0.xyz;
  mediump float tmpvar_47;
  tmpvar_47 = max (0.0, dot (tmpvar_33, normalize(
    (viewDir_36 + lightDir_35)
  )));
  nh_37 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (nh_37, (tmpvar_12 * 128.0));
  specular_38 = (tmpvar_46 * tmpvar_48);
  specular_38.xyz = (specular_38.xyz * vec3(_Specularity));
  color_39 = (color_39 + specular_38.xyz);
  lowp vec4 tmpvar_49;
  tmpvar_49.xyz = color_39;
  tmpvar_49.w = tmpvar_13;
  tmpvar_32 = tmpvar_49;
  c_1 = tmpvar_32;
  lowp vec4 color_50;
  color_50.w = c_1.w;
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (xlv_TEXCOORD5.xyz, c_1.xyz, xlv_TEXCOORD5.www);
  color_50.xyz = tmpvar_51;
  c_1.xyz = color_50.xyz;
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
Fallback "Holo/Character/Irises/Vertex Lit (No Cubemap Fallback)"
}