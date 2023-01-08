//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Transparent (Two Pass)/Vertex Lit" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 55812
Program "vp" {
SubProgram "gles hw_tier00 " {
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  lowp vec4 ambientColor_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  ambientColor_8 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * tmpvar_13).xyz;
  wPos_7 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  wsNormal_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_19);
  ldn_3.w = ((tmpvar_19 * 0.5) + 0.5);
  lowp float tmpvar_20;
  tmpvar_20 = max (0.0, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_5);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_3.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_10 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_5.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_7.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_5.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_8.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_6;
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = (tmpvar_29 * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_1 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_1.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_1.x);
  tmpvar_9.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (tmpvar_3.w - 0.99);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  lowp vec4 ambientColor_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  ambientColor_8 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * tmpvar_13).xyz;
  wPos_7 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  wsNormal_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_19);
  ldn_3.w = ((tmpvar_19 * 0.5) + 0.5);
  lowp float tmpvar_20;
  tmpvar_20 = max (0.0, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_5);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_3.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_10 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_5.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_7.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_5.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_8.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_6;
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = (tmpvar_29 * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_1 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_1.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_1.x);
  tmpvar_9.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (tmpvar_3.w - 0.99);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp vec4 _MainTex_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  lowp vec4 ambientColor_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_AmbientEquator * _Ambient);
  ambientColor_8 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * tmpvar_13).xyz;
  wPos_7 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  wsNormal_5 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_19);
  ldn_3.w = ((tmpvar_19 * 0.5) + 0.5);
  lowp float tmpvar_20;
  tmpvar_20 = max (0.0, tmpvar_19);
  highp float tmpvar_21;
  tmpvar_21 = mix (tmpvar_20, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_21;
  lowp vec3 tmpvar_22;
  tmpvar_22 = normalize(wsNormal_5);
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_23;
  lowp vec4 tmpvar_24;
  tmpvar_24.z = 0.0;
  tmpvar_24.xy = ldn_3.ww;
  tmpvar_24.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_10 = tmpvar_24;
  mediump float tmpvar_25;
  highp float N_26;
  N_26 = wsNormal_5.y;
  tmpvar_25 = ((N_26 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_25;
  highp float tmpvar_27;
  tmpvar_27 = clamp ((1.0 - (
    (wPos_7.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_28;
  tmpvar_28 = max (0.0, -(wsNormal_5.y));
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (ambientColor_8.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_27 * tmpvar_27) * tmpvar_28)));
  highp vec4 tmpvar_30;
  tmpvar_30.xyz = tmpvar_29;
  tmpvar_30.w = sky2ground_6;
  tmpvar_11.w = tmpvar_30.w;
  tmpvar_11.xyz = (tmpvar_29 * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_31[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_31[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((tmpvar_31 * _glesNormal));
  vsNormal_1 = tmpvar_32;
  highp vec4 tmpvar_33;
  tmpvar_33.z = 0.0;
  tmpvar_33.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_33.w = vsNormal_1.x;
  lowp vec3 tmpvar_34;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_34 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_34 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_35;
  tmpvar_35 = abs(vsNormal_1.x);
  tmpvar_9.xyz = ((tmpvar_34 * tmpvar_35) * _glesColor.w);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (tmpvar_3.w - 0.99);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
}
}
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, One One
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 99185
Program "vp" {
SubProgram "gles hw_tier00 " {
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
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * tmpvar_11).xyz;
  wPos_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  wsNormal_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_17);
  ldn_3.w = ((tmpvar_17 * 0.5) + 0.5);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(wsNormal_5);
  highp float tmpvar_21;
  tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.xy = ldn_3.ww;
  tmpvar_22.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_9 = tmpvar_22;
  mediump float tmpvar_23;
  highp float N_24;
  N_24 = wsNormal_5.y;
  tmpvar_23 = ((N_24 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_23;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = unity_AmbientEquator.xyz;
  tmpvar_25.w = sky2ground_6;
  tmpvar_10 = tmpvar_25;
  tmpvar_10.xyz = (tmpvar_10.xyz * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_8.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_13;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (0.99 - tmpvar_3.w);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * tmpvar_11).xyz;
  wPos_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  wsNormal_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_17);
  ldn_3.w = ((tmpvar_17 * 0.5) + 0.5);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(wsNormal_5);
  highp float tmpvar_21;
  tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.xy = ldn_3.ww;
  tmpvar_22.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_9 = tmpvar_22;
  mediump float tmpvar_23;
  highp float N_24;
  N_24 = wsNormal_5.y;
  tmpvar_23 = ((N_24 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_23;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = unity_AmbientEquator.xyz;
  tmpvar_25.w = sky2ground_6;
  tmpvar_10 = tmpvar_25;
  tmpvar_10.xyz = (tmpvar_10.xyz * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_8.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_13;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (0.99 - tmpvar_3.w);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float vdn_2;
  lowp vec4 ldn_3;
  lowp vec3 wsLight_4;
  lowp vec3 wsNormal_5;
  lowp float sky2ground_6;
  lowp vec3 wPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * tmpvar_11).xyz;
  wPos_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  wsNormal_5 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_4 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (wsNormal_5, wsLight_4);
  ldn_3.xyz = vec3(tmpvar_17);
  ldn_3.w = ((tmpvar_17 * 0.5) + 0.5);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = mix (tmpvar_18, ldn_3.w, _glesColor.w);
  ldn_3.w = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = normalize(wsNormal_5);
  highp float tmpvar_21;
  tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_7)));
  vdn_2 = tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22.z = 0.0;
  tmpvar_22.xy = ldn_3.ww;
  tmpvar_22.w = (1.0 - clamp (vdn_2, 0.0, 1.0));
  tmpvar_9 = tmpvar_22;
  mediump float tmpvar_23;
  highp float N_24;
  N_24 = wsNormal_5.y;
  tmpvar_23 = ((N_24 * 0.5) + 0.5);
  sky2ground_6 = tmpvar_23;
  lowp vec4 tmpvar_25;
  tmpvar_25.xyz = unity_AmbientEquator.xyz;
  tmpvar_25.w = sky2ground_6;
  tmpvar_10 = tmpvar_25;
  tmpvar_10.xyz = (tmpvar_10.xyz * ((_glesColor.w * 
    (1.0 - unity_AmbientEquator.w)
  ) + unity_AmbientEquator.w));
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_8.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_13;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = tmpvar_10;
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
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  lowp float x_4;
  x_4 = (0.99 - tmpvar_3.w);
  if ((x_4 < 0.0)) {
    discard;
  };
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump vec2 tmpvar_10;
  tmpvar_10.x = ldn_6;
  tmpvar_10.y = fresnel_7;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Ramp, tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_11.www;
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = ((tmpvar_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_12) + color_8).xyz);
  tmpvar_13.w = color_8.w;
  tmpvar_5 = tmpvar_13;
  diffuse_1 = tmpvar_5;
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
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
}
}
}
Fallback "Hidden/Holo/Glass Fallback"
CustomEditor "CustomMaterialInspector"
}