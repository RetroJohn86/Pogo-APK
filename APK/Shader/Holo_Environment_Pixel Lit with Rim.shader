//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Pixel Lit with Rim" {
Properties {
[KeywordEnum(Opaque, Cutout)] _Render ("Rendering Mode", Float) = 0
[KeywordEnum(Off, Diffuse)] _ColorMode ("Color Modifier Mode", Float) = 0
_Color ("    Color", Color) = (1,1,1,1)
[KeywordEnum(Off, Diffuse)] _VertexMode ("Vertex Color Mode", Float) = 1
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle(BRB_LIGHTING_TWOSIDED)] _LightingDoubleSided ("    Two-sided lighting", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 63400
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
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ramp_23;
  lowp vec4 ldn_24;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_25;
  tmpvar_25 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_24 = tmpvar_25;
  ldn_24.w = ((ldn_24.x * 0.5) + 0.5);
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_24.w;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  mediump vec4 tmpvar_28;
  tmpvar_28 = tmpvar_27;
  ramp_23 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ramp_23.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_23.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyz * tmpvar_29.xyz);
  color_22 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_22;
  tmpvar_31.w = tmpvar_8;
  tmpvar_19 = tmpvar_31;
  c_1 = tmpvar_19;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_32.xyz = tmpvar_33;
  c_1.xyz = color_32.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ramp_23;
  lowp vec4 ldn_24;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_25;
  tmpvar_25 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_24 = tmpvar_25;
  ldn_24.w = ((ldn_24.x * 0.5) + 0.5);
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_24.w;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  mediump vec4 tmpvar_28;
  tmpvar_28 = tmpvar_27;
  ramp_23 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ramp_23.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_23.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyz * tmpvar_29.xyz);
  color_22 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_22;
  tmpvar_31.w = tmpvar_8;
  tmpvar_19 = tmpvar_31;
  c_1 = tmpvar_19;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_32.xyz = tmpvar_33;
  c_1.xyz = color_32.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  mediump vec4 tmpvar_19;
  lowp vec3 tmpvar_20;
  mediump vec3 lightDir_21;
  lightDir_21 = lightDir_4;
  lowp vec3 color_22;
  lowp vec4 ramp_23;
  lowp vec4 ldn_24;
  tmpvar_20 = normalize(tmpvar_2);
  mediump vec4 tmpvar_25;
  tmpvar_25 = vec4(dot (tmpvar_20, lightDir_21));
  ldn_24 = tmpvar_25;
  ldn_24.w = ((ldn_24.x * 0.5) + 0.5);
  lowp vec2 tmpvar_26;
  tmpvar_26.x = ldn_24.w;
  tmpvar_26.y = tmpvar_9.w;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_Ramp, tmpvar_26);
  mediump vec4 tmpvar_28;
  tmpvar_28 = tmpvar_27;
  ramp_23 = tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ramp_23.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_23.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_7.xyz * tmpvar_29.xyz);
  color_22 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_22;
  tmpvar_31.w = tmpvar_8;
  tmpvar_19 = tmpvar_31;
  c_1 = tmpvar_19;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  highp vec3 tmpvar_33;
  tmpvar_33 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_32.xyz = tmpvar_33;
  c_1.xyz = color_32.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_19;
  highp float lightShadowDataX_20;
  mediump float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_20);
  tmpvar_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_4;
  mediump float atten_26;
  atten_26 = tmpvar_19;
  lowp vec3 color_27;
  lowp vec4 ramp_28;
  lowp vec4 ldn_29;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_29.w;
  tmpvar_31.y = tmpvar_9.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp float tmpvar_33;
  tmpvar_33 = abs(ldn_29.x);
  mediump vec4 tmpvar_34;
  tmpvar_34 = mix (tmpvar_32, (tmpvar_32 * atten_26), vec4(tmpvar_33));
  ramp_28 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((ramp_28.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_28.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_7.xyz * tmpvar_35.xyz);
  color_27 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.xyz = color_27;
  tmpvar_37.w = tmpvar_8;
  tmpvar_23 = tmpvar_37;
  c_1 = tmpvar_23;
  lowp vec4 color_38;
  color_38.w = c_1.w;
  highp vec3 tmpvar_39;
  tmpvar_39 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_38.xyz = tmpvar_39;
  c_1.xyz = color_38.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_19;
  highp float lightShadowDataX_20;
  mediump float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_20);
  tmpvar_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_4;
  mediump float atten_26;
  atten_26 = tmpvar_19;
  lowp vec3 color_27;
  lowp vec4 ramp_28;
  lowp vec4 ldn_29;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_29.w;
  tmpvar_31.y = tmpvar_9.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp float tmpvar_33;
  tmpvar_33 = abs(ldn_29.x);
  mediump vec4 tmpvar_34;
  tmpvar_34 = mix (tmpvar_32, (tmpvar_32 * atten_26), vec4(tmpvar_33));
  ramp_28 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((ramp_28.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_28.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_7.xyz * tmpvar_35.xyz);
  color_27 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.xyz = color_27;
  tmpvar_37.w = tmpvar_8;
  tmpvar_23 = tmpvar_37;
  c_1 = tmpvar_23;
  lowp vec4 color_38;
  color_38.w = c_1.w;
  highp vec3 tmpvar_39;
  tmpvar_39 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_38.xyz = tmpvar_39;
  c_1.xyz = color_38.xyz;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp float rim_6;
  highp vec4 envFogColor_7;
  lowp vec3 vsNormal_8;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_9;
  tmpvar_9 = _glesColor.wwww;
  tmpvar_5.xz = tmpvar_9.xz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize((
    (unity_WorldToObject * tmpvar_10)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11;
  tmpvar_12.y = (1.0 - max (0.0, tmpvar_11));
  tmpvar_5.yw = tmpvar_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_13[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_13[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((tmpvar_13 * tmpvar_4));
  vsNormal_8 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  envFogColor_7 = (tmpvar_16 * _EnvironmentColor);
  lowp float tmpvar_17;
  tmpvar_17 = vsNormal_8.x;
  rim_6 = tmpvar_17;
  lowp vec3 tmpvar_18;
  if ((rim_6 < 0.0)) {
    tmpvar_18 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_18 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_2 = tmpvar_21;
  tmpvar_3 = worldNormal_2;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = envFogColor_7;
  xlv_TEXCOORD4 = (tmpvar_18 * abs(rim_6));
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  lowp vec3 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_12;
  lowp vec4 leftRim_13;
  mediump vec4 c_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_14 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = c_14.xyz;
  tmpvar_16.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_16;
  tmpvar_8 = c_14.w;
  leftRim_13 = xlv_TEXCOORD2;
  highp vec3 tmpvar_17;
  tmpvar_17 = tmpvar_5.xyz;
  vlight_12 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = vlight_12;
  tmpvar_18.w = leftRim_13.w;
  tmpvar_9 = tmpvar_18;
  tmpvar_10 = xlv_TEXCOORD4;
  tmpvar_11.w = c_14.w;
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_19;
  highp float lightShadowDataX_20;
  mediump float tmpvar_21;
  tmpvar_21 = _LightShadowData.x;
  lightShadowDataX_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD5.xy).x > xlv_TEXCOORD5.z)), lightShadowDataX_20);
  tmpvar_19 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_4;
  mediump float atten_26;
  atten_26 = tmpvar_19;
  lowp vec3 color_27;
  lowp vec4 ramp_28;
  lowp vec4 ldn_29;
  tmpvar_24 = normalize(tmpvar_2);
  mediump vec4 tmpvar_30;
  tmpvar_30 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_29 = tmpvar_30;
  ldn_29.w = ((ldn_29.x * 0.5) + 0.5);
  lowp vec2 tmpvar_31;
  tmpvar_31.x = ldn_29.w;
  tmpvar_31.y = tmpvar_9.w;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_Ramp, tmpvar_31);
  lowp float tmpvar_33;
  tmpvar_33 = abs(ldn_29.x);
  mediump vec4 tmpvar_34;
  tmpvar_34 = mix (tmpvar_32, (tmpvar_32 * atten_26), vec4(tmpvar_33));
  ramp_28 = tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((ramp_28.xyz * _LightColor0.xyz) + ((tmpvar_10 * ramp_28.www) + tmpvar_9.xyz));
  mediump vec3 tmpvar_36;
  tmpvar_36 = (tmpvar_7.xyz * tmpvar_35.xyz);
  color_27 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37.xyz = color_27;
  tmpvar_37.w = tmpvar_8;
  tmpvar_23 = tmpvar_37;
  c_1 = tmpvar_23;
  lowp vec4 color_38;
  color_38.w = c_1.w;
  highp vec3 tmpvar_39;
  tmpvar_39 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_38.xyz = tmpvar_39;
  c_1.xyz = color_38.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
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
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 200
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 123156
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = _glesColor.wwww;
  tmpvar_4.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = (1.0 - max (0.0, tmpvar_10));
  tmpvar_4.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_3));
  vsNormal_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  envFogColor_6 = (tmpvar_15 * _EnvironmentColor);
  lowp float tmpvar_16;
  tmpvar_16 = vsNormal_7.x;
  rim_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  if ((rim_5 < 0.0)) {
    tmpvar_17 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_17 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_17 * abs(rim_5));
  highp vec3 vertex_18;
  vertex_18 = tmpvar_1.xyz;
  highp vec4 clipPos_19;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_18;
    highp vec3 tmpvar_21;
    tmpvar_21 = (unity_ObjectToWorld * tmpvar_20).xyz;
    highp mat3 tmpvar_22;
    tmpvar_22[0] = unity_WorldToObject[0].xyz;
    tmpvar_22[1] = unity_WorldToObject[1].xyz;
    tmpvar_22[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_21 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (tmpvar_21 - (tmpvar_23 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_24 * tmpvar_24)))
    )));
    clipPos_19 = (unity_MatrixVP * tmpvar_25);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = vertex_18;
    clipPos_19 = (glstate_matrix_mvp * tmpvar_26);
  };
  highp vec4 clipPos_27;
  clipPos_27.xyw = clipPos_19.xyw;
  clipPos_27.z = (clipPos_19.z + clamp ((unity_LightShadowBias.x / clipPos_19.w), 0.0, 1.0));
  clipPos_27.z = mix (clipPos_27.z, max (clipPos_27.z, -(clipPos_19.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_27;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = _glesColor.wwww;
  tmpvar_4.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = (1.0 - max (0.0, tmpvar_10));
  tmpvar_4.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_3));
  vsNormal_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  envFogColor_6 = (tmpvar_15 * _EnvironmentColor);
  lowp float tmpvar_16;
  tmpvar_16 = vsNormal_7.x;
  rim_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  if ((rim_5 < 0.0)) {
    tmpvar_17 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_17 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_17 * abs(rim_5));
  highp vec3 vertex_18;
  vertex_18 = tmpvar_1.xyz;
  highp vec4 clipPos_19;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_18;
    highp vec3 tmpvar_21;
    tmpvar_21 = (unity_ObjectToWorld * tmpvar_20).xyz;
    highp mat3 tmpvar_22;
    tmpvar_22[0] = unity_WorldToObject[0].xyz;
    tmpvar_22[1] = unity_WorldToObject[1].xyz;
    tmpvar_22[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_21 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (tmpvar_21 - (tmpvar_23 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_24 * tmpvar_24)))
    )));
    clipPos_19 = (unity_MatrixVP * tmpvar_25);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = vertex_18;
    clipPos_19 = (glstate_matrix_mvp * tmpvar_26);
  };
  highp vec4 clipPos_27;
  clipPos_27.xyw = clipPos_19.xyw;
  clipPos_27.z = (clipPos_19.z + clamp ((unity_LightShadowBias.x / clipPos_19.w), 0.0, 1.0));
  clipPos_27.z = mix (clipPos_27.z, max (clipPos_27.z, -(clipPos_19.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_27;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp float rim_5;
  highp vec4 envFogColor_6;
  lowp vec3 vsNormal_7;
  tmpvar_3 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = _glesColor.wwww;
  tmpvar_4.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_3);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = (1.0 - max (0.0, tmpvar_10));
  tmpvar_4.yw = tmpvar_11;
  highp mat3 tmpvar_12;
  tmpvar_12[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_12[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_12[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_12 * tmpvar_3));
  vsNormal_7 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_15;
  tmpvar_15.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_15.w = exp2((-(tmpvar_14) * tmpvar_14));
  envFogColor_6 = (tmpvar_15 * _EnvironmentColor);
  lowp float tmpvar_16;
  tmpvar_16 = vsNormal_7.x;
  rim_5 = tmpvar_16;
  lowp vec3 tmpvar_17;
  if ((rim_5 < 0.0)) {
    tmpvar_17 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_17 = unity_AmbientSky.xyz;
  };
  tmpvar_2 = (tmpvar_17 * abs(rim_5));
  highp vec3 vertex_18;
  vertex_18 = tmpvar_1.xyz;
  highp vec4 clipPos_19;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_18;
    highp vec3 tmpvar_21;
    tmpvar_21 = (unity_ObjectToWorld * tmpvar_20).xyz;
    highp mat3 tmpvar_22;
    tmpvar_22[0] = unity_WorldToObject[0].xyz;
    tmpvar_22[1] = unity_WorldToObject[1].xyz;
    tmpvar_22[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = normalize((tmpvar_3 * tmpvar_22));
    highp float tmpvar_24;
    tmpvar_24 = dot (tmpvar_23, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_21 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = (tmpvar_21 - (tmpvar_23 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_24 * tmpvar_24)))
    )));
    clipPos_19 = (unity_MatrixVP * tmpvar_25);
  } else {
    highp vec4 tmpvar_26;
    tmpvar_26.w = 1.0;
    tmpvar_26.xyz = vertex_18;
    clipPos_19 = (glstate_matrix_mvp * tmpvar_26);
  };
  highp vec4 clipPos_27;
  clipPos_27.xyw = clipPos_19.xyw;
  clipPos_27.z = (clipPos_19.z + clamp ((unity_LightShadowBias.x / clipPos_19.w), 0.0, 1.0));
  clipPos_27.z = mix (clipPos_27.z, max (clipPos_27.z, -(clipPos_19.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_27;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = envFogColor_6;
  xlv_TEXCOORD3 = tmpvar_2;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = _glesColor.wwww;
  tmpvar_3.xz = tmpvar_7.xz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_9;
  tmpvar_9 = dot (normalize((
    (unity_WorldToObject * tmpvar_8)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9;
  tmpvar_10.y = (1.0 - max (0.0, tmpvar_9));
  tmpvar_3.yw = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_11[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_11[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * tmpvar_2));
  vsNormal_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_14.w = exp2((-(tmpvar_13) * tmpvar_13));
  envFogColor_5 = (tmpvar_14 * _EnvironmentColor);
  lowp float tmpvar_15;
  tmpvar_15 = vsNormal_6.x;
  rim_4 = tmpvar_15;
  lowp vec3 tmpvar_16;
  if ((rim_4 < 0.0)) {
    tmpvar_16 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_16 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_16 * abs(rim_4));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = _glesColor.wwww;
  tmpvar_3.xz = tmpvar_7.xz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_9;
  tmpvar_9 = dot (normalize((
    (unity_WorldToObject * tmpvar_8)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9;
  tmpvar_10.y = (1.0 - max (0.0, tmpvar_9));
  tmpvar_3.yw = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_11[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_11[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * tmpvar_2));
  vsNormal_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_14.w = exp2((-(tmpvar_13) * tmpvar_13));
  envFogColor_5 = (tmpvar_14 * _EnvironmentColor);
  lowp float tmpvar_15;
  tmpvar_15 = vsNormal_6.x;
  rim_4 = tmpvar_15;
  lowp vec3 tmpvar_16;
  if ((rim_4 < 0.0)) {
    tmpvar_16 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_16 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_16 * abs(rim_4));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientSky;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _EnvironmentColor;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float rim_4;
  highp vec4 envFogColor_5;
  lowp vec3 vsNormal_6;
  tmpvar_2 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = _glesColor.wwww;
  tmpvar_3.xz = tmpvar_7.xz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_9;
  tmpvar_9 = dot (normalize((
    (unity_WorldToObject * tmpvar_8)
  .xyz - _glesVertex.xyz)), tmpvar_2);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9;
  tmpvar_10.y = (1.0 - max (0.0, tmpvar_9));
  tmpvar_3.yw = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_11[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_11[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * tmpvar_2));
  vsNormal_6 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_14.w = exp2((-(tmpvar_13) * tmpvar_13));
  envFogColor_5 = (tmpvar_14 * _EnvironmentColor);
  lowp float tmpvar_15;
  tmpvar_15 = vsNormal_6.x;
  rim_4 = tmpvar_15;
  lowp vec3 tmpvar_16;
  if ((rim_4 < 0.0)) {
    tmpvar_16 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_16 = unity_AmbientSky.xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_17);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = envFogColor_5;
  xlv_TEXCOORD3 = (tmpvar_16 * abs(rim_4));
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
SubProgram "gles hw_tier02 " {
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
Fallback "Holo/Environment/Vertex Lit with Rim"
CustomEditor "CustomMaterialInspector"
}