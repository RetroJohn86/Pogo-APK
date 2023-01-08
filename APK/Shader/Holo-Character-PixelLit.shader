//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Pixel Lit" {
Properties {
[KeywordEnum(Opaque, Cutout)]  _Render ("Rendering Mode", Float) = 0.000000
 _MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _AlphaTestRef ("    Alpha Cutoff", Range(0.000000,1.000000)) = 0.500000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 3469
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
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
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
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
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
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
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
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
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * tmpvar_4.x)
   + 
    (v_33.xyz * tmpvar_4.y)
  ) + (v_34.xyz * tmpvar_4.z)));
  worldNormal_2 = tmpvar_35;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = envFogColor_10;
  xlv_TEXCOORD4 = (tmpvar_30 * abs(rim_7));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
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
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 106529
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (unity_AmbientEquator * _Ambient);
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(((_glesColor.w * (1.0 - tmpvar_8.w)) + tmpvar_8.w));
  tmpvar_4.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = ((1.0 - max (0.0, tmpvar_11)) * _glesColor.w);
  tmpvar_4.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_3));
  vsNormal_7 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  envFogColor_6 = (tmpvar_16 * tmpvar_17);
  lowp float tmpvar_19;
  tmpvar_19 = vsNormal_7.x;
  rim_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  if ((rim_5 < 0.0)) {
    tmpvar_20 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_20 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_20 * abs(rim_5));
  highp vec3 vertex_21;
  vertex_21 = tmpvar_1.xyz;
  highp vec4 clipPos_22;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = vertex_21;
    highp vec3 tmpvar_24;
    tmpvar_24 = (unity_ObjectToWorld * tmpvar_23).xyz;
    highp vec4 v_25;
    v_25.x = unity_WorldToObject[0].x;
    v_25.y = unity_WorldToObject[1].x;
    v_25.z = unity_WorldToObject[2].x;
    v_25.w = unity_WorldToObject[3].x;
    highp vec4 v_26;
    v_26.x = unity_WorldToObject[0].y;
    v_26.y = unity_WorldToObject[1].y;
    v_26.z = unity_WorldToObject[2].y;
    v_26.w = unity_WorldToObject[3].y;
    highp vec4 v_27;
    v_27.x = unity_WorldToObject[0].z;
    v_27.y = unity_WorldToObject[1].z;
    v_27.z = unity_WorldToObject[2].z;
    v_27.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_28;
    tmpvar_28 = normalize(((
      (v_25.xyz * tmpvar_3.x)
     + 
      (v_26.xyz * tmpvar_3.y)
    ) + (v_27.xyz * tmpvar_3.z)));
    highp float tmpvar_29;
    tmpvar_29 = dot (tmpvar_28, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_24 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (tmpvar_24 - (tmpvar_28 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_29 * tmpvar_29)))
    )));
    clipPos_22 = (unity_MatrixVP * tmpvar_30);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = vertex_21;
    clipPos_22 = (glstate_matrix_mvp * tmpvar_31);
  };
  highp vec4 clipPos_32;
  clipPos_32.xyw = clipPos_22.xyw;
  clipPos_32.z = (clipPos_22.z + clamp ((unity_LightShadowBias.x / clipPos_22.w), 0.0, 1.0));
  clipPos_32.z = mix (clipPos_32.z, max (clipPos_32.z, -(clipPos_22.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_32;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (unity_AmbientEquator * _Ambient);
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(((_glesColor.w * (1.0 - tmpvar_8.w)) + tmpvar_8.w));
  tmpvar_4.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = ((1.0 - max (0.0, tmpvar_11)) * _glesColor.w);
  tmpvar_4.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_3));
  vsNormal_7 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  envFogColor_6 = (tmpvar_16 * tmpvar_17);
  lowp float tmpvar_19;
  tmpvar_19 = vsNormal_7.x;
  rim_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  if ((rim_5 < 0.0)) {
    tmpvar_20 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_20 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_20 * abs(rim_5));
  highp vec3 vertex_21;
  vertex_21 = tmpvar_1.xyz;
  highp vec4 clipPos_22;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = vertex_21;
    highp vec3 tmpvar_24;
    tmpvar_24 = (unity_ObjectToWorld * tmpvar_23).xyz;
    highp vec4 v_25;
    v_25.x = unity_WorldToObject[0].x;
    v_25.y = unity_WorldToObject[1].x;
    v_25.z = unity_WorldToObject[2].x;
    v_25.w = unity_WorldToObject[3].x;
    highp vec4 v_26;
    v_26.x = unity_WorldToObject[0].y;
    v_26.y = unity_WorldToObject[1].y;
    v_26.z = unity_WorldToObject[2].y;
    v_26.w = unity_WorldToObject[3].y;
    highp vec4 v_27;
    v_27.x = unity_WorldToObject[0].z;
    v_27.y = unity_WorldToObject[1].z;
    v_27.z = unity_WorldToObject[2].z;
    v_27.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_28;
    tmpvar_28 = normalize(((
      (v_25.xyz * tmpvar_3.x)
     + 
      (v_26.xyz * tmpvar_3.y)
    ) + (v_27.xyz * tmpvar_3.z)));
    highp float tmpvar_29;
    tmpvar_29 = dot (tmpvar_28, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_24 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (tmpvar_24 - (tmpvar_28 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_29 * tmpvar_29)))
    )));
    clipPos_22 = (unity_MatrixVP * tmpvar_30);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = vertex_21;
    clipPos_22 = (glstate_matrix_mvp * tmpvar_31);
  };
  highp vec4 clipPos_32;
  clipPos_32.xyw = clipPos_22.xyw;
  clipPos_32.z = (clipPos_22.z + clamp ((unity_LightShadowBias.x / clipPos_22.w), 0.0, 1.0));
  clipPos_32.z = mix (clipPos_32.z, max (clipPos_32.z, -(clipPos_22.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_32;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (unity_AmbientEquator * _Ambient);
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = vec4(((_glesColor.w * (1.0 - tmpvar_8.w)) + tmpvar_8.w));
  tmpvar_4.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = ((1.0 - max (0.0, tmpvar_11)) * _glesColor.w);
  tmpvar_4.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_3));
  vsNormal_7 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  envFogColor_6 = (tmpvar_16 * tmpvar_17);
  lowp float tmpvar_19;
  tmpvar_19 = vsNormal_7.x;
  rim_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  if ((rim_5 < 0.0)) {
    tmpvar_20 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_20 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_20 * abs(rim_5));
  highp vec3 vertex_21;
  vertex_21 = tmpvar_1.xyz;
  highp vec4 clipPos_22;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = vertex_21;
    highp vec3 tmpvar_24;
    tmpvar_24 = (unity_ObjectToWorld * tmpvar_23).xyz;
    highp vec4 v_25;
    v_25.x = unity_WorldToObject[0].x;
    v_25.y = unity_WorldToObject[1].x;
    v_25.z = unity_WorldToObject[2].x;
    v_25.w = unity_WorldToObject[3].x;
    highp vec4 v_26;
    v_26.x = unity_WorldToObject[0].y;
    v_26.y = unity_WorldToObject[1].y;
    v_26.z = unity_WorldToObject[2].y;
    v_26.w = unity_WorldToObject[3].y;
    highp vec4 v_27;
    v_27.x = unity_WorldToObject[0].z;
    v_27.y = unity_WorldToObject[1].z;
    v_27.z = unity_WorldToObject[2].z;
    v_27.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_28;
    tmpvar_28 = normalize(((
      (v_25.xyz * tmpvar_3.x)
     + 
      (v_26.xyz * tmpvar_3.y)
    ) + (v_27.xyz * tmpvar_3.z)));
    highp float tmpvar_29;
    tmpvar_29 = dot (tmpvar_28, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_24 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_30;
    tmpvar_30.w = 1.0;
    tmpvar_30.xyz = (tmpvar_24 - (tmpvar_28 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_29 * tmpvar_29)))
    )));
    clipPos_22 = (unity_MatrixVP * tmpvar_30);
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.w = 1.0;
    tmpvar_31.xyz = vertex_21;
    clipPos_22 = (glstate_matrix_mvp * tmpvar_31);
  };
  highp vec4 clipPos_32;
  clipPos_32.xyw = clipPos_22.xyw;
  clipPos_32.z = (clipPos_22.z + clamp ((unity_LightShadowBias.x / clipPos_22.w), 0.0, 1.0));
  clipPos_32.z = mix (clipPos_32.z, max (clipPos_32.z, -(clipPos_22.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_32;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (unity_AmbientEquator * _Ambient);
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - tmpvar_7.w)) + tmpvar_7.w));
  tmpvar_3.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_3.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_2));
  vsNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  highp vec4 tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = unity_FogColor.xyz;
  tmpvar_16 = tmpvar_17;
  envFogColor_5 = (tmpvar_15 * tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = vsNormal_6.x;
  rim_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  if ((rim_4 < 0.0)) {
    tmpvar_19 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_19 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_19 * abs(rim_4));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (unity_AmbientEquator * _Ambient);
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - tmpvar_7.w)) + tmpvar_7.w));
  tmpvar_3.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_3.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_2));
  vsNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  highp vec4 tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = unity_FogColor.xyz;
  tmpvar_16 = tmpvar_17;
  envFogColor_5 = (tmpvar_15 * tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = vsNormal_6.x;
  rim_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  if ((rim_4 < 0.0)) {
    tmpvar_19 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_19 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_19 * abs(rim_4));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _Ambient;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (unity_AmbientEquator * _Ambient);
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - tmpvar_7.w)) + tmpvar_7.w));
  tmpvar_3.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_3.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_2));
  vsNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  highp vec4 tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = unity_FogColor.xyz;
  tmpvar_16 = tmpvar_17;
  envFogColor_5 = (tmpvar_15 * tmpvar_16);
  lowp float tmpvar_18;
  tmpvar_18 = vsNormal_6.x;
  rim_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  if ((rim_4 < 0.0)) {
    tmpvar_19 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_19 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_19 * abs(rim_4));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback "Holo/Character/Vertex Lit"
}