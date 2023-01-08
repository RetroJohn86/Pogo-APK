//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Wrapped Diffuse/Pixel Lit" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_RampOverlayColor ("Ramp Overlay Color (RGB)", Color) = (0.5,0.5,0.5,0.5)
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 43442
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1.xyz = tmpvar_17.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
  xlv_TEXCOORD4 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  tmpvar_5.x = 1.0;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = ((ldn_21.www * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_7.xyz * tmpvar_23.xyz);
  color_20 = tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = color_20;
  tmpvar_25.w = tmpvar_8;
  tmpvar_17 = tmpvar_25;
  c_1 = tmpvar_17;
  highp float tmpvar_26;
  tmpvar_26 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_26));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 78165
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  tmpvar_1 = (tmpvar_3 * tmpvar_4);
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  tmpvar_1 = (tmpvar_3 * tmpvar_4);
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  tmpvar_1 = (tmpvar_3 * tmpvar_4);
  highp vec3 vertex_6;
  vertex_6 = _glesVertex.xyz;
  highp vec4 clipPos_7;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = vertex_6;
    highp vec3 tmpvar_9;
    tmpvar_9 = (unity_ObjectToWorld * tmpvar_8).xyz;
    highp mat3 tmpvar_10;
    tmpvar_10[0] = unity_WorldToObject[0].xyz;
    tmpvar_10[1] = unity_WorldToObject[1].xyz;
    tmpvar_10[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_11;
    tmpvar_11 = normalize((_glesNormal * tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_11, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_9 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_13;
    tmpvar_13.w = 1.0;
    tmpvar_13.xyz = (tmpvar_9 - (tmpvar_11 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_12 * tmpvar_12)))
    )));
    clipPos_7 = (unity_MatrixVP * tmpvar_13);
  } else {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_6;
    clipPos_7 = (glstate_matrix_mvp * tmpvar_14);
  };
  highp vec4 clipPos_15;
  clipPos_15.xyw = clipPos_7.xyw;
  clipPos_15.z = (clipPos_7.z + clamp ((unity_LightShadowBias.x / clipPos_7.w), 0.0, 1.0));
  clipPos_15.z = mix (clipPos_15.z, max (clipPos_15.z, -(clipPos_7.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_15;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = unity_FogColor.xyz;
  tmpvar_3 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD1 = (tmpvar_2 * tmpvar_3);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = unity_FogColor.xyz;
  tmpvar_3 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD1 = (tmpvar_2 * tmpvar_3);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float tmpvar_1;
  tmpvar_1 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_2.w = exp2((-(tmpvar_1) * tmpvar_1));
  highp vec4 tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = unity_FogColor.xyz;
  tmpvar_3 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD1 = (tmpvar_2 * tmpvar_3);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
Fallback "Holo/Wrapped Diffuse/Vertex Lit"
CustomEditor "CustomMaterialInspector"
}