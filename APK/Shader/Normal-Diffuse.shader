//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/Diffuse" {
Properties {
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 27706
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_14.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_14.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_8;
  normal_8 = worldNormal_1;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  res_10 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_14.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = ambient_25;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = ambient_25;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = ambient_25;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].x;
  v_6.y = unity_WorldToObject[1].x;
  v_6.z = unity_WorldToObject[2].x;
  v_6.w = unity_WorldToObject[3].x;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].y;
  v_7.y = unity_WorldToObject[1].y;
  v_7.z = unity_WorldToObject[2].y;
  v_7.w = unity_WorldToObject[3].y;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].z;
  v_8.y = unity_WorldToObject[1].z;
  v_8.z = unity_WorldToObject[2].z;
  v_8.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(((
    (v_6.xyz * _glesNormal.x)
   + 
    (v_7.xyz * _glesNormal.y)
  ) + (v_8.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_9;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_10;
  lightColor0_10 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_11;
  lightColor1_11 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_12;
  lightColor2_12 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_13;
  lightColor3_13 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_14;
  lightAttenSq_14 = unity_4LightAtten0;
  highp vec3 normal_15;
  normal_15 = worldNormal_1;
  highp vec3 col_16;
  highp vec4 ndotl_17;
  highp vec4 lengthSq_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_5.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_5.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_5.z);
  lengthSq_18 = (tmpvar_19 * tmpvar_19);
  lengthSq_18 = (lengthSq_18 + (tmpvar_20 * tmpvar_20));
  lengthSq_18 = (lengthSq_18 + (tmpvar_21 * tmpvar_21));
  ndotl_17 = (tmpvar_19 * normal_15.x);
  ndotl_17 = (ndotl_17 + (tmpvar_20 * normal_15.y));
  ndotl_17 = (ndotl_17 + (tmpvar_21 * normal_15.z));
  highp vec4 tmpvar_22;
  tmpvar_22 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_17 * inversesqrt(lengthSq_18)));
  ndotl_17 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * (1.0/((1.0 + 
    (lengthSq_18 * lightAttenSq_14)
  ))));
  col_16 = (lightColor0_10 * tmpvar_23.x);
  col_16 = (col_16 + (lightColor1_11 * tmpvar_23.y));
  col_16 = (col_16 + (lightColor2_12 * tmpvar_23.z));
  col_16 = (col_16 + (lightColor3_13 * tmpvar_23.w));
  tmpvar_3 = col_16;
  mediump vec3 normal_24;
  normal_24 = worldNormal_1;
  mediump vec3 ambient_25;
  mediump vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = normal_24;
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, tmpvar_26);
  x_28.y = dot (unity_SHAg, tmpvar_26);
  x_28.z = dot (unity_SHAb, tmpvar_26);
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_24.xyzz * normal_24.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  res_27 = (x_28 + (x1_29 + (unity_SHC.xyz * 
    ((normal_24.x * normal_24.x) - (normal_24.y * normal_24.y))
  )));
  res_27 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_25 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_27));
  tmpvar_3 = ambient_25;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_5.xyz;
  xlv_TEXCOORD3 = ambient_25;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  c_4.xyz = c_14.xyz;
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_15.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_15.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  mediump vec3 normal_9;
  normal_9 = worldNormal_1;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  res_11 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD2 = tmpvar_15.xyz;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_11);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_15);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6.xyz;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6.xyz;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].x;
  v_7.y = unity_WorldToObject[1].x;
  v_7.z = unity_WorldToObject[2].x;
  v_7.w = unity_WorldToObject[3].x;
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].y;
  v_8.y = unity_WorldToObject[1].y;
  v_8.z = unity_WorldToObject[2].y;
  v_8.w = unity_WorldToObject[3].y;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].z;
  v_9.y = unity_WorldToObject[1].z;
  v_9.z = unity_WorldToObject[2].z;
  v_9.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(((
    (v_7.xyz * _glesNormal.x)
   + 
    (v_8.xyz * _glesNormal.y)
  ) + (v_9.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_10;
  tmpvar_2 = worldNormal_1;
  highp vec3 lightColor0_11;
  lightColor0_11 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_12;
  lightColor1_12 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_13;
  lightColor2_13 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_14;
  lightColor3_14 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_15;
  lightAttenSq_15 = unity_4LightAtten0;
  highp vec3 normal_16;
  normal_16 = worldNormal_1;
  highp vec3 col_17;
  highp vec4 ndotl_18;
  highp vec4 lengthSq_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_19 = (tmpvar_20 * tmpvar_20);
  lengthSq_19 = (lengthSq_19 + (tmpvar_21 * tmpvar_21));
  lengthSq_19 = (lengthSq_19 + (tmpvar_22 * tmpvar_22));
  ndotl_18 = (tmpvar_20 * normal_16.x);
  ndotl_18 = (ndotl_18 + (tmpvar_21 * normal_16.y));
  ndotl_18 = (ndotl_18 + (tmpvar_22 * normal_16.z));
  highp vec4 tmpvar_23;
  tmpvar_23 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_18 * inversesqrt(lengthSq_19)));
  ndotl_18 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (1.0/((1.0 + 
    (lengthSq_19 * lightAttenSq_15)
  ))));
  col_17 = (lightColor0_11 * tmpvar_24.x);
  col_17 = (col_17 + (lightColor1_12 * tmpvar_24.y));
  col_17 = (col_17 + (lightColor2_13 * tmpvar_24.z));
  col_17 = (col_17 + (lightColor3_14 * tmpvar_24.w));
  tmpvar_3 = col_17;
  mediump vec3 normal_25;
  normal_25 = worldNormal_1;
  mediump vec3 ambient_26;
  mediump vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = normal_25;
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, tmpvar_27);
  x_29.y = dot (unity_SHAg, tmpvar_27);
  x_29.z = dot (unity_SHAb, tmpvar_27);
  mediump vec3 x1_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = (normal_25.xyzz * normal_25.yzzx);
  x1_30.x = dot (unity_SHBr, tmpvar_31);
  x1_30.y = dot (unity_SHBg, tmpvar_31);
  x1_30.z = dot (unity_SHBb, tmpvar_31);
  res_28 = (x_29 + (x1_30 + (unity_SHC.xyz * 
    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
  )));
  res_28 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_26 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_28));
  tmpvar_3 = ambient_26;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_6.xyz;
  xlv_TEXCOORD3 = ambient_26;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp float tmpvar_9;
  highp float lightShadowDataX_10;
  mediump float tmpvar_11;
  tmpvar_11 = _LightShadowData.x;
  lightShadowDataX_10 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_10);
  tmpvar_9 = tmpvar_12;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_9;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_13;
  lowp vec4 c_14;
  lowp vec4 c_15;
  lowp float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_16 = tmpvar_17;
  c_15.xyz = ((tmpvar_8.xyz * tmpvar_13) * diff_16);
  c_15.w = tmpvar_8.w;
  c_14.w = c_15.w;
  c_14.xyz = (c_15.xyz + (tmpvar_8.xyz * xlv_TEXCOORD3));
  highp float tmpvar_18;
  tmpvar_18 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_14.xyz, vec3(tmpvar_18));
  c_4.w = 1.0;
  gl_FragData[0] = c_4;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Blend One One
  GpuProgramID 101986
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
  c_9.w = tmpvar_7.w;
  c_8.w = c_9.w;
  c_8.xyz = c_9.xyz;
  c_3.xyz = c_8.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_8.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_8.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_18);
  c_17.w = tmpvar_8.w;
  c_16.w = c_17.w;
  c_16.xyz = c_17.xyz;
  c_3.xyz = c_16.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_14);
  c_13.w = tmpvar_7.w;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  c_11.w = c_12.w;
  c_11.xyz = c_12.xyz;
  c_3.xyz = c_11.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, vec2(tmpvar_10)).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_9);
  c_8.w = tmpvar_7.w;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_8.xyz * vec3(tmpvar_11));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_8.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_8.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_8;
  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD2;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_WorldToLight * tmpvar_9);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10.xy / tmpvar_10.w) + 0.5);
  tmpvar_11 = texture2D (_LightTexture0, P_12);
  highp float tmpvar_13;
  tmpvar_13 = dot (tmpvar_10.xyz, tmpvar_10.xyz);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTextureB0, vec2(tmpvar_13));
  highp float tmpvar_15;
  tmpvar_15 = ((float(
    (tmpvar_10.z > 0.0)
  ) * tmpvar_11.w) * tmpvar_14.w);
  atten_4 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_16;
  lowp float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_17 = tmpvar_18;
  c_16.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_17);
  c_16.w = tmpvar_8.w;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_16.xyz * vec3(tmpvar_19));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xyz;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  lowp float tmpvar_11;
  tmpvar_11 = (texture2D (_LightTextureB0, vec2(tmpvar_10)).w * textureCube (_LightTexture0, tmpvar_9).w);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_11);
  lowp vec4 c_12;
  lowp float diff_13;
  mediump float tmpvar_14;
  tmpvar_14 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_13 = tmpvar_14;
  c_12.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_13);
  c_12.w = tmpvar_7.w;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_12.xyz * vec3(tmpvar_15));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_7.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_7.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
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
  worldNormal_1 = tmpvar_8;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_7;
  tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD2;
  highp vec2 tmpvar_9;
  tmpvar_9 = (unity_WorldToLight * tmpvar_8).xy;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_LightTexture0, tmpvar_9).w;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  tmpvar_1 = (tmpvar_1 * tmpvar_10);
  lowp vec4 c_11;
  lowp float diff_12;
  mediump float tmpvar_13;
  tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_12 = tmpvar_13;
  c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
  c_11.w = tmpvar_7.w;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
  c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  GpuProgramID 196438
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying mediump vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying mediump vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 v_4;
  v_4.x = unity_WorldToObject[0].x;
  v_4.y = unity_WorldToObject[1].x;
  v_4.z = unity_WorldToObject[2].x;
  v_4.w = unity_WorldToObject[3].x;
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].y;
  v_5.y = unity_WorldToObject[1].y;
  v_5.z = unity_WorldToObject[2].y;
  v_5.w = unity_WorldToObject[3].y;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].z;
  v_6.y = unity_WorldToObject[1].z;
  v_6.z = unity_WorldToObject[2].z;
  v_6.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((
    (v_4.xyz * _glesNormal.x)
   + 
    (v_5.xyz * _glesNormal.y)
  ) + (v_6.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_7;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
varying mediump vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  GpuProgramID 232251
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2.xyz = c_6.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2.xyz = c_7.xyz;
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_6;
  c_6.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_6.w = tmpvar_4.w;
  c_2 = c_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_8;
  v_8.x = unity_WorldToObject[0].x;
  v_8.y = unity_WorldToObject[1].x;
  v_8.z = unity_WorldToObject[2].x;
  v_8.w = unity_WorldToObject[3].x;
  highp vec4 v_9;
  v_9.x = unity_WorldToObject[0].y;
  v_9.y = unity_WorldToObject[1].y;
  v_9.z = unity_WorldToObject[2].y;
  v_9.w = unity_WorldToObject[3].y;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].z;
  v_10.y = unity_WorldToObject[1].z;
  v_10.z = unity_WorldToObject[2].z;
  v_10.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  mediump vec4 normal_12;
  normal_12 = tmpvar_11;
  mediump vec3 res_13;
  mediump vec3 x_14;
  x_14.x = dot (unity_SHAr, normal_12);
  x_14.y = dot (unity_SHAg, normal_12);
  x_14.z = dot (unity_SHAb, normal_12);
  mediump vec3 x1_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
  x1_15.x = dot (unity_SHBr, tmpvar_16);
  x1_15.y = dot (unity_SHBg, tmpvar_16);
  x1_15.z = dot (unity_SHBb, tmpvar_16);
  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_13 = max (((1.055 * 
    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_13;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_6.w;
  light_3.xyz = (tmpvar_6.xyz + xlv_TEXCOORD4);
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4.xyz * light_3.xyz);
  c_7.w = tmpvar_4.w;
  c_2 = c_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_8));
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "UNITY_HDR_ON" }
""
}
}
 }
}
Fallback "Legacy Shaders/VertexLit"
}