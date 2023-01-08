//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Irises/Vertex Lit (No Cubemap Fallback)" {
Properties {
_Ambient ("Ambient Multiplier", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit)] _BaseAlpha ("    Alpha Mode", Float) = 0
_lIris ("Left Iris/Pupil (RGBA)", 2D) = "black" { }
_rIris ("Right Iris/Pupil (RGBA)", 2D) = "black" { }
_OsNormalMap ("Eye Mask (Alpha)", 2D) = "gray" { }
[Toggle(BRB_EYE_ADD_MASKS)] _AddMask ("    Add Base Alpha with Eye Mask (special eye case)", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "CASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 33743
Program "vp" {
SubProgram "gles hw_tier00 " {
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
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
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
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
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
void main ()
{
  highp vec3 vertex_1;
  vertex_1 = _glesVertex.xyz;
  highp vec4 clipPos_2;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_3;
    tmpvar_3.w = 1.0;
    tmpvar_3.xyz = vertex_1;
    highp vec3 tmpvar_4;
    tmpvar_4 = (unity_ObjectToWorld * tmpvar_3).xyz;
    highp mat3 tmpvar_5;
    tmpvar_5[0] = unity_WorldToObject[0].xyz;
    tmpvar_5[1] = unity_WorldToObject[1].xyz;
    tmpvar_5[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize((_glesNormal * tmpvar_5));
    highp float tmpvar_7;
    tmpvar_7 = dot (tmpvar_6, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_8;
    tmpvar_8.w = 1.0;
    tmpvar_8.xyz = (tmpvar_4 - (tmpvar_6 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_7 * tmpvar_7)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_8);
  } else {
    highp vec4 tmpvar_9;
    tmpvar_9.w = 1.0;
    tmpvar_9.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_9);
  };
  highp vec4 clipPos_10;
  clipPos_10.xyw = clipPos_2.xyw;
  clipPos_10.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_10.z = mix (clipPos_10.z, max (clipPos_10.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_10;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
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
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 119226
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_36;
  tmpvar_36.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_36.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_36;
  xlv_TEXCOORD5 = vec4((_glesMultiTexCoord0.x - 1.0));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 diffuse_1;
  mediump vec4 irises_2;
  lowp float alpha_3;
  lowp vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_4 = tmpvar_5;
  alpha_3 = tmpvar_5.w;
  lowp vec4 tmpvar_6;
  if ((xlv_TEXCOORD5.x >= 0.0)) {
    tmpvar_6 = texture2D (_lIris, xlv_TEXCOORD4.xy);
  } else {
    tmpvar_6 = texture2D (_rIris, xlv_TEXCOORD4.zw);
  };
  irises_2 = tmpvar_6;
  alpha_3 = (irises_2.w * tmpvar_5.w);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5.xyz, irises_2.xyz, vec3(alpha_3));
  col_4.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float ldn_9;
  ldn_9 = xlv_TEXCOORD1.x;
  mediump float fresnel_10;
  fresnel_10 = xlv_TEXCOORD1.w;
  lowp vec4 color_11;
  color_11 = xlv_TEXCOORD2;
  lowp vec4 rimColor_12;
  rimColor_12 = xlv_COLOR0;
  lowp vec4 ramp_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = ldn_9;
  tmpvar_14.y = fresnel_10;
  ramp_13.w = texture2D (_Ramp, tmpvar_14).w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = vec3(ldn_9);
  ramp_13.xyz = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ramp_13.www;
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = ((ramp_13.xyz * _LightColor0.xyz) + ((rimColor_12 * tmpvar_16) + color_11).xyz);
  tmpvar_17.w = color_11.w;
  tmpvar_8 = tmpvar_17;
  diffuse_1 = tmpvar_8;
  col_4.xyz = (col_4.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_4;
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_36;
  tmpvar_36.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_36.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_36;
  xlv_TEXCOORD5 = vec4((_glesMultiTexCoord0.x - 1.0));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 diffuse_1;
  mediump vec4 irises_2;
  lowp float alpha_3;
  lowp vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_4 = tmpvar_5;
  alpha_3 = tmpvar_5.w;
  lowp vec4 tmpvar_6;
  if ((xlv_TEXCOORD5.x >= 0.0)) {
    tmpvar_6 = texture2D (_lIris, xlv_TEXCOORD4.xy);
  } else {
    tmpvar_6 = texture2D (_rIris, xlv_TEXCOORD4.zw);
  };
  irises_2 = tmpvar_6;
  alpha_3 = (irises_2.w * tmpvar_5.w);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5.xyz, irises_2.xyz, vec3(alpha_3));
  col_4.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float ldn_9;
  ldn_9 = xlv_TEXCOORD1.x;
  mediump float fresnel_10;
  fresnel_10 = xlv_TEXCOORD1.w;
  lowp vec4 color_11;
  color_11 = xlv_TEXCOORD2;
  lowp vec4 rimColor_12;
  rimColor_12 = xlv_COLOR0;
  lowp vec4 ramp_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = ldn_9;
  tmpvar_14.y = fresnel_10;
  ramp_13.w = texture2D (_Ramp, tmpvar_14).w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = vec3(ldn_9);
  ramp_13.xyz = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ramp_13.www;
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = ((ramp_13.xyz * _LightColor0.xyz) + ((rimColor_12 * tmpvar_16) + color_11).xyz);
  tmpvar_17.w = color_11.w;
  tmpvar_8 = tmpvar_17;
  diffuse_1 = tmpvar_8;
  col_4.xyz = (col_4.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_4;
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
uniform highp vec4 _lIris_ST;
uniform highp vec4 _rIris_ST;
uniform highp float _Ground;
uniform highp vec4 _Ambient;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
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
  highp vec4 tmpvar_36;
  tmpvar_36.xy = ((_glesMultiTexCoord0.xy * _lIris_ST.xy) + _lIris_ST.zw);
  tmpvar_36.zw = ((_glesMultiTexCoord0.xy * _rIris_ST.xy) + _rIris_ST.zw);
  gl_Position = tmpvar_15;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_33;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD4 = tmpvar_36;
  xlv_TEXCOORD5 = vec4((_glesMultiTexCoord0.x - 1.0));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _lIris;
uniform sampler2D _rIris;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 diffuse_1;
  mediump vec4 irises_2;
  lowp float alpha_3;
  lowp vec4 col_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_4 = tmpvar_5;
  alpha_3 = tmpvar_5.w;
  lowp vec4 tmpvar_6;
  if ((xlv_TEXCOORD5.x >= 0.0)) {
    tmpvar_6 = texture2D (_lIris, xlv_TEXCOORD4.xy);
  } else {
    tmpvar_6 = texture2D (_rIris, xlv_TEXCOORD4.zw);
  };
  irises_2 = tmpvar_6;
  alpha_3 = (irises_2.w * tmpvar_5.w);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_5.xyz, irises_2.xyz, vec3(alpha_3));
  col_4.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump float ldn_9;
  ldn_9 = xlv_TEXCOORD1.x;
  mediump float fresnel_10;
  fresnel_10 = xlv_TEXCOORD1.w;
  lowp vec4 color_11;
  color_11 = xlv_TEXCOORD2;
  lowp vec4 rimColor_12;
  rimColor_12 = xlv_COLOR0;
  lowp vec4 ramp_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = ldn_9;
  tmpvar_14.y = fresnel_10;
  ramp_13.w = texture2D (_Ramp, tmpvar_14).w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = vec3(ldn_9);
  ramp_13.xyz = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ramp_13.www;
  lowp vec4 tmpvar_17;
  tmpvar_17.xyz = ((ramp_13.xyz * _LightColor0.xyz) + ((rimColor_12 * tmpvar_16) + color_11).xyz);
  tmpvar_17.w = color_11.w;
  tmpvar_8 = tmpvar_17;
  diffuse_1 = tmpvar_8;
  col_4.xyz = (col_4.xyz * diffuse_1.xyz);
  gl_FragData[0] = col_4;
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
CustomEditor "CustomMaterialInspector"
}