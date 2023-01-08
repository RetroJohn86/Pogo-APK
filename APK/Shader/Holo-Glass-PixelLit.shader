//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass without Refraction" {
Properties {
[Toggle(BRB_GLASS_BASE)]  _GlassMode ("Glass with Diffuse", Float) = 0.000000
[KeywordEnum(Off, Diffuse, GlassTint, GlassBlend)]  _ColorMode ("Color Modifier Mode", Float) = 0.000000
 _Color ("    Color", Color) = (1.000000,1.000000,1.000000,1.000000)
[KeywordEnum(Off, Diffuse)]  _VertexMode ("Vertex Color Mode", Float) = 1.000000
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit, SpecularColor)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _AlphaTestRef ("    Alpha Cutoff", Range(0.000000,1.000000)) = 0.500000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
 _Specularity ("Specularity", Range(0.000000,2.000000)) = 1.000000
 _Glossiness ("Specular Glossiness", Range(0.025000,1.000000)) = 0.950000
[KeywordEnum(None, Specularity, Cubemap)]  _Fresnel ("Fresnel Mode", Float) = 0.000000
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Name "TINT"
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend DstColor Zero, DstAlpha One
  GpuProgramID 48199
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
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
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  discard;
  tmpvar_1 = _Color;
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
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend One OneMinusSrcAlpha, One One
  GpuProgramID 128682
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_3 = normalize(_glesNormal);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * tmpvar_3.x)
   + 
    (v_12.xyz * tmpvar_3.y)
  ) + (v_13.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_14;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_3 = normalize(_glesNormal);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * tmpvar_3.x)
   + 
    (v_12.xyz * tmpvar_3.y)
  ) + (v_13.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_14;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_3 = normalize(_glesNormal);
  highp float tmpvar_6;
  tmpvar_6 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_7;
  tmpvar_7.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_7.w = exp2((-(tmpvar_6) * tmpvar_6));
  highp vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(((
    (v_11.xyz * tmpvar_3.x)
   + 
    (v_12.xyz * tmpvar_3.y)
  ) + (v_13.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_14;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_7 * tmpvar_8);
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_TEXCOORD5 = vec3(0.0, 0.0, 0.0);
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_4 = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  highp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_4.x)
   + 
    (v_14.xyz * tmpvar_4.y)
  ) + (v_15.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_1;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_23;
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_3;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_4 = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  highp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_4.x)
   + 
    (v_14.xyz * tmpvar_4.y)
  ) + (v_15.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_1;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_23;
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_3;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_4 = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  highp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = unity_FogColor.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].x;
  v_13.y = unity_WorldToObject[1].x;
  v_13.z = unity_WorldToObject[2].x;
  v_13.w = unity_WorldToObject[3].x;
  highp vec4 v_14;
  v_14.x = unity_WorldToObject[0].y;
  v_14.y = unity_WorldToObject[1].y;
  v_14.z = unity_WorldToObject[2].y;
  v_14.w = unity_WorldToObject[3].y;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].z;
  v_15.y = unity_WorldToObject[1].z;
  v_15.z = unity_WorldToObject[2].z;
  v_15.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((
    (v_13.xyz * tmpvar_4.x)
   + 
    (v_14.xyz * tmpvar_4.y)
  ) + (v_15.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_16;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_1;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_3 = col_23;
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_11.xyz;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = (tmpvar_8 * tmpvar_9);
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_3;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  worldViewDir_4 = tmpvar_7;
  tmpvar_2 = xlv_TEXCOORD0;
  mediump float tmpvar_8;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec3 lightDir_11;
  lightDir_11 = lightDir_5;
  mediump vec3 viewDir_12;
  viewDir_12 = worldViewDir_4;
  lowp float nh_13;
  lowp vec4 specular_14;
  lowp vec3 worldRefl_15;
  tmpvar_10 = normalize(tmpvar_2);
  mediump vec3 tmpvar_16;
  tmpvar_16 = (-(viewDir_12) - ((2.0 * tmpvar_10) * -(tmpvar_3.w)));
  worldRefl_15 = tmpvar_16;
  mediump vec3 worldNormal_17;
  worldNormal_17 = worldRefl_15;
  mediump float roughness_18;
  roughness_18 = (1.0 - tmpvar_8);
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = worldNormal_17;
  tmpvar_19.w = ((roughness_18 * (1.7 - 
    (0.7 * roughness_18)
  )) * 6.0);
  lowp vec4 tmpvar_20;
  tmpvar_20 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_17, tmpvar_19.w);
  mediump vec4 tmpvar_21;
  tmpvar_21 = tmpvar_20;
  lowp vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = clamp (((tmpvar_21.w * unity_SpecCube0_HDR.x) * tmpvar_21.xyz), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _LightColor0.xyz;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_10, normalize(
    (viewDir_12 + lightDir_11)
  )));
  nh_13 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (nh_13, (tmpvar_8 * 128.0));
  specular_14 = (tmpvar_24 * tmpvar_26);
  specular_14.xyz = (specular_14.xyz + tmpvar_22);
  specular_14.xyz = (specular_14.xyz * vec3(_Specularity));
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = specular_14.xyz;
  tmpvar_27.w = 0.0;
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix ((xlv_TEXCOORD3.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1 = color_28;
  gl_FragData[0] = color_28;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback "Hidden/Holo/Glass Fallback"
}