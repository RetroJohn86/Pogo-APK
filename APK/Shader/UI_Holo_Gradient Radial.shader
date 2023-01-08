//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Holo/Gradient Radial" {
Properties {
_GradientParams ("Gradient Parameters (center x,y and scale x,y)", Vector) = (0,0,1,1)
_Color ("Color (Outside)", Color) = (0,0,0,0)
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Enum(UnityEngine.Rendering.ColorWriteMask)] _ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZClip Off
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 29832
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _GradientParams;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.xyw = _glesVertex.xyw;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.z = 0.1;
  highp vec4 tmpvar_5;
  tmpvar_5.xy = _glesMultiTexCoord0.xy;
  tmpvar_5.zw = (_GradientParams.xy + 0.5);
  tmpvar_4.zw = tmpvar_5.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - tmpvar_5.zw);
  tmpvar_4.xy = (tmpvar_4.xy / _GradientParams.zw);
  tmpvar_4.xy = (tmpvar_4.xy + tmpvar_5.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  highp vec2 x_2;
  x_2 = (xlv_TEXCOORD0.xy - xlv_TEXCOORD0.zw);
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (xlv_COLOR, _Color, vec4(sqrt(dot (x_2, x_2))));
  color_1 = tmpvar_3;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _GradientParams;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.xyw = _glesVertex.xyw;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.z = 0.1;
  highp vec4 tmpvar_5;
  tmpvar_5.xy = _glesMultiTexCoord0.xy;
  tmpvar_5.zw = (_GradientParams.xy + 0.5);
  tmpvar_4.zw = tmpvar_5.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - tmpvar_5.zw);
  tmpvar_4.xy = (tmpvar_4.xy / _GradientParams.zw);
  tmpvar_4.xy = (tmpvar_4.xy + tmpvar_5.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  highp vec2 x_2;
  x_2 = (xlv_TEXCOORD0.xy - xlv_TEXCOORD0.zw);
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (xlv_COLOR, _Color, vec4(sqrt(dot (x_2, x_2))));
  color_1 = tmpvar_3;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _GradientParams;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  tmpvar_2.xyw = _glesVertex.xyw;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.z = 0.1;
  highp vec4 tmpvar_5;
  tmpvar_5.xy = _glesMultiTexCoord0.xy;
  tmpvar_5.zw = (_GradientParams.xy + 0.5);
  tmpvar_4.zw = tmpvar_5.zw;
  tmpvar_4.xy = (_glesMultiTexCoord0.xy - tmpvar_5.zw);
  tmpvar_4.xy = (tmpvar_4.xy / _GradientParams.zw);
  tmpvar_4.xy = (tmpvar_4.xy + tmpvar_5.zw);
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  highp vec2 x_2;
  x_2 = (xlv_TEXCOORD0.xy - xlv_TEXCOORD0.zw);
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (xlv_COLOR, _Color, vec4(sqrt(dot (x_2, x_2))));
  color_1 = tmpvar_3;
  gl_FragData[0] = color_1;
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