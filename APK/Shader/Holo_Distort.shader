//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Distort" {
Properties {
_Color ("    Color", Color) = (1,1,1,1)
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 400
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 GrabPass {
}
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 14490
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_3 * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_12;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_3 * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_12;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_3 * tmpvar_10));
  worldNormal_1 = tmpvar_11;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_12;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
SubProgram "gles " {
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
CustomEditor "CustomMaterialInspector"
}