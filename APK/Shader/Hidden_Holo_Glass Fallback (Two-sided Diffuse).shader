//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Holo/Glass Fallback (Two-sided Diffuse)" {
Properties {
[KeywordEnum(Off, Diffuse, GlassTint, GlassBlend)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Specularity ("Specularity", Range(0, 2)) = 1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.95
[KeywordEnum(None, Specularity, Cubemap)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
}
SubShader {
 LOD 1
 Tags { "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" }
 Pass {
  Name "SHADOWCASTER"
  LOD 1
  Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
  Blend One OneMinusSrcAlpha, One One
  ZClip Off
  Cull Off
  GpuProgramID 15600
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
uniform lowp float _AlphaTestRef;
void main ()
{
  lowp float x_1;
  x_1 = -(_AlphaTestRef);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
uniform lowp float _AlphaTestRef;
void main ()
{
  lowp float x_1;
  x_1 = -(_AlphaTestRef);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
uniform lowp float _AlphaTestRef;
void main ()
{
  lowp float x_1;
  x_1 = -(_AlphaTestRef);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform lowp float _AlphaTestRef;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = -(_AlphaTestRef);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform lowp float _AlphaTestRef;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = -(_AlphaTestRef);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform lowp float _AlphaTestRef;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp float x_2;
  x_2 = -(_AlphaTestRef);
  if ((x_2 < 0.0)) {
    discard;
  };
  highp vec4 enc_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_3 = (tmpvar_4 - (tmpvar_4.yzww * 0.003921569));
  tmpvar_1 = enc_3;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}