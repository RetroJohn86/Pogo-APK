//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Pokeball" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _Specularity ("Specularity", Range(0.000000,2.000000)) = 0.100000
 _Glossiness ("Specular Glossiness", Range(0.025000,1.000000)) = 0.100000
 _SpecularBacklight ("Specular Backlight", Color) = (0.000000,0.000000,0.000000,1.000000)
 _FresnelBias ("    Fresnel Bias", Range(0.000000,1.000000)) = 0.200000
 _FresnelPower ("    Fresnel Power", Range(0.000000,5.000000)) = 2.000000
 _Metalness ("    Metalness", Range(0.000000,1.000000)) = 1.000000
}
SubShader { 
 LOD 275
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  GpuProgramID 31480
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_7 = (tmpvar_21 * tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  lowp float tmpvar_28;
  tmpvar_28 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_28)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_29 * tmpvar_29)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * tmpvar_5));
  vsNormal_8 = tmpvar_31;
  vec3 tmpvar_32;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_32 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_32 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_32 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_34;
  tmpvar_34 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].x;
  v_35.y = unity_WorldToObject[1].x;
  v_35.z = unity_WorldToObject[2].x;
  v_35.w = unity_WorldToObject[3].x;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].y;
  v_36.y = unity_WorldToObject[1].y;
  v_36.z = unity_WorldToObject[2].y;
  v_36.w = unity_WorldToObject[3].y;
  highp vec4 v_37;
  v_37.x = unity_WorldToObject[0].z;
  v_37.y = unity_WorldToObject[1].z;
  v_37.z = unity_WorldToObject[2].z;
  v_37.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_5.x)
   + 
    (v_36.xyz * tmpvar_5.y)
  ) + (v_37.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_38;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_34);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_7 = (tmpvar_21 * tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  lowp float tmpvar_28;
  tmpvar_28 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_28)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_29 * tmpvar_29)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * tmpvar_5));
  vsNormal_8 = tmpvar_31;
  vec3 tmpvar_32;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_32 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_32 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_32 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_34;
  tmpvar_34 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].x;
  v_35.y = unity_WorldToObject[1].x;
  v_35.z = unity_WorldToObject[2].x;
  v_35.w = unity_WorldToObject[3].x;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].y;
  v_36.y = unity_WorldToObject[1].y;
  v_36.z = unity_WorldToObject[2].y;
  v_36.w = unity_WorldToObject[3].y;
  highp vec4 v_37;
  v_37.x = unity_WorldToObject[0].z;
  v_37.y = unity_WorldToObject[1].z;
  v_37.z = unity_WorldToObject[2].z;
  v_37.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_5.x)
   + 
    (v_36.xyz * tmpvar_5.y)
  ) + (v_37.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_38;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_34);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  lowp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = unity_FogColor.xyz;
  tmpvar_7 = (tmpvar_21 * tmpvar_22);
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_23;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].x;
  v_24.y = unity_WorldToObject[1].x;
  v_24.z = unity_WorldToObject[2].x;
  v_24.w = unity_WorldToObject[3].x;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].y;
  v_25.y = unity_WorldToObject[1].y;
  v_25.z = unity_WorldToObject[2].y;
  v_25.w = unity_WorldToObject[3].y;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].z;
  v_26.y = unity_WorldToObject[1].z;
  v_26.z = unity_WorldToObject[2].z;
  v_26.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_24.xyz * tmpvar_5.x)
   + 
    (v_25.xyz * tmpvar_5.y)
  ) + (v_26.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_27;
  lowp float tmpvar_28;
  tmpvar_28 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_28)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_29 * tmpvar_29)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * tmpvar_5));
  vsNormal_8 = tmpvar_31;
  vec3 tmpvar_32;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_32 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_32 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_32 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_34;
  tmpvar_34 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].x;
  v_35.y = unity_WorldToObject[1].x;
  v_35.z = unity_WorldToObject[2].x;
  v_35.w = unity_WorldToObject[3].x;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].y;
  v_36.y = unity_WorldToObject[1].y;
  v_36.z = unity_WorldToObject[2].y;
  v_36.w = unity_WorldToObject[3].y;
  highp vec4 v_37;
  v_37.x = unity_WorldToObject[0].z;
  v_37.y = unity_WorldToObject[1].z;
  v_37.z = unity_WorldToObject[2].z;
  v_37.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_5.x)
   + 
    (v_36.xyz * tmpvar_5.y)
  ) + (v_37.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_38;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_34);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump vec4 _CharacterColor;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  tmpvar_7 = (tmpvar_21 * _CharacterColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_22;
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_5.x)
   + 
    (v_24.xyz * tmpvar_5.y)
  ) + (v_25.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_27)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_29;
  tmpvar_29[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_29[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_29[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29 * tmpvar_5));
  vsNormal_8 = tmpvar_30;
  vec3 tmpvar_31;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_31 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_31 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_31 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].x;
  v_34.y = unity_WorldToObject[1].x;
  v_34.z = unity_WorldToObject[2].x;
  v_34.w = unity_WorldToObject[3].x;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].y;
  v_35.y = unity_WorldToObject[1].y;
  v_35.z = unity_WorldToObject[2].y;
  v_35.w = unity_WorldToObject[3].y;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].z;
  v_36.y = unity_WorldToObject[1].z;
  v_36.z = unity_WorldToObject[2].z;
  v_36.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_5.x)
   + 
    (v_35.xyz * tmpvar_5.y)
  ) + (v_36.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_37;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_33);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump vec4 _CharacterColor;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  tmpvar_7 = (tmpvar_21 * _CharacterColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_22;
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_5.x)
   + 
    (v_24.xyz * tmpvar_5.y)
  ) + (v_25.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_27)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_29;
  tmpvar_29[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_29[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_29[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29 * tmpvar_5));
  vsNormal_8 = tmpvar_30;
  vec3 tmpvar_31;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_31 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_31 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_31 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].x;
  v_34.y = unity_WorldToObject[1].x;
  v_34.z = unity_WorldToObject[2].x;
  v_34.w = unity_WorldToObject[3].x;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].y;
  v_35.y = unity_WorldToObject[1].y;
  v_35.z = unity_WorldToObject[2].y;
  v_35.w = unity_WorldToObject[3].y;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].z;
  v_36.y = unity_WorldToObject[1].z;
  v_36.z = unity_WorldToObject[2].z;
  v_36.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_5.x)
   + 
    (v_35.xyz * tmpvar_5.y)
  ) + (v_36.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_37;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_33);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _LightColor0;
uniform mediump float _Ground;
uniform mediump vec4 _CharacterColor;
uniform mediump float _Metalness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = _glesColor;
  mediump vec4 tmpvar_7;
  mediump vec3 vsNormal_8;
  mediump vec3 diffuse_9;
  mediump vec3 worldNormal_10;
  mediump vec3 worldPos_11;
  mediump float unityFogFactor_12;
  mediump vec4 coord_13;
  mediump vec2 vdn_14;
  mediump vec3 osView_15;
  tmpvar_5 = normalize(_glesNormal);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((unity_WorldToObject * tmpvar_16).xyz - _glesVertex.xyz));
  osView_15 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = vec2(dot (osView_15, tmpvar_5));
  vdn_14 = tmpvar_18;
  vdn_14.y = (1.0 - max (vec2(0.0, 0.0), vdn_14)).x;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_mvp * _glesVertex);
  coord_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * coord_13.z);
  unityFogFactor_12 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(unityFogFactor_12) * unityFogFactor_12));
  tmpvar_7 = (tmpvar_21 * _CharacterColor);
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex).xyz;
  worldPos_11 = tmpvar_22;
  highp vec4 v_23;
  v_23.x = unity_WorldToObject[0].x;
  v_23.y = unity_WorldToObject[1].x;
  v_23.z = unity_WorldToObject[2].x;
  v_23.w = unity_WorldToObject[3].x;
  highp vec4 v_24;
  v_24.x = unity_WorldToObject[0].y;
  v_24.y = unity_WorldToObject[1].y;
  v_24.z = unity_WorldToObject[2].y;
  v_24.w = unity_WorldToObject[3].y;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].z;
  v_25.y = unity_WorldToObject[1].z;
  v_25.z = unity_WorldToObject[2].z;
  v_25.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((
    (v_23.xyz * tmpvar_5.x)
   + 
    (v_24.xyz * tmpvar_5.y)
  ) + (v_25.xyz * tmpvar_5.z)));
  worldNormal_10 = tmpvar_26;
  lowp float tmpvar_27;
  tmpvar_27 = min (1.0, unity_AmbientGround.w);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    (worldPos_11.y - _Ground)
   * tmpvar_27)), 0.0, 1.0);
  diffuse_9 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * 
    max (0.0, -(worldNormal_10.y))
  ))) * _glesColor.w);
  diffuse_9 = (diffuse_9 + ((
    (dot (worldNormal_10, _WorldSpaceLightPos0.xyz) * 0.5)
   + 0.5) * _LightColor0.xyz));
  highp mat3 tmpvar_29;
  tmpvar_29[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_29[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_29[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29 * tmpvar_5));
  vsNormal_8 = tmpvar_30;
  vec3 tmpvar_31;
  if ((vsNormal_8.x <= 0.0)) {
    tmpvar_31 = vec3(-1.0, -1.0, -1.0);
  } else {
    tmpvar_31 = vec3(0.0, 0.0, 0.0);
  };
  diffuse_9 = (diffuse_9 + ((
    ((tmpvar_31 + unity_AmbientSky.xyz) * vsNormal_8.x)
   * vdn_14.y) * vdn_14.y));
  diffuse_9 = (diffuse_9 * (1.0 - _Metalness));
  tmpvar_6.xyz = diffuse_9;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_1.xyz;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].x;
  v_34.y = unity_WorldToObject[1].x;
  v_34.z = unity_WorldToObject[2].x;
  v_34.w = unity_WorldToObject[3].x;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].y;
  v_35.y = unity_WorldToObject[1].y;
  v_35.z = unity_WorldToObject[2].y;
  v_35.w = unity_WorldToObject[3].y;
  highp vec4 v_36;
  v_36.x = unity_WorldToObject[0].z;
  v_36.y = unity_WorldToObject[1].z;
  v_36.z = unity_WorldToObject[2].z;
  v_36.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_5.x)
   + 
    (v_35.xyz * tmpvar_5.y)
  ) + (v_36.xyz * tmpvar_5.z)));
  worldNormal_2 = tmpvar_37;
  tmpvar_4 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_32);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_33);
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

uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump float _Specularity;
uniform mediump float _Glossiness;
uniform mediump vec4 _SpecularBacklight;
uniform mediump float _FresnelBias;
uniform mediump float _FresnelPower;
uniform mediump float _Metalness;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(xlv_TEXCOORD4);
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec3 tmpvar_7;
  mediump vec4 color_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_8 = tmpvar_9;
  tmpvar_7 = (color_8.xyz * tmpvar_4.xyz);
  mediump vec3 lightDir_10;
  lightDir_10 = lightDir_3;
  mediump vec3 viewDir_11;
  viewDir_11 = worldViewDir_2;
  mediump vec4 specular_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD1);
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_14.w = color_8.w;
  specular_12.w = tmpvar_14.w;
  mediump float tmpvar_15;
  tmpvar_15 = (_Glossiness * 128.0);
  specular_12.xyz = (pow (vec3(clamp (
    dot (tmpvar_13, normalize((viewDir_11 + lightDir_10)))
  , 0.0, 1.0)), vec3(tmpvar_15)) * _LightColor0.xyz);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (dot (viewDir_11, tmpvar_13), 0.0, 1.0);
  mediump float roughness_17;
  roughness_17 = (1.0 - _Glossiness);
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = (-(viewDir_11) - ((2.0 * tmpvar_13) * -(tmpvar_16)));
  tmpvar_18.w = ((roughness_17 * (1.7 - 
    (0.7 * roughness_17)
  )) * 6.0);
  lowp vec4 tmpvar_19;
  tmpvar_19 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_18.xyz, tmpvar_18.w);
  mediump vec4 tmpvar_20;
  tmpvar_20 = tmpvar_19;
  specular_12.xyz = (specular_12.xyz + ((
    ((tmpvar_20.w * unity_SpecCube0_HDR.x) * tmpvar_20.xyz)
   + 
    (pow (max (0.0, dot (tmpvar_13, 
      normalize((viewDir_11 - lightDir_10))
    )), (tmpvar_15 * _SpecularBacklight.w)) * _SpecularBacklight.xyz)
  ) * mix (
    pow ((1.0 - tmpvar_16), _FresnelPower)
  , 1.0, _FresnelBias)));
  specular_12.xyz = (specular_12.xyz * (_Specularity * (
    (color_8.xyz * _Metalness)
   + 
    (1.0 - _Metalness)
  )));
  c_1 = specular_12;
  c_1.xyz = (c_1.xyz + tmpvar_7);
  mediump vec4 color_21;
  color_21 = c_1;
  color_21.xyz = mix (xlv_TEXCOORD3.xyz, color_21.xyz, xlv_TEXCOORD3.www);
  c_1.xyz = color_21.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback "Mobile/Diffuse"
}