//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/FX/Multiply" {
Properties {
 _Intensity ("Intensity", Float) = 1.000000
 _MainTex ("A1 (RGB)", 2D) = "white" { }
 _AddTex ("A2 (RGB)", 2D) = "black" { }
 _Offset ("Depth Offset", Float) = 0.000000
 _Speed ("Scroll Speed (A1.uv, A2.uv)", Vector) = (0.000000,0.000000,0.000000,0.000000)
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent-50" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent-50" "RenderType"="Transparent" }
  ZWrite Off
  Blend DstColor Zero
  Offset 0.000000, [_Offset]
  GpuProgramID 39353
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  highp float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_1 = tmpvar_5;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  color_2.xyz = mix (vec4(1.0, 1.0, 1.0, 1.0), color_2, vec4(xlv_TEXCOORD1)).xyz;
  tmpvar_1 = color_2;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  highp float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_1 = tmpvar_5;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  color_2.xyz = mix (vec4(1.0, 1.0, 1.0, 1.0), color_2, vec4(xlv_TEXCOORD1)).xyz;
  tmpvar_1 = color_2;
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
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump float tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  highp float tmpvar_5;
  tmpvar_5 = exp2((-(tmpvar_4) * tmpvar_4));
  tmpvar_1 = tmpvar_5;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  color_2.xyz = mix (vec4(1.0, 1.0, 1.0, 1.0), color_2, vec4(xlv_TEXCOORD1)).xyz;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_4)
   * tmpvar_4)));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(1.0, 1.0, 1.0), color_2.xyz, xlv_TEXCOORD1.www);
  color_2.xyz = tmpvar_5;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_4)
   * tmpvar_4)));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(1.0, 1.0, 1.0), color_2.xyz, xlv_TEXCOORD1.www);
  color_2.xyz = tmpvar_5;
  tmpvar_1 = color_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _AddTex_ST;
uniform lowp vec4 _Speed;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _AddTex_ST.xy) + _AddTex_ST.zw);
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_4)
   * tmpvar_4)));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (tmpvar_3 + (_Speed * _Time.y));
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AddTex;
uniform lowp float _Intensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_AddTex, xlv_TEXCOORD0.zw));
  color_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = min (color_2, vec4(1.0, 1.0, 1.0, 1.0));
  color_2.w = tmpvar_4.w;
  color_2.xyz = ((tmpvar_4.xyz * _Intensity) + (1.0 - _Intensity));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (vec3(1.0, 1.0, 1.0), color_2.xyz, xlv_TEXCOORD1.www);
  color_2.xyz = tmpvar_5;
  tmpvar_1 = color_2;
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