//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Effects/Particles/Alpha Blended - Stencil" {
Properties {
 _MainTex ("Particle Texture", 2D) = "white" { }
[KeywordEnum(Unlit,Simple,Flat)]  _Lighting ("Lighting Mode", Float) = 0.000000
 _InvFade ("Soft Particles Factor", Range(0.010000,3.000000)) = 1.000000
 _Stencil ("Stencil ID", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _StencilComp ("Stencil Compare Function", Float) = 5.000000
[Enum(UnityEngine.Rendering.StencilOp)]  _StencilOp ("Stencil Operation", Float) = 2.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _ZTest ("Z Test", Float) = 4.000000
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  ZTest [_ZTest]
  ZWrite Off
  Cull Off
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha One
  GpuProgramID 5916
Program "vp" {
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
  lowp vec4 tmpvar_1;
  tmpvar_1 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  gl_FragData[0] = tmpvar_1;
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
  lowp vec4 tmpvar_1;
  tmpvar_1 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  gl_FragData[0] = tmpvar_1;
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
  lowp vec4 tmpvar_1;
  tmpvar_1 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_3)
   * tmpvar_3)));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  col_1.w = tmpvar_2.w;
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD1.xyz, tmpvar_2.xyz, xlv_TEXCOORD1.www);
  col_1.xyz = tmpvar_3;
  gl_FragData[0] = col_1;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_3)
   * tmpvar_3)));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  col_1.w = tmpvar_2.w;
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD1.xyz, tmpvar_2.xyz, xlv_TEXCOORD1.www);
  col_1.xyz = tmpvar_3;
  gl_FragData[0] = col_1;
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 envFogColor_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * tmpvar_2.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_3)
   * tmpvar_3)));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
  col_1.w = tmpvar_2.w;
  highp vec3 tmpvar_3;
  tmpvar_3 = mix (xlv_TEXCOORD1.xyz, tmpvar_2.xyz, xlv_TEXCOORD1.www);
  col_1.xyz = tmpvar_3;
  gl_FragData[0] = col_1;
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