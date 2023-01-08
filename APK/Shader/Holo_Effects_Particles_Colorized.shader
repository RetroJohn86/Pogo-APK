//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Effects/Particles/Colorized" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 40277
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (xlv_COLOR * 0.75);
  col_1.xyz = mix (xlv_COLOR, mix (mix (
    ((tmpvar_3 * tmpvar_3) * tmpvar_3)
  , xlv_COLOR, tmpvar_2.xxxx), vec4(1.0, 1.0, 1.0, 1.0), vec4((
    (tmpvar_2.x * tmpvar_2.x)
   * 
    (tmpvar_2.x * tmpvar_2.x)
  ))), xlv_COLOR.wwww).xyz;
  col_1.w = tmpvar_2.y;
  gl_FragData[0] = col_1;
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
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
""
}
}
}
}
}