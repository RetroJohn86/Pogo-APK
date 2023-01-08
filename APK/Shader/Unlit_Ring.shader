//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/Ring" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
_Distort ("Distort", Vector) = (0.5,0.5,1,1)
_OuterRadius ("Outer Radius", Float) = 0.5
_InnerRadius ("Inner Radius", Float) = -0.5
_Hardness ("Hardness", Float) = 1
}
SubShader {
 Tags { "AllowProjectors" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "ForwardBase" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZClip Off
  ZWrite Off
  GpuProgramID 11133
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_2 = tmpvar_7;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = worldNormal_2;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
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
Keywords { "DIRECTIONAL" }
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
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_2 = tmpvar_7;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = worldNormal_2;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
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
Keywords { "DIRECTIONAL" }
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
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  worldNormal_2 = tmpvar_7;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = worldNormal_2;
  mediump vec4 normal_9;
  normal_9 = tmpvar_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, normal_9);
  x_11.y = dot (unity_SHAg, normal_9);
  x_11.z = dot (unity_SHAb, normal_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_9.xyzz * normal_9.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  shlight_1 = tmpvar_14;
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 normal_21;
  normal_21 = worldNormal_2;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * normal_21.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * normal_21.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * normal_21.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_20)
  ))));
  col_22 = (lightColor0_16 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_17 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_18 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_19 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_22);
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
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 normal_21;
  normal_21 = worldNormal_2;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * normal_21.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * normal_21.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * normal_21.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_20)
  ))));
  col_22 = (lightColor0_16 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_17 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_18 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_19 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_22);
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
Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
  tmpvar_4 = shlight_1;
  highp vec3 lightColor0_16;
  lightColor0_16 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_17;
  lightColor1_17 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_18;
  lightColor2_18 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_19;
  lightColor3_19 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_20;
  lightAttenSq_20 = unity_4LightAtten0;
  highp vec3 normal_21;
  normal_21 = worldNormal_2;
  highp vec3 col_22;
  highp vec4 ndotl_23;
  highp vec4 lengthSq_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_6.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_6.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_6.z);
  lengthSq_24 = (tmpvar_25 * tmpvar_25);
  lengthSq_24 = (lengthSq_24 + (tmpvar_26 * tmpvar_26));
  lengthSq_24 = (lengthSq_24 + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_28;
  tmpvar_28 = max (lengthSq_24, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_24 = tmpvar_28;
  ndotl_23 = (tmpvar_25 * normal_21.x);
  ndotl_23 = (ndotl_23 + (tmpvar_26 * normal_21.y));
  ndotl_23 = (ndotl_23 + (tmpvar_27 * normal_21.z));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_23 * inversesqrt(tmpvar_28)));
  ndotl_23 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
    (tmpvar_28 * lightAttenSq_20)
  ))));
  col_22 = (lightColor0_16 * tmpvar_30.x);
  col_22 = (col_22 + (lightColor1_17 * tmpvar_30.y));
  col_22 = (col_22 + (lightColor2_18 * tmpvar_30.z));
  col_22 = (col_22 + (lightColor3_19 * tmpvar_30.w));
  tmpvar_4 = (tmpvar_4 + col_22);
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  tmpvar_3 = worldNormal_2;
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = worldNormal_2;
  mediump vec4 normal_10;
  normal_10 = tmpvar_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, normal_10);
  x_12.y = dot (unity_SHAg, normal_10);
  x_12.z = dot (unity_SHAb, normal_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_10.xyzz * normal_10.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  shlight_1 = tmpvar_15;
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
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
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_23);
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
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
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_23);
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
Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
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
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
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
  mediump vec3 tmpvar_16;
  tmpvar_16 = max (((1.055 * 
    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_12 = tmpvar_16;
  shlight_1 = tmpvar_16;
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
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_7.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_7.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_7.z);
  lengthSq_25 = (tmpvar_26 * tmpvar_26);
  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_29;
  tmpvar_29 = max (lengthSq_25, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_25 = tmpvar_29;
  ndotl_24 = (tmpvar_26 * normal_22.x);
  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
  highp vec4 tmpvar_30;
  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(tmpvar_29)));
  ndotl_24 = tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
    (tmpvar_29 * lightAttenSq_21)
  ))));
  col_23 = (lightColor0_17 * tmpvar_31.x);
  col_23 = (col_23 + (lightColor1_18 * tmpvar_31.y));
  col_23 = (col_23 + (lightColor2_19 * tmpvar_31.z));
  col_23 = (col_23 + (lightColor3_20 * tmpvar_31.w));
  tmpvar_4 = (tmpvar_4 + col_23);
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "ForwardAdd" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha One, SrcAlpha One
  ColorMask RGB 0
  ZClip Off
  ZWrite Off
  GpuProgramID 78654
Program "vp" {
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_glesNormal * tmpvar_4));
  worldNormal_1 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
SubProgram "gles hw_tier00 " {
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  worldNormal_1 = tmpvar_6;
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
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles " {
Keywords { "POINT" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles " {
Keywords { "SPOT" }
""
}
SubProgram "gles " {
Keywords { "SPOT" }
""
}
SubProgram "gles " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
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
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
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
SubProgram "gles " {
Keywords { "POINT" "FOG_LINEAR" }
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
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
SubProgram "gles " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "SPOT" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "AllowProjectors" = "False" "LIGHTMODE" = "Meta" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask RGB 0
  ZClip Off
  ZWrite Off
  Cull Off
  GpuProgramID 192513
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp vec4 rgbm_11;
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = (emission_9 * 0.01030928);
    rgbm_11.xyz = tmpvar_12.xyz;
    rgbm_11.w = max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02));
    rgbm_11.w = (ceil((rgbm_11.w * 255.0)) / 255.0);
    rgbm_11.w = max (rgbm_11.w, 0.02);
    rgbm_11.xyz = (tmpvar_12.xyz / rgbm_11.w);
    tmpvar_10 = rgbm_11;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp vec4 rgbm_11;
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = (emission_9 * 0.01030928);
    rgbm_11.xyz = tmpvar_12.xyz;
    rgbm_11.w = max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02));
    rgbm_11.w = (ceil((rgbm_11.w * 255.0)) / 255.0);
    rgbm_11.w = max (rgbm_11.w, 0.02);
    rgbm_11.xyz = (tmpvar_12.xyz / rgbm_11.w);
    tmpvar_10 = rgbm_11;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 vertex_1;
  vertex_1 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_2;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_2 = 0.0001;
    } else {
      tmpvar_2 = 0.0;
    };
    vertex_1.z = tmpvar_2;
  };
  if (unity_MetaVertexControl.y) {
    vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_3;
    if ((vertex_1.z > 0.0)) {
      tmpvar_3 = 0.0001;
    } else {
      tmpvar_3 = 0.0;
    };
    vertex_1.z = tmpvar_3;
  };
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = vertex_1.xyz;
  gl_Position = (glstate_matrix_mvp * tmpvar_4);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _Color;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_4 = tmpvar_5;
  tmpvar_3 = (_Color.xyz * c_4.xyz);
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_6;
  res_6 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = tmpvar_2;
    res_6.w = tmpvar_7.w;
    highp vec3 tmpvar_8;
    tmpvar_8 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_6.xyz = tmpvar_8;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_9;
    if (bool(unity_UseLinearSpace)) {
      emission_9 = vec3(0.0, 0.0, 0.0);
    } else {
      emission_9 = vec3(0.0, 0.0, 0.0);
    };
    mediump vec4 tmpvar_10;
    highp vec4 rgbm_11;
    highp vec4 tmpvar_12;
    tmpvar_12.w = 1.0;
    tmpvar_12.xyz = (emission_9 * 0.01030928);
    rgbm_11.xyz = tmpvar_12.xyz;
    rgbm_11.w = max (max (tmpvar_12.x, tmpvar_12.y), max (tmpvar_12.z, 0.02));
    rgbm_11.w = (ceil((rgbm_11.w * 255.0)) / 255.0);
    rgbm_11.w = max (rgbm_11.w, 0.02);
    rgbm_11.xyz = (tmpvar_12.xyz / rgbm_11.w);
    tmpvar_10 = rgbm_11;
    res_6 = tmpvar_10;
  };
  tmpvar_1 = res_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
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
}
Fallback "Diffuse"
}