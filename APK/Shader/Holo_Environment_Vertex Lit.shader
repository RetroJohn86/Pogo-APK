//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Environment/Vertex Lit" {
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
[Toggle(BRB_RAMP)] _RampEnable ("Use Toon Ramp", Float) = 0
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
[Toggle(BRB_LIGHTING_TWOSIDED)] _LightingDoubleSided ("    Two-sided lighting", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "CASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" }
  ZClip Off
  GpuProgramID 28047
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
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 99821
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _EnvironmentColor;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  highp vec4 envFogColor_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  wsNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_11;
  mediump float tmpvar_12;
  highp float N_13;
  N_13 = wsNormal_3.y;
  tmpvar_12 = ((N_13 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_12;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = unity_AmbientEquator.xyz;
  tmpvar_14.w = sky2ground_4;
  tmpvar_7 = tmpvar_14;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  lowp float tmpvar_15;
  tmpvar_15 = dot (wsNormal_3, wsLight_2);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_7.w);
  tmpvar_7.xyz = ((vec3(tmpvar_15) * xlat_mutable_LightColor0.xyz) + tmpvar_7.xyz);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * tmpvar_8.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_17)
   * tmpvar_17)));
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_4;
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _EnvironmentColor;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  highp vec4 envFogColor_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  wsNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_11;
  mediump float tmpvar_12;
  highp float N_13;
  N_13 = wsNormal_3.y;
  tmpvar_12 = ((N_13 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_12;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = unity_AmbientEquator.xyz;
  tmpvar_14.w = sky2ground_4;
  tmpvar_7 = tmpvar_14;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  lowp float tmpvar_15;
  tmpvar_15 = dot (wsNormal_3, wsLight_2);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_7.w);
  tmpvar_7.xyz = ((vec3(tmpvar_15) * xlat_mutable_LightColor0.xyz) + tmpvar_7.xyz);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * tmpvar_8.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_17)
   * tmpvar_17)));
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_4;
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
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _EnvironmentColor;
lowp vec4 xlat_mutable_LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  xlat_mutable_LightColor0.w = _LightColor0.w;
  highp vec4 envFogColor_1;
  lowp vec3 wsLight_2;
  lowp vec3 wsNormal_3;
  lowp float sky2ground_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (glstate_matrix_mvp * _glesVertex);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  wsNormal_3 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(_WorldSpaceLightPos0.xyz);
  wsLight_2 = tmpvar_11;
  mediump float tmpvar_12;
  highp float N_13;
  N_13 = wsNormal_3.y;
  tmpvar_12 = ((N_13 * 0.5) + 0.5);
  sky2ground_4 = tmpvar_12;
  lowp vec4 tmpvar_14;
  tmpvar_14.xyz = unity_AmbientEquator.xyz;
  tmpvar_14.w = sky2ground_4;
  tmpvar_7 = tmpvar_14;
  tmpvar_7.xyz = (tmpvar_7.xyz * _glesColor.w);
  lowp float tmpvar_15;
  tmpvar_15 = dot (wsNormal_3, wsLight_2);
  xlat_mutable_LightColor0.xyz = (_LightColor0.xyz * tmpvar_7.w);
  tmpvar_7.xyz = ((vec3(tmpvar_15) * xlat_mutable_LightColor0.xyz) + tmpvar_7.xyz);
  highp vec4 tmpvar_16;
  tmpvar_16.zw = vec2(0.0, 0.0);
  tmpvar_16.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp float tmpvar_17;
  tmpvar_17 = (unity_FogParams.x * tmpvar_8.z);
  envFogColor_1.xyz = _EnvironmentColor.xyz;
  envFogColor_1.w = (_EnvironmentColor.w * exp2((
    -(tmpvar_17)
   * tmpvar_17)));
  gl_Position = tmpvar_8;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_16;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD6 = envFogColor_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  diffuse_1 = xlv_TEXCOORD2;
  col_2.xyz = (tmpvar_3.xyz * diffuse_1.xyz);
  highp vec3 tmpvar_4;
  tmpvar_4 = mix (xlv_TEXCOORD6.xyz, col_2.xyz, xlv_TEXCOORD6.www);
  col_2.xyz = tmpvar_4;
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
CustomEditor "CustomMaterialInspector"
}