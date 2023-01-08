//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-DepthNormalsTexture" {
Properties {
_MainTex ("", 2D) = "white" { }
_Cutoff ("", Float) = 0.5
_Color ("", Color) = (1,1,1,1)
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 14949
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
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
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles " {
""
}
}
}
}
SubShader {
 Tags { "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "RenderType" = "TransparentCutout" }
  ZClip Off
  GpuProgramID 108096
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * _Color.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * _Color.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_4[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_4[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_4 * _glesNormal));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_5).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * _Color.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
}
}
}
SubShader {
 Tags { "RenderType" = "TreeBark" }
 Pass {
  Tags { "RenderType" = "TreeBark" }
  ZClip Off
  GpuProgramID 191435
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = _glesVertex.w;
  tmpvar_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.xy = tmpvar_1.xy;
  tmpvar_4.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_5;
  pos_5.w = tmpvar_3.w;
  highp vec3 bend_6;
  highp float tmpvar_7;
  tmpvar_7 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_4.x);
  highp vec2 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_3.xyz, vec3((tmpvar_4.y + tmpvar_7)));
  tmpvar_8.y = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_8).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_10;
  tmpvar_10 = ((tmpvar_9 * tmpvar_9) * (3.0 - (2.0 * tmpvar_9)));
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz + tmpvar_10.yw);
  bend_6.xz = ((tmpvar_4.y * 0.1) * _glesNormal).xz;
  bend_6.y = (_glesMultiTexCoord1.y * 0.3);
  pos_5.xyz = (tmpvar_3.xyz + ((
    (tmpvar_11.xyx * bend_6)
   + 
    ((_Wind.xyz * tmpvar_11.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_5.xyz = (pos_5.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = mix ((pos_5.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_5.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_5.xyz, vec3(_SquashAmount));
  tmpvar_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_14[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_14[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_14 * normalize(_glesNormal)));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_12.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_15).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = _glesVertex.w;
  tmpvar_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.xy = tmpvar_1.xy;
  tmpvar_4.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_5;
  pos_5.w = tmpvar_3.w;
  highp vec3 bend_6;
  highp float tmpvar_7;
  tmpvar_7 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_4.x);
  highp vec2 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_3.xyz, vec3((tmpvar_4.y + tmpvar_7)));
  tmpvar_8.y = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_8).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_10;
  tmpvar_10 = ((tmpvar_9 * tmpvar_9) * (3.0 - (2.0 * tmpvar_9)));
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz + tmpvar_10.yw);
  bend_6.xz = ((tmpvar_4.y * 0.1) * _glesNormal).xz;
  bend_6.y = (_glesMultiTexCoord1.y * 0.3);
  pos_5.xyz = (tmpvar_3.xyz + ((
    (tmpvar_11.xyx * bend_6)
   + 
    ((_Wind.xyz * tmpvar_11.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_5.xyz = (pos_5.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = mix ((pos_5.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_5.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_5.xyz, vec3(_SquashAmount));
  tmpvar_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_14[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_14[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_14 * normalize(_glesNormal)));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_12.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_15).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = _glesVertex.w;
  tmpvar_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.xy = tmpvar_1.xy;
  tmpvar_4.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_5;
  pos_5.w = tmpvar_3.w;
  highp vec3 bend_6;
  highp float tmpvar_7;
  tmpvar_7 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_4.x);
  highp vec2 tmpvar_8;
  tmpvar_8.x = dot (tmpvar_3.xyz, vec3((tmpvar_4.y + tmpvar_7)));
  tmpvar_8.y = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_8).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_10;
  tmpvar_10 = ((tmpvar_9 * tmpvar_9) * (3.0 - (2.0 * tmpvar_9)));
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz + tmpvar_10.yw);
  bend_6.xz = ((tmpvar_4.y * 0.1) * _glesNormal).xz;
  bend_6.y = (_glesMultiTexCoord1.y * 0.3);
  pos_5.xyz = (tmpvar_3.xyz + ((
    (tmpvar_11.xyx * bend_6)
   + 
    ((_Wind.xyz * tmpvar_11.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_5.xyz = (pos_5.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = mix ((pos_5.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_5.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_5.xyz, vec3(_SquashAmount));
  tmpvar_3 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_12.xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_14[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_14[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_14 * normalize(_glesNormal)));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_12.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_15).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
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
}
}
}
SubShader {
 Tags { "RenderType" = "TreeLeaf" }
 Pass {
  Tags { "RenderType" = "TreeLeaf" }
  ZClip Off
  GpuProgramID 203420
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 pos_5;
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - abs(_glesTANGENT.w));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = tmpvar_1.xy;
  pos_5 = (_glesVertex + ((tmpvar_8 * glstate_matrix_invtrans_modelview0) * tmpvar_6));
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_glesNormal, normalize((tmpvar_7 * glstate_matrix_invtrans_modelview0)).xyz, vec3(tmpvar_6));
  tmpvar_4.w = pos_5.w;
  tmpvar_4.xyz = (pos_5.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_2.xy;
  tmpvar_10.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_11;
  pos_11.w = tmpvar_4.w;
  highp vec3 bend_12;
  highp float tmpvar_13;
  tmpvar_13 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_10.x);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_4.xyz, vec3((tmpvar_10.y + tmpvar_13)));
  tmpvar_14.y = tmpvar_13;
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_16;
  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
  highp vec2 tmpvar_17;
  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
  bend_12.xz = ((tmpvar_10.y * 0.1) * tmpvar_9).xz;
  bend_12.y = (_glesMultiTexCoord1.y * 0.3);
  pos_11.xyz = (tmpvar_4.xyz + ((
    (tmpvar_17.xyx * bend_12)
   + 
    ((_Wind.xyz * tmpvar_17.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_11.xyz = (pos_11.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = mix ((pos_11.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_11.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_11.xyz, vec3(_SquashAmount));
  tmpvar_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_20 * normalize(tmpvar_9)));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_18.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 pos_5;
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - abs(_glesTANGENT.w));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = tmpvar_1.xy;
  pos_5 = (_glesVertex + ((tmpvar_8 * glstate_matrix_invtrans_modelview0) * tmpvar_6));
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_glesNormal, normalize((tmpvar_7 * glstate_matrix_invtrans_modelview0)).xyz, vec3(tmpvar_6));
  tmpvar_4.w = pos_5.w;
  tmpvar_4.xyz = (pos_5.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_2.xy;
  tmpvar_10.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_11;
  pos_11.w = tmpvar_4.w;
  highp vec3 bend_12;
  highp float tmpvar_13;
  tmpvar_13 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_10.x);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_4.xyz, vec3((tmpvar_10.y + tmpvar_13)));
  tmpvar_14.y = tmpvar_13;
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_16;
  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
  highp vec2 tmpvar_17;
  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
  bend_12.xz = ((tmpvar_10.y * 0.1) * tmpvar_9).xz;
  bend_12.y = (_glesMultiTexCoord1.y * 0.3);
  pos_11.xyz = (tmpvar_4.xyz + ((
    (tmpvar_17.xyx * bend_12)
   + 
    ((_Wind.xyz * tmpvar_17.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_11.xyz = (pos_11.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = mix ((pos_11.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_11.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_11.xyz, vec3(_SquashAmount));
  tmpvar_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_20 * normalize(tmpvar_9)));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_18.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp vec4 _TreeInstanceScale;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec4 _Wind;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 pos_5;
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - abs(_glesTANGENT.w));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = tmpvar_1.xy;
  pos_5 = (_glesVertex + ((tmpvar_8 * glstate_matrix_invtrans_modelview0) * tmpvar_6));
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_glesNormal, normalize((tmpvar_7 * glstate_matrix_invtrans_modelview0)).xyz, vec3(tmpvar_6));
  tmpvar_4.w = pos_5.w;
  tmpvar_4.xyz = (pos_5.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_10;
  tmpvar_10.xy = tmpvar_2.xy;
  tmpvar_10.zw = _glesMultiTexCoord1.xy;
  highp vec4 pos_11;
  pos_11.w = tmpvar_4.w;
  highp vec3 bend_12;
  highp float tmpvar_13;
  tmpvar_13 = (dot (unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0)) + tmpvar_10.x);
  highp vec2 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_4.xyz, vec3((tmpvar_10.y + tmpvar_13)));
  tmpvar_14.y = tmpvar_13;
  highp vec4 tmpvar_15;
  tmpvar_15 = abs(((
    fract((((
      fract(((_Time.yy + tmpvar_14).xxyy * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec4 tmpvar_16;
  tmpvar_16 = ((tmpvar_15 * tmpvar_15) * (3.0 - (2.0 * tmpvar_15)));
  highp vec2 tmpvar_17;
  tmpvar_17 = (tmpvar_16.xz + tmpvar_16.yw);
  bend_12.xz = ((tmpvar_10.y * 0.1) * tmpvar_9).xz;
  bend_12.y = (_glesMultiTexCoord1.y * 0.3);
  pos_11.xyz = (tmpvar_4.xyz + ((
    (tmpvar_17.xyx * bend_12)
   + 
    ((_Wind.xyz * tmpvar_17.y) * _glesMultiTexCoord1.y)
  ) * _Wind.w));
  pos_11.xyz = (pos_11.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = mix ((pos_11.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_11.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_11.xyz, vec3(_SquashAmount));
  tmpvar_4 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_18.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_20 * normalize(tmpvar_9)));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_18.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
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
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
SubShader {
 Tags { "DisableBatching" = "true" "RenderType" = "TreeOpaque" }
 Pass {
  Tags { "DisableBatching" = "true" "RenderType" = "TreeOpaque" }
  ZClip Off
  GpuProgramID 325870
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec2 enc_3;
  enc_3 = (xlv_TEXCOORD0.xy / (xlv_TEXCOORD0.z + 1.0));
  enc_3 = (enc_3 / 1.7777);
  enc_3 = ((enc_3 * 0.5) + 0.5);
  enc_2.xy = enc_3;
  highp vec2 enc_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD0.w));
  enc_4.y = tmpvar_5.y;
  enc_4.x = (tmpvar_5.x - (tmpvar_5.y * 0.003921569));
  enc_2.zw = enc_4;
  tmpvar_1 = enc_2;
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
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
SubShader {
 Tags { "DisableBatching" = "true" "RenderType" = "TreeTransparentCutout" }
 Pass {
  Tags { "DisableBatching" = "true" "RenderType" = "TreeTransparentCutout" }
  ZClip Off
  GpuProgramID 370694
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = normalize((tmpvar_8 * _glesNormal));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - _Cutoff);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp vec4 enc_5;
  highp vec2 enc_6;
  enc_6 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_6 = (enc_6 / 1.7777);
  enc_6 = ((enc_6 * 0.5) + 0.5);
  enc_5.xy = enc_6;
  highp vec2 enc_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_7.y = tmpvar_8.y;
  enc_7.x = (tmpvar_8.x - (tmpvar_8.y * 0.003921569));
  enc_5.zw = enc_7;
  tmpvar_1 = enc_5;
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
}
}
 Pass {
  Tags { "DisableBatching" = "true" "RenderType" = "TreeTransparentCutout" }
  ZClip Off
  Cull Front
  GpuProgramID 443367
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = -(normalize((tmpvar_8 * _glesNormal)));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = -(normalize((tmpvar_8 * _glesNormal)));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp vec4 _TreeInstanceScale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 pos_3;
  pos_3.w = _glesVertex.w;
  highp float alpha_4;
  alpha_4 = tmpvar_1.w;
  pos_3.xyz = (_glesVertex.xyz * _TreeInstanceScale.xyz);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = pos_3.xyz;
  pos_3.xyz = mix (pos_3.xyz, (_TerrainEngineBendTree * tmpvar_5).xyz, vec3(alpha_4));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = mix ((pos_3.xyz - (
    (dot (_SquashPlaneNormal.xyz, pos_3.xyz) + _SquashPlaneNormal.w)
   * _SquashPlaneNormal.xyz)), pos_3.xyz, vec3(_SquashAmount));
  pos_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_8[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_8[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_2.xyz = -(normalize((tmpvar_8 * _glesNormal)));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_6.xyz;
  tmpvar_2.w = -(((glstate_matrix_modelview0 * tmpvar_9).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
SubShader {
 Tags { "RenderType" = "TreeBillboard" }
 Pass {
  Tags { "RenderType" = "TreeBillboard" }
  ZClip Off
  Cull Off
  GpuProgramID 511096
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesMultiTexCoord1.xy;
  highp float offsetz_6;
  offsetz_6 = tmpvar_1.y;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_glesVertex.xyz - _TreeBillboardCameraPos.xyz);
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, tmpvar_7);
  if ((tmpvar_8 > _TreeBillboardDistances.x)) {
    offsetz_6 = 0.0;
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (_TreeBillboardCameraRight * offset_5.x));
  pos_4.xyz = (pos_4.xyz + (_TreeBillboardCameraUp.xyz * mix (offset_5.y, offsetz_6, _TreeBillboardCameraPos.w)));
  pos_4.xyz = (pos_4.xyz + ((_TreeBillboardCameraFront.xyz * 
    abs(offset_5.x)
  ) * _TreeBillboardCameraUp.w));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = pos_4.xyz;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_2.y = float((_glesMultiTexCoord0.y > 0.0));
  tmpvar_3.xyz = vec3(0.0, 0.0, 1.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = pos_4.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_10).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesMultiTexCoord1.xy;
  highp float offsetz_6;
  offsetz_6 = tmpvar_1.y;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_glesVertex.xyz - _TreeBillboardCameraPos.xyz);
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, tmpvar_7);
  if ((tmpvar_8 > _TreeBillboardDistances.x)) {
    offsetz_6 = 0.0;
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (_TreeBillboardCameraRight * offset_5.x));
  pos_4.xyz = (pos_4.xyz + (_TreeBillboardCameraUp.xyz * mix (offset_5.y, offsetz_6, _TreeBillboardCameraPos.w)));
  pos_4.xyz = (pos_4.xyz + ((_TreeBillboardCameraFront.xyz * 
    abs(offset_5.x)
  ) * _TreeBillboardCameraUp.w));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = pos_4.xyz;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_2.y = float((_glesMultiTexCoord0.y > 0.0));
  tmpvar_3.xyz = vec3(0.0, 0.0, 1.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = pos_4.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_10).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesMultiTexCoord1.xy;
  highp float offsetz_6;
  offsetz_6 = tmpvar_1.y;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_glesVertex.xyz - _TreeBillboardCameraPos.xyz);
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_7, tmpvar_7);
  if ((tmpvar_8 > _TreeBillboardDistances.x)) {
    offsetz_6 = 0.0;
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (_TreeBillboardCameraRight * offset_5.x));
  pos_4.xyz = (pos_4.xyz + (_TreeBillboardCameraUp.xyz * mix (offset_5.y, offsetz_6, _TreeBillboardCameraPos.w)));
  pos_4.xyz = (pos_4.xyz + ((_TreeBillboardCameraFront.xyz * 
    abs(offset_5.x)
  ) * _TreeBillboardCameraUp.w));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = pos_4.xyz;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_2.y = float((_glesMultiTexCoord0.y > 0.0));
  tmpvar_3.xyz = vec3(0.0, 0.0, 1.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = pos_4.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_10).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_9);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.001);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles " {
""
}
}
}
}
SubShader {
 Tags { "RenderType" = "GrassBillboard" }
 Pass {
  Tags { "RenderType" = "GrassBillboard" }
  ZClip Off
  Cull Off
  GpuProgramID 566126
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesTANGENT.xy;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_glesVertex.xyz - _CameraPosition.xyz);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  if ((tmpvar_7 > _WaveAndDistance.w)) {
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (offset_5.x * _CameraRight));
  pos_4.xyz = (pos_4.xyz + (offset_5.y * _CameraUp));
  highp vec4 vertex_8;
  vertex_8.yw = pos_4.yw;
  lowp vec4 color_9;
  color_9.xyz = tmpvar_2.xyz;
  lowp vec3 waveColor_10;
  highp vec3 waveMove_11;
  highp vec4 s_12;
  highp vec4 waves_13;
  waves_13 = (pos_4.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_13 = (waves_13 + (pos_4.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_13 = (waves_13 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_14;
  tmpvar_14 = fract(waves_13);
  waves_13 = tmpvar_14;
  highp vec4 val_15;
  highp vec4 s_16;
  val_15 = ((tmpvar_14 * 6.408849) - 3.141593);
  highp vec4 tmpvar_17;
  tmpvar_17 = (val_15 * val_15);
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * val_15);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_17);
  s_16 = (((val_15 + 
    (tmpvar_18 * -0.1616162)
  ) + (tmpvar_19 * 0.0083333)) + ((tmpvar_19 * tmpvar_17) * -0.00019841));
  s_12 = (s_16 * s_16);
  s_12 = (s_12 * s_12);
  highp float tmpvar_20;
  tmpvar_20 = (dot (s_12, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_12 = (s_12 * _glesTANGENT.y);
  waveMove_11.y = 0.0;
  waveMove_11.x = dot (s_12, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_11.z = dot (s_12, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_8.xz = (pos_4.xz - (waveMove_11.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_20));
  waveColor_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (vertex_8.xyz - _CameraPosition.xyz);
  highp float tmpvar_23;
  tmpvar_23 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_22, tmpvar_22))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_9.w = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = ((2.0 * waveColor_10) * _glesColor.xyz);
  tmpvar_24.w = color_9.w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = vertex_8.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_26 * _glesNormal));
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_8.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_27).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_COLOR = tmpvar_24;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesTANGENT.xy;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_glesVertex.xyz - _CameraPosition.xyz);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  if ((tmpvar_7 > _WaveAndDistance.w)) {
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (offset_5.x * _CameraRight));
  pos_4.xyz = (pos_4.xyz + (offset_5.y * _CameraUp));
  highp vec4 vertex_8;
  vertex_8.yw = pos_4.yw;
  lowp vec4 color_9;
  color_9.xyz = tmpvar_2.xyz;
  lowp vec3 waveColor_10;
  highp vec3 waveMove_11;
  highp vec4 s_12;
  highp vec4 waves_13;
  waves_13 = (pos_4.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_13 = (waves_13 + (pos_4.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_13 = (waves_13 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_14;
  tmpvar_14 = fract(waves_13);
  waves_13 = tmpvar_14;
  highp vec4 val_15;
  highp vec4 s_16;
  val_15 = ((tmpvar_14 * 6.408849) - 3.141593);
  highp vec4 tmpvar_17;
  tmpvar_17 = (val_15 * val_15);
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * val_15);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_17);
  s_16 = (((val_15 + 
    (tmpvar_18 * -0.1616162)
  ) + (tmpvar_19 * 0.0083333)) + ((tmpvar_19 * tmpvar_17) * -0.00019841));
  s_12 = (s_16 * s_16);
  s_12 = (s_12 * s_12);
  highp float tmpvar_20;
  tmpvar_20 = (dot (s_12, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_12 = (s_12 * _glesTANGENT.y);
  waveMove_11.y = 0.0;
  waveMove_11.x = dot (s_12, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_11.z = dot (s_12, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_8.xz = (pos_4.xz - (waveMove_11.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_20));
  waveColor_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (vertex_8.xyz - _CameraPosition.xyz);
  highp float tmpvar_23;
  tmpvar_23 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_22, tmpvar_22))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_9.w = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = ((2.0 * waveColor_10) * _glesColor.xyz);
  tmpvar_24.w = color_9.w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = vertex_8.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_26 * _glesNormal));
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_8.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_27).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_COLOR = tmpvar_24;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 pos_4;
  pos_4 = _glesVertex;
  highp vec2 offset_5;
  offset_5 = _glesTANGENT.xy;
  highp vec3 tmpvar_6;
  tmpvar_6 = (_glesVertex.xyz - _CameraPosition.xyz);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_6, tmpvar_6);
  if ((tmpvar_7 > _WaveAndDistance.w)) {
    offset_5 = vec2(0.0, 0.0);
  };
  pos_4.xyz = (_glesVertex.xyz + (offset_5.x * _CameraRight));
  pos_4.xyz = (pos_4.xyz + (offset_5.y * _CameraUp));
  highp vec4 vertex_8;
  vertex_8.yw = pos_4.yw;
  lowp vec4 color_9;
  color_9.xyz = tmpvar_2.xyz;
  lowp vec3 waveColor_10;
  highp vec3 waveMove_11;
  highp vec4 s_12;
  highp vec4 waves_13;
  waves_13 = (pos_4.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_13 = (waves_13 + (pos_4.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_13 = (waves_13 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_14;
  tmpvar_14 = fract(waves_13);
  waves_13 = tmpvar_14;
  highp vec4 val_15;
  highp vec4 s_16;
  val_15 = ((tmpvar_14 * 6.408849) - 3.141593);
  highp vec4 tmpvar_17;
  tmpvar_17 = (val_15 * val_15);
  highp vec4 tmpvar_18;
  tmpvar_18 = (tmpvar_17 * val_15);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * tmpvar_17);
  s_16 = (((val_15 + 
    (tmpvar_18 * -0.1616162)
  ) + (tmpvar_19 * 0.0083333)) + ((tmpvar_19 * tmpvar_17) * -0.00019841));
  s_12 = (s_16 * s_16);
  s_12 = (s_12 * s_12);
  highp float tmpvar_20;
  tmpvar_20 = (dot (s_12, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_12 = (s_12 * _glesTANGENT.y);
  waveMove_11.y = 0.0;
  waveMove_11.x = dot (s_12, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_11.z = dot (s_12, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_8.xz = (pos_4.xz - (waveMove_11.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_20));
  waveColor_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (vertex_8.xyz - _CameraPosition.xyz);
  highp float tmpvar_23;
  tmpvar_23 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_22, tmpvar_22))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_9.w = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = ((2.0 * waveColor_10) * _glesColor.xyz);
  tmpvar_24.w = color_9.w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = vertex_8.xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_3.xyz = normalize((tmpvar_26 * _glesNormal));
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_8.xyz;
  tmpvar_3.w = -(((glstate_matrix_modelview0 * tmpvar_27).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_COLOR = tmpvar_24;
  xlv_TEXCOORD0 = tmpvar_1.xy;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
}
}
}
SubShader {
 Tags { "RenderType" = "Grass" }
 Pass {
  Tags { "RenderType" = "Grass" }
  ZClip Off
  Cull Off
  GpuProgramID 606273
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 vertex_2;
  vertex_2.yw = _glesVertex.yw;
  lowp vec4 color_3;
  color_3.xyz = _glesColor.xyz;
  lowp vec3 waveColor_4;
  highp vec3 waveMove_5;
  highp vec4 s_6;
  highp vec4 waves_7;
  waves_7 = (_glesVertex.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_7 = (waves_7 + (_glesVertex.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_7 = (waves_7 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_8;
  tmpvar_8 = fract(waves_7);
  waves_7 = tmpvar_8;
  highp vec4 val_9;
  highp vec4 s_10;
  val_9 = ((tmpvar_8 * 6.408849) - 3.141593);
  highp vec4 tmpvar_11;
  tmpvar_11 = (val_9 * val_9);
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * val_9);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * tmpvar_11);
  s_10 = (((val_9 + 
    (tmpvar_12 * -0.1616162)
  ) + (tmpvar_13 * 0.0083333)) + ((tmpvar_13 * tmpvar_11) * -0.00019841));
  s_6 = (s_10 * s_10);
  s_6 = (s_6 * s_6);
  highp float tmpvar_14;
  tmpvar_14 = (dot (s_6, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_6 = (s_6 * (_glesColor.w * _WaveAndDistance.z));
  waveMove_5.y = 0.0;
  waveMove_5.x = dot (s_6, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_5.z = dot (s_6, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_2.xz = (_glesVertex.xz - (waveMove_5.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_14));
  waveColor_4 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (vertex_2.xyz - _CameraPosition.xyz);
  highp float tmpvar_17;
  tmpvar_17 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_16, tmpvar_16))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_3.w = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = ((2.0 * waveColor_4) * _glesColor.xyz);
  tmpvar_18.w = color_3.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = vertex_2.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = normalize((tmpvar_20 * _glesNormal));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_2.xyz;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_COLOR = tmpvar_18;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 vertex_2;
  vertex_2.yw = _glesVertex.yw;
  lowp vec4 color_3;
  color_3.xyz = _glesColor.xyz;
  lowp vec3 waveColor_4;
  highp vec3 waveMove_5;
  highp vec4 s_6;
  highp vec4 waves_7;
  waves_7 = (_glesVertex.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_7 = (waves_7 + (_glesVertex.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_7 = (waves_7 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_8;
  tmpvar_8 = fract(waves_7);
  waves_7 = tmpvar_8;
  highp vec4 val_9;
  highp vec4 s_10;
  val_9 = ((tmpvar_8 * 6.408849) - 3.141593);
  highp vec4 tmpvar_11;
  tmpvar_11 = (val_9 * val_9);
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * val_9);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * tmpvar_11);
  s_10 = (((val_9 + 
    (tmpvar_12 * -0.1616162)
  ) + (tmpvar_13 * 0.0083333)) + ((tmpvar_13 * tmpvar_11) * -0.00019841));
  s_6 = (s_10 * s_10);
  s_6 = (s_6 * s_6);
  highp float tmpvar_14;
  tmpvar_14 = (dot (s_6, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_6 = (s_6 * (_glesColor.w * _WaveAndDistance.z));
  waveMove_5.y = 0.0;
  waveMove_5.x = dot (s_6, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_5.z = dot (s_6, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_2.xz = (_glesVertex.xz - (waveMove_5.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_14));
  waveColor_4 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (vertex_2.xyz - _CameraPosition.xyz);
  highp float tmpvar_17;
  tmpvar_17 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_16, tmpvar_16))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_3.w = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = ((2.0 * waveColor_4) * _glesColor.xyz);
  tmpvar_18.w = color_3.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = vertex_2.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = normalize((tmpvar_20 * _glesNormal));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_2.xyz;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_COLOR = tmpvar_18;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 vertex_2;
  vertex_2.yw = _glesVertex.yw;
  lowp vec4 color_3;
  color_3.xyz = _glesColor.xyz;
  lowp vec3 waveColor_4;
  highp vec3 waveMove_5;
  highp vec4 s_6;
  highp vec4 waves_7;
  waves_7 = (_glesVertex.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y));
  waves_7 = (waves_7 + (_glesVertex.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y)));
  waves_7 = (waves_7 + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)));
  highp vec4 tmpvar_8;
  tmpvar_8 = fract(waves_7);
  waves_7 = tmpvar_8;
  highp vec4 val_9;
  highp vec4 s_10;
  val_9 = ((tmpvar_8 * 6.408849) - 3.141593);
  highp vec4 tmpvar_11;
  tmpvar_11 = (val_9 * val_9);
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * val_9);
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_12 * tmpvar_11);
  s_10 = (((val_9 + 
    (tmpvar_12 * -0.1616162)
  ) + (tmpvar_13 * 0.0083333)) + ((tmpvar_13 * tmpvar_11) * -0.00019841));
  s_6 = (s_10 * s_10);
  s_6 = (s_6 * s_6);
  highp float tmpvar_14;
  tmpvar_14 = (dot (s_6, vec4(0.6741998, 0.6741998, 0.2696799, 0.13484)) * 0.7);
  s_6 = (s_6 * (_glesColor.w * _WaveAndDistance.z));
  waveMove_5.y = 0.0;
  waveMove_5.x = dot (s_6, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_5.z = dot (s_6, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_2.xz = (_glesVertex.xz - (waveMove_5.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3(tmpvar_14));
  waveColor_4 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = (vertex_2.xyz - _CameraPosition.xyz);
  highp float tmpvar_17;
  tmpvar_17 = clamp (((2.0 * 
    (_WaveAndDistance.w - dot (tmpvar_16, tmpvar_16))
  ) * _CameraPosition.w), 0.0, 1.0);
  color_3.w = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = ((2.0 * waveColor_4) * _glesColor.xyz);
  tmpvar_18.w = color_3.w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = vertex_2.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = glstate_matrix_invtrans_modelview0[0].xyz;
  tmpvar_20[1] = glstate_matrix_invtrans_modelview0[1].xyz;
  tmpvar_20[2] = glstate_matrix_invtrans_modelview0[2].xyz;
  tmpvar_1.xyz = normalize((tmpvar_20 * _glesNormal));
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_2.xyz;
  tmpvar_1.w = -(((glstate_matrix_modelview0 * tmpvar_21).z * _ProjectionParams.w));
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_COLOR = tmpvar_18;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec2 enc_4;
  enc_4 = (xlv_TEXCOORD1.xy / (xlv_TEXCOORD1.z + 1.0));
  enc_4 = (enc_4 / 1.7777);
  enc_4 = ((enc_4 * 0.5) + 0.5);
  enc_3.xy = enc_4;
  highp vec2 enc_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = fract((vec2(1.0, 255.0) * xlv_TEXCOORD1.w));
  enc_5.y = tmpvar_6.y;
  enc_5.x = (tmpvar_6.x - (tmpvar_6.y * 0.003921569));
  enc_3.zw = enc_5;
  tmpvar_1 = enc_3;
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
}
}
}
}