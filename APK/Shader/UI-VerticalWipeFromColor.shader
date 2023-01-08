//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Holo/VerticalWipeFromToColor" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _Wipe ("Wipe", Range(0.000000,2.000000)) = 0.000000
 _Feather ("Feather", Range(0.000000,1.000000)) = 0.000000
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
  GpuProgramID 58257
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _Wipe;
uniform lowp float _Feather;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  lowp vec2 tmpvar_5;
  tmpvar_5.x = ((fract(_Wipe) * (1.0 + _Feather)) - 1.0);
  tmpvar_5.y = max (0.0025, _Feather);
  tmpvar_4.zw = tmpvar_5;
  tmpvar_4.w = ((_glesMultiTexCoord0.y + tmpvar_4.z) / tmpvar_4.w);
  if (((_Wipe >= 1.0) && (_Wipe < 2.0))) {
    tmpvar_4.w = (1.0 - tmpvar_4.w);
  };
  tmpvar_3 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_2.xyz = xlv_TEXCOORD0.xyz;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_4.w);
  tmpvar_2.w = clamp (xlv_TEXCOORD0.w, 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, tmpvar_4, tmpvar_2.wwww);
  color_3 = tmpvar_5;
  gl_FragData[0] = color_3;
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
uniform lowp float _Wipe;
uniform lowp float _Feather;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  lowp vec2 tmpvar_5;
  tmpvar_5.x = ((fract(_Wipe) * (1.0 + _Feather)) - 1.0);
  tmpvar_5.y = max (0.0025, _Feather);
  tmpvar_4.zw = tmpvar_5;
  tmpvar_4.w = ((_glesMultiTexCoord0.y + tmpvar_4.z) / tmpvar_4.w);
  if (((_Wipe >= 1.0) && (_Wipe < 2.0))) {
    tmpvar_4.w = (1.0 - tmpvar_4.w);
  };
  tmpvar_3 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_2.xyz = xlv_TEXCOORD0.xyz;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_4.w);
  tmpvar_2.w = clamp (xlv_TEXCOORD0.w, 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, tmpvar_4, tmpvar_2.wwww);
  color_3 = tmpvar_5;
  gl_FragData[0] = color_3;
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
uniform lowp float _Wipe;
uniform lowp float _Feather;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_4.xy = _glesMultiTexCoord0.xy;
  lowp vec2 tmpvar_5;
  tmpvar_5.x = ((fract(_Wipe) * (1.0 + _Feather)) - 1.0);
  tmpvar_5.y = max (0.0025, _Feather);
  tmpvar_4.zw = tmpvar_5;
  tmpvar_4.w = ((_glesMultiTexCoord0.y + tmpvar_4.z) / tmpvar_4.w);
  if (((_Wipe >= 1.0) && (_Wipe < 2.0))) {
    tmpvar_4.w = (1.0 - tmpvar_4.w);
  };
  tmpvar_3 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  tmpvar_2.xyz = xlv_TEXCOORD0.xyz;
  lowp vec4 color_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_4.w);
  tmpvar_2.w = clamp (xlv_TEXCOORD0.w, 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (tmpvar_1, tmpvar_4, tmpvar_2.wwww);
  color_3 = tmpvar_5;
  gl_FragData[0] = color_3;
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