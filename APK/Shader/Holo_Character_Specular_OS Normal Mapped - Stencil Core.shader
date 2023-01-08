//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Specular/OS Normal Mapped - Stencil Core" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit, Specular, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Specularity ("Specularity", Range(0, 2)) = 0.1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.1
[KeywordEnum(None, Specularity)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
[Toggle(BRB_METAL)] _Metal ("Metal", Float) = 0
_Metalness ("    Metalness", Range(0, 1)) = 1
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 400
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  Stencil {
   Comp Always
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 58429
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
  tmpvar_7.xz = tmpvar_12.xz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec3 tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec4 osNormal_13;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_18;
  tmpvar_9 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD4.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_10 = tmpvar_20;
  tmpvar_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_21.xyz);
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = tmpvar_21.w;
  osNormal_13.w = tmpvar_23.w;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_22 - tmpvar_4.xyz));
  osNormal_13.xyz = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * osNormal_13.xyz));
  mediump vec4 tmpvar_27;
  tmpvar_27.xyz = tmpvar_26;
  tmpvar_27.w = c_16.w;
  tmpvar_12 = tmpvar_27;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_28;
  lowp vec3 tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_31;
  lightDir_31 = lightDir_3;
  mediump vec3 viewDir_32;
  viewDir_32 = worldViewDir_2;
  lowp float nh_33;
  lowp vec4 specular_34;
  lowp vec3 color_35;
  lowp vec4 ldn_36;
  tmpvar_29 = normalize(tmpvar_12.xyz);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_29, lightDir_31));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  ldn_36.y = max (0.0, ldn_36.x);
  mediump float tmpvar_38;
  tmpvar_38 = mix (ldn_36.y, ldn_36.w, tmpvar_7.w);
  ldn_36.z = tmpvar_38;
  tmpvar_30.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_39;
  tmpvar_39.x = ldn_36.z;
  tmpvar_39.y = tmpvar_30.w;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_Ramp, tmpvar_39);
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((tmpvar_40.xyz * _LightColor0.xyz) + ((tmpvar_11 * tmpvar_40.www) + tmpvar_10.xyz));
  mediump vec3 tmpvar_42;
  tmpvar_42 = (tmpvar_7.xyz * tmpvar_41.xyz);
  color_35 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = _LightColor0.xyz;
  mediump float tmpvar_44;
  tmpvar_44 = max (0.0, dot (tmpvar_29, normalize(
    (viewDir_32 + lightDir_31)
  )));
  nh_33 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = pow (nh_33, (tmpvar_8 * 128.0));
  specular_34 = (tmpvar_43 * tmpvar_45);
  specular_34.xyz = (specular_34.xyz * vec3(_Specularity));
  color_35 = (color_35 + specular_34.xyz);
  lowp vec4 tmpvar_46;
  tmpvar_46.xyz = color_35;
  tmpvar_46.w = tmpvar_9;
  tmpvar_28 = tmpvar_46;
  c_1 = tmpvar_28;
  lowp vec4 color_47;
  color_47.w = c_1.w;
  mediump vec4 envFogColor_48;
  highp vec4 tmpvar_49;
  lowp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = unity_FogColor.xyz;
  tmpvar_49 = tmpvar_50;
  envFogColor_48 = tmpvar_49;
  envFogColor_48.w = (envFogColor_48.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_51;
  tmpvar_51 = mix (envFogColor_48.xyz, c_1.xyz, envFogColor_48.www);
  color_47.xyz = tmpvar_51;
  c_1.xyz = color_47.xyz;
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
  tmpvar_7.xz = tmpvar_12.xz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec3 tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec4 osNormal_13;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_18;
  tmpvar_9 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD4.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_10 = tmpvar_20;
  tmpvar_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_21.xyz);
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = tmpvar_21.w;
  osNormal_13.w = tmpvar_23.w;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_22 - tmpvar_4.xyz));
  osNormal_13.xyz = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * osNormal_13.xyz));
  mediump vec4 tmpvar_27;
  tmpvar_27.xyz = tmpvar_26;
  tmpvar_27.w = c_16.w;
  tmpvar_12 = tmpvar_27;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_28;
  lowp vec3 tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_31;
  lightDir_31 = lightDir_3;
  mediump vec3 viewDir_32;
  viewDir_32 = worldViewDir_2;
  lowp float nh_33;
  lowp vec4 specular_34;
  lowp vec3 color_35;
  lowp vec4 ldn_36;
  tmpvar_29 = normalize(tmpvar_12.xyz);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_29, lightDir_31));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  ldn_36.y = max (0.0, ldn_36.x);
  mediump float tmpvar_38;
  tmpvar_38 = mix (ldn_36.y, ldn_36.w, tmpvar_7.w);
  ldn_36.z = tmpvar_38;
  tmpvar_30.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_39;
  tmpvar_39.x = ldn_36.z;
  tmpvar_39.y = tmpvar_30.w;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_Ramp, tmpvar_39);
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((tmpvar_40.xyz * _LightColor0.xyz) + ((tmpvar_11 * tmpvar_40.www) + tmpvar_10.xyz));
  mediump vec3 tmpvar_42;
  tmpvar_42 = (tmpvar_7.xyz * tmpvar_41.xyz);
  color_35 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = _LightColor0.xyz;
  mediump float tmpvar_44;
  tmpvar_44 = max (0.0, dot (tmpvar_29, normalize(
    (viewDir_32 + lightDir_31)
  )));
  nh_33 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = pow (nh_33, (tmpvar_8 * 128.0));
  specular_34 = (tmpvar_43 * tmpvar_45);
  specular_34.xyz = (specular_34.xyz * vec3(_Specularity));
  color_35 = (color_35 + specular_34.xyz);
  lowp vec4 tmpvar_46;
  tmpvar_46.xyz = color_35;
  tmpvar_46.w = tmpvar_9;
  tmpvar_28 = tmpvar_46;
  c_1 = tmpvar_28;
  lowp vec4 color_47;
  color_47.w = c_1.w;
  mediump vec4 envFogColor_48;
  highp vec4 tmpvar_49;
  lowp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = unity_FogColor.xyz;
  tmpvar_49 = tmpvar_50;
  envFogColor_48 = tmpvar_49;
  envFogColor_48.w = (envFogColor_48.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_51;
  tmpvar_51 = mix (envFogColor_48.xyz, c_1.xyz, envFogColor_48.www);
  color_47.xyz = tmpvar_51;
  c_1.xyz = color_47.xyz;
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
  tmpvar_7.xz = tmpvar_12.xz;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD6);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec3 tmpvar_11;
  lowp vec4 tmpvar_12;
  lowp vec4 osNormal_13;
  mediump vec3 vlight_14;
  lowp vec4 leftRim_15;
  mediump vec4 c_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = c_16.xyz;
  tmpvar_18.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_18;
  tmpvar_9 = c_16.w;
  leftRim_15 = xlv_TEXCOORD3;
  highp vec3 tmpvar_19;
  tmpvar_19 = xlv_TEXCOORD4.xyz;
  vlight_14 = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20.xyz = vlight_14;
  tmpvar_20.w = leftRim_15.y;
  tmpvar_10 = tmpvar_20;
  tmpvar_11 = xlv_TEXCOORD5;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_21.xyz);
  lowp vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22;
  tmpvar_23.w = tmpvar_21.w;
  osNormal_13.w = tmpvar_23.w;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((tmpvar_22 - tmpvar_4.xyz));
  osNormal_13.xyz = tmpvar_24;
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_25[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_25[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * osNormal_13.xyz));
  mediump vec4 tmpvar_27;
  tmpvar_27.xyz = tmpvar_26;
  tmpvar_27.w = c_16.w;
  tmpvar_12 = tmpvar_27;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_28;
  lowp vec3 tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_31;
  lightDir_31 = lightDir_3;
  mediump vec3 viewDir_32;
  viewDir_32 = worldViewDir_2;
  lowp float nh_33;
  lowp vec4 specular_34;
  lowp vec3 color_35;
  lowp vec4 ldn_36;
  tmpvar_29 = normalize(tmpvar_12.xyz);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_29, lightDir_31));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  ldn_36.y = max (0.0, ldn_36.x);
  mediump float tmpvar_38;
  tmpvar_38 = mix (ldn_36.y, ldn_36.w, tmpvar_7.w);
  ldn_36.z = tmpvar_38;
  tmpvar_30.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_39;
  tmpvar_39.x = ldn_36.z;
  tmpvar_39.y = tmpvar_30.w;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_Ramp, tmpvar_39);
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((tmpvar_40.xyz * _LightColor0.xyz) + ((tmpvar_11 * tmpvar_40.www) + tmpvar_10.xyz));
  mediump vec3 tmpvar_42;
  tmpvar_42 = (tmpvar_7.xyz * tmpvar_41.xyz);
  color_35 = tmpvar_42;
  lowp vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = _LightColor0.xyz;
  mediump float tmpvar_44;
  tmpvar_44 = max (0.0, dot (tmpvar_29, normalize(
    (viewDir_32 + lightDir_31)
  )));
  nh_33 = tmpvar_44;
  mediump float tmpvar_45;
  tmpvar_45 = pow (nh_33, (tmpvar_8 * 128.0));
  specular_34 = (tmpvar_43 * tmpvar_45);
  specular_34.xyz = (specular_34.xyz * vec3(_Specularity));
  color_35 = (color_35 + specular_34.xyz);
  lowp vec4 tmpvar_46;
  tmpvar_46.xyz = color_35;
  tmpvar_46.w = tmpvar_9;
  tmpvar_28 = tmpvar_46;
  c_1 = tmpvar_28;
  lowp vec4 color_47;
  color_47.w = c_1.w;
  mediump vec4 envFogColor_48;
  highp vec4 tmpvar_49;
  lowp vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = unity_FogColor.xyz;
  tmpvar_49 = tmpvar_50;
  envFogColor_48 = tmpvar_49;
  envFogColor_48.w = (envFogColor_48.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_51;
  tmpvar_51 = mix (envFogColor_48.xyz, c_1.xyz, envFogColor_48.www);
  color_47.xyz = tmpvar_51;
  c_1.xyz = color_47.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
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
Fallback "Holo/Character/OS Normal Mapped - Stencil Core"
CustomEditor "CustomMaterialInspector"
}