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
 Tags { "ShadowmapFilter" = "HardShadow" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow" }
  ZClip Off
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 27348
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_13 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_13 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_13 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
  mediump vec4 tmpvar_14;
  tmpvar_14 = vec4(shadow_2);
  res_1 = tmpvar_14;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_9 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_9 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_9 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
  mediump vec4 tmpvar_10;
  tmpvar_10 = vec4(shadow_2);
  res_1 = tmpvar_10;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
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
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "HardShadow_FORCE_INV_PROJECTION_IN_PS" }
  ZClip Off
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 127620
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_12.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  highp float tmpvar_15;
  tmpvar_15 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_14) + tmpvar_15);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_12.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  highp float tmpvar_15;
  tmpvar_15 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_14) + tmpvar_15);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_12.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  highp float tmpvar_15;
  tmpvar_15 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_14) + tmpvar_15);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_17.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (((
    sqrt(dot (tmpvar_21, tmpvar_21))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  tmpvar_20 = tmpvar_22;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_19) + tmpvar_20);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(shadow_2);
  res_1 = tmpvar_24;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_17.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (((
    sqrt(dot (tmpvar_21, tmpvar_21))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  tmpvar_20 = tmpvar_22;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_19) + tmpvar_20);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(shadow_2);
  res_1 = tmpvar_24;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  mediump float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_17.z)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = 1.0;
  };
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (((
    sqrt(dot (tmpvar_21, tmpvar_21))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  tmpvar_20 = tmpvar_22;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_19) + tmpvar_20);
  mediump vec4 tmpvar_24;
  tmpvar_24 = vec4(shadow_2);
  res_1 = tmpvar_24;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  mediump float tmpvar_10;
  if ((tmpvar_9.x < tmpvar_8.z)) {
    tmpvar_10 = 0.0;
  } else {
    tmpvar_10 = 1.0;
  };
  highp float tmpvar_11;
  tmpvar_11 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_10) + tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = vec4(shadow_2);
  res_1 = tmpvar_12;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  mediump float tmpvar_10;
  if ((tmpvar_9.x < tmpvar_8.z)) {
    tmpvar_10 = 0.0;
  } else {
    tmpvar_10 = 1.0;
  };
  highp float tmpvar_11;
  tmpvar_11 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_10) + tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = vec4(shadow_2);
  res_1 = tmpvar_12;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  highp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  mediump float tmpvar_10;
  if ((tmpvar_9.x < tmpvar_8.z)) {
    tmpvar_10 = 0.0;
  } else {
    tmpvar_10 = 1.0;
  };
  highp float tmpvar_11;
  tmpvar_11 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_10) + tmpvar_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = vec4(shadow_2);
  res_1 = tmpvar_12;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_9.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    sqrt(dot (tmpvar_13, tmpvar_13))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  tmpvar_12 = tmpvar_14;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_11) + tmpvar_12);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_9.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    sqrt(dot (tmpvar_13, tmpvar_13))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  tmpvar_12 = tmpvar_14;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_11) + tmpvar_12);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  highp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  mediump float tmpvar_11;
  if ((tmpvar_10.x < tmpvar_9.z)) {
    tmpvar_11 = 0.0;
  } else {
    tmpvar_11 = 1.0;
  };
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((
    sqrt(dot (tmpvar_13, tmpvar_13))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_14 = tmpvar_15;
  tmpvar_12 = tmpvar_14;
  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_11) + tmpvar_12);
  mediump vec4 tmpvar_16;
  tmpvar_16 = vec4(shadow_2);
  res_1 = tmpvar_16;
  gl_FragData[0] = res_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
""
}
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "PCF_5x5" }
 Pass {
  Tags { "ShadowmapFilter" = "PCF_5x5" }
  ZClip Off
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 164474
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_46 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_46 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
  bvec4 tmpvar_7;
  tmpvar_7 = greaterThanEqual (tmpvar_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_8;
  tmpvar_8 = lessThan (tmpvar_3.zzzz, _LightSplitsFar);
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
  tmpvar_46 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_45 + tmpvar_46);
  mediump vec4 tmpvar_47;
  tmpvar_47 = vec4(shadow_2);
  tmpvar_1 = tmpvar_47;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_42 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_42 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
  tmpvar_3 = mix ((xlv_TEXCOORD1 * mix (
    (1.0/(((_ZBufferParams.x * tmpvar_4.x) + _ZBufferParams.y)))
  , tmpvar_4.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_4.xxx), unity_OrthoParams.www);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_3;
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
  tmpvar_42 = clamp (((tmpvar_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_41 + tmpvar_42);
  mediump vec4 tmpvar_43;
  tmpvar_43 = vec4(shadow_2);
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
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
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy);
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
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
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
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
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
}
}
}
SubShader {
 Tags { "ShadowmapFilter" = "PCF_5x5_FORCE_INV_PROJECTION_IN_PS" }
 Pass {
  Tags { "ShadowmapFilter" = "PCF_5x5_FORCE_INV_PROJECTION_IN_PS" }
  ZClip Off
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 234566
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  mediump float shadow_13;
  shadow_13 = 0.0;
  highp vec2 tmpvar_14;
  tmpvar_14 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_12.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_15.z = tmpvar_12.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  mediump float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_12.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_13 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18.x = 0.0;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_12.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_12.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_12.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_13 = (tmpvar_17 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_14.x;
  tmpvar_22.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_12.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_12.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_12.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_12.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_12.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_29);
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_12.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.y = 0.0;
  tmpvar_32.x = tmpvar_14.x;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_12.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_12.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_12.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_36.y = tmpvar_14.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_12.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_12.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_12.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_39);
  highp vec2 tmpvar_40;
  tmpvar_40.x = 0.0;
  tmpvar_40.y = tmpvar_14.y;
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_12.xy + tmpvar_40);
  tmpvar_41.z = tmpvar_12.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_12.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_43);
  highp vec3 tmpvar_44;
  tmpvar_44.xy = (tmpvar_12.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_44.z = tmpvar_12.z;
  highp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_ShadowMapTexture, tmpvar_44.xy);
  highp float tmpvar_46;
  if ((tmpvar_45.x < tmpvar_12.z)) {
    tmpvar_46 = 0.0;
  } else {
    tmpvar_46 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_46);
  shadow_13 = (shadow_13 / 9.0);
  mediump float tmpvar_47;
  tmpvar_47 = mix (_LightShadowData.x, 1.0, shadow_13);
  shadow_13 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_47 + tmpvar_48);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  mediump float shadow_13;
  shadow_13 = 0.0;
  highp vec2 tmpvar_14;
  tmpvar_14 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_12.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_15.z = tmpvar_12.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  mediump float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_12.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_13 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18.x = 0.0;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_12.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_12.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_12.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_13 = (tmpvar_17 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_14.x;
  tmpvar_22.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_12.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_12.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_12.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_12.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_12.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_29);
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_12.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.y = 0.0;
  tmpvar_32.x = tmpvar_14.x;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_12.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_12.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_12.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_36.y = tmpvar_14.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_12.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_12.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_12.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_39);
  highp vec2 tmpvar_40;
  tmpvar_40.x = 0.0;
  tmpvar_40.y = tmpvar_14.y;
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_12.xy + tmpvar_40);
  tmpvar_41.z = tmpvar_12.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_12.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_43);
  highp vec3 tmpvar_44;
  tmpvar_44.xy = (tmpvar_12.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_44.z = tmpvar_12.z;
  highp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_ShadowMapTexture, tmpvar_44.xy);
  highp float tmpvar_46;
  if ((tmpvar_45.x < tmpvar_12.z)) {
    tmpvar_46 = 0.0;
  } else {
    tmpvar_46 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_46);
  shadow_13 = (shadow_13 / 9.0);
  mediump float tmpvar_47;
  tmpvar_47 = mix (_LightShadowData.x, 1.0, shadow_13);
  shadow_13 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_47 + tmpvar_48);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  bvec4 tmpvar_9;
  tmpvar_9 = greaterThanEqual (camPos_3.zzzz, _LightSplitsNear);
  bvec4 tmpvar_10;
  tmpvar_10 = lessThan (camPos_3.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_11;
  tmpvar_11 = (vec4(tmpvar_9) * vec4(tmpvar_10));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_11.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * tmpvar_11.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * tmpvar_11.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * tmpvar_11.w));
  mediump float shadow_13;
  shadow_13 = 0.0;
  highp vec2 tmpvar_14;
  tmpvar_14 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_12.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_15.z = tmpvar_12.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  mediump float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_12.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_13 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18.x = 0.0;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_12.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_12.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_12.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_13 = (tmpvar_17 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_14.x;
  tmpvar_22.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_12.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_12.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_12.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_25);
  highp vec2 tmpvar_26;
  tmpvar_26.y = 0.0;
  tmpvar_26.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_27;
  tmpvar_27.xy = (tmpvar_12.xy + tmpvar_26);
  tmpvar_27.z = tmpvar_12.z;
  highp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
  highp float tmpvar_29;
  if ((tmpvar_28.x < tmpvar_12.z)) {
    tmpvar_29 = 0.0;
  } else {
    tmpvar_29 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_29);
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_12.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.y = 0.0;
  tmpvar_32.x = tmpvar_14.x;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_12.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_12.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_12.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_36.y = tmpvar_14.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_12.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_12.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_12.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_39);
  highp vec2 tmpvar_40;
  tmpvar_40.x = 0.0;
  tmpvar_40.y = tmpvar_14.y;
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_12.xy + tmpvar_40);
  tmpvar_41.z = tmpvar_12.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_12.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_43);
  highp vec3 tmpvar_44;
  tmpvar_44.xy = (tmpvar_12.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_44.z = tmpvar_12.z;
  highp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_ShadowMapTexture, tmpvar_44.xy);
  highp float tmpvar_46;
  if ((tmpvar_45.x < tmpvar_12.z)) {
    tmpvar_46 = 0.0;
  } else {
    tmpvar_46 = 1.0;
  };
  shadow_13 = (shadow_13 + tmpvar_46);
  shadow_13 = (shadow_13 / 9.0);
  mediump float tmpvar_47;
  tmpvar_47 = mix (_LightShadowData.x, 1.0, shadow_13);
  shadow_13 = tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_47 + tmpvar_48);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  mediump float shadow_18;
  shadow_18 = 0.0;
  highp vec2 tmpvar_19;
  tmpvar_19 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_17.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_20.z = tmpvar_17.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  mediump float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_17.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_18 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23.x = 0.0;
  tmpvar_23.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_17.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_17.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_17.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_18 = (tmpvar_22 + tmpvar_26);
  highp vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_19.x;
  tmpvar_27.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_28;
  tmpvar_28.xy = (tmpvar_17.xy + tmpvar_27);
  tmpvar_28.z = tmpvar_17.z;
  highp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_ShadowMapTexture, tmpvar_28.xy);
  highp float tmpvar_30;
  if ((tmpvar_29.x < tmpvar_17.z)) {
    tmpvar_30 = 0.0;
  } else {
    tmpvar_30 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_30);
  highp vec2 tmpvar_31;
  tmpvar_31.y = 0.0;
  tmpvar_31.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_32;
  tmpvar_32.xy = (tmpvar_17.xy + tmpvar_31);
  tmpvar_32.z = tmpvar_17.z;
  highp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, tmpvar_32.xy);
  highp float tmpvar_34;
  if ((tmpvar_33.x < tmpvar_17.z)) {
    tmpvar_34 = 0.0;
  } else {
    tmpvar_34 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_17.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.y = 0.0;
  tmpvar_37.x = tmpvar_19.x;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_17.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_17.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_17.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_40);
  highp vec2 tmpvar_41;
  tmpvar_41.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_41.y = tmpvar_19.y;
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_17.xy + tmpvar_41);
  tmpvar_42.z = tmpvar_17.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_17.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_44);
  highp vec2 tmpvar_45;
  tmpvar_45.x = 0.0;
  tmpvar_45.y = tmpvar_19.y;
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_17.xy + tmpvar_45);
  tmpvar_46.z = tmpvar_17.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_17.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_48);
  highp vec3 tmpvar_49;
  tmpvar_49.xy = (tmpvar_17.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_49.z = tmpvar_17.z;
  highp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_ShadowMapTexture, tmpvar_49.xy);
  highp float tmpvar_51;
  if ((tmpvar_50.x < tmpvar_17.z)) {
    tmpvar_51 = 0.0;
  } else {
    tmpvar_51 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_51);
  shadow_18 = (shadow_18 / 9.0);
  mediump float tmpvar_52;
  tmpvar_52 = mix (_LightShadowData.x, 1.0, shadow_18);
  shadow_18 = tmpvar_52;
  highp float tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((
    sqrt(dot (tmpvar_54, tmpvar_54))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  tmpvar_53 = tmpvar_55;
  shadow_2 = (tmpvar_52 + tmpvar_53);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(shadow_2);
  tmpvar_1 = tmpvar_57;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  mediump float shadow_18;
  shadow_18 = 0.0;
  highp vec2 tmpvar_19;
  tmpvar_19 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_17.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_20.z = tmpvar_17.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  mediump float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_17.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_18 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23.x = 0.0;
  tmpvar_23.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_17.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_17.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_17.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_18 = (tmpvar_22 + tmpvar_26);
  highp vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_19.x;
  tmpvar_27.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_28;
  tmpvar_28.xy = (tmpvar_17.xy + tmpvar_27);
  tmpvar_28.z = tmpvar_17.z;
  highp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_ShadowMapTexture, tmpvar_28.xy);
  highp float tmpvar_30;
  if ((tmpvar_29.x < tmpvar_17.z)) {
    tmpvar_30 = 0.0;
  } else {
    tmpvar_30 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_30);
  highp vec2 tmpvar_31;
  tmpvar_31.y = 0.0;
  tmpvar_31.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_32;
  tmpvar_32.xy = (tmpvar_17.xy + tmpvar_31);
  tmpvar_32.z = tmpvar_17.z;
  highp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, tmpvar_32.xy);
  highp float tmpvar_34;
  if ((tmpvar_33.x < tmpvar_17.z)) {
    tmpvar_34 = 0.0;
  } else {
    tmpvar_34 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_17.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.y = 0.0;
  tmpvar_37.x = tmpvar_19.x;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_17.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_17.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_17.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_40);
  highp vec2 tmpvar_41;
  tmpvar_41.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_41.y = tmpvar_19.y;
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_17.xy + tmpvar_41);
  tmpvar_42.z = tmpvar_17.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_17.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_44);
  highp vec2 tmpvar_45;
  tmpvar_45.x = 0.0;
  tmpvar_45.y = tmpvar_19.y;
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_17.xy + tmpvar_45);
  tmpvar_46.z = tmpvar_17.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_17.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_48);
  highp vec3 tmpvar_49;
  tmpvar_49.xy = (tmpvar_17.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_49.z = tmpvar_17.z;
  highp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_ShadowMapTexture, tmpvar_49.xy);
  highp float tmpvar_51;
  if ((tmpvar_50.x < tmpvar_17.z)) {
    tmpvar_51 = 0.0;
  } else {
    tmpvar_51 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_51);
  shadow_18 = (shadow_18 / 9.0);
  mediump float tmpvar_52;
  tmpvar_52 = mix (_LightShadowData.x, 1.0, shadow_18);
  shadow_18 = tmpvar_52;
  highp float tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((
    sqrt(dot (tmpvar_54, tmpvar_54))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  tmpvar_53 = tmpvar_55;
  shadow_2 = (tmpvar_52 + tmpvar_53);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(shadow_2);
  tmpvar_1 = tmpvar_57;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  lowp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_8.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9.x = tmpvar_16.x;
  weights_9.yzw = clamp ((tmpvar_16.yzw - tmpvar_16.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((
    ((unity_WorldToShadow[0] * tmpvar_8).xyz * tmpvar_16.x)
   + 
    ((unity_WorldToShadow[1] * tmpvar_8).xyz * weights_9.y)
  ) + (
    (unity_WorldToShadow[2] * tmpvar_8)
  .xyz * weights_9.z)) + ((unity_WorldToShadow[3] * tmpvar_8).xyz * weights_9.w));
  mediump float shadow_18;
  shadow_18 = 0.0;
  highp vec2 tmpvar_19;
  tmpvar_19 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_17.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_20.z = tmpvar_17.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  mediump float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_17.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_18 = tmpvar_22;
  highp vec2 tmpvar_23;
  tmpvar_23.x = 0.0;
  tmpvar_23.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_17.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_17.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_17.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_18 = (tmpvar_22 + tmpvar_26);
  highp vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_19.x;
  tmpvar_27.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_28;
  tmpvar_28.xy = (tmpvar_17.xy + tmpvar_27);
  tmpvar_28.z = tmpvar_17.z;
  highp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_ShadowMapTexture, tmpvar_28.xy);
  highp float tmpvar_30;
  if ((tmpvar_29.x < tmpvar_17.z)) {
    tmpvar_30 = 0.0;
  } else {
    tmpvar_30 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_30);
  highp vec2 tmpvar_31;
  tmpvar_31.y = 0.0;
  tmpvar_31.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_32;
  tmpvar_32.xy = (tmpvar_17.xy + tmpvar_31);
  tmpvar_32.z = tmpvar_17.z;
  highp vec4 tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, tmpvar_32.xy);
  highp float tmpvar_34;
  if ((tmpvar_33.x < tmpvar_17.z)) {
    tmpvar_34 = 0.0;
  } else {
    tmpvar_34 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_17.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.y = 0.0;
  tmpvar_37.x = tmpvar_19.x;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_17.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_17.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_17.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_40);
  highp vec2 tmpvar_41;
  tmpvar_41.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_41.y = tmpvar_19.y;
  highp vec3 tmpvar_42;
  tmpvar_42.xy = (tmpvar_17.xy + tmpvar_41);
  tmpvar_42.z = tmpvar_17.z;
  highp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
  highp float tmpvar_44;
  if ((tmpvar_43.x < tmpvar_17.z)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_44);
  highp vec2 tmpvar_45;
  tmpvar_45.x = 0.0;
  tmpvar_45.y = tmpvar_19.y;
  highp vec3 tmpvar_46;
  tmpvar_46.xy = (tmpvar_17.xy + tmpvar_45);
  tmpvar_46.z = tmpvar_17.z;
  highp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
  highp float tmpvar_48;
  if ((tmpvar_47.x < tmpvar_17.z)) {
    tmpvar_48 = 0.0;
  } else {
    tmpvar_48 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_48);
  highp vec3 tmpvar_49;
  tmpvar_49.xy = (tmpvar_17.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_49.z = tmpvar_17.z;
  highp vec4 tmpvar_50;
  tmpvar_50 = texture2D (_ShadowMapTexture, tmpvar_49.xy);
  highp float tmpvar_51;
  if ((tmpvar_50.x < tmpvar_17.z)) {
    tmpvar_51 = 0.0;
  } else {
    tmpvar_51 = 1.0;
  };
  shadow_18 = (shadow_18 + tmpvar_51);
  shadow_18 = (shadow_18 / 9.0);
  mediump float tmpvar_52;
  tmpvar_52 = mix (_LightShadowData.x, 1.0, shadow_18);
  shadow_18 = tmpvar_52;
  highp float tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((
    sqrt(dot (tmpvar_54, tmpvar_54))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  tmpvar_53 = tmpvar_55;
  shadow_2 = (tmpvar_52 + tmpvar_53);
  mediump vec4 tmpvar_57;
  tmpvar_57 = vec4(shadow_2);
  tmpvar_1 = tmpvar_57;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  mediump float shadow_9;
  shadow_9 = 0.0;
  highp vec2 tmpvar_10;
  tmpvar_10 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_11;
  tmpvar_11.xy = (tmpvar_8.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_11.z = tmpvar_8.z;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  mediump float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_8.z)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_9 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = 0.0;
  tmpvar_14.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_8.xy + tmpvar_14);
  tmpvar_15.z = tmpvar_8.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  highp float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_8.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_9 = (tmpvar_13 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_10.x;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_8.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_8.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_8.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_8.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_8.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_8.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_8.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = tmpvar_10.x;
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_8.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_8.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_8.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_32.y = tmpvar_10.y;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_8.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_8.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_8.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = 0.0;
  tmpvar_36.y = tmpvar_10.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_8.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_8.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_8.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_39);
  highp vec3 tmpvar_40;
  tmpvar_40.xy = (tmpvar_8.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_40.z = tmpvar_8.z;
  highp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_ShadowMapTexture, tmpvar_40.xy);
  highp float tmpvar_42;
  if ((tmpvar_41.x < tmpvar_8.z)) {
    tmpvar_42 = 0.0;
  } else {
    tmpvar_42 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_42);
  shadow_9 = (shadow_9 / 9.0);
  mediump float tmpvar_43;
  tmpvar_43 = mix (_LightShadowData.x, 1.0, shadow_9);
  shadow_9 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_43 + tmpvar_44);
  mediump vec4 tmpvar_45;
  tmpvar_45 = vec4(shadow_2);
  tmpvar_1 = tmpvar_45;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  mediump float shadow_9;
  shadow_9 = 0.0;
  highp vec2 tmpvar_10;
  tmpvar_10 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_11;
  tmpvar_11.xy = (tmpvar_8.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_11.z = tmpvar_8.z;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  mediump float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_8.z)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_9 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = 0.0;
  tmpvar_14.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_8.xy + tmpvar_14);
  tmpvar_15.z = tmpvar_8.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  highp float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_8.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_9 = (tmpvar_13 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_10.x;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_8.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_8.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_8.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_8.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_8.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_8.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_8.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = tmpvar_10.x;
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_8.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_8.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_8.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_32.y = tmpvar_10.y;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_8.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_8.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_8.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = 0.0;
  tmpvar_36.y = tmpvar_10.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_8.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_8.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_8.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_39);
  highp vec3 tmpvar_40;
  tmpvar_40.xy = (tmpvar_8.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_40.z = tmpvar_8.z;
  highp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_ShadowMapTexture, tmpvar_40.xy);
  highp float tmpvar_42;
  if ((tmpvar_41.x < tmpvar_8.z)) {
    tmpvar_42 = 0.0;
  } else {
    tmpvar_42 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_42);
  shadow_9 = (shadow_9 / 9.0);
  mediump float tmpvar_43;
  tmpvar_43 = mix (_LightShadowData.x, 1.0, shadow_9);
  shadow_9 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_43 + tmpvar_44);
  mediump vec4 tmpvar_45;
  tmpvar_45 = vec4(shadow_2);
  tmpvar_1 = tmpvar_45;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_7)).xyz;
  mediump float shadow_9;
  shadow_9 = 0.0;
  highp vec2 tmpvar_10;
  tmpvar_10 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_11;
  tmpvar_11.xy = (tmpvar_8.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_11.z = tmpvar_8.z;
  highp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowMapTexture, tmpvar_11.xy);
  mediump float tmpvar_13;
  if ((tmpvar_12.x < tmpvar_8.z)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = 1.0;
  };
  shadow_9 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = 0.0;
  tmpvar_14.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_15;
  tmpvar_15.xy = (tmpvar_8.xy + tmpvar_14);
  tmpvar_15.z = tmpvar_8.z;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowMapTexture, tmpvar_15.xy);
  highp float tmpvar_17;
  if ((tmpvar_16.x < tmpvar_8.z)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = 1.0;
  };
  shadow_9 = (tmpvar_13 + tmpvar_17);
  highp vec2 tmpvar_18;
  tmpvar_18.x = tmpvar_10.x;
  tmpvar_18.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_19;
  tmpvar_19.xy = (tmpvar_8.xy + tmpvar_18);
  tmpvar_19.z = tmpvar_8.z;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_ShadowMapTexture, tmpvar_19.xy);
  highp float tmpvar_21;
  if ((tmpvar_20.x < tmpvar_8.z)) {
    tmpvar_21 = 0.0;
  } else {
    tmpvar_21 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_21);
  highp vec2 tmpvar_22;
  tmpvar_22.y = 0.0;
  tmpvar_22.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_23;
  tmpvar_23.xy = (tmpvar_8.xy + tmpvar_22);
  tmpvar_23.z = tmpvar_8.z;
  highp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_23.xy);
  highp float tmpvar_25;
  if ((tmpvar_24.x < tmpvar_8.z)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_25);
  highp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_8.xy);
  highp float tmpvar_27;
  if ((tmpvar_26.x < tmpvar_8.z)) {
    tmpvar_27 = 0.0;
  } else {
    tmpvar_27 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_27);
  highp vec2 tmpvar_28;
  tmpvar_28.y = 0.0;
  tmpvar_28.x = tmpvar_10.x;
  highp vec3 tmpvar_29;
  tmpvar_29.xy = (tmpvar_8.xy + tmpvar_28);
  tmpvar_29.z = tmpvar_8.z;
  highp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
  highp float tmpvar_31;
  if ((tmpvar_30.x < tmpvar_8.z)) {
    tmpvar_31 = 0.0;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_31);
  highp vec2 tmpvar_32;
  tmpvar_32.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_32.y = tmpvar_10.y;
  highp vec3 tmpvar_33;
  tmpvar_33.xy = (tmpvar_8.xy + tmpvar_32);
  tmpvar_33.z = tmpvar_8.z;
  highp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_ShadowMapTexture, tmpvar_33.xy);
  highp float tmpvar_35;
  if ((tmpvar_34.x < tmpvar_8.z)) {
    tmpvar_35 = 0.0;
  } else {
    tmpvar_35 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_35);
  highp vec2 tmpvar_36;
  tmpvar_36.x = 0.0;
  tmpvar_36.y = tmpvar_10.y;
  highp vec3 tmpvar_37;
  tmpvar_37.xy = (tmpvar_8.xy + tmpvar_36);
  tmpvar_37.z = tmpvar_8.z;
  highp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_ShadowMapTexture, tmpvar_37.xy);
  highp float tmpvar_39;
  if ((tmpvar_38.x < tmpvar_8.z)) {
    tmpvar_39 = 0.0;
  } else {
    tmpvar_39 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_39);
  highp vec3 tmpvar_40;
  tmpvar_40.xy = (tmpvar_8.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_40.z = tmpvar_8.z;
  highp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_ShadowMapTexture, tmpvar_40.xy);
  highp float tmpvar_42;
  if ((tmpvar_41.x < tmpvar_8.z)) {
    tmpvar_42 = 0.0;
  } else {
    tmpvar_42 = 1.0;
  };
  shadow_9 = (shadow_9 + tmpvar_42);
  shadow_9 = (shadow_9 / 9.0);
  mediump float tmpvar_43;
  tmpvar_43 = mix (_LightShadowData.x, 1.0, shadow_9);
  shadow_9 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((camPos_3.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  shadow_2 = (tmpvar_43 + tmpvar_44);
  mediump vec4 tmpvar_45;
  tmpvar_45 = vec4(shadow_2);
  tmpvar_1 = tmpvar_45;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  mediump float shadow_10;
  shadow_10 = 0.0;
  highp vec2 tmpvar_11;
  tmpvar_11 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.xy = (tmpvar_9.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_12.z = tmpvar_9.z;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_9.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  shadow_10 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15.x = 0.0;
  tmpvar_15.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_16;
  tmpvar_16.xy = (tmpvar_9.xy + tmpvar_15);
  tmpvar_16.z = tmpvar_9.z;
  highp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_ShadowMapTexture, tmpvar_16.xy);
  highp float tmpvar_18;
  if ((tmpvar_17.x < tmpvar_9.z)) {
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_10 = (tmpvar_14 + tmpvar_18);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_11.x;
  tmpvar_19.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_9.xy + tmpvar_19);
  tmpvar_20.z = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  highp float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_9.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_9.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_9.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_9.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_26);
  highp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  highp float tmpvar_28;
  if ((tmpvar_27.x < tmpvar_9.z)) {
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_28);
  highp vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_11.x;
  highp vec3 tmpvar_30;
  tmpvar_30.xy = (tmpvar_9.xy + tmpvar_29);
  tmpvar_30.z = tmpvar_9.z;
  highp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_ShadowMapTexture, tmpvar_30.xy);
  highp float tmpvar_32;
  if ((tmpvar_31.x < tmpvar_9.z)) {
    tmpvar_32 = 0.0;
  } else {
    tmpvar_32 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_32);
  highp vec2 tmpvar_33;
  tmpvar_33.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_33.y = tmpvar_11.y;
  highp vec3 tmpvar_34;
  tmpvar_34.xy = (tmpvar_9.xy + tmpvar_33);
  tmpvar_34.z = tmpvar_9.z;
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_34.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_9.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.x = 0.0;
  tmpvar_37.y = tmpvar_11.y;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_9.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_9.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_9.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_40);
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_9.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_41.z = tmpvar_9.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_9.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_43);
  shadow_10 = (shadow_10 / 9.0);
  mediump float tmpvar_44;
  tmpvar_44 = mix (_LightShadowData.x, 1.0, shadow_10);
  shadow_10 = tmpvar_44;
  highp float tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    sqrt(dot (tmpvar_46, tmpvar_46))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  tmpvar_45 = tmpvar_47;
  shadow_2 = (tmpvar_44 + tmpvar_45);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  mediump float shadow_10;
  shadow_10 = 0.0;
  highp vec2 tmpvar_11;
  tmpvar_11 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.xy = (tmpvar_9.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_12.z = tmpvar_9.z;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_9.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  shadow_10 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15.x = 0.0;
  tmpvar_15.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_16;
  tmpvar_16.xy = (tmpvar_9.xy + tmpvar_15);
  tmpvar_16.z = tmpvar_9.z;
  highp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_ShadowMapTexture, tmpvar_16.xy);
  highp float tmpvar_18;
  if ((tmpvar_17.x < tmpvar_9.z)) {
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_10 = (tmpvar_14 + tmpvar_18);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_11.x;
  tmpvar_19.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_9.xy + tmpvar_19);
  tmpvar_20.z = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  highp float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_9.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_9.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_9.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_9.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_26);
  highp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  highp float tmpvar_28;
  if ((tmpvar_27.x < tmpvar_9.z)) {
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_28);
  highp vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_11.x;
  highp vec3 tmpvar_30;
  tmpvar_30.xy = (tmpvar_9.xy + tmpvar_29);
  tmpvar_30.z = tmpvar_9.z;
  highp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_ShadowMapTexture, tmpvar_30.xy);
  highp float tmpvar_32;
  if ((tmpvar_31.x < tmpvar_9.z)) {
    tmpvar_32 = 0.0;
  } else {
    tmpvar_32 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_32);
  highp vec2 tmpvar_33;
  tmpvar_33.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_33.y = tmpvar_11.y;
  highp vec3 tmpvar_34;
  tmpvar_34.xy = (tmpvar_9.xy + tmpvar_33);
  tmpvar_34.z = tmpvar_9.z;
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_34.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_9.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.x = 0.0;
  tmpvar_37.y = tmpvar_11.y;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_9.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_9.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_9.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_40);
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_9.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_41.z = tmpvar_9.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_9.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_43);
  shadow_10 = (shadow_10 / 9.0);
  mediump float tmpvar_44;
  tmpvar_44 = mix (_LightShadowData.x, 1.0, shadow_10);
  shadow_10 = tmpvar_44;
  highp float tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    sqrt(dot (tmpvar_46, tmpvar_46))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  tmpvar_45 = tmpvar_47;
  shadow_2 = (tmpvar_44 + tmpvar_45);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
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
varying highp vec4 xlv_TEXCOORD0;
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
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  clipPos_3.xzw = tmpvar_5.xzw;
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4.zw = o_7.xy;
  clipPos_3.y = (tmpvar_5.y * _ProjectionParams.x);
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(-1.0, 1.0);
  tmpvar_10.xy = clipPos_3.xy;
  highp vec3 tmpvar_11;
  tmpvar_11 = (unity_CameraInvProjection * tmpvar_10).xyz;
  orthoPosNear_2.xy = tmpvar_11.xy;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(1.0, 1.0);
  tmpvar_12.xy = clipPos_3.xy;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_CameraInvProjection * tmpvar_12).xyz;
  orthoPosFar_1.xy = tmpvar_13.xy;
  orthoPosNear_2.z = -(tmpvar_11.z);
  orthoPosFar_1.z = -(tmpvar_13.z);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = _glesNormal;
  xlv_TEXCOORD2 = orthoPosNear_2;
  xlv_TEXCOORD3 = orthoPosFar_1;
  gl_Position = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_CameraInvProjection;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_WorldToShadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp sampler2D _CameraDepthTexture;
uniform highp sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowMapTexture_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float shadow_2;
  highp vec4 camPos_3;
  highp vec4 clipPos_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = xlv_TEXCOORD0.zw;
  tmpvar_5.z = texture2D (_CameraDepthTexture, xlv_TEXCOORD0.xy).x;
  clipPos_4.w = tmpvar_5.w;
  clipPos_4.xyz = ((2.0 * tmpvar_5.xyz) - 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_CameraInvProjection * clipPos_4);
  camPos_3.w = tmpvar_6.w;
  camPos_3.xyz = (tmpvar_6.xyz / tmpvar_6.w);
  camPos_3.z = -(camPos_3.z);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = camPos_3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_CameraToWorld * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = (unity_WorldToShadow[0] * tmpvar_8).xyz;
  mediump float shadow_10;
  shadow_10 = 0.0;
  highp vec2 tmpvar_11;
  tmpvar_11 = _ShadowMapTexture_TexelSize.xy;
  highp vec3 tmpvar_12;
  tmpvar_12.xy = (tmpvar_9.xy - _ShadowMapTexture_TexelSize.xy);
  tmpvar_12.z = tmpvar_9.z;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ShadowMapTexture, tmpvar_12.xy);
  mediump float tmpvar_14;
  if ((tmpvar_13.x < tmpvar_9.z)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  shadow_10 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15.x = 0.0;
  tmpvar_15.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_16;
  tmpvar_16.xy = (tmpvar_9.xy + tmpvar_15);
  tmpvar_16.z = tmpvar_9.z;
  highp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_ShadowMapTexture, tmpvar_16.xy);
  highp float tmpvar_18;
  if ((tmpvar_17.x < tmpvar_9.z)) {
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_10 = (tmpvar_14 + tmpvar_18);
  highp vec2 tmpvar_19;
  tmpvar_19.x = tmpvar_11.x;
  tmpvar_19.y = -(_ShadowMapTexture_TexelSize.y);
  highp vec3 tmpvar_20;
  tmpvar_20.xy = (tmpvar_9.xy + tmpvar_19);
  tmpvar_20.z = tmpvar_9.z;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_ShadowMapTexture, tmpvar_20.xy);
  highp float tmpvar_22;
  if ((tmpvar_21.x < tmpvar_9.z)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23.y = 0.0;
  tmpvar_23.x = -(_ShadowMapTexture_TexelSize.x);
  highp vec3 tmpvar_24;
  tmpvar_24.xy = (tmpvar_9.xy + tmpvar_23);
  tmpvar_24.z = tmpvar_9.z;
  highp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_ShadowMapTexture, tmpvar_24.xy);
  highp float tmpvar_26;
  if ((tmpvar_25.x < tmpvar_9.z)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_26);
  highp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
  highp float tmpvar_28;
  if ((tmpvar_27.x < tmpvar_9.z)) {
    tmpvar_28 = 0.0;
  } else {
    tmpvar_28 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_28);
  highp vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_11.x;
  highp vec3 tmpvar_30;
  tmpvar_30.xy = (tmpvar_9.xy + tmpvar_29);
  tmpvar_30.z = tmpvar_9.z;
  highp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_ShadowMapTexture, tmpvar_30.xy);
  highp float tmpvar_32;
  if ((tmpvar_31.x < tmpvar_9.z)) {
    tmpvar_32 = 0.0;
  } else {
    tmpvar_32 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_32);
  highp vec2 tmpvar_33;
  tmpvar_33.x = -(_ShadowMapTexture_TexelSize.x);
  tmpvar_33.y = tmpvar_11.y;
  highp vec3 tmpvar_34;
  tmpvar_34.xy = (tmpvar_9.xy + tmpvar_33);
  tmpvar_34.z = tmpvar_9.z;
  highp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, tmpvar_34.xy);
  highp float tmpvar_36;
  if ((tmpvar_35.x < tmpvar_9.z)) {
    tmpvar_36 = 0.0;
  } else {
    tmpvar_36 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_36);
  highp vec2 tmpvar_37;
  tmpvar_37.x = 0.0;
  tmpvar_37.y = tmpvar_11.y;
  highp vec3 tmpvar_38;
  tmpvar_38.xy = (tmpvar_9.xy + tmpvar_37);
  tmpvar_38.z = tmpvar_9.z;
  highp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
  highp float tmpvar_40;
  if ((tmpvar_39.x < tmpvar_9.z)) {
    tmpvar_40 = 0.0;
  } else {
    tmpvar_40 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_40);
  highp vec3 tmpvar_41;
  tmpvar_41.xy = (tmpvar_9.xy + _ShadowMapTexture_TexelSize.xy);
  tmpvar_41.z = tmpvar_9.z;
  highp vec4 tmpvar_42;
  tmpvar_42 = texture2D (_ShadowMapTexture, tmpvar_41.xy);
  highp float tmpvar_43;
  if ((tmpvar_42.x < tmpvar_9.z)) {
    tmpvar_43 = 0.0;
  } else {
    tmpvar_43 = 1.0;
  };
  shadow_10 = (shadow_10 + tmpvar_43);
  shadow_10 = (shadow_10 / 9.0);
  mediump float tmpvar_44;
  tmpvar_44 = mix (_LightShadowData.x, 1.0, shadow_10);
  shadow_10 = tmpvar_44;
  highp float tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (tmpvar_8.xyz - unity_ShadowFadeCenterAndType.xyz);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((
    sqrt(dot (tmpvar_46, tmpvar_46))
   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  tmpvar_45 = tmpvar_47;
  shadow_2 = (tmpvar_44 + tmpvar_45);
  mediump vec4 tmpvar_49;
  tmpvar_49 = vec4(shadow_2);
  tmpvar_1 = tmpvar_49;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
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
}
}
}
}