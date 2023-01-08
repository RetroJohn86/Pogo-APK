//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass without Refraction (Two-sided Diffuse)" {
Properties {
[KeywordEnum(Off, Diffuse, GlassTint, GlassBlend)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit, SpecularColor)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_Specularity ("Specularity", Range(0, 2)) = 1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.95
[KeywordEnum(None, Specularity, Cubemap)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  Cull Front
  GpuProgramID 2018
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ldn_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  wsNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_10;
  wsLight_2 = -(wsLight_2);
  lowp float tmpvar_11;
  tmpvar_11 = dot (wsNormal_3, wsLight_2);
  ldn_1.xyz = vec3(tmpvar_11);
  ldn_1.w = ((tmpvar_11 * 0.5) + 0.5);
  lowp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 1.0);
  tmpvar_12.xy = ldn_1.ww;
  tmpvar_6 = tmpvar_12;
  mediump float tmpvar_13;
  highp float N_14;
  N_14 = wsNormal_3.y;
  tmpvar_13 = ((N_14 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = unity_AmbientEquator.xyz;
  tmpvar_15.w = sky2ground_4;
  tmpvar_7 = tmpvar_15;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  lowp vec4 color_6;
  color_6 = xlv_TEXCOORD2;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = ldn_5;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (texture2D (_Ramp, tmpvar_7).xyz * _LightColor0.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_8 + color_6);
  tmpvar_4 = tmpvar_9;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ldn_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  wsNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_10;
  wsLight_2 = -(wsLight_2);
  lowp float tmpvar_11;
  tmpvar_11 = dot (wsNormal_3, wsLight_2);
  ldn_1.xyz = vec3(tmpvar_11);
  ldn_1.w = ((tmpvar_11 * 0.5) + 0.5);
  lowp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 1.0);
  tmpvar_12.xy = ldn_1.ww;
  tmpvar_6 = tmpvar_12;
  mediump float tmpvar_13;
  highp float N_14;
  N_14 = wsNormal_3.y;
  tmpvar_13 = ((N_14 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = unity_AmbientEquator.xyz;
  tmpvar_15.w = sky2ground_4;
  tmpvar_7 = tmpvar_15;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  lowp vec4 color_6;
  color_6 = xlv_TEXCOORD2;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = ldn_5;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (texture2D (_Ramp, tmpvar_7).xyz * _LightColor0.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_8 + color_6);
  tmpvar_4 = tmpvar_9;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 ldn_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  wsNormal_3 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_10;
  wsLight_2 = -(wsLight_2);
  lowp float tmpvar_11;
  tmpvar_11 = dot (wsNormal_3, wsLight_2);
  ldn_1.xyz = vec3(tmpvar_11);
  ldn_1.w = ((tmpvar_11 * 0.5) + 0.5);
  lowp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 1.0);
  tmpvar_12.xy = ldn_1.ww;
  tmpvar_6 = tmpvar_12;
  mediump float tmpvar_13;
  highp float N_14;
  N_14 = wsNormal_3.y;
  tmpvar_13 = ((N_14 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = unity_AmbientEquator.xyz;
  tmpvar_15.w = sky2ground_4;
  tmpvar_7 = tmpvar_15;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  lowp vec4 color_6;
  color_6 = xlv_TEXCOORD2;
  mediump vec2 tmpvar_7;
  tmpvar_7.y = 0.0;
  tmpvar_7.x = ldn_5;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = (texture2D (_Ramp, tmpvar_7).xyz * _LightColor0.xyz);
  lowp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_8 + color_6);
  tmpvar_4 = tmpvar_9;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
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
 Pass {
  Name "TINT"
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend DstColor Zero, DstAlpha One
  ZClip Off
  ZWrite Off
  GpuProgramID 67335
Program "vp" {
SubProgram "gles hw_tier00 " {
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
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles " {
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  GpuProgramID 144057
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp float rim_8;
  highp vec4 envFogColor_9;
  lowp vec3 vsNormal_10;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_11;
  tmpvar_11 = _glesColor.wwww;
  tmpvar_6.xz = tmpvar_11.xz;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_13;
  tmpvar_13 = dot (normalize((
    (unity_WorldToObject * tmpvar_12)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13;
  tmpvar_14.y = (1.0 - max (0.0, tmpvar_13));
  tmpvar_6.yw = tmpvar_14;
  tmpvar_5 = (tmpvar_5 * sign(tmpvar_13));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_15[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_15[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * tmpvar_5));
  vsNormal_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  highp vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = unity_FogColor.xyz;
  tmpvar_19 = tmpvar_20;
  envFogColor_9 = (tmpvar_18 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = vsNormal_10.x;
  rim_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  if ((rim_8 < 0.0)) {
    tmpvar_22 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_22 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_7;
  tmpvar_4.yzw = (tmpvar_22 * abs(rim_8));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_2 = tmpvar_25;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_9;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = vec3(0.0, 0.0, 0.0);
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp float rim_8;
  highp vec4 envFogColor_9;
  lowp vec3 vsNormal_10;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_11;
  tmpvar_11 = _glesColor.wwww;
  tmpvar_6.xz = tmpvar_11.xz;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_13;
  tmpvar_13 = dot (normalize((
    (unity_WorldToObject * tmpvar_12)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13;
  tmpvar_14.y = (1.0 - max (0.0, tmpvar_13));
  tmpvar_6.yw = tmpvar_14;
  tmpvar_5 = (tmpvar_5 * sign(tmpvar_13));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_15[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_15[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * tmpvar_5));
  vsNormal_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  highp vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = unity_FogColor.xyz;
  tmpvar_19 = tmpvar_20;
  envFogColor_9 = (tmpvar_18 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = vsNormal_10.x;
  rim_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  if ((rim_8 < 0.0)) {
    tmpvar_22 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_22 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_7;
  tmpvar_4.yzw = (tmpvar_22 * abs(rim_8));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_2 = tmpvar_25;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_9;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = vec3(0.0, 0.0, 0.0);
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp float tmpvar_7;
  highp float rim_8;
  highp vec4 envFogColor_9;
  lowp vec3 vsNormal_10;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_11;
  tmpvar_11 = _glesColor.wwww;
  tmpvar_6.xz = tmpvar_11.xz;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_13;
  tmpvar_13 = dot (normalize((
    (unity_WorldToObject * tmpvar_12)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13;
  tmpvar_14.y = (1.0 - max (0.0, tmpvar_13));
  tmpvar_6.yw = tmpvar_14;
  tmpvar_5 = (tmpvar_5 * sign(tmpvar_13));
  highp mat3 tmpvar_15;
  tmpvar_15[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_15[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_15[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * tmpvar_5));
  vsNormal_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_18.w = exp2((-(tmpvar_17) * tmpvar_17));
  highp vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = unity_FogColor.xyz;
  tmpvar_19 = tmpvar_20;
  envFogColor_9 = (tmpvar_18 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = vsNormal_10.x;
  rim_8 = tmpvar_21;
  lowp vec3 tmpvar_22;
  if ((rim_8 < 0.0)) {
    tmpvar_22 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_22 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_7;
  tmpvar_4.yzw = (tmpvar_22 * abs(rim_8));
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_2 = tmpvar_25;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = envFogColor_9;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = vec3(0.0, 0.0, 0.0);
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp float rim_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = _glesColor.wwww;
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = (1.0 - max (0.0, tmpvar_14));
  tmpvar_7.yw = tmpvar_15;
  tmpvar_6 = (tmpvar_6 * sign(tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_6));
  vsNormal_11 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  envFogColor_10 = (tmpvar_19 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = vsNormal_11.x;
  rim_9 = tmpvar_22;
  lowp vec3 tmpvar_23;
  if ((rim_9 < 0.0)) {
    tmpvar_23 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_23 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yzw = (tmpvar_23 * abs(rim_9));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_6 * tmpvar_26));
  worldNormal_2 = tmpvar_27;
  tmpvar_3 = worldNormal_2;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 normal_33;
  normal_33 = worldNormal_2;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_25.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_25.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_25.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * normal_33.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * normal_33.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * normal_33.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_32)
  ))));
  col_34 = (lightColor0_28 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_29 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_30 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_31 * tmpvar_42.w));
  tmpvar_5 = col_34;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_25;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp float rim_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = _glesColor.wwww;
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = (1.0 - max (0.0, tmpvar_14));
  tmpvar_7.yw = tmpvar_15;
  tmpvar_6 = (tmpvar_6 * sign(tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_6));
  vsNormal_11 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  envFogColor_10 = (tmpvar_19 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = vsNormal_11.x;
  rim_9 = tmpvar_22;
  lowp vec3 tmpvar_23;
  if ((rim_9 < 0.0)) {
    tmpvar_23 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_23 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yzw = (tmpvar_23 * abs(rim_9));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_6 * tmpvar_26));
  worldNormal_2 = tmpvar_27;
  tmpvar_3 = worldNormal_2;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 normal_33;
  normal_33 = worldNormal_2;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_25.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_25.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_25.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * normal_33.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * normal_33.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * normal_33.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_32)
  ))));
  col_34 = (lightColor0_28 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_29 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_30 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_31 * tmpvar_42.w));
  tmpvar_5 = col_34;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_25;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp float rim_9;
  highp vec4 envFogColor_10;
  lowp vec3 vsNormal_11;
  tmpvar_6 = normalize(_glesNormal);
  lowp vec4 tmpvar_12;
  tmpvar_12 = _glesColor.wwww;
  tmpvar_7.xz = tmpvar_12.xz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_14;
  tmpvar_14 = dot (normalize((
    (unity_WorldToObject * tmpvar_13)
  .xyz - _glesVertex.xyz)), tmpvar_6);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = (1.0 - max (0.0, tmpvar_14));
  tmpvar_7.yw = tmpvar_15;
  tmpvar_6 = (tmpvar_6 * sign(tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_16[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_16[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * tmpvar_6));
  vsNormal_11 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_19.w = exp2((-(tmpvar_18) * tmpvar_18));
  highp vec4 tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = unity_FogColor.xyz;
  tmpvar_20 = tmpvar_21;
  envFogColor_10 = (tmpvar_19 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = vsNormal_11.x;
  rim_9 = tmpvar_22;
  lowp vec3 tmpvar_23;
  if ((rim_9 < 0.0)) {
    tmpvar_23 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_23 = unity_AmbientSky.xyz;
  };
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yzw = (tmpvar_23 * abs(rim_9));
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_6 * tmpvar_26));
  worldNormal_2 = tmpvar_27;
  tmpvar_3 = worldNormal_2;
  highp vec3 lightColor0_28;
  lightColor0_28 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_29;
  lightColor1_29 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_30;
  lightColor2_30 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_31;
  lightColor3_31 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_32;
  lightAttenSq_32 = unity_4LightAtten0;
  highp vec3 normal_33;
  normal_33 = worldNormal_2;
  highp vec3 col_34;
  highp vec4 ndotl_35;
  highp vec4 lengthSq_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosX0 - tmpvar_25.x);
  highp vec4 tmpvar_38;
  tmpvar_38 = (unity_4LightPosY0 - tmpvar_25.y);
  highp vec4 tmpvar_39;
  tmpvar_39 = (unity_4LightPosZ0 - tmpvar_25.z);
  lengthSq_36 = (tmpvar_37 * tmpvar_37);
  lengthSq_36 = (lengthSq_36 + (tmpvar_38 * tmpvar_38));
  lengthSq_36 = (lengthSq_36 + (tmpvar_39 * tmpvar_39));
  highp vec4 tmpvar_40;
  tmpvar_40 = max (lengthSq_36, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_36 = tmpvar_40;
  ndotl_35 = (tmpvar_37 * normal_33.x);
  ndotl_35 = (ndotl_35 + (tmpvar_38 * normal_33.y));
  ndotl_35 = (ndotl_35 + (tmpvar_39 * normal_33.z));
  highp vec4 tmpvar_41;
  tmpvar_41 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_35 * inversesqrt(tmpvar_40)));
  ndotl_35 = tmpvar_41;
  highp vec4 tmpvar_42;
  tmpvar_42 = (tmpvar_41 * (1.0/((1.0 + 
    (tmpvar_40 * lightAttenSq_32)
  ))));
  col_34 = (lightColor0_28 * tmpvar_42.x);
  col_34 = (col_34 + (lightColor1_29 * tmpvar_42.y));
  col_34 = (col_34 + (lightColor2_30 * tmpvar_42.z));
  col_34 = (col_34 + (lightColor3_31 * tmpvar_42.w));
  tmpvar_5 = col_34;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_25;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = envFogColor_10;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
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
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying lowp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  highp vec4 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6.x = 1.0;
  tmpvar_7 = xlv_TEXCOORD5.yzw;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_4 = tmpvar_9;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_10;
  mediump float tmpvar_11;
  lowp float tmpvar_12;
  lowp vec4 tmpvar_13;
  lowp vec3 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_16;
  lowp vec4 leftRim_17;
  mediump vec4 c_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_18 = tmpvar_19;
  c_18.xyz = (c_18.xyz * c_18.w);
  highp vec4 tmpvar_20;
  tmpvar_20.xyz = c_18.xyz;
  tmpvar_20.w = tmpvar_6.w;
  tmpvar_10 = tmpvar_20;
  tmpvar_12 = c_18.w;
  leftRim_17 = xlv_TEXCOORD3;
  highp vec3 tmpvar_21;
  tmpvar_21 = tmpvar_6.xyz;
  vlight_16 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = vlight_16;
  tmpvar_22.w = leftRim_17.y;
  tmpvar_13 = tmpvar_22;
  tmpvar_14 = tmpvar_7;
  tmpvar_15.w = c_18.w;
  tmpvar_11 = _Glossiness;
  tmpvar_3 = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_10.xyz * xlv_TEXCOORD6);
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_13.xyz;
  mediump vec3 lightDir_26;
  lightDir_26 = lightDir_5;
  mediump vec3 viewDir_27;
  viewDir_27 = worldViewDir_4;
  lowp float nh_28;
  lowp vec4 specular_29;
  lowp vec3 color_30;
  lowp vec3 worldRefl_31;
  lowp vec4 ramp_32;
  lowp vec4 ldn_33;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_34;
  tmpvar_34 = vec4(dot (tmpvar_24, lightDir_26));
  ldn_33 = tmpvar_34;
  ldn_33.w = ((ldn_33.x * 0.5) + 0.5);
  tmpvar_25.w = (1.0 - clamp (tmpvar_13.w, 0.0, 1.0));
  lowp vec2 tmpvar_35;
  tmpvar_35.x = ldn_33.w;
  tmpvar_35.y = tmpvar_25.w;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_Ramp, tmpvar_35);
  mediump vec4 tmpvar_37;
  tmpvar_37 = tmpvar_36;
  ramp_32 = tmpvar_37;
  lowp vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((ramp_32.xyz * _LightColor0.xyz) + ((tmpvar_14 * ramp_32.www) + tmpvar_13.xyz));
  mediump vec3 tmpvar_39;
  tmpvar_39 = (-(viewDir_27) - ((2.0 * tmpvar_24) * -(tmpvar_13.w)));
  worldRefl_31 = tmpvar_39;
  mediump vec3 worldNormal_40;
  worldNormal_40 = worldRefl_31;
  mediump float perceptualRoughness_41;
  perceptualRoughness_41 = (1.0 - tmpvar_11);
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = worldNormal_40;
  tmpvar_42.w = ((perceptualRoughness_41 * (1.7 - 
    (0.7 * perceptualRoughness_41)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_40, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  mediump float tmpvar_45;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_45 = tmpvar_44.w;
  } else {
    tmpvar_45 = 1.0;
  };
  lowp vec3 tmpvar_46;
  mediump vec3 tmpvar_47;
  tmpvar_47 = clamp (((unity_SpecCube0_HDR.x * tmpvar_45) * tmpvar_44.xyz), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  mediump vec3 tmpvar_48;
  tmpvar_48 = (tmpvar_10.xyz * tmpvar_38.xyz);
  color_30 = tmpvar_48;
  lowp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = _LightColor0.xyz;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (tmpvar_24, normalize(
    (viewDir_27 + lightDir_26)
  )));
  nh_28 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (nh_28, (tmpvar_11 * 128.0));
  specular_29 = (tmpvar_49 * tmpvar_51);
  specular_29.xyz = (specular_29.xyz + tmpvar_46);
  specular_29.xyz = (specular_29.xyz * vec3(_Specularity));
  color_30 = (color_30 + specular_29.xyz);
  lowp vec4 tmpvar_52;
  tmpvar_52.xyz = color_30;
  tmpvar_52.w = tmpvar_12;
  tmpvar_23 = tmpvar_52;
  c_1 = (c_1 + tmpvar_23);
  lowp vec4 color_53;
  color_53.w = c_1.w;
  highp vec3 tmpvar_54;
  tmpvar_54 = mix ((xlv_TEXCOORD4.xyz * c_1.w), c_1.xyz, xlv_TEXCOORD4.www);
  color_53.xyz = tmpvar_54;
  c_1 = color_53;
  gl_FragData[0] = color_53;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Hidden/Holo/Glass Fallback (Two-sided Diffuse)"
CustomEditor "CustomMaterialInspector"
}