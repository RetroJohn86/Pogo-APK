//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Shadow Matte/Multiply with Clear Color" {
Properties {
 _ShadowColor ("Shadow Tint (RGBA)", Color) = (0.000000,0.000000,0.000000,1.000000)
 _Alpha ("Alpha Out (for Pokedex)", Range(0.000000,1.000000)) = 1.000000
[KeywordEnum(Alpha_X_Ambient, RGBA)]  _Multiplier ("    Clear Multiplier", Float) = 0.000000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="AlphaTest+50" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="AlphaTest+50" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend DstColor Zero, SrcAlpha One
  GpuProgramID 29153
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  discard;
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 0.0);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  discard;
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 0.0);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  discard;
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 0.0);
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD1.w;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float atten_9;
  atten_9 = tmpvar_4;
  lowp vec4 col_10;
  lowp float mask_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - atten_9);
  mask_11 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_2.xyz;
  tmpvar_13.w = tmpvar_3;
  col_10 = tmpvar_13;
  lowp float x_14;
  x_14 = (mask_11 - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = vec3(atten_9);
  tmpvar_8 = ((col_10 * mask_11) + tmpvar_15);
  c_1 = tmpvar_8;
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD1.w;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float atten_9;
  atten_9 = tmpvar_4;
  lowp vec4 col_10;
  lowp float mask_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - atten_9);
  mask_11 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_2.xyz;
  tmpvar_13.w = tmpvar_3;
  col_10 = tmpvar_13;
  lowp float x_14;
  x_14 = (mask_11 - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = vec3(atten_9);
  tmpvar_8 = ((col_10 * mask_11) + tmpvar_15);
  c_1 = tmpvar_8;
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
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = _glesColor.xyz;
  mediump float tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4 = (unity_FogParams.x * tmpvar_5.z);
  mediump float tmpvar_6;
  tmpvar_6 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_4 = tmpvar_6;
  tmpvar_3.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_3.w * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].x;
  v_9.y = unity_WorldToObject[1].x;
  v_9.z = unity_WorldToObject[2].x;
  v_9.w = unity_WorldToObject[3].x;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].y;
  v_10.y = unity_WorldToObject[1].y;
  v_10.z = unity_WorldToObject[2].y;
  v_10.w = unity_WorldToObject[3].y;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].z;
  v_11.y = unity_WorldToObject[1].z;
  v_11.z = unity_WorldToObject[2].z;
  v_11.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(((
    (v_9.xyz * _glesNormal.x)
   + 
    (v_10.xyz * _glesNormal.y)
  ) + (v_11.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_12;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_8);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_2 = xlv_TEXCOORD1;
  tmpvar_3 = xlv_TEXCOORD1.w;
  lowp float tmpvar_4;
  highp float lightShadowDataX_5;
  mediump float tmpvar_6;
  tmpvar_6 = _LightShadowData.x;
  lightShadowDataX_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_5);
  tmpvar_4 = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float atten_9;
  atten_9 = tmpvar_4;
  lowp vec4 col_10;
  lowp float mask_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - atten_9);
  mask_11 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = tmpvar_2.xyz;
  tmpvar_13.w = tmpvar_3;
  col_10 = tmpvar_13;
  lowp float x_14;
  x_14 = (mask_11 - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = vec3(atten_9);
  tmpvar_8 = ((col_10 * mask_11) + tmpvar_15);
  c_1 = tmpvar_8;
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
  Tags { "LIGHTMODE"="SHADOWCASTER" "QUEUE"="AlphaTest+50" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Blend DstColor Zero, SrcAlpha One
  GpuProgramID 84852
Program "vp" {
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp vec4 v_10;
    v_10.x = unity_WorldToObject[0].x;
    v_10.y = unity_WorldToObject[1].x;
    v_10.z = unity_WorldToObject[2].x;
    v_10.w = unity_WorldToObject[3].x;
    highp vec4 v_11;
    v_11.x = unity_WorldToObject[0].y;
    v_11.y = unity_WorldToObject[1].y;
    v_11.z = unity_WorldToObject[2].y;
    v_11.w = unity_WorldToObject[3].y;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].z;
    v_12.y = unity_WorldToObject[1].z;
    v_12.z = unity_WorldToObject[2].z;
    v_12.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize(((
      (v_10.xyz * _glesNormal.x)
     + 
      (v_11.xyz * _glesNormal.y)
    ) + (v_12.xyz * _glesNormal.z)));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_9 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_7.xyw;
  clipPos_17.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp vec4 v_10;
    v_10.x = unity_WorldToObject[0].x;
    v_10.y = unity_WorldToObject[1].x;
    v_10.z = unity_WorldToObject[2].x;
    v_10.w = unity_WorldToObject[3].x;
    highp vec4 v_11;
    v_11.x = unity_WorldToObject[0].y;
    v_11.y = unity_WorldToObject[1].y;
    v_11.z = unity_WorldToObject[2].y;
    v_11.w = unity_WorldToObject[3].y;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].z;
    v_12.y = unity_WorldToObject[1].z;
    v_12.z = unity_WorldToObject[2].z;
    v_12.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize(((
      (v_10.xyz * _glesNormal.x)
     + 
      (v_11.xyz * _glesNormal.y)
    ) + (v_12.xyz * _glesNormal.z)));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_9 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_7.xyw;
  clipPos_17.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
SubProgram "gles hw_tier03 " {
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp vec4 v_10;
    v_10.x = unity_WorldToObject[0].x;
    v_10.y = unity_WorldToObject[1].x;
    v_10.z = unity_WorldToObject[2].x;
    v_10.w = unity_WorldToObject[3].x;
    highp vec4 v_11;
    v_11.x = unity_WorldToObject[0].y;
    v_11.y = unity_WorldToObject[1].y;
    v_11.z = unity_WorldToObject[2].y;
    v_11.w = unity_WorldToObject[3].y;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].z;
    v_12.y = unity_WorldToObject[1].z;
    v_12.z = unity_WorldToObject[2].z;
    v_12.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_13;
    tmpvar_13 = normalize(((
      (v_10.xyz * _glesNormal.x)
     + 
      (v_11.xyz * _glesNormal.y)
    ) + (v_12.xyz * _glesNormal.z)));
    highp float tmpvar_14;
    tmpvar_14 = dot (tmpvar_13, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (tmpvar_9 - (tmpvar_13 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_14 * tmpvar_14)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_15);
  } else {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_16);
  };
  highp vec4 clipPos_17;
  clipPos_17.xyw = clipPos_7.xyw;
  clipPos_17.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_17.z = mix (clipPos_17.z, max (clipPos_17.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_17;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_6);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_6);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_ShadowColor.xyz = _ShadowColor.xyz;
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = _glesColor.xyz;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = (unity_FogParams.x * tmpvar_3.z);
  mediump float tmpvar_4;
  tmpvar_4 = exp2((-(tmpvar_2) * tmpvar_2));
  tmpvar_2 = tmpvar_4;
  tmpvar_1.w = (_glesColor.w * _Alpha);
  xlat_mutable_ShadowColor.w = (_ShadowColor.w * (tmpvar_1.w * tmpvar_4));
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = (((_ShadowColor.xyz * unity_AmbientEquator.xyz) * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_5.w = tmpvar_1.w;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_6);
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_4;
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
Fallback Off
}