//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass" {
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
 _RefractionAmount ("Refraction Amount", Float) = 100.000000
}
SubShader { 
 LOD 400
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 GrabPass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" }
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Opaque" }
  GpuProgramID 48049
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * tmpvar_4.x)
   + 
    (v_18.xyz * tmpvar_4.y)
  ) + (v_19.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_21;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  tmpvar_27.w = ((specular_14.x + specular_14.y) + (specular_14.z * 0.333));
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  lowp vec3 uvgrab_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_29 = tmpvar_30;
  uvgrab_29.xy = (uvgrab_29.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_29.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_28 = (c_1 + texture2D (_GrabTexture, uvgrab_29.xy));
  color_28.w = min (1.0, color_28.w);
  highp vec3 tmpvar_31;
  tmpvar_31 = mix ((xlv_TEXCOORD4.xyz * color_28.w), color_28.xyz, xlv_TEXCOORD4.www);
  color_28.xyz = tmpvar_31;
  color_28 = (color_28 + (tmpvar_3 * 0.0001));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * tmpvar_4.x)
   + 
    (v_18.xyz * tmpvar_4.y)
  ) + (v_19.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_21;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  tmpvar_27.w = ((specular_14.x + specular_14.y) + (specular_14.z * 0.333));
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  lowp vec3 uvgrab_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_29 = tmpvar_30;
  uvgrab_29.xy = (uvgrab_29.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_29.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_28 = (c_1 + texture2D (_GrabTexture, uvgrab_29.xy));
  color_28.w = min (1.0, color_28.w);
  highp vec3 tmpvar_31;
  tmpvar_31 = mix ((xlv_TEXCOORD4.xyz * color_28.w), color_28.xyz, xlv_TEXCOORD4.www);
  color_28.xyz = tmpvar_31;
  color_28 = (color_28 + (tmpvar_3 * 0.0001));
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_9[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_9[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * tmpvar_4));
  vsNormal_8 = tmpvar_10;
  tmpvar_7 = ((vsNormal_8.xy * vsNormal_8.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_11;
  tmpvar_11 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_12;
  tmpvar_12.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_12.w = exp2((-(tmpvar_11) * tmpvar_11));
  highp vec4 tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = unity_FogColor.xyz;
  tmpvar_13 = tmpvar_14;
  tmpvar_3.x = tmpvar_6;
  tmpvar_3.yz = tmpvar_7;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * tmpvar_4.x)
   + 
    (v_18.xyz * tmpvar_4.y)
  ) + (v_19.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_15.zw;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_21;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_12 * tmpvar_13);
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
uniform sampler2D _GrabTexture;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCOORD5;
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
  tmpvar_27.w = ((specular_14.x + specular_14.y) + (specular_14.z * 0.333));
  tmpvar_9 = tmpvar_27;
  c_1 = tmpvar_9;
  lowp vec4 color_28;
  lowp vec3 uvgrab_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD2.xyz / xlv_TEXCOORD2.w);
  uvgrab_29 = tmpvar_30;
  uvgrab_29.xy = (uvgrab_29.xy - ((xlv_TEXCOORD5.yz / xlv_TEXCOORD2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_29.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  color_28 = (c_1 + texture2D (_GrabTexture, uvgrab_29.xy));
  color_28.w = min (1.0, color_28.w);
  highp vec3 tmpvar_31;
  tmpvar_31 = mix ((xlv_TEXCOORD4.xyz * color_28.w), color_28.xyz, xlv_TEXCOORD4.www);
  color_28.xyz = tmpvar_31;
  color_28 = (color_28 + (tmpvar_3 * 0.0001));
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
Fallback "Holo/Glass without Refraction"
}