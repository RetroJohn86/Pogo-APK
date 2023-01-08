//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Skybox/Cubemap" {
Properties {
_Alpha ("Alpha (output)", Range(0, 1)) = 1
_Rotation ("Rotation", Range(0, 360)) = 0
_Tex ("Cubemap   (HDR)", Cube) = "grey" { }
[Toggle(BRB_LIGHTING_TWOSIDED)] _Street ("    Is Street View?", Float) = 0
_Bluriness ("    Bluriness", Range(0, 1)) = 0
[Toggle(_BASEALPHA_UNLIT)] _Unlit ("    Disable LightKit", Float) = 0
[KeywordEnum(Off, Wrap_U, Horizon_Clamp, Horizon_Clip)] _Mirror_V ("    Horizon Mode ('Wrap_U' means 'Horizon_Mirror')", Float) = 0
_HorizonOffset ("    Horizon Offset (combined)", Range(-0.5, 0.5)) = 0
_CubeHorizon ("    Horizon Offset (cubemap only)", Range(-0.5, 0.5)) = 0
[KeywordEnum(Off, Composite, Horizon_Clamp, Horizon_Fake)] _Fog ("Fog Mode", Float) = 0
_FogAlpha ("Fog Alpha (minimum)", Range(0, 1)) = 1
_FogHorizonHeight ("Fog Horizon Height", Range(0, 10)) = 0.1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (Off = double-sided)", Float) = 0
[Toggle(BRB_FX)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 41821
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp float _Rotation;
uniform lowp float _HorizonOffset;
uniform lowp float _CubeHorizon;
uniform highp vec4 _SkyColor;
uniform highp float _Overcast;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_4;
  tmpvar_4 = sin(tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = cos(tmpvar_3);
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4;
  tmpvar_6[1].x = -(tmpvar_4);
  tmpvar_6[1].y = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xy = (tmpvar_6 * _glesVertex.xz);
  tmpvar_7.zw = tmpvar_1.yw;
  tmpvar_2.xzw = tmpvar_1.xzw;
  tmpvar_2.y = (_glesVertex.y + _HorizonOffset);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _SkyColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_2.y);
  tmpvar_2.w = (_Overcast * (1.0 - (tmpvar_9 * tmpvar_9)));
  tmpvar_2.y = (tmpvar_2.y + _CubeHorizon);
  gl_Position = (glstate_matrix_mvp * tmpvar_7.xzyw);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_8 * _SkyColor.w);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform lowp float _Bluriness;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = xlv_TEXCOORD0.xyz;
  tmpvar_3.w = _Bluriness;
  lowp vec4 tmpvar_4;
  tmpvar_4 = impl_low_textureCubeLodEXT (_Tex, xlv_TEXCOORD0.xyz, tmpvar_3.w);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump float tmpvar_7;
  if ((_Tex_HDR.w == 1.0)) {
    tmpvar_7 = tmpvar_5.w;
  } else {
    tmpvar_7 = 1.0;
  };
  tmpvar_6 = ((_Tex_HDR.x * tmpvar_7) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_TEXCOORD1.xyz, xlv_TEXCOORD0.www);
  c_2 = tmpvar_8;
  c_2 = (c_2 * xlv_TEXCOORD1.xyz);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = c_2;
  tmpvar_9.w = _Alpha;
  tmpvar_1 = tmpvar_9;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp float _Rotation;
uniform lowp float _HorizonOffset;
uniform lowp float _CubeHorizon;
uniform highp vec4 _SkyColor;
uniform highp float _Overcast;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_4;
  tmpvar_4 = sin(tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = cos(tmpvar_3);
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4;
  tmpvar_6[1].x = -(tmpvar_4);
  tmpvar_6[1].y = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xy = (tmpvar_6 * _glesVertex.xz);
  tmpvar_7.zw = tmpvar_1.yw;
  tmpvar_2.xzw = tmpvar_1.xzw;
  tmpvar_2.y = (_glesVertex.y + _HorizonOffset);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _SkyColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_2.y);
  tmpvar_2.w = (_Overcast * (1.0 - (tmpvar_9 * tmpvar_9)));
  tmpvar_2.y = (tmpvar_2.y + _CubeHorizon);
  gl_Position = (glstate_matrix_mvp * tmpvar_7.xzyw);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_8 * _SkyColor.w);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform lowp float _Bluriness;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = xlv_TEXCOORD0.xyz;
  tmpvar_3.w = _Bluriness;
  lowp vec4 tmpvar_4;
  tmpvar_4 = impl_low_textureCubeLodEXT (_Tex, xlv_TEXCOORD0.xyz, tmpvar_3.w);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump float tmpvar_7;
  if ((_Tex_HDR.w == 1.0)) {
    tmpvar_7 = tmpvar_5.w;
  } else {
    tmpvar_7 = 1.0;
  };
  tmpvar_6 = ((_Tex_HDR.x * tmpvar_7) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_TEXCOORD1.xyz, xlv_TEXCOORD0.www);
  c_2 = tmpvar_8;
  c_2 = (c_2 * xlv_TEXCOORD1.xyz);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = c_2;
  tmpvar_9.w = _Alpha;
  tmpvar_1 = tmpvar_9;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp float _Rotation;
uniform lowp float _HorizonOffset;
uniform lowp float _CubeHorizon;
uniform highp vec4 _SkyColor;
uniform highp float _Overcast;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = ((_Rotation * 3.141593) / 180.0);
  highp float tmpvar_4;
  tmpvar_4 = sin(tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = cos(tmpvar_3);
  highp mat2 tmpvar_6;
  tmpvar_6[0].x = tmpvar_5;
  tmpvar_6[0].y = tmpvar_4;
  tmpvar_6[1].x = -(tmpvar_4);
  tmpvar_6[1].y = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7.xy = (tmpvar_6 * _glesVertex.xz);
  tmpvar_7.zw = tmpvar_1.yw;
  tmpvar_2.xzw = tmpvar_1.xzw;
  tmpvar_2.y = (_glesVertex.y + _HorizonOffset);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _SkyColor.xyz;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_2.y);
  tmpvar_2.w = (_Overcast * (1.0 - (tmpvar_9 * tmpvar_9)));
  tmpvar_2.y = (tmpvar_2.y + _CubeHorizon);
  gl_Position = (glstate_matrix_mvp * tmpvar_7.xzyw);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (tmpvar_8 * _SkyColor.w);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform lowp samplerCube _Tex;
uniform mediump vec4 _Tex_HDR;
uniform lowp float _Bluriness;
uniform lowp float _Alpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 c_2;
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = xlv_TEXCOORD0.xyz;
  tmpvar_3.w = _Bluriness;
  lowp vec4 tmpvar_4;
  tmpvar_4 = impl_low_textureCubeLodEXT (_Tex, xlv_TEXCOORD0.xyz, tmpvar_3.w);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec3 tmpvar_6;
  mediump float tmpvar_7;
  if ((_Tex_HDR.w == 1.0)) {
    tmpvar_7 = tmpvar_5.w;
  } else {
    tmpvar_7 = 1.0;
  };
  tmpvar_6 = ((_Tex_HDR.x * tmpvar_7) * tmpvar_5.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_6, xlv_TEXCOORD1.xyz, xlv_TEXCOORD0.www);
  c_2 = tmpvar_8;
  c_2 = (c_2 * xlv_TEXCOORD1.xyz);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = c_2;
  tmpvar_9.w = _Alpha;
  tmpvar_1 = tmpvar_9;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
CustomEditor "CustomMaterialInspector"
}