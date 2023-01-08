//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/Basic" {
Properties {
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
 _Ramp2D ("BRDF Ramp", 2D) = "grey" { }
 _Amount_Blend ("BRDF Amount", Range(0.000000,2.000000)) = 1.000000
 _Amount_Wrap ("Lambert Wrap Amount", Range(0.000000,1.000000)) = 0.000000
 _cTint ("Tint", Color) = (0.000000,0.000000,0.000000,0.500000)
 _cDiff ("Diffuse", Color) = (1.000000,1.000000,1.000000,0.500000)
 _cAmbn ("Ambient", Color) = (0.000000,0.000000,0.000000,0.500000)
 _cKeyf ("Specular (.a=0.5)", Color) = (1.000000,1.000000,1.000000,0.500000)
 _cRimt ("RimTop   (.a=0.5)", Color) = (1.000000,1.000000,0.000000,0.500000)
 _cRimb ("RimBottom(.a=0.5)", Color) = (0.000000,0.000000,1.000000,0.500000)
 _Amount_RimLt ("RimLight Mult", Range(0.000000,2.000000)) = 1.000000
 _vAmOc ("vAmbOcclusion", Color) = (0.000000,0.000000,0.000000,1.000000)
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)]  _Stencil ("Stencil ID", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _StencilComp ("Stencil Compare Function", Float) = 0.000000
[Enum(UnityEngine.Rendering.StencilOp)]  _StencilOp ("Stencil Operation", Float) = 0.000000
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  GpuProgramID 35883
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_20;
  normal_20 = worldNormal_1;
  mediump vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = normal_20;
  mediump vec3 res_22;
  mediump vec3 x_23;
  x_23.x = dot (unity_SHAr, tmpvar_21);
  x_23.y = dot (unity_SHAg, tmpvar_21);
  x_23.z = dot (unity_SHAb, tmpvar_21);
  mediump vec3 x1_24;
  mediump vec4 tmpvar_25;
  tmpvar_25 = (normal_20.xyzz * normal_20.yzzx);
  x1_24.x = dot (unity_SHBr, tmpvar_25);
  x1_24.y = dot (unity_SHBg, tmpvar_25);
  x1_24.z = dot (unity_SHBb, tmpvar_25);
  res_22 = (x_23 + (x1_24 + (unity_SHC.xyz * 
    ((normal_20.x * normal_20.x) - (normal_20.y * normal_20.y))
  )));
  res_22 = max (((1.055 * 
    pow (max (res_22, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_22);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_18 = tmpvar_19;
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
  c_3.xyz = (c_17.xyz + tmpvar_9);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_21;
  lightColor0_21 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_22;
  lightColor1_22 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_23;
  lightColor2_23 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_24;
  lightColor3_24 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_25;
  lightAttenSq_25 = unity_4LightAtten0;
  highp vec3 normal_26;
  normal_26 = worldNormal_1;
  highp vec3 col_27;
  highp vec4 ndotl_28;
  highp vec4 lengthSq_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_29 = (tmpvar_30 * tmpvar_30);
  lengthSq_29 = (lengthSq_29 + (tmpvar_31 * tmpvar_31));
  lengthSq_29 = (lengthSq_29 + (tmpvar_32 * tmpvar_32));
  ndotl_28 = (tmpvar_30 * normal_26.x);
  ndotl_28 = (ndotl_28 + (tmpvar_31 * normal_26.y));
  ndotl_28 = (ndotl_28 + (tmpvar_32 * normal_26.z));
  highp vec4 tmpvar_33;
  tmpvar_33 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_28 * inversesqrt(lengthSq_29)));
  ndotl_28 = tmpvar_33;
  highp vec4 tmpvar_34;
  tmpvar_34 = (tmpvar_33 * (1.0/((1.0 + 
    (lengthSq_29 * lightAttenSq_25)
  ))));
  col_27 = (lightColor0_21 * tmpvar_34.x);
  col_27 = (col_27 + (lightColor1_22 * tmpvar_34.y));
  col_27 = (col_27 + (lightColor2_23 * tmpvar_34.z));
  col_27 = (col_27 + (lightColor3_24 * tmpvar_34.w));
  tmpvar_5 = col_27;
  mediump vec3 normal_35;
  normal_35 = worldNormal_1;
  mediump vec3 ambient_36;
  mediump vec4 tmpvar_37;
  tmpvar_37.w = 1.0;
  tmpvar_37.xyz = normal_35;
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, tmpvar_37);
  x_39.y = dot (unity_SHAg, tmpvar_37);
  x_39.z = dot (unity_SHAb, tmpvar_37);
  mediump vec3 x1_40;
  mediump vec4 tmpvar_41;
  tmpvar_41 = (normal_35.xyzz * normal_35.yzzx);
  x1_40.x = dot (unity_SHBr, tmpvar_41);
  x1_40.y = dot (unity_SHBg, tmpvar_41);
  x1_40.z = dot (unity_SHBb, tmpvar_41);
  res_38 = (x_39 + (x1_40 + (unity_SHC.xyz * 
    ((normal_35.x * normal_35.x) - (normal_35.y * normal_35.y))
  )));
  res_38 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_36 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_38));
  tmpvar_5 = ambient_36;
  gl_Position = (glstate_matrix_mvp * tmpvar_16);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_36;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp float diff_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_24 = tmpvar_25;
  c_23.xyz = ((tmpvar_9 * tmpvar_22) * diff_24);
  c_23.w = 0.0;
  c_4.xyz = (c_23.xyz + tmpvar_10);
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((tmpvar_13 * 0.5) + 0.5) * 0.9);
  tmpvar_5.x = ((tmpvar_13 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_5.y = 1.0;
  tmpvar_4.xy = tmpvar_14;
  tmpvar_4.zw = tmpvar_5;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_3 = worldNormal_1;
  mediump vec3 normal_21;
  normal_21 = worldNormal_1;
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = normal_21;
  mediump vec3 res_23;
  mediump vec3 x_24;
  x_24.x = dot (unity_SHAr, tmpvar_22);
  x_24.y = dot (unity_SHAg, tmpvar_22);
  x_24.z = dot (unity_SHAb, tmpvar_22);
  mediump vec3 x1_25;
  mediump vec4 tmpvar_26;
  tmpvar_26 = (normal_21.xyzz * normal_21.yzzx);
  x1_25.x = dot (unity_SHBr, tmpvar_26);
  x1_25.y = dot (unity_SHBg, tmpvar_26);
  x1_25.z = dot (unity_SHBb, tmpvar_26);
  res_23 = (x_24 + (x1_25 + (unity_SHC.xyz * 
    ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
  )));
  res_23 = max (((1.055 * 
    pow (max (res_23, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_10.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_6;
  xlv_TEXCOORD5 = max (vec3(0.0, 0.0, 0.0), res_23);
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_10);
  xlv_TEXCOORD7 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec4 tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_7;
  tmpvar_6 = xlv_COLOR0;
  tmpvar_4 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_8;
  lowp vec3 tmpvar_9;
  mediump vec4 brdf_10;
  mediump vec4 tex_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_11 = tmpvar_12;
  tmpvar_8 = _cTint.xyz;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_10 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((_cKeyf.xyz * brdf_10.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cRimt.xyz * brdf_10.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = clamp (((
    ((_cDiff.xyz * brdf_10.y) + (_cAmbn.xyz * (1.0 - brdf_10.y)))
   * 
    (tmpvar_6.www + (_vAmOc.xyz * (1.0 - tmpvar_6.w)))
  ) + (
    (_cRimb.xyz * brdf_10.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_9 = (((tex_11.xyz * 
    (tmpvar_16 + ((tmpvar_14 + tmpvar_15) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_8 * tmpvar_1) * diff_19);
  c_18.w = 0.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.w = c_17.w;
  c_3.xyz = (c_18.xyz + tmpvar_9);
  highp float tmpvar_21;
  tmpvar_21 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_3.xyz = mix (unity_FogColor.xyz, c_3.xyz, vec3(tmpvar_21));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
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
uniform mediump float _Amount_Wrap;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec3 vNormal_8;
  mediump vec3 viewDir_9;
  highp vec3 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_11.xyz));
  viewDir_9 = tmpvar_10;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = _glesNormal;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((unity_ObjectToWorld * tmpvar_12).xyz);
  vNormal_8 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = dot (vNormal_8, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_15;
  tmpvar_15.x = clamp (dot (vNormal_8, viewDir_9), 0.0, 1.0);
  tmpvar_15.y = (((tmpvar_14 * 0.5) + 0.5) * 0.9);
  tmpvar_6.x = ((tmpvar_14 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_6.y = 1.0;
  tmpvar_4.xy = tmpvar_15;
  tmpvar_4.zw = tmpvar_6;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_16 = (glstate_matrix_mvp * tmpvar_17);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].x;
  v_18.y = unity_WorldToObject[1].x;
  v_18.z = unity_WorldToObject[2].x;
  v_18.w = unity_WorldToObject[3].x;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].y;
  v_19.y = unity_WorldToObject[1].y;
  v_19.z = unity_WorldToObject[2].y;
  v_19.w = unity_WorldToObject[3].y;
  highp vec4 v_20;
  v_20.x = unity_WorldToObject[0].z;
  v_20.y = unity_WorldToObject[1].z;
  v_20.z = unity_WorldToObject[2].z;
  v_20.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(((
    (v_18.xyz * _glesNormal.x)
   + 
    (v_19.xyz * _glesNormal.y)
  ) + (v_20.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  highp vec3 lightColor0_22;
  lightColor0_22 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_23;
  lightColor1_23 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_24;
  lightColor2_24 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_25;
  lightColor3_25 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_26;
  lightAttenSq_26 = unity_4LightAtten0;
  highp vec3 normal_27;
  normal_27 = worldNormal_1;
  highp vec3 col_28;
  highp vec4 ndotl_29;
  highp vec4 lengthSq_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_4LightPosX0 - tmpvar_11.x);
  highp vec4 tmpvar_32;
  tmpvar_32 = (unity_4LightPosY0 - tmpvar_11.y);
  highp vec4 tmpvar_33;
  tmpvar_33 = (unity_4LightPosZ0 - tmpvar_11.z);
  lengthSq_30 = (tmpvar_31 * tmpvar_31);
  lengthSq_30 = (lengthSq_30 + (tmpvar_32 * tmpvar_32));
  lengthSq_30 = (lengthSq_30 + (tmpvar_33 * tmpvar_33));
  ndotl_29 = (tmpvar_31 * normal_27.x);
  ndotl_29 = (ndotl_29 + (tmpvar_32 * normal_27.y));
  ndotl_29 = (ndotl_29 + (tmpvar_33 * normal_27.z));
  highp vec4 tmpvar_34;
  tmpvar_34 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_29 * inversesqrt(lengthSq_30)));
  ndotl_29 = tmpvar_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (tmpvar_34 * (1.0/((1.0 + 
    (lengthSq_30 * lightAttenSq_26)
  ))));
  col_28 = (lightColor0_22 * tmpvar_35.x);
  col_28 = (col_28 + (lightColor1_23 * tmpvar_35.y));
  col_28 = (col_28 + (lightColor2_24 * tmpvar_35.z));
  col_28 = (col_28 + (lightColor3_25 * tmpvar_35.w));
  tmpvar_5 = col_28;
  mediump vec3 normal_36;
  normal_36 = worldNormal_1;
  mediump vec3 ambient_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = normal_36;
  mediump vec3 res_39;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_38);
  x_40.y = dot (unity_SHAg, tmpvar_38);
  x_40.z = dot (unity_SHAb, tmpvar_38);
  mediump vec3 x1_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = (normal_36.xyzz * normal_36.yzzx);
  x1_41.x = dot (unity_SHBr, tmpvar_42);
  x1_41.y = dot (unity_SHBg, tmpvar_42);
  x1_41.z = dot (unity_SHBb, tmpvar_42);
  res_39 = (x_40 + (x1_41 + (unity_SHC.xyz * 
    ((normal_36.x * normal_36.x) - (normal_36.y * normal_36.y))
  )));
  res_39 = max (((1.055 * 
    pow (max (res_39, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  ambient_37 = (tmpvar_5 + max (vec3(0.0, 0.0, 0.0), res_39));
  tmpvar_5 = ambient_37;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_11.xyz;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = ambient_37;
  xlv_TEXCOORD6 = (unity_WorldToShadow[0] * tmpvar_11);
  xlv_TEXCOORD7 = ((tmpvar_16.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _LightShadowData;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cTint;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
varying highp float xlv_TEXCOORD7;
void main ()
{
  mediump float tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  lowp vec4 c_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_8;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_5 = xlv_TEXCOORD1;
  lowp vec3 tmpvar_9;
  lowp vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_12 = tmpvar_13;
  tmpvar_9 = _cTint.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_11 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = clamp (((
    ((_cDiff.xyz * brdf_11.y) + (_cAmbn.xyz * (1.0 - brdf_11.y)))
   * 
    (tmpvar_7.www + (_vAmOc.xyz * (1.0 - tmpvar_7.w)))
  ) + (
    (_cRimb.xyz * brdf_11.w)
   * 
    (_cRimb.w * 2.0)
  )), 0.0, 1.0);
  tmpvar_10 = (((tex_12.xyz * 
    (tmpvar_17 + ((tmpvar_15 + tmpvar_16) * _Amount_RimLt))
  ) * _Amount_Blend) * xlv_TEXCOORD3.z);
  lowp float tmpvar_18;
  highp float lightShadowDataX_19;
  mediump float tmpvar_20;
  tmpvar_20 = _LightShadowData.x;
  lightShadowDataX_19 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD6.xy).x > xlv_TEXCOORD6.z)), lightShadowDataX_19);
  tmpvar_18 = tmpvar_21;
  tmpvar_2 = _LightColor0.xyz;
  tmpvar_3 = lightDir_6;
  tmpvar_1 = tmpvar_18;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_2 * tmpvar_1);
  tmpvar_2 = tmpvar_22;
  lowp vec4 c_23;
  lowp vec4 c_24;
  lowp float diff_25;
  mediump float tmpvar_26;
  tmpvar_26 = max (0.0, dot (tmpvar_5, tmpvar_3));
  diff_25 = tmpvar_26;
  c_24.xyz = ((tmpvar_9 * tmpvar_22) * diff_25);
  c_24.w = 0.0;
  c_23.w = c_24.w;
  c_23.xyz = c_24.xyz;
  c_4.w = c_23.w;
  c_4.xyz = (c_24.xyz + tmpvar_10);
  highp float tmpvar_27;
  tmpvar_27 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_27));
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
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend One One
  GpuProgramID 106027
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_17.xyz = ((tmpvar_8 * tmpvar_1) * diff_18);
  c_17.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_13.xyz = ((tmpvar_7 * tmpvar_1) * diff_14);
  c_13.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesVertex.xyz;
  highp vec4 v_15;
  v_15.x = unity_WorldToObject[0].x;
  v_15.y = unity_WorldToObject[1].x;
  v_15.z = unity_WorldToObject[2].x;
  v_15.w = unity_WorldToObject[3].x;
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].y;
  v_16.y = unity_WorldToObject[1].y;
  v_16.z = unity_WorldToObject[2].y;
  v_16.w = unity_WorldToObject[3].y;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].z;
  v_17.y = unity_WorldToObject[1].z;
  v_17.z = unity_WorldToObject[2].z;
  v_17.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((
    (v_15.xyz * _glesNormal.x)
   + 
    (v_16.xyz * _glesNormal.y)
  ) + (v_17.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_18;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
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
  tmpvar_7 = _cTint.xyz;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_8;
  lowp float diff_9;
  mediump float tmpvar_10;
  tmpvar_10 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_9 = tmpvar_10;
  c_8.xyz = ((tmpvar_7 * tmpvar_1) * diff_9);
  c_8.w = 0.0;
  highp float tmpvar_11;
  tmpvar_11 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = _cTint.xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = xlv_TEXCOORD1;
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
  c_16.xyz = ((tmpvar_8 * tmpvar_1) * diff_17);
  c_16.w = 0.0;
  highp float tmpvar_19;
  tmpvar_19 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump float NdotL_6;
  mediump vec3 vNormal_7;
  mediump vec3 viewDir_8;
  highp vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_10.xyz));
  viewDir_8 = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = _glesNormal;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((unity_ObjectToWorld * tmpvar_11).xyz);
  vNormal_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (vNormal_7, _WorldSpaceLightPos0.xyz);
  NdotL_6 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = clamp (dot (vNormal_7, viewDir_8), 0.0, 1.0);
  tmpvar_14.y = (((NdotL_6 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((NdotL_6 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_14;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_15 = (glstate_matrix_mvp * tmpvar_16);
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].x;
  v_17.y = unity_WorldToObject[1].x;
  v_17.z = unity_WorldToObject[2].x;
  v_17.w = unity_WorldToObject[3].x;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].y;
  v_18.y = unity_WorldToObject[1].y;
  v_18.z = unity_WorldToObject[2].y;
  v_18.w = unity_WorldToObject[3].y;
  highp vec4 v_19;
  v_19.x = unity_WorldToObject[0].z;
  v_19.y = unity_WorldToObject[1].z;
  v_19.z = unity_WorldToObject[2].z;
  v_19.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(((
    (v_17.xyz * _glesNormal.x)
   + 
    (v_18.xyz * _glesNormal.y)
  ) + (v_19.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_20;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_10.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_15.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_12.xyz = ((tmpvar_7 * tmpvar_1) * diff_13);
  c_12.w = 0.0;
  highp float tmpvar_15;
  tmpvar_15 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_7 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_7 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying highp float xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec3 vNormal_6;
  mediump vec3 viewDir_7;
  highp vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = normalize((_WorldSpaceCameraPos - tmpvar_9.xyz));
  viewDir_7 = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _glesNormal;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((unity_ObjectToWorld * tmpvar_10).xyz);
  vNormal_6 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = dot (vNormal_6, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_13;
  tmpvar_13.x = clamp (dot (vNormal_6, viewDir_7), 0.0, 1.0);
  tmpvar_13.y = (((tmpvar_12 * 0.5) + 0.5) * 0.9);
  tmpvar_4.x = ((tmpvar_12 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_4.y = 1.0;
  tmpvar_3.xy = tmpvar_13;
  tmpvar_3.zw = tmpvar_4;
  highp vec4 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  tmpvar_14 = (glstate_matrix_mvp * tmpvar_15);
  highp vec4 v_16;
  v_16.x = unity_WorldToObject[0].x;
  v_16.y = unity_WorldToObject[1].x;
  v_16.z = unity_WorldToObject[2].x;
  v_16.w = unity_WorldToObject[3].x;
  highp vec4 v_17;
  v_17.x = unity_WorldToObject[0].y;
  v_17.y = unity_WorldToObject[1].y;
  v_17.z = unity_WorldToObject[2].y;
  v_17.w = unity_WorldToObject[3].y;
  highp vec4 v_18;
  v_18.x = unity_WorldToObject[0].z;
  v_18.y = unity_WorldToObject[1].z;
  v_18.z = unity_WorldToObject[2].z;
  v_18.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(((
    (v_16.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_18.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_19;
  tmpvar_2 = worldNormal_1;
  gl_Position = tmpvar_14;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9.xyz;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD5 = ((tmpvar_14.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _cTint;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
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
  tmpvar_7 = _cTint.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = xlv_TEXCOORD1;
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
  c_11.xyz = ((tmpvar_7 * tmpvar_1) * diff_12);
  c_11.w = 0.0;
  highp float tmpvar_14;
  tmpvar_14 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
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
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  GpuProgramID 258947
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec3 vertex_14;
  vertex_14 = _glesVertex.xyz;
  highp vec4 clipPos_15;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_14;
    highp vec3 tmpvar_17;
    tmpvar_17 = (unity_ObjectToWorld * tmpvar_16).xyz;
    highp vec4 v_18;
    v_18.x = unity_WorldToObject[0].x;
    v_18.y = unity_WorldToObject[1].x;
    v_18.z = unity_WorldToObject[2].x;
    v_18.w = unity_WorldToObject[3].x;
    highp vec4 v_19;
    v_19.x = unity_WorldToObject[0].y;
    v_19.y = unity_WorldToObject[1].y;
    v_19.z = unity_WorldToObject[2].y;
    v_19.w = unity_WorldToObject[3].y;
    highp vec4 v_20;
    v_20.x = unity_WorldToObject[0].z;
    v_20.y = unity_WorldToObject[1].z;
    v_20.z = unity_WorldToObject[2].z;
    v_20.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize(((
      (v_18.xyz * _glesNormal.x)
     + 
      (v_19.xyz * _glesNormal.y)
    ) + (v_20.xyz * _glesNormal.z)));
    highp float tmpvar_22;
    tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_17 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = (tmpvar_17 - (tmpvar_21 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_22 * tmpvar_22)))
    )));
    clipPos_15 = (unity_MatrixVP * tmpvar_23);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = vertex_14;
    clipPos_15 = (glstate_matrix_mvp * tmpvar_24);
  };
  highp vec4 clipPos_25;
  clipPos_25.xyw = clipPos_15.xyw;
  clipPos_25.z = (clipPos_15.z + clamp ((unity_LightShadowBias.x / clipPos_15.w), 0.0, 1.0));
  clipPos_25.z = mix (clipPos_25.z, max (clipPos_25.z, -(clipPos_15.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_25;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
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
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec3 vertex_14;
  vertex_14 = _glesVertex.xyz;
  highp vec4 clipPos_15;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_14;
    highp vec3 tmpvar_17;
    tmpvar_17 = (unity_ObjectToWorld * tmpvar_16).xyz;
    highp vec4 v_18;
    v_18.x = unity_WorldToObject[0].x;
    v_18.y = unity_WorldToObject[1].x;
    v_18.z = unity_WorldToObject[2].x;
    v_18.w = unity_WorldToObject[3].x;
    highp vec4 v_19;
    v_19.x = unity_WorldToObject[0].y;
    v_19.y = unity_WorldToObject[1].y;
    v_19.z = unity_WorldToObject[2].y;
    v_19.w = unity_WorldToObject[3].y;
    highp vec4 v_20;
    v_20.x = unity_WorldToObject[0].z;
    v_20.y = unity_WorldToObject[1].z;
    v_20.z = unity_WorldToObject[2].z;
    v_20.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize(((
      (v_18.xyz * _glesNormal.x)
     + 
      (v_19.xyz * _glesNormal.y)
    ) + (v_20.xyz * _glesNormal.z)));
    highp float tmpvar_22;
    tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_17 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = (tmpvar_17 - (tmpvar_21 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_22 * tmpvar_22)))
    )));
    clipPos_15 = (unity_MatrixVP * tmpvar_23);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = vertex_14;
    clipPos_15 = (glstate_matrix_mvp * tmpvar_24);
  };
  highp vec4 clipPos_25;
  clipPos_25.xyw = clipPos_15.xyw;
  clipPos_25.z = (clipPos_15.z + clamp ((unity_LightShadowBias.x / clipPos_15.w), 0.0, 1.0));
  clipPos_25.z = mix (clipPos_25.z, max (clipPos_25.z, -(clipPos_15.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_25;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
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
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_8.xyz;
  highp vec3 vertex_14;
  vertex_14 = _glesVertex.xyz;
  highp vec4 clipPos_15;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_16;
    tmpvar_16.w = 1.0;
    tmpvar_16.xyz = vertex_14;
    highp vec3 tmpvar_17;
    tmpvar_17 = (unity_ObjectToWorld * tmpvar_16).xyz;
    highp vec4 v_18;
    v_18.x = unity_WorldToObject[0].x;
    v_18.y = unity_WorldToObject[1].x;
    v_18.z = unity_WorldToObject[2].x;
    v_18.w = unity_WorldToObject[3].x;
    highp vec4 v_19;
    v_19.x = unity_WorldToObject[0].y;
    v_19.y = unity_WorldToObject[1].y;
    v_19.z = unity_WorldToObject[2].y;
    v_19.w = unity_WorldToObject[3].y;
    highp vec4 v_20;
    v_20.x = unity_WorldToObject[0].z;
    v_20.y = unity_WorldToObject[1].z;
    v_20.z = unity_WorldToObject[2].z;
    v_20.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize(((
      (v_18.xyz * _glesNormal.x)
     + 
      (v_19.xyz * _glesNormal.y)
    ) + (v_20.xyz * _glesNormal.z)));
    highp float tmpvar_22;
    tmpvar_22 = dot (tmpvar_21, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_17 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_23;
    tmpvar_23.w = 1.0;
    tmpvar_23.xyz = (tmpvar_17 - (tmpvar_21 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_22 * tmpvar_22)))
    )));
    clipPos_15 = (unity_MatrixVP * tmpvar_23);
  } else {
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = vertex_14;
    clipPos_15 = (glstate_matrix_mvp * tmpvar_24);
  };
  highp vec4 clipPos_25;
  clipPos_25.xyw = clipPos_15.xyw;
  clipPos_25.z = (clipPos_15.z + clamp ((unity_LightShadowBias.x / clipPos_15.w), 0.0, 1.0));
  clipPos_25.z = mix (clipPos_25.z, max (clipPos_25.z, -(clipPos_15.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_25;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
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
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform mediump float _Amount_Wrap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  mediump float NdotL_4;
  mediump vec3 vNormal_5;
  mediump vec3 viewDir_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_7 = normalize((_WorldSpaceCameraPos - tmpvar_8.xyz));
  viewDir_6 = tmpvar_7;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((unity_ObjectToWorld * tmpvar_9).xyz);
  vNormal_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (vNormal_5, _WorldSpaceLightPos0.xyz);
  NdotL_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = clamp (dot (vNormal_5, viewDir_6), 0.0, 1.0);
  tmpvar_12.y = (((NdotL_4 * 0.5) + 0.5) * 0.9);
  tmpvar_2.x = ((NdotL_4 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_2.y = 1.0;
  tmpvar_1.xy = tmpvar_12;
  tmpvar_1.zw = tmpvar_2;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_8.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_13);
  xlv_TEXCOORD1 = tmpvar_8.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 enc_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_2 = (tmpvar_3 - (tmpvar_3.yzww * 0.003921569));
  tmpvar_1 = enc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
 }
}
Fallback "Mobile/Diffuse"
}