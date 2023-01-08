//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Skydome (Ignore Fog)" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_StarTex ("Star Texture", 2D) = "black" { }
_PanningSpeed ("Panning Speed", Float) = 0.01
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Background" "RenderType" = "Background" }
  ZClip Off
  GpuProgramID 41540
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _StarTex_ST;
uniform lowp float _PanningSpeed;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_Time.x * _PanningSpeed);
  tmpvar_1.zw = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _StarTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp float gradient_1;
  highp float tmpvar_2;
  tmpvar_2 = (1.0 - xlv_TEXCOORD0.y);
  gradient_1 = tmpvar_2;
  gradient_1 = (1.0 - pow (gradient_1, 50.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + (texture2D (_StarTex, xlv_TEXCOORD0.zw) * gradient_1));
  gl_FragData[0] = tmpvar_3;
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _StarTex_ST;
uniform lowp float _PanningSpeed;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_Time.x * _PanningSpeed);
  tmpvar_1.zw = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _StarTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp float gradient_1;
  highp float tmpvar_2;
  tmpvar_2 = (1.0 - xlv_TEXCOORD0.y);
  gradient_1 = tmpvar_2;
  gradient_1 = (1.0 - pow (gradient_1, 50.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + (texture2D (_StarTex, xlv_TEXCOORD0.zw) * gradient_1));
  gl_FragData[0] = tmpvar_3;
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _StarTex_ST;
uniform lowp float _PanningSpeed;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = (_Time.x * _PanningSpeed);
  tmpvar_1.zw = (((_glesMultiTexCoord1.xy * _StarTex_ST.xy) + _StarTex_ST.zw) + tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _StarTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp float gradient_1;
  highp float tmpvar_2;
  tmpvar_2 = (1.0 - xlv_TEXCOORD0.y);
  gradient_1 = tmpvar_2;
  gradient_1 = (1.0 - pow (gradient_1, 50.0));
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + (texture2D (_StarTex, xlv_TEXCOORD0.zw) * gradient_1));
  gl_FragData[0] = tmpvar_3;
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
}