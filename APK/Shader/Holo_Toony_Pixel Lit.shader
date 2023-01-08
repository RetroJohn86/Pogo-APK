//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Toony/Pixel Lit" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Toggle(BRB_SHADOW)] _Shadow ("Treat as environment?", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore environment FX Color", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 43137
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_WorldToObject[0].xyz;
  tmpvar_17[1] = unity_WorldToObject[1].xyz;
  tmpvar_17[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_glesNormal * tmpvar_17));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_glesNormal * tmpvar_18));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_glesNormal * tmpvar_18));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_6 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((_glesNormal * tmpvar_18));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
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
varying highp vec4 xlv_TEXCOORD3;
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
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 90677
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize((_glesNormal * tmpvar_12));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_11 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_9.xyw;
  clipPos_17.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
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
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize((_glesNormal * tmpvar_12));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_11 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_9.xyw;
  clipPos_17.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize((_glesNormal * tmpvar_12));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_11 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_9.xyw;
  clipPos_17.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
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
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
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
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
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
}
}
}
Fallback "Holo/Toony/Vertex Lit"
CustomEditor "CustomMaterialInspector"
}