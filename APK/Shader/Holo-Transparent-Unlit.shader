//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Transparent/Unlit" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
[KeywordEnum(Off, Clamp_V, Wrap_V)]  _Mirror_U ("    U Mirror (use only if texture is clamped - wrap V has issues)", Float) = 0.000000
[KeywordEnum(Off, Clamp_U, Wrap_U)]  _Mirror_V ("    V Mirror (use only if texture is clamped - wrap U has issues)", Float) = 0.000000
[Toggle(BRB_SCREENSPACE)]  _ScreenSpace ("    Use screenspace coordinates", Float) = 0.000000
[Toggle(BRB_SCREENSPACE_ASPECTX)]  _ScreenSpaceAspect ("    Screenspace aspect correction (fit horizontal)", Float) = 0.000000
[Toggle(BRB_SCROLL)]  _Scroll ("    Scroll base texture", Float) = 0.000000
 _ScrollU ("    Scroll U/X speed", Range(-30.000000,30.000000)) = 0.000000
 _ScrollV ("    Scroll V/Y speed", Range(-30.000000,30.000000)) = 0.000000
[Toggle(_VERTEXMODE_DIFFUSE)]  _VertexMode ("Vertex RGBA multiply", Float) = 0.000000
[KeywordEnum(Off, Fog, Composite)]  _Fog ("Fog Mode", Float) = 0.000000
 _FogAlpha ("Fog Alpha (an override)", Range(0.000000,1.000000)) = 1.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
[Toggle]  _ZWrite ("Z Write", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _ZTest ("Z Test", Float) = 4.000000
[Toggle(BRB_SHADOW)]  _Shadow ("Treat as environment?", Float) = 0.000000
[Toggle(BRB_FX_DISABLE)]  _FX ("Ignore FX Color", Float) = 0.000000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZTest [_ZTest]
  ZWrite [_ZWrite]
  Cull [_Cull]
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 40887
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2 = tmpvar_3;
  tmpvar_1 = col_2;
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
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2 = tmpvar_3;
  tmpvar_1 = col_2;
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
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2 = tmpvar_3;
  tmpvar_1 = col_2;
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
CustomEditor "CustomMaterialInspector"
Fallback Off
}