//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Transparent/Vertex Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Toggle]  _ZWrite ("Z Write", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _ZTest ("Z Test", Float) = 4.000000
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest [_ZTest]
  Blend SrcAlpha OneMinusSrcAlpha, One One
  ColorMask 0
  GpuProgramID 36047
Program "vp" {
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
uniform lowp vec4 _LightColor0;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec3 wsLight_1;
  lowp vec3 wsNormal_2;
  lowp float sky2ground_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesNormal));
  wsNormal_2 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_1 = tmpvar_9;
  mediump float tmpvar_10;
  highp float N_11;
  N_11 = wsNormal_2.y;
  tmpvar_10 = ((N_11 * 0.5) + 0.5);
  sky2ground_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = unity_AmbientEquator.xyz;
  tmpvar_12.w = sky2ground_3;
  tmpvar_6 = tmpvar_12;
  tmpvar_6.xyz = (tmpvar_6.xyz * _glesColor.w);
  lowp float tmpvar_13;
  tmpvar_13 = dot (wsNormal_2, wsLight_1);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_6.w);
  tmpvar_6.xyz = ((vec3(tmpvar_13) * xlat_mutable_LightColor0.xyz) + tmpvar_6.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_14;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
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
uniform lowp vec4 _LightColor0;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec3 wsLight_1;
  lowp vec3 wsNormal_2;
  lowp float sky2ground_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesNormal));
  wsNormal_2 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_1 = tmpvar_9;
  mediump float tmpvar_10;
  highp float N_11;
  N_11 = wsNormal_2.y;
  tmpvar_10 = ((N_11 * 0.5) + 0.5);
  sky2ground_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = unity_AmbientEquator.xyz;
  tmpvar_12.w = sky2ground_3;
  tmpvar_6 = tmpvar_12;
  tmpvar_6.xyz = (tmpvar_6.xyz * _glesColor.w);
  lowp float tmpvar_13;
  tmpvar_13 = dot (wsNormal_2, wsLight_1);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_6.w);
  tmpvar_6.xyz = ((vec3(tmpvar_13) * xlat_mutable_LightColor0.xyz) + tmpvar_6.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_14;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _LightColor0;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  lowp vec3 wsLight_1;
  lowp vec3 wsNormal_2;
  lowp float sky2ground_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesNormal));
  wsNormal_2 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_1 = tmpvar_9;
  mediump float tmpvar_10;
  highp float N_11;
  N_11 = wsNormal_2.y;
  tmpvar_10 = ((N_11 * 0.5) + 0.5);
  sky2ground_3 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = unity_AmbientEquator.xyz;
  tmpvar_12.w = sky2ground_3;
  tmpvar_6 = tmpvar_12;
  tmpvar_6.xyz = (tmpvar_6.xyz * _glesColor.w);
  lowp float tmpvar_13;
  tmpvar_13 = dot (wsNormal_2, wsLight_1);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_6.w);
  tmpvar_6.xyz = ((vec3(tmpvar_13) * xlat_mutable_LightColor0.xyz) + tmpvar_6.xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_14;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
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
}
 }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest [_ZTest]
  ZWrite [_ZWrite]
  Cull [_Cull]
  Blend SrcAlpha OneMinusSrcAlpha, One One
  GpuProgramID 92509
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
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback "Hidden/Holo/Glass Fallback"
}