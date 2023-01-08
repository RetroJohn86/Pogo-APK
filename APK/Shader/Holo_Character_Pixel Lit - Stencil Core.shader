//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Pixel Lit - Stencil Core" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  Stencil {
   Comp Always
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 29292
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_4 * tmpvar_30));
  worldNormal_2 = tmpvar_31;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_28 * abs(rim_7));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ldn_23;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_23 = tmpvar_24;
  ldn_23.w = ((ldn_23.x * 0.5) + 0.5);
  ldn_23.y = max (0.0, ldn_23.x);
  mediump float tmpvar_25;
  tmpvar_25 = mix (ldn_23.y, ldn_23.w, tmpvar_7.w);
  ldn_23.z = tmpvar_25;
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_23.z;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_27.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_27.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyz * tmpvar_28.xyz);
  color_22 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = color_22;
  tmpvar_30.w = tmpvar_8;
  tmpvar_19 = tmpvar_30;
  c_1 = tmpvar_19;
  lowp vec4 color_31;
  color_31.w = c_1.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_31.xyz = tmpvar_32;
  c_1.xyz = color_31.xyz;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_4 * tmpvar_30));
  worldNormal_2 = tmpvar_31;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_28 * abs(rim_7));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ldn_23;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_23 = tmpvar_24;
  ldn_23.w = ((ldn_23.x * 0.5) + 0.5);
  ldn_23.y = max (0.0, ldn_23.x);
  mediump float tmpvar_25;
  tmpvar_25 = mix (ldn_23.y, ldn_23.w, tmpvar_7.w);
  ldn_23.z = tmpvar_25;
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_23.z;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_27.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_27.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyz * tmpvar_28.xyz);
  color_22 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = color_22;
  tmpvar_30.w = tmpvar_8;
  tmpvar_19 = tmpvar_30;
  c_1 = tmpvar_19;
  lowp vec4 color_31;
  color_31.w = c_1.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_31.xyz = tmpvar_32;
  c_1.xyz = color_31.xyz;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  highp mat3 tmpvar_30;
  tmpvar_30[0] = unity_WorldToObject[0].xyz;
  tmpvar_30[1] = unity_WorldToObject[1].xyz;
  tmpvar_30[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_4 * tmpvar_30));
  worldNormal_2 = tmpvar_31;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_28 * abs(rim_7));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ldn_23;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_23 = tmpvar_24;
  ldn_23.w = ((ldn_23.x * 0.5) + 0.5);
  ldn_23.y = max (0.0, ldn_23.x);
  mediump float tmpvar_25;
  tmpvar_25 = mix (ldn_23.y, ldn_23.w, tmpvar_7.w);
  ldn_23.z = tmpvar_25;
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_23.z;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  lowp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = ((tmpvar_27.xyz * _LightColor0.xyz) + ((tmpvar_10 * tmpvar_27.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_7.xyz * tmpvar_28.xyz);
  color_22 = tmpvar_29;
  lowp vec4 tmpvar_30;
  tmpvar_30.xyz = color_22;
  tmpvar_30.w = tmpvar_8;
  tmpvar_19 = tmpvar_30;
  c_1 = tmpvar_19;
  lowp vec4 color_31;
  color_31.w = c_1.w;
  highp vec3 tmpvar_32;
  tmpvar_32 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_31.xyz = tmpvar_32;
  c_1.xyz = color_31.xyz;
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Holo/Character/Vertex Lit - Stencil Core"
CustomEditor "CustomMaterialInspector"
}