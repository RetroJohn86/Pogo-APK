//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Vertex Lit with Rim" {
Properties {
[KeywordEnum(Opaque, Cutout)]  _Render ("Rendering Mode", Float) = 0.000000
[KeywordEnum(Off, Diffuse)]  _ColorMode ("Color Modifier Mode", Float) = 0.000000
 _Color ("    Color", Color) = (1.000000,1.000000,1.000000,1.000000)
[KeywordEnum(Off, Diffuse)]  _VertexMode ("Vertex Color Mode", Float) = 1.000000
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _AlphaTestRef ("    Alpha Cutoff", Range(0.000000,1.000000)) = 0.500000
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)]  _Cull ("Culling Mode (None = double-sided)", Float) = 2.000000
[Toggle(BRB_LIGHTING_TWOSIDED)]  _LightingDoubleSided ("    Two-sided lighting", Float) = 0.000000
[Toggle(BRB_FX_DISABLE)]  _FX ("Ignore FX Color", Float) = 0.000000
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "CASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "RenderType"="Opaque" }
  Cull [_Cull]
  GpuProgramID 59309
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
  GpuProgramID 86189
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _EnvironmentColor;
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
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12).xyz;
  wPos_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  wsNormal_6 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_18);
  ldn_4.w = ((tmpvar_18 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(wsNormal_6);
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.z = 0.0;
  tmpvar_21.xy = ldn_4.ww;
  tmpvar_21.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_10 = tmpvar_21;
  mediump float tmpvar_22;
  highp float N_23;
  N_23 = wsNormal_6.y;
  tmpvar_22 = ((N_23 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_22;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = unity_AmbientEquator.xyz;
  tmpvar_24.w = sky2ground_7;
  tmpvar_11 = tmpvar_24;
  tmpvar_11.xyz = (tmpvar_11.xyz * _glesColor.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_25[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_25[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * _glesNormal));
  vsNormal_2 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.z = 0.0;
  tmpvar_27.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_27.w = vsNormal_2.x;
  lowp vec3 tmpvar_28;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_29;
  tmpvar_29 = abs(vsNormal_2.x);
  tmpvar_9.xyz = ((tmpvar_28 * tmpvar_29) * _glesColor.w);
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * tmpvar_14.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_30)
   * tmpvar_30)));
  gl_Position = tmpvar_14;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_27;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _EnvironmentColor;
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
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12).xyz;
  wPos_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  wsNormal_6 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_18);
  ldn_4.w = ((tmpvar_18 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(wsNormal_6);
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.z = 0.0;
  tmpvar_21.xy = ldn_4.ww;
  tmpvar_21.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_10 = tmpvar_21;
  mediump float tmpvar_22;
  highp float N_23;
  N_23 = wsNormal_6.y;
  tmpvar_22 = ((N_23 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_22;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = unity_AmbientEquator.xyz;
  tmpvar_24.w = sky2ground_7;
  tmpvar_11 = tmpvar_24;
  tmpvar_11.xyz = (tmpvar_11.xyz * _glesColor.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_25[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_25[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * _glesNormal));
  vsNormal_2 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.z = 0.0;
  tmpvar_27.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_27.w = vsNormal_2.x;
  lowp vec3 tmpvar_28;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_29;
  tmpvar_29 = abs(vsNormal_2.x);
  tmpvar_9.xyz = ((tmpvar_28 * tmpvar_29) * _glesColor.w);
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * tmpvar_14.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_30)
   * tmpvar_30)));
  gl_Position = tmpvar_14;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_27;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _EnvironmentColor;
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
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12).xyz;
  wPos_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_15[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_15[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((tmpvar_15 * _glesNormal));
  wsNormal_6 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_5 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = dot (wsNormal_6, wsLight_5);
  ldn_4.xyz = vec3(tmpvar_18);
  ldn_4.w = ((tmpvar_18 * 0.5) + 0.5);
  lowp vec3 tmpvar_19;
  tmpvar_19 = normalize(wsNormal_6);
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_19, normalize((_WorldSpaceCameraPos - wPos_8)));
  vdn_3 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21.z = 0.0;
  tmpvar_21.xy = ldn_4.ww;
  tmpvar_21.w = (1.0 - clamp (vdn_3, 0.0, 1.0));
  tmpvar_10 = tmpvar_21;
  mediump float tmpvar_22;
  highp float N_23;
  N_23 = wsNormal_6.y;
  tmpvar_22 = ((N_23 * 0.5) + 0.5);
  sky2ground_7 = tmpvar_22;
  lowp vec4 tmpvar_24;
  tmpvar_24.xyz = unity_AmbientEquator.xyz;
  tmpvar_24.w = sky2ground_7;
  tmpvar_11 = tmpvar_24;
  tmpvar_11.xyz = (tmpvar_11.xyz * _glesColor.w);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_25[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_25[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((tmpvar_25 * _glesNormal));
  vsNormal_2 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.z = 0.0;
  tmpvar_27.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_27.w = vsNormal_2.x;
  lowp vec3 tmpvar_28;
  if ((vsNormal_2.x < 0.0)) {
    tmpvar_28 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_28 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_29;
  tmpvar_29 = abs(vsNormal_2.x);
  tmpvar_9.xyz = ((tmpvar_28 * tmpvar_29) * _glesColor.w);
  highp float tmpvar_30;
  tmpvar_30 = (unity_FogParams.x * tmpvar_14.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_30)
   * tmpvar_30)));
  gl_Position = tmpvar_14;
  xlv_COLOR0 = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_27;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
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
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}