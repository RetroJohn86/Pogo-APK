//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Specular/Pixel Lit" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit, Specular, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Specularity ("Specularity", Range(0, 2)) = 0.1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.1
[KeywordEnum(None, Specularity)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
[Toggle(BRB_METAL)] _Metal ("Metal", Float) = 0
_Metalness ("    Metalness", Range(0, 1)) = 1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 300
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 300
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 63350
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
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_4 * tmpvar_23));
  worldNormal_9 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_25 * tmpvar_25)
   * tmpvar_26))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_27;
  tmpvar_27 = vsNormal_11.x;
  rim_7 = tmpvar_27;
  lowp vec3 tmpvar_28;
  if ((rim_7 < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_4 * tmpvar_31));
  worldNormal_2 = tmpvar_32;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_30;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_28 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_30);
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
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_4 * tmpvar_23));
  worldNormal_9 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_25 * tmpvar_25)
   * tmpvar_26))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_27;
  tmpvar_27 = vsNormal_11.x;
  rim_7 = tmpvar_27;
  lowp vec3 tmpvar_28;
  if ((rim_7 < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_4 * tmpvar_31));
  worldNormal_2 = tmpvar_32;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_30;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_28 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_30);
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
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_4 * tmpvar_23));
  worldNormal_9 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_26;
  tmpvar_26 = max (0.0, -(worldNormal_9.y));
  vlight_8 = (mix (tmpvar_12.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_25 * tmpvar_25)
   * tmpvar_26))) * tmpvar_6.x);
  tmpvar_5.xyz = vlight_8;
  lowp float tmpvar_27;
  tmpvar_27 = vsNormal_11.x;
  rim_7 = tmpvar_27;
  lowp vec3 tmpvar_28;
  if ((rim_7 < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_WorldToObject[0].xyz;
  tmpvar_31[1] = unity_WorldToObject[1].xyz;
  tmpvar_31[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_4 * tmpvar_31));
  worldNormal_2 = tmpvar_32;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_30;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = (tmpvar_28 * abs(rim_7));
  xlv_TEXCOORD6 = (_WorldSpaceCameraPos - tmpvar_30);
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Holo/Character/Pixel Lit"
CustomEditor "CustomMaterialInspector"
}