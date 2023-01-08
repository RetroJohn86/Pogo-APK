//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/FX/FireGeom" {
Properties {
_MainTex ("A1 (RGB)", 2D) = "white" { }
_FPS ("FPS", Float) = 15
_Step ("Step", Float) = 0
_Scale ("Scale", Float) = 1
_Offset ("Depth Offset", Float) = 0
_Stencil ("Stencil ID", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Blend One One, One One
  ZClip Off
  Stencil {
   Comp Always
   Pass Replace
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 5532
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 _MainTex_ST;
uniform highp float _FPS;
uniform highp float _Step;
uniform highp float _Scale;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1.xyz = (_glesVertex.xyz * _Scale);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_1.y;
  tmpvar_6.y = tmpvar_1.x;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xw = (tmpvar_3.xw + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) - tmpvar_6));
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).x;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 _MainTex_ST;
uniform highp float _FPS;
uniform highp float _Step;
uniform highp float _Scale;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1.xyz = (_glesVertex.xyz * _Scale);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_1.y;
  tmpvar_6.y = tmpvar_1.x;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xw = (tmpvar_3.xw + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) - tmpvar_6));
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).x;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 _MainTex_ST;
uniform highp float _FPS;
uniform highp float _Step;
uniform highp float _Scale;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_1.xyz = (_glesVertex.xyz * _Scale);
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_1.y;
  tmpvar_6.y = tmpvar_1.x;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3.xw = (tmpvar_3.xw + fract((
    floor((_Time.y * _FPS))
   * _Step)));
  gl_Position = (glstate_matrix_projection * ((glstate_matrix_modelview0 * vec4(0.0, 0.0, 0.0, 1.0)) - tmpvar_6));
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump float alpha_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy).x;
  alpha_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_2 - 0.5);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_5.w = alpha_2;
  tmpvar_1 = tmpvar_5;
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
CustomEditor "CustomMaterialInspector"
}