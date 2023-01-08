//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Shadow Matte/Blend" {
Properties {
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Blend DstColor Zero, DstColor Zero
  ZClip Off
  GpuProgramID 61396
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  highp vec4 tmpvar_4;
  mediump float tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = (unity_FogParams.x * tmpvar_6.z);
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(tmpvar_5) * tmpvar_5));
  tmpvar_5 = tmpvar_7;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = tmpvar_7;
  tmpvar_4 = (tmpvar_3 * tmpvar_8);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = vec3(0.0, 0.0, 0.0);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_AmbientEquator;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  c_1.w = 0.0;
  c_1.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec4 tmpvar_3;
  discard;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = tmpvar_2;
  tmpvar_3 = tmpvar_4;
  c_1 = tmpvar_3;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = _glesColor.xyz;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_6 = (unity_FogParams.x * tmpvar_7.z);
  mediump float tmpvar_8;
  tmpvar_8 = exp2((-(tmpvar_6) * tmpvar_6));
  tmpvar_6 = tmpvar_8;
  tmpvar_4.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = tmpvar_8;
  tmpvar_5 = (tmpvar_4 * tmpvar_9);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (lengthSq_22, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_22 = tmpvar_26;
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_27;
  tmpvar_27 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(tmpvar_26)));
  ndotl_21 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28 = (tmpvar_27 * (1.0/((1.0 + 
    (tmpvar_26 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_28.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_28.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_28.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_28.w));
  tmpvar_3 = col_20;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_8;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_AmbientEquator;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD1.w;
  lowp float tmpvar_3;
  highp float lightShadowDataX_4;
  mediump float tmpvar_5;
  tmpvar_5 = _LightShadowData.x;
  lightShadowDataX_4 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_4);
  tmpvar_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump float atten_8;
  atten_8 = tmpvar_3;
  lowp float mask_9;
  mediump float tmpvar_10;
  tmpvar_10 = (1.0 - atten_8);
  mask_9 = tmpvar_10;
  lowp float x_11;
  x_11 = (mask_9 - 1.0);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = (1.0 - (mask_9 * vec3(tmpvar_2)));
  tmpvar_12.w = tmpvar_2;
  tmpvar_7 = tmpvar_12;
  c_1 = tmpvar_7;
  c_1.xyz = (c_1.xyz + unity_AmbientEquator.xyz);
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
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
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  Blend DstColor Zero, DstColor Zero
  ZClip Off
  GpuProgramID 104020
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec3 vertex_7;
  vertex_7 = _glesVertex.xyz;
  highp vec4 clipPos_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_7;
    highp vec3 tmpvar_10;
    tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
    highp mat3 tmpvar_11;
    tmpvar_11[0] = unity_WorldToObject[0].xyz;
    tmpvar_11[1] = unity_WorldToObject[1].xyz;
    tmpvar_11[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = normalize((_glesNormal * tmpvar_11));
    highp float tmpvar_13;
    tmpvar_13 = dot (tmpvar_12, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_10 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = (tmpvar_10 - (tmpvar_12 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_13 * tmpvar_13)))
    )));
    clipPos_8 = (unity_MatrixVP * tmpvar_14);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = vertex_7;
    clipPos_8 = (glstate_matrix_mvp * tmpvar_15);
  };
  highp vec4 clipPos_16;
  clipPos_16.xyw = clipPos_8.xyw;
  clipPos_16.z = (clipPos_8.z + clamp ((unity_LightShadowBias.x / clipPos_8.w), 0.0, 1.0));
  clipPos_16.z = mix (clipPos_16.z, max (clipPos_16.z, -(clipPos_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_16;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec3 vertex_7;
  vertex_7 = _glesVertex.xyz;
  highp vec4 clipPos_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_7;
    highp vec3 tmpvar_10;
    tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
    highp mat3 tmpvar_11;
    tmpvar_11[0] = unity_WorldToObject[0].xyz;
    tmpvar_11[1] = unity_WorldToObject[1].xyz;
    tmpvar_11[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = normalize((_glesNormal * tmpvar_11));
    highp float tmpvar_13;
    tmpvar_13 = dot (tmpvar_12, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_10 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = (tmpvar_10 - (tmpvar_12 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_13 * tmpvar_13)))
    )));
    clipPos_8 = (unity_MatrixVP * tmpvar_14);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = vertex_7;
    clipPos_8 = (glstate_matrix_mvp * tmpvar_15);
  };
  highp vec4 clipPos_16;
  clipPos_16.xyw = clipPos_8.xyw;
  clipPos_16.z = (clipPos_8.z + clamp ((unity_LightShadowBias.x / clipPos_8.w), 0.0, 1.0));
  clipPos_16.z = mix (clipPos_16.z, max (clipPos_16.z, -(clipPos_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_16;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec3 vertex_7;
  vertex_7 = _glesVertex.xyz;
  highp vec4 clipPos_8;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_7;
    highp vec3 tmpvar_10;
    tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
    highp mat3 tmpvar_11;
    tmpvar_11[0] = unity_WorldToObject[0].xyz;
    tmpvar_11[1] = unity_WorldToObject[1].xyz;
    tmpvar_11[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = normalize((_glesNormal * tmpvar_11));
    highp float tmpvar_13;
    tmpvar_13 = dot (tmpvar_12, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_10 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = (tmpvar_10 - (tmpvar_12 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_13 * tmpvar_13)))
    )));
    clipPos_8 = (unity_MatrixVP * tmpvar_14);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = vertex_7;
    clipPos_8 = (glstate_matrix_mvp * tmpvar_15);
  };
  highp vec4 clipPos_16;
  clipPos_16.xyw = clipPos_8.xyw;
  clipPos_16.z = (clipPos_8.z + clamp ((unity_LightShadowBias.x / clipPos_8.w), 0.0, 1.0));
  clipPos_16.z = mix (clipPos_16.z, max (clipPos_16.z, -(clipPos_8.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_16;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
void main ()
{
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
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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
uniform highp vec4 unity_FogParams;
uniform lowp float _Alpha;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  highp vec4 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = (unity_FogParams.x * tmpvar_4.z);
  mediump float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_3) * tmpvar_3));
  tmpvar_3 = tmpvar_5;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  mediump vec4 tmpvar_6;
  tmpvar_6.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_6.w = tmpvar_5;
  tmpvar_2 = (tmpvar_1 * tmpvar_6);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
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
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}