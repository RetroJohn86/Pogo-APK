//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Glass (Two-sided Diffuse)" {
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
_RefractionAmount ("Refraction Amount", Float) = 100
}
SubShader {
 LOD 450
 Tags { "QUEUE" = "Transparent" "RenderType" = "Opaque" }
 Pass {
  LOD 450
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  Blend SrcAlpha OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  Cull Front
  GpuProgramID 59629
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
 GrabPass {
}
 Pass {
  Name "FORWARD"
  LOD 450
  Tags { "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 128406
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec2 tmpvar_9;
  highp float rim_10;
  highp vec3 vlight_11;
  lowp vec3 worldNormal_12;
  lowp vec3 vsNormal_13;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = tmpvar_1.wwww;
  tmpvar_7.xz = tmpvar_14.xz;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = (1.0 - max (0.0, tmpvar_16));
  tmpvar_7.yw = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
  vsNormal_13 = tmpvar_19;
  tmpvar_9 = ((vsNormal_13.xy * vsNormal_13.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_12 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_12.y));
  vlight_11 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_11;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_13.x;
  rim_10 = tmpvar_29;
  tmpvar_7.x = rim_10;
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yz = tmpvar_9;
  highp vec4 tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  tmpvar_30 = (glstate_matrix_mvp * tmpvar_31);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_5 * tmpvar_32));
  worldNormal_2 = tmpvar_33;
  tmpvar_3 = worldNormal_2;
  highp vec4 o_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_30 * 0.5);
  highp vec2 tmpvar_36;
  tmpvar_36.x = tmpvar_35.x;
  tmpvar_36.y = (tmpvar_35.y * _ProjectionParams.x);
  o_34.xy = (tmpvar_36 + tmpvar_35.w);
  o_34.zw = tmpvar_30.zw;
  gl_Position = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_27.xyz;
  xlv_TEXCOORD3 = o_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = (tmpvar_21 * tmpvar_22);
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump float tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  highp vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_10;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_13 = tmpvar_3;
  tmpvar_15 = tmpvar_4;
  tmpvar_16 = tmpvar_5;
  mediump vec3 vlight_17;
  lowp vec4 leftRim_18;
  mediump vec4 c_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_19 = tmpvar_20;
  c_19.xyz = (c_19.xyz * c_19.w);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = c_19.xyz;
  tmpvar_21.w = tmpvar_8.w;
  tmpvar_11 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = c_19.wwww;
  tmpvar_12 = tmpvar_22;
  leftRim_18 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_8.xyz;
  vlight_17 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_17;
  tmpvar_24.w = leftRim_18.y;
  tmpvar_14 = tmpvar_24;
  lowp vec3 tmpvar_25;
  if ((leftRim_18.x < 0.0)) {
    tmpvar_25 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_25 = unity_AmbientSky.xyz;
  };
  tmpvar_15 = (tmpvar_25 * abs(leftRim_18.x));
  tmpvar_16.w = c_19.w;
  tmpvar_12.xyz = vec3(_Specularity);
  tmpvar_13 = _Glossiness;
  tmpvar_3 = tmpvar_13;
  tmpvar_4 = tmpvar_15;
  tmpvar_5 = tmpvar_16;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_26;
  lowp vec3 tmpvar_27;
  lowp float tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_28 = 0.0;
  tmpvar_29.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_7;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_6;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec3 worldRefl_35;
  lowp vec4 ldn_36;
  tmpvar_27 = normalize(tmpvar_2);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_27, lightDir_30));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  tmpvar_29.w = (1.0 - clamp (tmpvar_14.w, 0.0, 1.0));
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_36.w;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_Ramp, tmpvar_38);
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((tmpvar_39.xyz * _LightColor0.xyz) + ((tmpvar_15 * tmpvar_39.www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_41;
  tmpvar_41 = (-(viewDir_31) - ((2.0 * tmpvar_27) * -(tmpvar_14.w)));
  worldRefl_35 = tmpvar_41;
  mediump vec3 worldNormal_42;
  worldNormal_42 = worldRefl_35;
  mediump float perceptualRoughness_43;
  perceptualRoughness_43 = (1.0 - tmpvar_13);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = worldNormal_42;
  tmpvar_44.w = ((perceptualRoughness_43 * (1.7 - 
    (0.7 * perceptualRoughness_43)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_42, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump float tmpvar_47;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_47 = tmpvar_46.w;
  } else {
    tmpvar_47 = 1.0;
  };
  lowp vec3 tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = clamp (((unity_SpecCube0_HDR.x * tmpvar_47) * tmpvar_46.xyz), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_11.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_50;
  lowp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = _LightColor0.xyz;
  mediump float tmpvar_52;
  tmpvar_52 = max (0.0, dot (tmpvar_27, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = pow (nh_32, (tmpvar_13 * 128.0));
  specular_33 = (tmpvar_51 * tmpvar_53);
  specular_33.xyz = (specular_33.xyz + tmpvar_48);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  tmpvar_28 = ((specular_33.x + specular_33.y) + (specular_33.z * 0.333));
  lowp vec4 tmpvar_54;
  tmpvar_54.xyz = color_34;
  tmpvar_54.w = tmpvar_28;
  tmpvar_26 = tmpvar_54;
  c_1 = tmpvar_26;
  lowp vec4 color_55;
  lowp vec3 uvgrab_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
  uvgrab_56 = tmpvar_57;
  uvgrab_56.xy = (uvgrab_56.xy - ((xlv_TEXCOORD6.yz / xlv_TEXCOORD3.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_56.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_58;
  tmpvar_58 = texture2D (_GrabTexture, uvgrab_56.xy);
  lowp vec4 tmpvar_59;
  tmpvar_59.xyz = (tmpvar_58.xyz * (1.0 - tmpvar_12.w));
  tmpvar_59.w = tmpvar_58.w;
  color_55 = (c_1 + tmpvar_59);
  color_55.w = min (1.0, (tmpvar_12.w + color_55.w));
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (xlv_TEXCOORD5.xyz, color_55.xyz, xlv_TEXCOORD5.www);
  color_55.xyz = tmpvar_60;
  color_55 = (color_55 + (tmpvar_14 * 0.0001));
  c_1 = color_55;
  gl_FragData[0] = color_55;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec2 tmpvar_9;
  highp float rim_10;
  highp vec3 vlight_11;
  lowp vec3 worldNormal_12;
  lowp vec3 vsNormal_13;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = tmpvar_1.wwww;
  tmpvar_7.xz = tmpvar_14.xz;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = (1.0 - max (0.0, tmpvar_16));
  tmpvar_7.yw = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
  vsNormal_13 = tmpvar_19;
  tmpvar_9 = ((vsNormal_13.xy * vsNormal_13.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_12 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_12.y));
  vlight_11 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_11;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_13.x;
  rim_10 = tmpvar_29;
  tmpvar_7.x = rim_10;
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yz = tmpvar_9;
  highp vec4 tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  tmpvar_30 = (glstate_matrix_mvp * tmpvar_31);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_5 * tmpvar_32));
  worldNormal_2 = tmpvar_33;
  tmpvar_3 = worldNormal_2;
  highp vec4 o_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_30 * 0.5);
  highp vec2 tmpvar_36;
  tmpvar_36.x = tmpvar_35.x;
  tmpvar_36.y = (tmpvar_35.y * _ProjectionParams.x);
  o_34.xy = (tmpvar_36 + tmpvar_35.w);
  o_34.zw = tmpvar_30.zw;
  gl_Position = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_27.xyz;
  xlv_TEXCOORD3 = o_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = (tmpvar_21 * tmpvar_22);
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump float tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  highp vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_10;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_13 = tmpvar_3;
  tmpvar_15 = tmpvar_4;
  tmpvar_16 = tmpvar_5;
  mediump vec3 vlight_17;
  lowp vec4 leftRim_18;
  mediump vec4 c_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_19 = tmpvar_20;
  c_19.xyz = (c_19.xyz * c_19.w);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = c_19.xyz;
  tmpvar_21.w = tmpvar_8.w;
  tmpvar_11 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = c_19.wwww;
  tmpvar_12 = tmpvar_22;
  leftRim_18 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_8.xyz;
  vlight_17 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_17;
  tmpvar_24.w = leftRim_18.y;
  tmpvar_14 = tmpvar_24;
  lowp vec3 tmpvar_25;
  if ((leftRim_18.x < 0.0)) {
    tmpvar_25 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_25 = unity_AmbientSky.xyz;
  };
  tmpvar_15 = (tmpvar_25 * abs(leftRim_18.x));
  tmpvar_16.w = c_19.w;
  tmpvar_12.xyz = vec3(_Specularity);
  tmpvar_13 = _Glossiness;
  tmpvar_3 = tmpvar_13;
  tmpvar_4 = tmpvar_15;
  tmpvar_5 = tmpvar_16;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_26;
  lowp vec3 tmpvar_27;
  lowp float tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_28 = 0.0;
  tmpvar_29.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_7;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_6;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec3 worldRefl_35;
  lowp vec4 ldn_36;
  tmpvar_27 = normalize(tmpvar_2);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_27, lightDir_30));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  tmpvar_29.w = (1.0 - clamp (tmpvar_14.w, 0.0, 1.0));
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_36.w;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_Ramp, tmpvar_38);
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((tmpvar_39.xyz * _LightColor0.xyz) + ((tmpvar_15 * tmpvar_39.www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_41;
  tmpvar_41 = (-(viewDir_31) - ((2.0 * tmpvar_27) * -(tmpvar_14.w)));
  worldRefl_35 = tmpvar_41;
  mediump vec3 worldNormal_42;
  worldNormal_42 = worldRefl_35;
  mediump float perceptualRoughness_43;
  perceptualRoughness_43 = (1.0 - tmpvar_13);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = worldNormal_42;
  tmpvar_44.w = ((perceptualRoughness_43 * (1.7 - 
    (0.7 * perceptualRoughness_43)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_42, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump float tmpvar_47;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_47 = tmpvar_46.w;
  } else {
    tmpvar_47 = 1.0;
  };
  lowp vec3 tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = clamp (((unity_SpecCube0_HDR.x * tmpvar_47) * tmpvar_46.xyz), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_11.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_50;
  lowp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = _LightColor0.xyz;
  mediump float tmpvar_52;
  tmpvar_52 = max (0.0, dot (tmpvar_27, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = pow (nh_32, (tmpvar_13 * 128.0));
  specular_33 = (tmpvar_51 * tmpvar_53);
  specular_33.xyz = (specular_33.xyz + tmpvar_48);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  tmpvar_28 = ((specular_33.x + specular_33.y) + (specular_33.z * 0.333));
  lowp vec4 tmpvar_54;
  tmpvar_54.xyz = color_34;
  tmpvar_54.w = tmpvar_28;
  tmpvar_26 = tmpvar_54;
  c_1 = tmpvar_26;
  lowp vec4 color_55;
  lowp vec3 uvgrab_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
  uvgrab_56 = tmpvar_57;
  uvgrab_56.xy = (uvgrab_56.xy - ((xlv_TEXCOORD6.yz / xlv_TEXCOORD3.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_56.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_58;
  tmpvar_58 = texture2D (_GrabTexture, uvgrab_56.xy);
  lowp vec4 tmpvar_59;
  tmpvar_59.xyz = (tmpvar_58.xyz * (1.0 - tmpvar_12.w));
  tmpvar_59.w = tmpvar_58.w;
  color_55 = (c_1 + tmpvar_59);
  color_55.w = min (1.0, (tmpvar_12.w + color_55.w));
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (xlv_TEXCOORD5.xyz, color_55.xyz, xlv_TEXCOORD5.www);
  color_55.xyz = tmpvar_60;
  color_55 = (color_55 + (tmpvar_14 * 0.0001));
  c_1 = color_55;
  gl_FragData[0] = color_55;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform lowp float _RefractionAmount;
uniform lowp vec2 _GrabTexture_TexelSize;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = tmpvar_1.w;
  highp vec4 tmpvar_7;
  highp float tmpvar_8;
  highp vec2 tmpvar_9;
  highp float rim_10;
  highp vec3 vlight_11;
  lowp vec3 worldNormal_12;
  lowp vec3 vsNormal_13;
  tmpvar_5 = normalize(_glesNormal);
  lowp vec4 tmpvar_14;
  tmpvar_14 = tmpvar_1.wwww;
  tmpvar_7.xz = tmpvar_14.xz;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_16;
  tmpvar_16 = dot (normalize((
    (unity_WorldToObject * tmpvar_15)
  .xyz - _glesVertex.xyz)), tmpvar_5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16;
  tmpvar_17.y = (1.0 - max (0.0, tmpvar_16));
  tmpvar_7.yw = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_18[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_18[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * tmpvar_5));
  vsNormal_13 = tmpvar_19;
  tmpvar_9 = ((vsNormal_13.xy * vsNormal_13.z) * (_RefractionAmount * _GrabTexture_TexelSize));
  highp float tmpvar_20;
  tmpvar_20 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_21.w = exp2((-(tmpvar_20) * tmpvar_20));
  highp vec4 tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  tmpvar_22 = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_WorldToObject[0].xyz;
  tmpvar_24[1] = unity_WorldToObject[1].xyz;
  tmpvar_24[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_5 * tmpvar_24));
  worldNormal_12 = tmpvar_25;
  highp float tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_26 = clamp ((1.0 - (
    (tmpvar_27.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(worldNormal_12.y));
  vlight_11 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_26 * tmpvar_26)
   * tmpvar_28))) * tmpvar_7.x);
  tmpvar_6.xyz = vlight_11;
  lowp float tmpvar_29;
  tmpvar_29 = vsNormal_13.x;
  rim_10 = tmpvar_29;
  tmpvar_7.x = rim_10;
  tmpvar_4.x = tmpvar_8;
  tmpvar_4.yz = tmpvar_9;
  highp vec4 tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  tmpvar_30 = (glstate_matrix_mvp * tmpvar_31);
  highp mat3 tmpvar_32;
  tmpvar_32[0] = unity_WorldToObject[0].xyz;
  tmpvar_32[1] = unity_WorldToObject[1].xyz;
  tmpvar_32[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((tmpvar_5 * tmpvar_32));
  worldNormal_2 = tmpvar_33;
  tmpvar_3 = worldNormal_2;
  highp vec4 o_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_30 * 0.5);
  highp vec2 tmpvar_36;
  tmpvar_36.x = tmpvar_35.x;
  tmpvar_36.y = (tmpvar_35.y * _ProjectionParams.x);
  o_34.xy = (tmpvar_36 + tmpvar_35.w);
  o_34.zw = tmpvar_30.zw;
  gl_Position = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_27.xyz;
  xlv_TEXCOORD3 = o_34;
  xlv_COLOR0 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = (tmpvar_21 * tmpvar_22);
  xlv_TEXCOORD6 = tmpvar_4;
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
uniform lowp vec4 unity_AmbientSky;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _GrabTexture;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  mediump float tmpvar_3;
  lowp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  highp vec4 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_6 = tmpvar_10;
  tmpvar_8 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_11;
  lowp vec4 tmpvar_12;
  mediump float tmpvar_13;
  lowp vec4 tmpvar_14;
  lowp vec3 tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_13 = tmpvar_3;
  tmpvar_15 = tmpvar_4;
  tmpvar_16 = tmpvar_5;
  mediump vec3 vlight_17;
  lowp vec4 leftRim_18;
  mediump vec4 c_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_19 = tmpvar_20;
  c_19.xyz = (c_19.xyz * c_19.w);
  highp vec4 tmpvar_21;
  tmpvar_21.xyz = c_19.xyz;
  tmpvar_21.w = tmpvar_8.w;
  tmpvar_11 = tmpvar_21;
  mediump vec4 tmpvar_22;
  tmpvar_22 = c_19.wwww;
  tmpvar_12 = tmpvar_22;
  leftRim_18 = xlv_TEXCOORD4;
  highp vec3 tmpvar_23;
  tmpvar_23 = tmpvar_8.xyz;
  vlight_17 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = vlight_17;
  tmpvar_24.w = leftRim_18.y;
  tmpvar_14 = tmpvar_24;
  lowp vec3 tmpvar_25;
  if ((leftRim_18.x < 0.0)) {
    tmpvar_25 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_25 = unity_AmbientSky.xyz;
  };
  tmpvar_15 = (tmpvar_25 * abs(leftRim_18.x));
  tmpvar_16.w = c_19.w;
  tmpvar_12.xyz = vec3(_Specularity);
  tmpvar_13 = _Glossiness;
  tmpvar_3 = tmpvar_13;
  tmpvar_4 = tmpvar_15;
  tmpvar_5 = tmpvar_16;
  c_1 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump vec4 tmpvar_26;
  lowp vec3 tmpvar_27;
  lowp float tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_28 = 0.0;
  tmpvar_29.xyz = tmpvar_14.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_7;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_6;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec3 worldRefl_35;
  lowp vec4 ldn_36;
  tmpvar_27 = normalize(tmpvar_2);
  mediump vec4 tmpvar_37;
  tmpvar_37 = vec4(dot (tmpvar_27, lightDir_30));
  ldn_36 = tmpvar_37;
  ldn_36.w = ((ldn_36.x * 0.5) + 0.5);
  tmpvar_29.w = (1.0 - clamp (tmpvar_14.w, 0.0, 1.0));
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_36.w;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_Ramp, tmpvar_38);
  lowp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((tmpvar_39.xyz * _LightColor0.xyz) + ((tmpvar_15 * tmpvar_39.www) + tmpvar_14.xyz));
  mediump vec3 tmpvar_41;
  tmpvar_41 = (-(viewDir_31) - ((2.0 * tmpvar_27) * -(tmpvar_14.w)));
  worldRefl_35 = tmpvar_41;
  mediump vec3 worldNormal_42;
  worldNormal_42 = worldRefl_35;
  mediump float perceptualRoughness_43;
  perceptualRoughness_43 = (1.0 - tmpvar_13);
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = worldNormal_42;
  tmpvar_44.w = ((perceptualRoughness_43 * (1.7 - 
    (0.7 * perceptualRoughness_43)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, worldNormal_42, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump float tmpvar_47;
  if ((unity_SpecCube0_HDR.w == 1.0)) {
    tmpvar_47 = tmpvar_46.w;
  } else {
    tmpvar_47 = 1.0;
  };
  lowp vec3 tmpvar_48;
  mediump vec3 tmpvar_49;
  tmpvar_49 = clamp (((unity_SpecCube0_HDR.x * tmpvar_47) * tmpvar_46.xyz), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  mediump vec3 tmpvar_50;
  tmpvar_50 = (tmpvar_11.xyz * tmpvar_40.xyz);
  color_34 = tmpvar_50;
  lowp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = _LightColor0.xyz;
  mediump float tmpvar_52;
  tmpvar_52 = max (0.0, dot (tmpvar_27, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = pow (nh_32, (tmpvar_13 * 128.0));
  specular_33 = (tmpvar_51 * tmpvar_53);
  specular_33.xyz = (specular_33.xyz + tmpvar_48);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  tmpvar_28 = ((specular_33.x + specular_33.y) + (specular_33.z * 0.333));
  lowp vec4 tmpvar_54;
  tmpvar_54.xyz = color_34;
  tmpvar_54.w = tmpvar_28;
  tmpvar_26 = tmpvar_54;
  c_1 = tmpvar_26;
  lowp vec4 color_55;
  lowp vec3 uvgrab_56;
  highp vec3 tmpvar_57;
  tmpvar_57 = (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w);
  uvgrab_56 = tmpvar_57;
  uvgrab_56.xy = (uvgrab_56.xy - ((xlv_TEXCOORD6.yz / xlv_TEXCOORD3.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((uvgrab_56.xy - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_58;
  tmpvar_58 = texture2D (_GrabTexture, uvgrab_56.xy);
  lowp vec4 tmpvar_59;
  tmpvar_59.xyz = (tmpvar_58.xyz * (1.0 - tmpvar_12.w));
  tmpvar_59.w = tmpvar_58.w;
  color_55 = (c_1 + tmpvar_59);
  color_55.w = min (1.0, (tmpvar_12.w + color_55.w));
  highp vec3 tmpvar_60;
  tmpvar_60 = mix (xlv_TEXCOORD5.xyz, color_55.xyz, xlv_TEXCOORD5.www);
  color_55.xyz = tmpvar_60;
  color_55 = (color_55 + (tmpvar_14 * 0.0001));
  c_1 = color_55;
  gl_FragData[0] = color_55;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
}
}
}
Fallback "Holo/Glass without Refraction (Two-sided Diffuse)"
CustomEditor "CustomMaterialInspector"
}