//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/LuminanceBakeShader" {
Properties {
 _MainTex ("Texture", 2D) = "white" { }
 _RampTex ("Ramp", 2D) = "white" { }
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  GpuProgramID 54955
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec2 tmpvar_1;
  tmpvar_1.y = 0.5;
  tmpvar_1.x = texture2D (_MainTex, xlv_TEXCOORD0).x;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_RampTex, tmpvar_1);
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec2 tmpvar_1;
  tmpvar_1.y = 0.5;
  tmpvar_1.x = texture2D (_MainTex, xlv_TEXCOORD0).x;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_RampTex, tmpvar_1);
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec2 tmpvar_1;
  tmpvar_1.y = 0.5;
  tmpvar_1.x = texture2D (_MainTex, xlv_TEXCOORD0).x;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_RampTex, tmpvar_1);
  gl_FragData[0] = tmpvar_2;
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
}
 }
}
}