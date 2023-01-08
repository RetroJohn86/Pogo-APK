//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/OS Normal Mapped - Stencil Core" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 300
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 300
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  Stencil {
   Comp Always
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 59471
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_5 * tmpvar_33));
  worldNormal_2 = tmpvar_34;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_29;
  xlv_TEXCOORD4 = (tmpvar_31 * abs(rim_8));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 osNormal_10;
  mediump vec3 vlight_11;
  lowp vec4 leftRim_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_15;
  tmpvar_6 = c_13.w;
  leftRim_12 = xlv_TEXCOORD2;
  highp vec3 tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD3.xyz;
  vlight_11 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vlight_11;
  tmpvar_17.w = leftRim_12.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20.xyz = tmpvar_19;
  tmpvar_20.w = tmpvar_18.w;
  osNormal_10.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_19 - tmpvar_3.xyz));
  osNormal_10.xyz = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_22[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_22[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_22 * osNormal_10.xyz));
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_23;
  tmpvar_24.w = c_13.w;
  tmpvar_9 = tmpvar_24;
  mediump vec4 tmpvar_25;
  lowp vec3 tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = lightDir_2;
  lowp vec3 color_28;
  lowp vec4 ldn_29;
  tmpvar_26 = normalize(tmpvar_9.xyz);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_26, lightDir_27));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  ldn_29.y = max (0.0, ldn_29.x);
  mediump float tmpvar_31;
  tmpvar_31 = mix (ldn_29.y, ldn_29.w, tmpvar_5.w);
  ldn_29.z = tmpvar_31;
  lowp vec2 tmpvar_32;
  tmpvar_32.x = ldn_29.z;
  tmpvar_32.y = tmpvar_7.w;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_Ramp, tmpvar_32);
  lowp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_33.xyz * _LightColor0.xyz) + ((tmpvar_8 * tmpvar_33.www) + tmpvar_7.xyz));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_5.xyz * tmpvar_34.xyz);
  color_28 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = color_28;
  tmpvar_36.w = tmpvar_6;
  tmpvar_25 = tmpvar_36;
  c_1 = tmpvar_25;
  lowp vec4 color_37;
  color_37.w = c_1.w;
  mediump vec4 envFogColor_38;
  highp vec4 tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = unity_FogColor.xyz;
  tmpvar_39 = tmpvar_40;
  envFogColor_38 = tmpvar_39;
  envFogColor_38.w = (envFogColor_38.w * xlv_TEXCOORD3.w);
  mediump vec3 tmpvar_41;
  tmpvar_41 = mix (envFogColor_38.xyz, c_1.xyz, envFogColor_38.www);
  color_37.xyz = tmpvar_41;
  c_1.xyz = color_37.xyz;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_5 * tmpvar_33));
  worldNormal_2 = tmpvar_34;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_29;
  xlv_TEXCOORD4 = (tmpvar_31 * abs(rim_8));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 osNormal_10;
  mediump vec3 vlight_11;
  lowp vec4 leftRim_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_15;
  tmpvar_6 = c_13.w;
  leftRim_12 = xlv_TEXCOORD2;
  highp vec3 tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD3.xyz;
  vlight_11 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vlight_11;
  tmpvar_17.w = leftRim_12.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20.xyz = tmpvar_19;
  tmpvar_20.w = tmpvar_18.w;
  osNormal_10.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_19 - tmpvar_3.xyz));
  osNormal_10.xyz = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_22[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_22[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_22 * osNormal_10.xyz));
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_23;
  tmpvar_24.w = c_13.w;
  tmpvar_9 = tmpvar_24;
  mediump vec4 tmpvar_25;
  lowp vec3 tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = lightDir_2;
  lowp vec3 color_28;
  lowp vec4 ldn_29;
  tmpvar_26 = normalize(tmpvar_9.xyz);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_26, lightDir_27));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  ldn_29.y = max (0.0, ldn_29.x);
  mediump float tmpvar_31;
  tmpvar_31 = mix (ldn_29.y, ldn_29.w, tmpvar_5.w);
  ldn_29.z = tmpvar_31;
  lowp vec2 tmpvar_32;
  tmpvar_32.x = ldn_29.z;
  tmpvar_32.y = tmpvar_7.w;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_Ramp, tmpvar_32);
  lowp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_33.xyz * _LightColor0.xyz) + ((tmpvar_8 * tmpvar_33.www) + tmpvar_7.xyz));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_5.xyz * tmpvar_34.xyz);
  color_28 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = color_28;
  tmpvar_36.w = tmpvar_6;
  tmpvar_25 = tmpvar_36;
  c_1 = tmpvar_25;
  lowp vec4 color_37;
  color_37.w = c_1.w;
  mediump vec4 envFogColor_38;
  highp vec4 tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = unity_FogColor.xyz;
  tmpvar_39 = tmpvar_40;
  envFogColor_38 = tmpvar_39;
  envFogColor_38.w = (envFogColor_38.w * xlv_TEXCOORD3.w);
  mediump vec3 tmpvar_41;
  tmpvar_41 = mix (envFogColor_38.xyz, c_1.xyz, envFogColor_38.www);
  color_37.xyz = tmpvar_41;
  c_1.xyz = color_37.xyz;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_33;
  tmpvar_33[0] = unity_WorldToObject[0].xyz;
  tmpvar_33[1] = unity_WorldToObject[1].xyz;
  tmpvar_33[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((tmpvar_5 * tmpvar_33));
  worldNormal_2 = tmpvar_34;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_29;
  xlv_TEXCOORD4 = (tmpvar_31 * abs(rim_8));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 osNormal_10;
  mediump vec3 vlight_11;
  lowp vec4 leftRim_12;
  mediump vec4 c_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_13 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = c_13.xyz;
  tmpvar_15.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_15;
  tmpvar_6 = c_13.w;
  leftRim_12 = xlv_TEXCOORD2;
  highp vec3 tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD3.xyz;
  vlight_11 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = vlight_11;
  tmpvar_17.w = leftRim_12.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_8 = xlv_TEXCOORD4;
  lowp vec4 tmpvar_18;
  tmpvar_18 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18.xyz);
  lowp vec4 tmpvar_20;
  tmpvar_20.xyz = tmpvar_19;
  tmpvar_20.w = tmpvar_18.w;
  osNormal_10.w = tmpvar_20.w;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_19 - tmpvar_3.xyz));
  osNormal_10.xyz = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_22[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_22[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_22 * osNormal_10.xyz));
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = tmpvar_23;
  tmpvar_24.w = c_13.w;
  tmpvar_9 = tmpvar_24;
  mediump vec4 tmpvar_25;
  lowp vec3 tmpvar_26;
  mediump vec3 lightDir_27;
  lightDir_27 = lightDir_2;
  lowp vec3 color_28;
  lowp vec4 ldn_29;
  tmpvar_26 = normalize(tmpvar_9.xyz);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_26, lightDir_27));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  ldn_29.y = max (0.0, ldn_29.x);
  mediump float tmpvar_31;
  tmpvar_31 = mix (ldn_29.y, ldn_29.w, tmpvar_5.w);
  ldn_29.z = tmpvar_31;
  lowp vec2 tmpvar_32;
  tmpvar_32.x = ldn_29.z;
  tmpvar_32.y = tmpvar_7.w;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_Ramp, tmpvar_32);
  lowp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((tmpvar_33.xyz * _LightColor0.xyz) + ((tmpvar_8 * tmpvar_33.www) + tmpvar_7.xyz));
  mediump vec3 tmpvar_35;
  tmpvar_35 = (tmpvar_5.xyz * tmpvar_34.xyz);
  color_28 = tmpvar_35;
  lowp vec4 tmpvar_36;
  tmpvar_36.xyz = color_28;
  tmpvar_36.w = tmpvar_6;
  tmpvar_25 = tmpvar_36;
  c_1 = tmpvar_25;
  lowp vec4 color_37;
  color_37.w = c_1.w;
  mediump vec4 envFogColor_38;
  highp vec4 tmpvar_39;
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = unity_FogColor.xyz;
  tmpvar_39 = tmpvar_40;
  envFogColor_38 = tmpvar_39;
  envFogColor_38.w = (envFogColor_38.w * xlv_TEXCOORD3.w);
  mediump vec3 tmpvar_41;
  tmpvar_41 = mix (envFogColor_38.xyz, c_1.xyz, envFogColor_38.www);
  color_37.xyz = tmpvar_41;
  c_1.xyz = color_37.xyz;
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
Fallback "Holo/Character/Pixel Lit - Stencil Core"
CustomEditor "CustomMaterialInspector"
}