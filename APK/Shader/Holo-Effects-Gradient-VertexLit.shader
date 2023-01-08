//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Effects/Gradation-VertexLit" {
Properties {
 _MainTex ("Texture", 2D) = "white" { }
 _Start ("Start position", Float) = 0.000000
 _End ("End position", Float) = 1.000000
 _ColorStart ("Start Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _ColorEnd ("End Color", Color) = (1.000000,1.000000,1.000000,1.000000)
[Toggle]  _Vertical ("Vertical", Float) = 0.000000
}
SubShader { 
 Pass {
  Cull Off
  GpuProgramID 27741
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _MainTex_Matrix;
uniform mediump float _Start;
uniform mediump float _End;
uniform mediump vec4 _ColorStart;
uniform mediump vec4 _ColorEnd;
uniform highp float _Vertical;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 color_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  mediump vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = tmpvar_1;
  tmpvar_4 = (_MainTex_Matrix * tmpvar_5).xy;
  mediump float tmpvar_6;
  if ((_Vertical > 0.0)) {
    tmpvar_6 = tmpvar_1.y;
  } else {
    tmpvar_6 = tmpvar_1.x;
  };
  mediump float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 - _Start) / (_End - _Start));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (_ColorStart, _ColorEnd, vec4(tmpvar_7));
  color_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  if (((0.0 <= tmpvar_7) && (tmpvar_7 <= 1.0))) {
    tmpvar_9 = color_2;
  } else {
    tmpvar_9 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  tmpvar_1 = (xlv_COLOR * color_2);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _MainTex_Matrix;
uniform mediump float _Start;
uniform mediump float _End;
uniform mediump vec4 _ColorStart;
uniform mediump vec4 _ColorEnd;
uniform highp float _Vertical;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 color_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  mediump vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = tmpvar_1;
  tmpvar_4 = (_MainTex_Matrix * tmpvar_5).xy;
  mediump float tmpvar_6;
  if ((_Vertical > 0.0)) {
    tmpvar_6 = tmpvar_1.y;
  } else {
    tmpvar_6 = tmpvar_1.x;
  };
  mediump float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 - _Start) / (_End - _Start));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (_ColorStart, _ColorEnd, vec4(tmpvar_7));
  color_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  if (((0.0 <= tmpvar_7) && (tmpvar_7 <= 1.0))) {
    tmpvar_9 = color_2;
  } else {
    tmpvar_9 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  tmpvar_1 = (xlv_COLOR * color_2);
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 _MainTex_Matrix;
uniform mediump float _Start;
uniform mediump float _End;
uniform mediump vec4 _ColorStart;
uniform mediump vec4 _ColorEnd;
uniform highp float _Vertical;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 color_2;
  highp vec4 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  mediump vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = tmpvar_1;
  tmpvar_4 = (_MainTex_Matrix * tmpvar_5).xy;
  mediump float tmpvar_6;
  if ((_Vertical > 0.0)) {
    tmpvar_6 = tmpvar_1.y;
  } else {
    tmpvar_6 = tmpvar_1.x;
  };
  mediump float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 - _Start) / (_End - _Start));
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (_ColorStart, _ColorEnd, vec4(tmpvar_7));
  color_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  if (((0.0 <= tmpvar_7) && (tmpvar_7 <= 1.0))) {
    tmpvar_9 = color_2;
  } else {
    tmpvar_9 = vec4(1.0, 1.0, 1.0, 1.0);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2 = tmpvar_3;
  tmpvar_1 = (xlv_COLOR * color_2);
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
}
 }
}
Fallback "Unlit/Texture"
}