//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/FX/Add" {
Properties {
 _Intensity ("Intensity", Float) = 1.000000
 _MainTex ("Combo (R=A1)", 2D) = "white" { }
 _Offset ("Depth Offset", Float) = 0.000000
[Toggle(BRB_SCROLL)]  _Scroll ("    Scroll Texture", Float) = 0.000000
 _Speed ("Scroll Speed (A1.uv, unused)", Vector) = (0.000000,0.000000,0.000000,0.000000)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent-50" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent-50" "RenderType"="Transparent" }
  ZWrite Off
  Blend One One
  Offset 0.000000, [_Offset]
  GpuProgramID 64910
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
uniform mediump vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  tmpvar_3.xyz = (tmpvar_3.xyz * _CharacterColor.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
uniform mediump vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  tmpvar_3.xyz = (tmpvar_3.xyz * _CharacterColor.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _Speed;
uniform mediump vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float unityFogFactor_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_3 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * tmpvar_4.z);
  unityFogFactor_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = exp2((-(unityFogFactor_2) * unityFogFactor_2));
  tmpvar_3.xyz = (tmpvar_3.xyz * tmpvar_7);
  tmpvar_3.xyz = (tmpvar_3.xyz * _CharacterColor.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (tmpvar_5 + (_Speed * _Time.y));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
  color_1 = tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = min (color_1, vec4(1.0, 1.0, 1.0, 1.0));
  color_1.w = tmpvar_3.w;
  color_1.xyz = ((tmpvar_3.xyz * _Intensity) * xlv_TEXCOORD0.xyz);
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
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}