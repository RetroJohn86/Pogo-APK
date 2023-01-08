//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/Ring" {
Properties {
 _MainTex ("Main Texture", 2D) = "white" { }
 _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _Distort ("Distort", Vector) = (0.500000,0.500000,1.000000,1.000000)
 _OuterRadius ("Outer Radius", Float) = 0.500000
 _InnerRadius ("Inner Radius", Float) = -0.500000
 _Hardness ("Hardness", Float) = 1.000000
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" "AllowProjectors"="False" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" "AllowProjectors"="False" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 34879
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_9;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_2;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  res_12 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_12;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_9;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_2;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  res_12 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_12;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_9;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = worldNormal_2;
  mediump vec4 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 res_12;
  mediump vec3 x_13;
  x_13.x = dot (unity_SHAr, normal_11);
  x_13.y = dot (unity_SHAg, normal_11);
  x_13.z = dot (unity_SHAb, normal_11);
  mediump vec3 x1_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
  x1_14.x = dot (unity_SHBr, tmpvar_15);
  x1_14.y = dot (unity_SHBg, tmpvar_15);
  x1_14.z = dot (unity_SHBb, tmpvar_15);
  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
  )));
  res_12 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_12;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_2;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_23);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_2;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_23);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_17;
  lightColor0_17 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_18;
  lightColor1_18 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_19;
  lightColor2_19 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_20;
  lightColor3_20 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_21;
  lightAttenSq_21 = unity_4LightAtten0;
  highp vec3 normal_22;
  normal_22 = worldNormal_2;
  highp vec3 col_23;
  highp vec4 ndotl_24;
  highp vec4 lengthSq_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
  ndotl_24 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (lengthSq_25 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_30.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_23);
  gl_Position = (glstate_matrix_mvp * tmpvar_5);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
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
  worldNormal_2 = tmpvar_10;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = worldNormal_2;
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
  shlight_1 = res_13;
  tmpvar_4 = shlight_1;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  worldNormal_2 = tmpvar_11;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_2;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_14;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 normal_23;
  normal_23 = worldNormal_2;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  ndotl_25 = (tmpvar_27 * normal_23.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
  ndotl_25 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (lengthSq_26 * lightAttenSq_22)
  ))));
  col_24 = (lightColor0_18 * tmpvar_31.x);
  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_24);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  worldNormal_2 = tmpvar_11;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_2;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_14;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 normal_23;
  normal_23 = worldNormal_2;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  ndotl_25 = (tmpvar_27 * normal_23.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
  ndotl_25 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (lengthSq_26 * lightAttenSq_22)
  ))));
  col_24 = (lightColor0_18 * tmpvar_31.x);
  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_24);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 worldNormal_2;
  mediump vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
  highp vec3 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
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
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(((
    (v_8.xyz * _glesNormal.x)
   + 
    (v_9.xyz * _glesNormal.y)
  ) + (v_10.xyz * _glesNormal.z)));
  worldNormal_2 = tmpvar_11;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = worldNormal_2;
  mediump vec4 normal_13;
  normal_13 = tmpvar_12;
  mediump vec3 res_14;
  mediump vec3 x_15;
  x_15.x = dot (unity_SHAr, normal_13);
  x_15.y = dot (unity_SHAg, normal_13);
  x_15.z = dot (unity_SHAb, normal_13);
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
  )));
  res_14 = max (((1.055 * 
    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  shlight_1 = res_14;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_18;
  lightColor0_18 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_19;
  lightColor1_19 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_20;
  lightColor2_20 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_21;
  lightColor3_21 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_22;
  lightAttenSq_22 = unity_4LightAtten0;
  highp vec3 normal_23;
  normal_23 = worldNormal_2;
  highp vec3 col_24;
  highp vec4 ndotl_25;
  highp vec4 lengthSq_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_26 = (tmpvar_27 * tmpvar_27);
  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
  ndotl_25 = (tmpvar_27 * normal_23.x);
  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
  ndotl_25 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (lengthSq_26 * lightAttenSq_22)
  ))));
  col_24 = (lightColor0_18 * tmpvar_31.x);
  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_24);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  c_1.w = 0.0;
  c_1.xyz = (tmpvar_2 * xlv_TEXCOORD2);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1 = (c_1 + tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "RenderType"="Transparent" "AllowProjectors"="False" }
  ZWrite Off
  Blend SrcAlpha One
  ColorMask RGB
  GpuProgramID 66220
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  lowp float tmpvar_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec2 x_5;
  x_5 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_6;
  tmpvar_6 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_1 = (_Color.xyz * c_3.xyz);
  highp float tmpvar_7;
  tmpvar_7 = pow (clamp ((
    abs((sqrt(dot (x_5, x_5)) - tmpvar_6))
   / 
    (_OuterRadius - tmpvar_6)
  ), 0.0, 1.0), _Hardness);
  tmpvar_2 = (((1.0 - tmpvar_7) * _Color.w) * c_3.w);
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_1;
  tmpvar_8.w = tmpvar_2;
  gl_FragData[0] = tmpvar_8;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
varying highp float xlv_TEXCOORD3;
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
  xlv_TEXCOORD3 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform highp vec4 _Distort;
uniform highp float _OuterRadius;
uniform highp float _InnerRadius;
uniform highp float _Hardness;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  highp vec2 x_6;
  x_6 = ((_Distort.xy - xlv_TEXCOORD0) * _Distort.zw);
  highp float tmpvar_7;
  tmpvar_7 = ((_OuterRadius + _InnerRadius) * 0.5);
  tmpvar_2 = (_Color.xyz * c_4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = pow (clamp ((
    abs((sqrt(dot (x_6, x_6)) - tmpvar_7))
   / 
    (_OuterRadius - tmpvar_7)
  ), 0.0, 1.0), _Hardness);
  tmpvar_3 = (((1.0 - tmpvar_8) * _Color.w) * c_4.w);
  lowp vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_2;
  tmpvar_9.w = tmpvar_3;
  c_1.w = tmpvar_9.w;
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD3, 0.0, 1.0);
  c_1.xyz = (tmpvar_2 * vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
}
Fallback "Diffuse"
}