//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Holo/BlendToColor" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _Blend ("Fade", Range(0.000000,1.000000)) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _StencilComp ("Stencil Comparison", Float) = 8.000000
 _Stencil ("Stencil ID", Float) = 0.000000
[Enum(UnityEngine.Rendering.StencilOp)]  _StencilOp ("Stencil Operation", Float) = 0.000000
 _StencilWriteMask ("Stencil Write Mask", Float) = 255.000000
 _StencilReadMask ("Stencil Read Mask", Float) = 255.000000
[Enum(UnityEngine.Rendering.ColorWriteMask)]  _ColorMask ("Color Mask", Float) = 15.000000
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZTest [unity_GUIZTestMode]
  ZWrite Off
  Cull Off
  Stencil {
   Ref [_Stencil]
   ReadMask [_StencilReadMask]
   WriteMask [_StencilWriteMask]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask [_ColorMask]
  GpuProgramID 21716
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Blend;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_3, xlv_COLOR, vec4(_Blend));
  color_1.xyz = tmpvar_4.xyz;
  color_1.w = (tmpvar_4.w * tmpvar_2.w);
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
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Blend;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_3, xlv_COLOR, vec4(_Blend));
  color_1.xyz = tmpvar_4.xyz;
  color_1.w = (tmpvar_4.w * tmpvar_2.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = tmpvar_2;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp float _Blend;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  lowp vec4 tmpvar_4;
  tmpvar_4 = mix (tmpvar_3, xlv_COLOR, vec4(_Blend));
  color_1.xyz = tmpvar_4.xyz;
  color_1.w = (tmpvar_4.w * tmpvar_2.w);
  gl_FragData[0] = color_1;
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
CustomEditor "CustomMaterialInspector"
Fallback Off
}