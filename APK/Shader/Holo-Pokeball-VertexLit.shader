//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Pokeball-Vertex Lit" {
Properties {
[KeywordEnum(Opaque, Cutout)]  _Render ("Rendering Mode", Float) = 0.000000
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _AlphaTestRef ("    Alpha Cutoff", Range(0.000000,1.000000)) = 0.500000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 56411
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  lowp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_36;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  lowp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_36;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  lowp vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_36;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_37;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_37;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  lowp vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = unity_FogColor.xyz;
  envFogColor_1 = tmpvar_37;
  envFogColor_1.w = (envFogColor_1.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
  wPos_8 = tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesNormal));
  wsNormal_6 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_20);
  ldn_4.w = ((tmpvar_20 * 0.5) + 0.5);
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(wsNormal_6);
  highp float tmpvar_22;
  tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.xy = ldn_4.ww;
  tmpvar_23.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_23;
  mediump float tmpvar_24;
  highp float N_25;
  N_25 = wsNormal_6.y;
  tmpvar_24 = ((N_25 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_24;
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_27;
  tmpvar_27 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_28;
  tmpvar_28 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_26 * tmpvar_26) * tmpvar_27)));
  highp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_28;
  tmpvar_29.w = sky2ground_7;
  tmpvar_12.w = tmpvar_29.w;
  tmpvar_12.xyz = (tmpvar_28 * _glesColor.w);
  highp mat3 tmpvar_30;
  tmpvar_30[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_30[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_30[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30 * _glesNormal));
  vsNormal_2 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.z = 0.0;
  tmpvar_32.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_32.w = vsNormal_2.x;
  lowp vec3 tmpvar_33;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_33 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_33 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_34;
  tmpvar_34 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_33 * tmpvar_34) * _glesColor.w);
  highp float tmpvar_35;
  tmpvar_35 = (unity_FogParams.x * tmpvar_16.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_35)
   * tmpvar_35)));
  gl_Position = tmpvar_16;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_32;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
uniform highp vec4 _CharacterColor;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 envFogColor_1;
  lowp vec3 vsNormal_2;
  lowp float vdn_3;
  lowp vec4 ldn_4;
  lowp vec3 wsLight_5;
  lowp vec3 wsNormal_6;
  lowp float sky2ground_7;
  lowp vec3 wPos_8;
  lowp vec4 ambientColor_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  highp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_AmbientEquator * _Ambient);
  ambientColor_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (unity_ObjectToWorld * tmpvar_15).xyz;
  wPos_8 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesNormal));
  wsNormal_6 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_20;
  lowp float tmpvar_21;
  tmpvar_21 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_21);
  ldn_4.w = ((tmpvar_21 * 0.5) + 0.5);
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_6);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_4.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_11 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_6.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_8.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_6.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_9.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_7;
  tmpvar_12.w = tmpvar_30.w;
  tmpvar_12.xyz = (tmpvar_29 * _glesColor.w);
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_2 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_2.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_2.x);
  tmpvar_10.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  highp float tmpvar_36;
  tmpvar_36 = (unity_FogParams.x * tmpvar_17.z);
  envFogColor_1.xyz = _CharacterColor.xyz;
  envFogColor_1.w = (_CharacterColor.w * exp2((
    -(tmpvar_36)
   * tmpvar_36)));
  gl_Position = tmpvar_17;
  xlv_COLOR0 = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
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
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_13;
  gl_FragData[0] = col_2;
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
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" "BRB_CHAR_FX" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}