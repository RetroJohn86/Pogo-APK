//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Eye Shade/Vertex Lit" {
Properties {
 _Ambient ("Ambient Multiplier", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB A=Eye Mask)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
[HideInInspector]  _OsNormalMap ("Fallback Eye Mask (A=Eye Mask)", 2D) = "gray" { }
[HideInInspector] [Toggle(BRB_EYE_ADD_MASKS)]  _AddMask ("    Add alpha from Base with OS Normal (special eye case)", Float) = 0.000000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "CASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "RenderType"="Opaque" }
  GpuProgramID 37362
Program "vp" {
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
    highp vec4 v_5;
    v_5.x = unity_WorldToObject[0].x;
    v_5.y = unity_WorldToObject[1].x;
    v_5.z = unity_WorldToObject[2].x;
    v_5.w = unity_WorldToObject[3].x;
    highp vec4 v_6;
    v_6.x = unity_WorldToObject[0].y;
    v_6.y = unity_WorldToObject[1].y;
    v_6.z = unity_WorldToObject[2].y;
    v_6.w = unity_WorldToObject[3].y;
    highp vec4 v_7;
    v_7.x = unity_WorldToObject[0].z;
    v_7.y = unity_WorldToObject[1].z;
    v_7.z = unity_WorldToObject[2].z;
    v_7.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * _glesNormal.x)
     + 
      (v_6.xyz * _glesNormal.y)
    ) + (v_7.xyz * _glesNormal.z)));
    highp float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
  };
  highp vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
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
    highp vec4 v_5;
    v_5.x = unity_WorldToObject[0].x;
    v_5.y = unity_WorldToObject[1].x;
    v_5.z = unity_WorldToObject[2].x;
    v_5.w = unity_WorldToObject[3].x;
    highp vec4 v_6;
    v_6.x = unity_WorldToObject[0].y;
    v_6.y = unity_WorldToObject[1].y;
    v_6.z = unity_WorldToObject[2].y;
    v_6.w = unity_WorldToObject[3].y;
    highp vec4 v_7;
    v_7.x = unity_WorldToObject[0].z;
    v_7.y = unity_WorldToObject[1].z;
    v_7.z = unity_WorldToObject[2].z;
    v_7.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * _glesNormal.x)
     + 
      (v_6.xyz * _glesNormal.y)
    ) + (v_7.xyz * _glesNormal.z)));
    highp float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
  };
  highp vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
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
SubProgram "gles hw_tier03 " {
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
    highp vec4 v_5;
    v_5.x = unity_WorldToObject[0].x;
    v_5.y = unity_WorldToObject[1].x;
    v_5.z = unity_WorldToObject[2].x;
    v_5.w = unity_WorldToObject[3].x;
    highp vec4 v_6;
    v_6.x = unity_WorldToObject[0].y;
    v_6.y = unity_WorldToObject[1].y;
    v_6.z = unity_WorldToObject[2].y;
    v_6.w = unity_WorldToObject[3].y;
    highp vec4 v_7;
    v_7.x = unity_WorldToObject[0].z;
    v_7.y = unity_WorldToObject[1].z;
    v_7.z = unity_WorldToObject[2].z;
    v_7.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_8;
    tmpvar_8 = normalize(((
      (v_5.xyz * _glesNormal.x)
     + 
      (v_6.xyz * _glesNormal.y)
    ) + (v_7.xyz * _glesNormal.z)));
    highp float tmpvar_9;
    tmpvar_9 = dot (tmpvar_8, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_4 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = (tmpvar_4 - (tmpvar_8 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_9 * tmpvar_9)))
    )));
    clipPos_2 = (unity_MatrixVP * tmpvar_10);
  } else {
    highp vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = vertex_1;
    clipPos_2 = (glstate_matrix_mvp * tmpvar_11);
  };
  highp vec4 clipPos_12;
  clipPos_12.xyw = clipPos_2.xyw;
  clipPos_12.z = (clipPos_2.z + clamp ((unity_LightShadowBias.x / clipPos_2.w), 0.0, 1.0));
  clipPos_12.z = mix (clipPos_12.z, max (clipPos_12.z, -(clipPos_2.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_12;
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
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 117282
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
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump float alpha_10;
  alpha_10 = tmpvar_4;
  lowp vec4 ramp_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = ldn_6;
  tmpvar_12.y = fresnel_7;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, tmpvar_12);
  ramp_11.w = tmpvar_13.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13.xyz, vec3(ldn_6), vec3(alpha_10));
  ramp_11.xyz = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = ramp_11.www;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = ((ramp_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_15) + color_8).xyz);
  tmpvar_16.w = color_8.w;
  tmpvar_5 = tmpvar_16;
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
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump float alpha_10;
  alpha_10 = tmpvar_4;
  lowp vec4 ramp_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = ldn_6;
  tmpvar_12.y = fresnel_7;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, tmpvar_12);
  ramp_11.w = tmpvar_13.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13.xyz, vec3(ldn_6), vec3(alpha_10));
  ramp_11.xyz = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = ramp_11.www;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = ((ramp_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_15) + color_8).xyz);
  tmpvar_16.w = color_8.w;
  tmpvar_5 = tmpvar_16;
  diffuse_1 = tmpvar_5;
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
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  mediump vec4 tmpvar_5;
  mediump float ldn_6;
  ldn_6 = xlv_TEXCOORD1.x;
  mediump float fresnel_7;
  fresnel_7 = xlv_TEXCOORD1.w;
  lowp vec4 color_8;
  color_8 = xlv_TEXCOORD2;
  lowp vec4 rimColor_9;
  rimColor_9 = xlv_COLOR0;
  mediump float alpha_10;
  alpha_10 = tmpvar_4;
  lowp vec4 ramp_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = ldn_6;
  tmpvar_12.y = fresnel_7;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp, tmpvar_12);
  ramp_11.w = tmpvar_13.w;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (tmpvar_13.xyz, vec3(ldn_6), vec3(alpha_10));
  ramp_11.xyz = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = ramp_11.www;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = ((ramp_11.xyz * _LightColor0.xyz) + ((rimColor_9 * tmpvar_15) + color_8).xyz);
  tmpvar_16.w = color_8.w;
  tmpvar_5 = tmpvar_16;
  diffuse_1 = tmpvar_5;
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
Fallback Off
}