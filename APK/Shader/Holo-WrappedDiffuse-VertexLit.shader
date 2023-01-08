//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Wrapped Diffuse/Vertex Lit" {
Properties {
 _MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
[KeywordEnum(None, Unlit)]  _BaseAlpha ("    Alpha Mode", Float) = 0.000000
 _RampOverlayColor ("Ramp Overlay Color (RGB)", Color) = (0.500000,0.500000,0.500000,0.500000)
}
SubShader { 
 LOD 100
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "CASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "RenderType"="Opaque" }
  GpuProgramID 54306
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
  GpuProgramID 114990
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
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}