//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/World Map/Ground" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _TextureScale ("Texture Scale", Float) = 0.010000
 _ColorRamp ("1D Gradient Ramp (RGB)", 2D) = "white" { }
 _NearDist ("Near Distance", Float) = 100.000000
 _FarDist ("Far Distance", Float) = 250.000000
 _Offset ("Z Offset", Float) = 10.000000
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Offset [_Offset], [_Offset]
  GpuProgramID 5275
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  c_3.xyz = c_13.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_6);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  c_4.xyz = c_19.xyz;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_3.zw;
  mediump vec3 normal_12;
  normal_12 = worldNormal_1;
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = normal_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, tmpvar_13);
  x_15.y = dot (unity_SHAg, tmpvar_13);
  x_15.z = dot (unity_SHAb, tmpvar_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_12.xyzz * normal_12.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  xlv_TEXCOORD1 = tmpvar_18.xyz;
  xlv_TEXCOORD2 = o_9;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), res_14);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_18);
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
  xlv_TEXCOORD5 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 texColor_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, P_9).xyz;
  texColor_8 = tmpvar_10;
  mediump float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_11 = tmpvar_12;
  tmpvar_7 = (texture2D (_ColorRamp, vec2(tmpvar_11)).xyz * texColor_8);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_7 * tmpvar_1) * diff_15);
  c_14.w = 0.0;
  c_13.w = c_14.w;
  c_13.xyz = (c_14.xyz + (tmpvar_7 * xlv_TEXCOORD3));
  highp float tmpvar_17;
  tmpvar_17 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_13.xyz, vec3(tmpvar_17));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
uniform highp vec4 _ProjectionParams;
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
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_4.zw;
  highp vec3 lightColor0_14;
  lightColor0_14 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_15;
  lightColor1_15 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_16;
  lightColor2_16 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_17;
  lightColor3_17 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_18;
  lightAttenSq_18 = unity_4LightAtten0;
  highp vec3 normal_19;
  normal_19 = worldNormal_1;
  highp vec3 col_20;
  highp vec4 ndotl_21;
  highp vec4 lengthSq_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_22 = (tmpvar_23 * tmpvar_23);
  lengthSq_22 = (lengthSq_22 + (tmpvar_24 * tmpvar_24));
  lengthSq_22 = (lengthSq_22 + (tmpvar_25 * tmpvar_25));
  ndotl_21 = (tmpvar_23 * normal_19.x);
  ndotl_21 = (ndotl_21 + (tmpvar_24 * normal_19.y));
  ndotl_21 = (ndotl_21 + (tmpvar_25 * normal_19.z));
  highp vec4 tmpvar_26;
  tmpvar_26 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_21 * inversesqrt(lengthSq_22)));
  ndotl_21 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 * (1.0/((1.0 + 
    (lengthSq_22 * lightAttenSq_18)
  ))));
  col_20 = (lightColor0_14 * tmpvar_27.x);
  col_20 = (col_20 + (lightColor1_15 * tmpvar_27.y));
  col_20 = (col_20 + (lightColor2_16 * tmpvar_27.z));
  col_20 = (col_20 + (lightColor3_17 * tmpvar_27.w));
  tmpvar_3 = col_20;
  mediump vec3 normal_28;
  normal_28 = worldNormal_1;
  mediump vec3 ambient_29;
  mediump vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = normal_28;
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_30);
  x_32.y = dot (unity_SHAg, tmpvar_30);
  x_32.z = dot (unity_SHAb, tmpvar_30);
  mediump vec3 x1_33;
  mediump vec4 tmpvar_34;
  tmpvar_34 = (normal_28.xyzz * normal_28.yzzx);
  x1_33.x = dot (unity_SHBr, tmpvar_34);
  x1_33.y = dot (unity_SHBg, tmpvar_34);
  x1_33.z = dot (unity_SHBb, tmpvar_34);
  res_31 = (x_32 + (x1_33 + (unity_SHC.xyz * 
    ((normal_28.x * normal_28.x) - (normal_28.y * normal_28.y))
  )));
  res_31 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_29 = (tmpvar_3 + max (vec3(0.0, 0.0, 0.0), res_31));
  tmpvar_3 = ambient_29;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_6.xyz;
  xlv_TEXCOORD2 = o_11;
  xlv_TEXCOORD3 = ambient_29;
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
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 texColor_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD1.xz * _TextureScale);
  lowp vec3 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, P_10).xyz;
  texColor_9 = tmpvar_11;
  mediump float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (((xlv_TEXCOORD2.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_12 = tmpvar_13;
  tmpvar_8 = (texture2D (_ColorRamp, vec2(tmpvar_12)).xyz * texColor_9);
  lowp float tmpvar_14;
  highp float lightShadowDataX_15;
  mediump float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD4.xy).x > xlv_TEXCOORD4.z)), lightShadowDataX_15);
  tmpvar_14 = tmpvar_17;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_14;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_18;
  lowp vec4 c_19;
  lowp vec4 c_20;
  lowp float diff_21;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_21 = tmpvar_22;
  c_20.xyz = ((tmpvar_8 * tmpvar_18) * diff_21);
  c_20.w = 0.0;
  c_19.w = c_20.w;
  c_19.xyz = (c_20.xyz + (tmpvar_8 * xlv_TEXCOORD3));
  highp float tmpvar_23;
  tmpvar_23 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_19.xyz, vec3(tmpvar_23));
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Offset [_Offset], [_Offset]
  GpuProgramID 122566
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
  Offset [_Offset], [_Offset]
  GpuProgramID 144537
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2.xyz = c_11.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2.xyz = c_11.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2.xyz = c_11.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2.xyz = c_12.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2.xyz = c_12.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2.xyz = c_12.xyz;
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2 = c_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_12));
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2 = c_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_12));
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.xyz = (light_3.xyz + xlv_TEXCOORD4);
  lowp vec4 c_11;
  c_11.xyz = (tmpvar_4 * light_3.xyz);
  c_11.w = 0.0;
  c_2 = c_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_12));
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2 = c_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_13));
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2 = c_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_13));
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
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
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
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_3.zw;
  tmpvar_1.zw = vec2(0.0, 0.0);
  tmpvar_1.xy = vec2(0.0, 0.0);
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].x;
  v_11.y = unity_WorldToObject[1].x;
  v_11.z = unity_WorldToObject[2].x;
  v_11.w = unity_WorldToObject[3].x;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].y;
  v_12.y = unity_WorldToObject[1].y;
  v_12.z = unity_WorldToObject[2].y;
  v_12.w = unity_WorldToObject[3].y;
  highp vec4 v_13;
  v_13.x = unity_WorldToObject[0].z;
  v_13.y = unity_WorldToObject[1].z;
  v_13.z = unity_WorldToObject[2].z;
  v_13.w = unity_WorldToObject[3].z;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = normalize(((
    (v_11.xyz * _glesNormal.x)
   + 
    (v_12.xyz * _glesNormal.y)
  ) + (v_13.xyz * _glesNormal.z)));
  mediump vec4 normal_15;
  normal_15 = tmpvar_14;
  mediump vec3 res_16;
  mediump vec3 x_17;
  x_17.x = dot (unity_SHAr, normal_15);
  x_17.y = dot (unity_SHAg, normal_15);
  x_17.z = dot (unity_SHAb, normal_15);
  mediump vec3 x1_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_15.xyzz * normal_15.yzzx);
  x1_18.x = dot (unity_SHBr, tmpvar_19);
  x1_18.y = dot (unity_SHBg, tmpvar_19);
  x1_18.z = dot (unity_SHBb, tmpvar_19);
  res_16 = (x_17 + (x1_18 + (unity_SHC.xyz * 
    ((normal_15.x * normal_15.x) - (normal_15.y * normal_15.y))
  )));
  res_16 = max (((1.055 * 
    pow (max (res_16, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  tmpvar_2 = res_16;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = o_8;
  xlv_TEXCOORD3 = tmpvar_1;
  xlv_TEXCOORD4 = tmpvar_2;
  xlv_TEXCOORD5 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform sampler2D _ColorRamp;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _TextureScale;
uniform sampler2D _LightBuffer;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD4;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 texColor_5;
  highp vec2 P_6;
  P_6 = (xlv_TEXCOORD0.xz * _TextureScale);
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, P_6).xyz;
  texColor_5 = tmpvar_7;
  mediump float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((xlv_TEXCOORD1.z - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_8 = tmpvar_9;
  tmpvar_4 = (texture2D (_ColorRamp, vec2(tmpvar_8)).xyz * texColor_5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_11.w;
  light_3.xyz = (tmpvar_11.xyz + xlv_TEXCOORD4);
  lowp vec4 c_12;
  c_12.xyz = (tmpvar_4 * light_3.xyz);
  c_12.w = 0.0;
  c_2 = c_12;
  highp float tmpvar_13;
  tmpvar_13 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_13));
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
Fallback "Legacy Shaders/Transparent/Diffuse"
}