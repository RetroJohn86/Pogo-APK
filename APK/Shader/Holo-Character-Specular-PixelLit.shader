//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Specular/Pixel Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit, Specular, DesaturatedRamp, LinearRamp)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
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
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 38238
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
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
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_15;
  lowp vec4 leftRim_16;
  mediump vec4 c_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_17 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = c_17.xyz;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_19;
  tmpvar_11 = c_17.w;
  leftRim_16 = xlv_TEXCOORD3;
  highp vec3 tmpvar_20;
  tmpvar_20 = tmpvar_6.xyz;
  vlight_15 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vlight_15;
  tmpvar_21.w = leftRim_16.y;
  tmpvar_12 = tmpvar_21;
  tmpvar_13 = xlv_TEXCOORD5;
  tmpvar_14.w = c_17.w;
  tmpvar_10 = _Glossiness;
  tmpvar_3 = tmpvar_14;
  mediump vec4 tmpvar_22;
  lowp vec3 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_12.xyz;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_5;
  mediump vec3 viewDir_26;
  viewDir_26 = worldViewDir_4;
  lowp float nh_27;
  lowp vec4 specular_28;
  lowp vec3 color_29;
  lowp vec4 ldn_30;
  tmpvar_23 = normalize(tmpvar_2);
  mediump vec4 tmpvar_31;
  tmpvar_31 = vec4(dot (tmpvar_23, lightDir_25));
  ldn_30 = tmpvar_31;
  ldn_30.w = ((ldn_30.x * 0.5) + 0.5);
  ldn_30.y = max (0.0, ldn_30.x);
  mediump float tmpvar_32;
  tmpvar_32 = mix (ldn_30.y, ldn_30.w, tmpvar_9.w);
  ldn_30.z = tmpvar_32;
  tmpvar_24.w = ((1.0 - clamp (tmpvar_12.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_33;
  tmpvar_33.x = ldn_30.z;
  tmpvar_33.y = tmpvar_24.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_Ramp, tmpvar_33);
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((tmpvar_34.xyz * _LightColor0.xyz) + ((tmpvar_13 * tmpvar_34.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_9.xyz * tmpvar_35.xyz);
  color_29 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = _LightColor0.xyz;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, dot (tmpvar_23, normalize(
    (viewDir_26 + lightDir_25)
  )));
  nh_27 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = pow (nh_27, (tmpvar_10 * 128.0));
  specular_28 = (tmpvar_37 * tmpvar_39);
  specular_28.xyz = (specular_28.xyz * vec3(_Specularity));
  color_29 = (color_29 + specular_28.xyz);
  lowp vec4 tmpvar_40;
  tmpvar_40.xyz = color_29;
  tmpvar_40.w = tmpvar_11;
  tmpvar_22 = tmpvar_40;
  c_1 = tmpvar_22;
  lowp vec4 color_41;
  color_41.w = c_1.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_41.xyz = tmpvar_42;
  c_1.xyz = color_41.xyz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
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
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_15;
  lowp vec4 leftRim_16;
  mediump vec4 c_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_17 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = c_17.xyz;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_19;
  tmpvar_11 = c_17.w;
  leftRim_16 = xlv_TEXCOORD3;
  highp vec3 tmpvar_20;
  tmpvar_20 = tmpvar_6.xyz;
  vlight_15 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vlight_15;
  tmpvar_21.w = leftRim_16.y;
  tmpvar_12 = tmpvar_21;
  tmpvar_13 = xlv_TEXCOORD5;
  tmpvar_14.w = c_17.w;
  tmpvar_10 = _Glossiness;
  tmpvar_3 = tmpvar_14;
  mediump vec4 tmpvar_22;
  lowp vec3 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_12.xyz;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_5;
  mediump vec3 viewDir_26;
  viewDir_26 = worldViewDir_4;
  lowp float nh_27;
  lowp vec4 specular_28;
  lowp vec3 color_29;
  lowp vec4 ldn_30;
  tmpvar_23 = normalize(tmpvar_2);
  mediump vec4 tmpvar_31;
  tmpvar_31 = vec4(dot (tmpvar_23, lightDir_25));
  ldn_30 = tmpvar_31;
  ldn_30.w = ((ldn_30.x * 0.5) + 0.5);
  ldn_30.y = max (0.0, ldn_30.x);
  mediump float tmpvar_32;
  tmpvar_32 = mix (ldn_30.y, ldn_30.w, tmpvar_9.w);
  ldn_30.z = tmpvar_32;
  tmpvar_24.w = ((1.0 - clamp (tmpvar_12.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_33;
  tmpvar_33.x = ldn_30.z;
  tmpvar_33.y = tmpvar_24.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_Ramp, tmpvar_33);
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((tmpvar_34.xyz * _LightColor0.xyz) + ((tmpvar_13 * tmpvar_34.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_9.xyz * tmpvar_35.xyz);
  color_29 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = _LightColor0.xyz;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, dot (tmpvar_23, normalize(
    (viewDir_26 + lightDir_25)
  )));
  nh_27 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = pow (nh_27, (tmpvar_10 * 128.0));
  specular_28 = (tmpvar_37 * tmpvar_39);
  specular_28.xyz = (specular_28.xyz * vec3(_Specularity));
  color_29 = (color_29 + specular_28.xyz);
  lowp vec4 tmpvar_40;
  tmpvar_40.xyz = color_29;
  tmpvar_40.w = tmpvar_11;
  tmpvar_22 = tmpvar_40;
  c_1 = tmpvar_22;
  lowp vec4 color_41;
  color_41.w = c_1.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_41.xyz = tmpvar_42;
  c_1.xyz = color_41.xyz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
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
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec3 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_15;
  lowp vec4 leftRim_16;
  mediump vec4 c_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_17 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = c_17.xyz;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_9 = tmpvar_19;
  tmpvar_11 = c_17.w;
  leftRim_16 = xlv_TEXCOORD3;
  highp vec3 tmpvar_20;
  tmpvar_20 = tmpvar_6.xyz;
  vlight_15 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vlight_15;
  tmpvar_21.w = leftRim_16.y;
  tmpvar_12 = tmpvar_21;
  tmpvar_13 = xlv_TEXCOORD5;
  tmpvar_14.w = c_17.w;
  tmpvar_10 = _Glossiness;
  tmpvar_3 = tmpvar_14;
  mediump vec4 tmpvar_22;
  lowp vec3 tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_12.xyz;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_5;
  mediump vec3 viewDir_26;
  viewDir_26 = worldViewDir_4;
  lowp float nh_27;
  lowp vec4 specular_28;
  lowp vec3 color_29;
  lowp vec4 ldn_30;
  tmpvar_23 = normalize(tmpvar_2);
  mediump vec4 tmpvar_31;
  tmpvar_31 = vec4(dot (tmpvar_23, lightDir_25));
  ldn_30 = tmpvar_31;
  ldn_30.w = ((ldn_30.x * 0.5) + 0.5);
  ldn_30.y = max (0.0, ldn_30.x);
  mediump float tmpvar_32;
  tmpvar_32 = mix (ldn_30.y, ldn_30.w, tmpvar_9.w);
  ldn_30.z = tmpvar_32;
  tmpvar_24.w = ((1.0 - clamp (tmpvar_12.w, 0.0, 1.0)) * tmpvar_9.w);
  lowp vec2 tmpvar_33;
  tmpvar_33.x = ldn_30.z;
  tmpvar_33.y = tmpvar_24.w;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_Ramp, tmpvar_33);
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((tmpvar_34.xyz * _LightColor0.xyz) + ((tmpvar_13 * tmpvar_34.www) + tmpvar_12.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_9.xyz * tmpvar_35.xyz);
  color_29 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = _LightColor0.xyz;
  mediump float tmpvar_38;
  tmpvar_38 = max (0.0, dot (tmpvar_23, normalize(
    (viewDir_26 + lightDir_25)
  )));
  nh_27 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = pow (nh_27, (tmpvar_10 * 128.0));
  specular_28 = (tmpvar_37 * tmpvar_39);
  specular_28.xyz = (specular_28.xyz * vec3(_Specularity));
  color_29 = (color_29 + specular_28.xyz);
  lowp vec4 tmpvar_40;
  tmpvar_40.xyz = color_29;
  tmpvar_40.w = tmpvar_11;
  tmpvar_22 = tmpvar_40;
  c_1 = tmpvar_22;
  lowp vec4 color_41;
  color_41.w = c_1.w;
  highp vec3 tmpvar_42;
  tmpvar_42 = mix (xlv_TEXCOORD4.xyz, c_1.xyz, xlv_TEXCOORD4.www);
  color_41.xyz = tmpvar_42;
  c_1.xyz = color_41.xyz;
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