//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-ScreenSpaceShadows" {
Properties {
 _ShadowMapTexture ("", any) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1194
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  mediump float tmpvar_12;
  if ((tmpvar_11.x < tmpvar_10.z)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = 1.0;
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = vec4(shadow_2);
  res_1 = tmpvar_14;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  mediump float tmpvar_12;
  if ((tmpvar_11.x < tmpvar_10.z)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = 1.0;
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = vec4(shadow_2);
  res_1 = tmpvar_14;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  highp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  mediump float tmpvar_12;
  if ((tmpvar_11.x < tmpvar_10.z)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = 1.0;
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = vec4(shadow_2);
  res_1 = tmpvar_14;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  mediump float tmpvar_16;
  if ((tmpvar_15.x < tmpvar_14.z)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    sqrt(dot (tmpvar_18, tmpvar_18))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  tmpvar_17 = tmpvar_19;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
  mediump vec4 tmpvar_21;
  tmpvar_21 = vec4(shadow_2);
  res_1 = tmpvar_21;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  mediump float tmpvar_16;
  if ((tmpvar_15.x < tmpvar_14.z)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    sqrt(dot (tmpvar_18, tmpvar_18))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  tmpvar_17 = tmpvar_19;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
  mediump vec4 tmpvar_21;
  tmpvar_21 = vec4(shadow_2);
  res_1 = tmpvar_21;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  mediump float tmpvar_16;
  if ((tmpvar_15.x < tmpvar_14.z)) {
    tmpvar_16 = 0.0;
  } else {
    tmpvar_16 = 1.0;
  };
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((
    sqrt(dot (tmpvar_18, tmpvar_18))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  tmpvar_17 = tmpvar_19;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
  mediump vec4 tmpvar_21;
  tmpvar_21 = vec4(shadow_2);
  res_1 = tmpvar_21;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(shadow_2);
  res_1 = tmpvar_10;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(shadow_2);
  res_1 = tmpvar_10;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(shadow_2);
  res_1 = tmpvar_10;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(dot (tmpvar_10, tmpvar_10))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_9 = tmpvar_11;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_13;
  tmpvar_13 = vec4(shadow_2);
  res_1 = tmpvar_13;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(dot (tmpvar_10, tmpvar_10))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_9 = tmpvar_11;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_13;
  tmpvar_13 = vec4(shadow_2);
  res_1 = tmpvar_13;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  mediump float tmpvar_8;
  if ((tmpvar_7.x < tmpvar_6.z)) {
    tmpvar_8 = 0.0;
  } else {
    tmpvar_8 = 1.0;
  };
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((
    sqrt(dot (tmpvar_10, tmpvar_10))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_9 = tmpvar_11;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_13;
  tmpvar_13 = vec4(shadow_2);
  res_1 = tmpvar_13;
  gl_FragData[0] = res_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier03 " {
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
 }
}
SubShader { 
 Tags { "ShadowmapFilter"="PCF_5x5" }
 Pass {
  Tags { "ShadowmapFilter"="PCF_5x5" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 88306
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  mediump float shadow_11;
  shadow_11 = 0.0;
  highp vec2 tmpvar_12;
  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_13.z = tmpvar_10.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  mediump float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_10.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_11 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_10.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_10.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_11 = (tmpvar_15 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_12.x;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_10.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_10.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_10.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_10.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = tmpvar_12.x;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_10.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_10.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_34.y = tmpvar_12.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_10.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_10.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = 0.0;
  tmpvar_38.y = tmpvar_12.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_10.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_10.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_41);
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_42.z = tmpvar_10.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_10.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_44);
  shadow_11 = (shadow_11 / 9.0);
  mediump float tmpvar_45;
  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
  shadow_11 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_45 + tmpvar_46);
  mediump vec4 tmpvar_47;
  tmpvar_47 = vec4(shadow_2);
  tmpvar_1 = tmpvar_47;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  mediump float shadow_11;
  shadow_11 = 0.0;
  highp vec2 tmpvar_12;
  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_13.z = tmpvar_10.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  mediump float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_10.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_11 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_10.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_10.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_11 = (tmpvar_15 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_12.x;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_10.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_10.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_10.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_10.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = tmpvar_12.x;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_10.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_10.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_34.y = tmpvar_12.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_10.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_10.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = 0.0;
  tmpvar_38.y = tmpvar_12.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_10.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_10.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_41);
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_42.z = tmpvar_10.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_10.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_44);
  shadow_11 = (shadow_11 / 9.0);
  mediump float tmpvar_45;
  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
  shadow_11 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_45 + tmpvar_46);
  mediump vec4 tmpvar_47;
  tmpvar_47 = vec4(shadow_2);
  tmpvar_1 = tmpvar_47;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_6)
  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
  mediump float shadow_11;
  shadow_11 = 0.0;
  highp vec2 tmpvar_12;
  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_13.z = tmpvar_10.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  mediump float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_10.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_11 = tmpvar_15;
  highp vec2 tmpvar_16;
  tmpvar_16.x = 0.0;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_10.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_10.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_11 = (tmpvar_15 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_12.x;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_10.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_10.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.y = 0.0;
  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_10.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_10.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_10.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = tmpvar_12.x;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_10.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_10.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_34.y = tmpvar_12.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_10.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_10.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = 0.0;
  tmpvar_38.y = tmpvar_12.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_10.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_10.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_41);
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_42.z = tmpvar_10.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_10.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_11 = (shadow_11 + tmpvar_44);
  shadow_11 = (shadow_11 / 9.0);
  mediump float tmpvar_45;
  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
  shadow_11 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_45 + tmpvar_46);
  mediump vec4 tmpvar_47;
  tmpvar_47 = vec4(shadow_2);
  tmpvar_1 = tmpvar_47;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  mediump float shadow_15;
  shadow_15 = 0.0;
  highp vec2 tmpvar_16;
  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_17.z = tmpvar_14.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_14.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_15 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20.x = 0.0;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_14.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_14.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_15 = (tmpvar_19 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_16.x;
  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_14.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_14.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_14.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_14.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_31);
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_14.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.0;
  tmpvar_34.x = tmpvar_16.x;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_14.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_14.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_38.y = tmpvar_16.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_14.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_14.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_41);
  highp vec2 tmpvar_42;
  tmpvar_42.x = 0.0;
  tmpvar_42.y = tmpvar_16.y;
  highp vec3 tmpvar_43;
  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
  tmpvar_43.z = tmpvar_14.z;
  highp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
  highp float tmpvar_45;
  if ((tmpvar_44.x < tmpvar_14.z)) {
    tmpvar_45 = 0.0;
  } else {
    tmpvar_45 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_45);
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_46.z = tmpvar_14.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_14.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_48);
  shadow_15 = (shadow_15 / 9.0);
  mediump float tmpvar_49;
  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
  shadow_15 = tmpvar_49;
  highp float tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp (((
    sqrt(dot (tmpvar_51, tmpvar_51))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  tmpvar_50 = tmpvar_52;
  shadow_2 = (tmpvar_49 + tmpvar_50);
  mediump vec4 tmpvar_54;
  tmpvar_54 = vec4(shadow_2);
  tmpvar_1 = tmpvar_54;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  mediump float shadow_15;
  shadow_15 = 0.0;
  highp vec2 tmpvar_16;
  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_17.z = tmpvar_14.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_14.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_15 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20.x = 0.0;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_14.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_14.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_15 = (tmpvar_19 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_16.x;
  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_14.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_14.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_14.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_14.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_31);
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_14.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.0;
  tmpvar_34.x = tmpvar_16.x;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_14.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_14.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_38.y = tmpvar_16.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_14.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_14.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_41);
  highp vec2 tmpvar_42;
  tmpvar_42.x = 0.0;
  tmpvar_42.y = tmpvar_16.y;
  highp vec3 tmpvar_43;
  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
  tmpvar_43.z = tmpvar_14.z;
  highp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
  highp float tmpvar_45;
  if ((tmpvar_44.x < tmpvar_14.z)) {
    tmpvar_45 = 0.0;
  } else {
    tmpvar_45 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_45);
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_46.z = tmpvar_14.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_14.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_48);
  shadow_15 = (shadow_15 / 9.0);
  mediump float tmpvar_49;
  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
  shadow_15 = tmpvar_49;
  highp float tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp (((
    sqrt(dot (tmpvar_51, tmpvar_51))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  tmpvar_50 = tmpvar_52;
  shadow_2 = (tmpvar_49 + tmpvar_50);
  mediump vec4 tmpvar_54;
  tmpvar_54 = vec4(shadow_2);
  tmpvar_1 = tmpvar_54;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  lowp vec4 weights_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_11;
  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
  bvec4 tmpvar_12;
  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_13;
  tmpvar_13 = vec4(tmpvar_12);
  weights_6.x = tmpvar_13.x;
  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_5)
  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
  mediump float shadow_15;
  shadow_15 = 0.0;
  highp vec2 tmpvar_16;
  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_17.z = tmpvar_14.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_14.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_15 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20.x = 0.0;
  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_14.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_14.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_15 = (tmpvar_19 + tmpvar_23);
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_16.x;
  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_25;
  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
  tmpvar_25.z = tmpvar_14.z;
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_14.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_14.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_14.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_31);
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_14.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.y = 0.0;
  tmpvar_34.x = tmpvar_16.x;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_14.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_14.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_37);
  highp vec2 tmpvar_38;
  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_38.y = tmpvar_16.y;
  highp vec3 tmpvar_39;
  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
  tmpvar_39.z = tmpvar_14.z;
  highp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
  highp float tmpvar_41;
  if ((tmpvar_40.x < tmpvar_14.z)) {
    tmpvar_41 = 0.0;
  } else {
    tmpvar_41 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_41);
  highp vec2 tmpvar_42;
  tmpvar_42.x = 0.0;
  tmpvar_42.y = tmpvar_16.y;
  highp vec3 tmpvar_43;
  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
  tmpvar_43.z = tmpvar_14.z;
  highp vec4 tmpvar_44;
  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
  highp float tmpvar_45;
  if ((tmpvar_44.x < tmpvar_14.z)) {
    tmpvar_45 = 0.0;
  } else {
    tmpvar_45 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_45);
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_46.z = tmpvar_14.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_14.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_15 = (shadow_15 + tmpvar_48);
  shadow_15 = (shadow_15 / 9.0);
  mediump float tmpvar_49;
  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
  shadow_15 = tmpvar_49;
  highp float tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp (((
    sqrt(dot (tmpvar_51, tmpvar_51))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  tmpvar_50 = tmpvar_52;
  shadow_2 = (tmpvar_49 + tmpvar_50);
  mediump vec4 tmpvar_54;
  tmpvar_54 = vec4(shadow_2);
  tmpvar_1 = tmpvar_54;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_43;
  tmpvar_43 = vec4(shadow_2);
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_43;
  tmpvar_43 = vec4(shadow_2);
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_43;
  tmpvar_43 = vec4(shadow_2);
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((
    sqrt(dot (tmpvar_43, tmpvar_43))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  tmpvar_42 = tmpvar_44;
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(shadow_2);
  tmpvar_1 = tmpvar_46;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((
    sqrt(dot (tmpvar_43, tmpvar_43))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  tmpvar_42 = tmpvar_44;
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(shadow_2);
  tmpvar_1 = tmpvar_46;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 orthoPosFar_1;
  highp vec3 orthoPosNear_2;
  highp vec4 clipPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  clipPos_3.xzw = tmpvar_4.xzw;
  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(-1.0, 1.0);
  tmpvar_6.xy = clipPos_3.xy;
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
  orthoPosNear_2.xy = tmpvar_7.xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(1.0, 1.0);
  tmpvar_8.xy = clipPos_3.xy;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
  orthoPosFar_1.xy = tmpvar_9.xy;
  orthoPosNear_2.z = -(tmpvar_7.z);
  orthoPosFar_1.z = -(tmpvar_9.z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_OrthoParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
  mediump float shadow_7;
  shadow_7 = 0.0;
  highp vec2 tmpvar_8;
  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_9.z = tmpvar_6.z;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_6.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  shadow_7 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_13;
  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
  tmpvar_13.z = tmpvar_6.z;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
  highp float tmpvar_15;
  if ((tmpvar_14.x < tmpvar_6.z)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = 1.0;
  };
  shadow_7 = (tmpvar_11 + tmpvar_15);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_8.x;
  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_17;
  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
  tmpvar_17.z = tmpvar_6.z;
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_6.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_19);
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.0;
  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_21;
  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
  tmpvar_21.z = tmpvar_6.z;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
  highp float tmpvar_23;
  if ((tmpvar_22.x < tmpvar_6.z)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_23);
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_6.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = tmpvar_8.x;
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_6.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_6.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_29);
  highp vec2 tmpvar_30;
  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_30.y = tmpvar_8.y;
  highp vec3 tmpvar_31;
  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
  tmpvar_31.z = tmpvar_6.z;
  highp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
  highp float tmpvar_33;
  if ((tmpvar_32.x < tmpvar_6.z)) {
    tmpvar_33 = 0.0;
  } else {
    tmpvar_33 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = 0.0;
  tmpvar_34.y = tmpvar_8.y;
  highp vec3 tmpvar_35;
  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
  tmpvar_35.z = tmpvar_6.z;
  highp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
  highp float tmpvar_37;
  if ((tmpvar_36.x < tmpvar_6.z)) {
    tmpvar_37 = 0.0;
  } else {
    tmpvar_37 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_37);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_38.z = tmpvar_6.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_6.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_7 = (shadow_7 + tmpvar_40);
  shadow_7 = (shadow_7 / 9.0);
  mediump float tmpvar_41;
  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
  shadow_7 = tmpvar_41;
  highp float tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (((
    sqrt(dot (tmpvar_43, tmpvar_43))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  tmpvar_42 = tmpvar_44;
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_46;
  tmpvar_46 = vec4(shadow_2);
  tmpvar_1 = tmpvar_46;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles hw_tier03 " {
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
 }
}
Fallback Off
}