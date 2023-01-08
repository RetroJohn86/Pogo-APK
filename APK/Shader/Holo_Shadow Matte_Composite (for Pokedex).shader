//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Shadow Matte/Composite (for Pokedex)" {
Properties {
_ShadowColor ("Shadow Tint (RGBA)", Color) = (0,0,0,1)
_Alpha ("Alpha Out (for Pokedex)", Range(0, 1)) = 1
[KeywordEnum(Alpha_X_Ambient, RGBA)] _Multiplier ("    Clear Multiplier", Float) = 0
_Clip ("Target Clip (x min, y min, x max, y max)", Vector) = (0,0,0,0)
_Feather ("Target Feather (x min, y min, x max, y max)", Vector) = (0,0,0,0)
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("Mask X", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("Mask Y", Float) = 0
[Toggle(BRB_EYE_SHADE_DEBUG)] _EyeShadeDebug ("Debug Mask", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 39672
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
void main ()
{
  lowp vec4 color_1;
  color_1.xyz = vec3(1.0, 1.0, 1.0);
  color_1.w = 0.0;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 screenMask_4;
  lowp vec2 screenPos_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  screenPos_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.xy = ((1.0 - _Clip.zy) - screenPos_5);
  tmpvar_7.zw = (screenPos_5 - _Clip.xw);
  screenMask_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_3 = xlv_TEXCOORD2.w;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  mediump vec4 tmpvar_12;
  mediump float atten_13;
  atten_13 = tmpvar_8;
  lowp vec4 col_14;
  lowp float mask_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - atten_13);
  mask_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_17.w = tmpvar_3;
  col_14 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = vec3(atten_13);
  tmpvar_12 = ((col_14 * mask_15) + tmpvar_18);
  c_1 = tmpvar_12;
  lowp vec4 color_19;
  color_19.xyz = c_1.xyz;
  mediump vec4 screenRatio_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((screenMask_4.y / (screenRatio_20.y * _Feather.y)), 0.0, 1.0);
  color_19.w = (c_1.w * tmpvar_22);
  mediump float tmpvar_23;
  tmpvar_23 = clamp ((screenMask_4.w / (screenRatio_20.w * _Feather.w)), 0.0, 1.0);
  color_19.w = (color_19.w * tmpvar_23);
  c_1 = color_19;
  gl_FragData[0] = color_19;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 screenMask_4;
  lowp vec2 screenPos_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  screenPos_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.xy = ((1.0 - _Clip.zy) - screenPos_5);
  tmpvar_7.zw = (screenPos_5 - _Clip.xw);
  screenMask_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_3 = xlv_TEXCOORD2.w;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  mediump vec4 tmpvar_12;
  mediump float atten_13;
  atten_13 = tmpvar_8;
  lowp vec4 col_14;
  lowp float mask_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - atten_13);
  mask_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_17.w = tmpvar_3;
  col_14 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = vec3(atten_13);
  tmpvar_12 = ((col_14 * mask_15) + tmpvar_18);
  c_1 = tmpvar_12;
  lowp vec4 color_19;
  color_19.xyz = c_1.xyz;
  mediump vec4 screenRatio_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((screenMask_4.y / (screenRatio_20.y * _Feather.y)), 0.0, 1.0);
  color_19.w = (c_1.w * tmpvar_22);
  mediump float tmpvar_23;
  tmpvar_23 = clamp ((screenMask_4.w / (screenRatio_20.w * _Feather.w)), 0.0, 1.0);
  color_19.w = (color_19.w * tmpvar_23);
  c_1 = color_19;
  gl_FragData[0] = color_19;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _ShadowColor;
uniform lowp float _Alpha;
highp vec4 xlat_mutable_ShadowColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  tmpvar_7.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
  tmpvar_7.w = tmpvar_3.w;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (glstate_matrix_mvp * tmpvar_9);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_8.zw;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = o_12;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _ShadowMapTexture;
uniform lowp vec4 _Clip;
uniform lowp vec4 _Feather;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 screenMask_4;
  lowp vec2 screenPos_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  screenPos_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.xy = ((1.0 - _Clip.zy) - screenPos_5);
  tmpvar_7.zw = (screenPos_5 - _Clip.xw);
  screenMask_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_3 = xlv_TEXCOORD2.w;
  lowp float tmpvar_8;
  highp float lightShadowDataX_9;
  mediump float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_9);
  tmpvar_8 = tmpvar_11;
  mediump vec4 tmpvar_12;
  mediump float atten_13;
  atten_13 = tmpvar_8;
  lowp vec4 col_14;
  lowp float mask_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - atten_13);
  mask_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = tmpvar_2.xyz;
  tmpvar_17.w = tmpvar_3;
  col_14 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = vec3(atten_13);
  tmpvar_12 = ((col_14 * mask_15) + tmpvar_18);
  c_1 = tmpvar_12;
  lowp vec4 color_19;
  color_19.xyz = c_1.xyz;
  mediump vec4 screenRatio_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = ((1.0 - _Clip) - _Clip.zwxy);
  screenRatio_20 = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp ((screenMask_4.y / (screenRatio_20.y * _Feather.y)), 0.0, 1.0);
  color_19.w = (c_1.w * tmpvar_22);
  mediump float tmpvar_23;
  tmpvar_23 = clamp ((screenMask_4.w / (screenRatio_20.w * _Feather.w)), 0.0, 1.0);
  color_19.w = (color_19.w * tmpvar_23);
  c_1 = color_19;
  gl_FragData[0] = color_19;
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+50" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 71970
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
  tmpvar_5.xyz = ((_ShadowColor.xyz * xlat_mutable_ShadowColor.w) + (1.0 - xlat_mutable_ShadowColor.w));
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
CustomEditor "CustomMaterialInspector"
}