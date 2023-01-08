//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/BRDF/UBER : vtxMask, uvAnimations, EyeShader" {
Properties {
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
 _Ramp2D ("BRDF Ramp", 2D) = "grey" { }
[KeywordEnum(DIFF, VCOLOR_DEBUG)]  NIANTIC_MODE ("BRDF Normal or Debug", Float) = 0.000000
 _Amount_Blend ("BRDF Amount", Range(0.000000,2.000000)) = 1.000000
 _Amount_Wrap ("Lambert Wrap Amount", Range(0.000000,1.000000)) = 0.000000
 _cTint ("Tint", Color) = (0.000000,0.000000,0.000000,0.500000)
 _cDiff ("Diffuse", Color) = (1.000000,1.000000,1.000000,0.500000)
 _cAmbn ("Ambient", Color) = (0.000000,0.000000,0.000000,0.500000)
 _cKeyf ("Specular (.a=0.5)", Color) = (1.000000,1.000000,1.000000,0.500000)
 _cRimt ("RimTop   (.a=0.5)", Color) = (1.000000,1.000000,0.000000,0.500000)
 _cRimb ("RimBottom(.a=0.5)", Color) = (0.500000,0.500000,0.500000,0.500000)
 _Amount_RimLt ("RimLight Mult", Range(0.000000,2.000000)) = 1.000000
 _vAmOc ("vAmbOcclusion", Color) = (0.000000,0.000000,0.000000,1.000000)
[Space] [Header(SPECULAR_SHADER_ACTIVATE____________)] [Space] [KeywordEnum(NONE, VERTEX, PIXEL, EYE_DEBUG)]  BRB_SPECULAR ("Toggle for Specular", Float) = 0.000000
 _EyeSpec ("Specular", Range(0.000000,1.000000)) = 1.000000
 _EyeGloss ("Glossiness", Range(0.025000,100.000000)) = 0.950000
 _EyeIllum ("Eye Illum", Range(0.850000,2.000000)) = 1.000000
 _EyeTiles ("Tile Count 'U', 'V', 'U Scale', 'V Scale'", Vector) = (2.000000,4.000000,1.000000,1.000000)
 _Roundness ("Roundness UV 'Offset', 'UNUSED','Strength'", Vector) = (0.000000,0.000000,1.000000,1.000000)
 _EyeMirrorOffset ("Mirror U Offset (keep for now)", Range(0.000000,2.000000)) = 1.000000
[Space] [Header(UV_ANIMATION_SETTINGS_______________)] [Space] [Toggle(NIANTIC_UV_ANIMATE)]  _UVAnimated ("Activates UV Animation", Float) = 0.000000
 _uv0 ("uv animation 0 (green)", Vector) = (0.000000,0.000000,4.000000,0.000000)
 _uv1 ("uv animation 1 (red  )", Vector) = (0.000000,0.000000,4.000000,2.000000)
 _uv2 ("uv animation 2 (blue )", Vector) = (0.000000,0.000000,4.000000,2.000000)
[Space] [Header(ACIVATED_IGNORES_USE_VERTEXMASKS____)] [Space] [Space] [Header(USE_VERTEXMASKS_____________________)] [Space] [Header(COLOR____red_vRedd____green_vGren____blue_vBlue)] [Header(SP_AM_AO_red_specrim_green_ambient_blue_AO___)] [Space] [KeywordEnum(COLOR, SP_AM_AO)]  NIANTIC_VERTEX ("Allows vertex variance on shared material ", Float) = 0.000000
 _vGren ("vGreen Channel", Color) = (1.000000,1.000000,1.000000,0.500000)
 _vRedd ("vRed   Channel", Color) = (1.000000,1.000000,1.000000,0.500000)
 _vBlue ("vBlue  Channel", Color) = (1.000000,1.000000,1.000000,0.500000)
[Header(STENCIL_ID_TO_CONTROL_SORTING_SPECIAL_FX)]  _Stencil ("Stencil ID", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _StencilComp ("Stencil Compare Function", Float) = 0.000000
[Enum(UnityEngine.Rendering.StencilOp)]  _StencilOp ("Stencil Operation", Float) = 0.000000
}
SubShader { 
 Tags { "QUEUE"="Geometry+1" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry+1" "RenderType"="Opaque" }
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  GpuProgramID 21820
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_10 = (tmpvar_22 * tmpvar_23);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _glesVertex.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_2;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].x;
  v_26.y = unity_WorldToObject[1].x;
  v_26.z = unity_WorldToObject[2].x;
  v_26.w = unity_WorldToObject[3].x;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].y;
  v_27.y = unity_WorldToObject[1].y;
  v_27.z = unity_WorldToObject[2].y;
  v_27.w = unity_WorldToObject[3].y;
  highp vec4 v_28;
  v_28.x = unity_WorldToObject[0].z;
  v_28.y = unity_WorldToObject[1].z;
  v_28.z = unity_WorldToObject[2].z;
  v_28.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_26.xyz * norm_25.x)
   + 
    (v_27.xyz * norm_25.y)
  ) + (v_28.xyz * norm_25.z)));
  worldNormal_4 = tmpvar_29;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_10 = (tmpvar_22 * tmpvar_23);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _glesVertex.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_2;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].x;
  v_26.y = unity_WorldToObject[1].x;
  v_26.z = unity_WorldToObject[2].x;
  v_26.w = unity_WorldToObject[3].x;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].y;
  v_27.y = unity_WorldToObject[1].y;
  v_27.z = unity_WorldToObject[2].y;
  v_27.w = unity_WorldToObject[3].y;
  highp vec4 v_28;
  v_28.x = unity_WorldToObject[0].z;
  v_28.y = unity_WorldToObject[1].z;
  v_28.z = unity_WorldToObject[2].z;
  v_28.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_26.xyz * norm_25.x)
   + 
    (v_27.xyz * norm_25.y)
  ) + (v_28.xyz * norm_25.z)));
  worldNormal_4 = tmpvar_29;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  lowp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = unity_FogColor.xyz;
  envFogColor_10 = (tmpvar_22 * tmpvar_23);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _glesVertex.xyz;
  highp vec3 norm_25;
  norm_25 = tmpvar_2;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].x;
  v_26.y = unity_WorldToObject[1].x;
  v_26.z = unity_WorldToObject[2].x;
  v_26.w = unity_WorldToObject[3].x;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].y;
  v_27.y = unity_WorldToObject[1].y;
  v_27.z = unity_WorldToObject[2].y;
  v_27.w = unity_WorldToObject[3].y;
  highp vec4 v_28;
  v_28.x = unity_WorldToObject[0].z;
  v_28.y = unity_WorldToObject[1].z;
  v_28.z = unity_WorldToObject[2].z;
  v_28.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_26.xyz * norm_25.x)
   + 
    (v_27.xyz * norm_25.y)
  ) + (v_28.xyz * norm_25.z)));
  worldNormal_4 = tmpvar_29;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_24);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_28 * tmpvar_29);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * norm_32.x)
   + 
    (v_34.xyz * norm_32.y)
  ) + (v_35.xyz * norm_32.z)));
  worldNormal_7 = tmpvar_36;
  highp mat3 tmpvar_37;
  tmpvar_37[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_37[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_37[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize((tmpvar_37 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_39;
  lowp vec3 tmpvar_40;
  tmpvar_40 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.x;
  tmpvar_41.y = tmpvar_40.x;
  tmpvar_41.z = worldNormal_7.x;
  tmpvar_41.w = tmpvar_31.x;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.y;
  tmpvar_42.y = tmpvar_40.y;
  tmpvar_42.z = worldNormal_7.y;
  tmpvar_42.w = tmpvar_31.y;
  highp vec4 tmpvar_43;
  tmpvar_43.x = worldTangent_6.z;
  tmpvar_43.y = tmpvar_40.z;
  tmpvar_43.z = worldNormal_7.z;
  tmpvar_43.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_41;
  xlv_TEXCOORD1 = tmpvar_42;
  xlv_TEXCOORD2 = tmpvar_43;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_28 * tmpvar_29);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * norm_32.x)
   + 
    (v_34.xyz * norm_32.y)
  ) + (v_35.xyz * norm_32.z)));
  worldNormal_7 = tmpvar_36;
  highp mat3 tmpvar_37;
  tmpvar_37[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_37[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_37[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize((tmpvar_37 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_39;
  lowp vec3 tmpvar_40;
  tmpvar_40 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.x;
  tmpvar_41.y = tmpvar_40.x;
  tmpvar_41.z = worldNormal_7.x;
  tmpvar_41.w = tmpvar_31.x;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.y;
  tmpvar_42.y = tmpvar_40.y;
  tmpvar_42.z = worldNormal_7.y;
  tmpvar_42.w = tmpvar_31.y;
  highp vec4 tmpvar_43;
  tmpvar_43.x = worldTangent_6.z;
  tmpvar_43.y = tmpvar_40.z;
  tmpvar_43.z = worldNormal_7.z;
  tmpvar_43.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_41;
  xlv_TEXCOORD1 = tmpvar_42;
  xlv_TEXCOORD2 = tmpvar_43;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = unity_FogColor.xyz;
  envFogColor_12 = (tmpvar_28 * tmpvar_29);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_32;
  norm_32 = tmpvar_3;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].x;
  v_33.y = unity_WorldToObject[1].x;
  v_33.z = unity_WorldToObject[2].x;
  v_33.w = unity_WorldToObject[3].x;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].y;
  v_34.y = unity_WorldToObject[1].y;
  v_34.z = unity_WorldToObject[2].y;
  v_34.w = unity_WorldToObject[3].y;
  highp vec4 v_35;
  v_35.x = unity_WorldToObject[0].z;
  v_35.y = unity_WorldToObject[1].z;
  v_35.z = unity_WorldToObject[2].z;
  v_35.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize(((
    (v_33.xyz * norm_32.x)
   + 
    (v_34.xyz * norm_32.y)
  ) + (v_35.xyz * norm_32.z)));
  worldNormal_7 = tmpvar_36;
  highp mat3 tmpvar_37;
  tmpvar_37[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_37[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_37[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize((tmpvar_37 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_39;
  lowp vec3 tmpvar_40;
  tmpvar_40 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.x;
  tmpvar_41.y = tmpvar_40.x;
  tmpvar_41.z = worldNormal_7.x;
  tmpvar_41.w = tmpvar_31.x;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.y;
  tmpvar_42.y = tmpvar_40.y;
  tmpvar_42.z = worldNormal_7.y;
  tmpvar_42.w = tmpvar_31.y;
  highp vec4 tmpvar_43;
  tmpvar_43.x = worldTangent_6.z;
  tmpvar_43.y = tmpvar_40.z;
  tmpvar_43.z = worldNormal_7.z;
  tmpvar_43.w = tmpvar_31.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = tmpvar_41;
  xlv_TEXCOORD1 = tmpvar_42;
  xlv_TEXCOORD2 = tmpvar_43;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_10 = (tmpvar_22 * _CharacterColor);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_2;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].x;
  v_25.y = unity_WorldToObject[1].x;
  v_25.z = unity_WorldToObject[2].x;
  v_25.w = unity_WorldToObject[3].x;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].y;
  v_26.y = unity_WorldToObject[1].y;
  v_26.z = unity_WorldToObject[2].y;
  v_26.w = unity_WorldToObject[3].y;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].z;
  v_27.y = unity_WorldToObject[1].z;
  v_27.z = unity_WorldToObject[2].z;
  v_27.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(((
    (v_25.xyz * norm_24.x)
   + 
    (v_26.xyz * norm_24.y)
  ) + (v_27.xyz * norm_24.z)));
  worldNormal_4 = tmpvar_28;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_10 = (tmpvar_22 * _CharacterColor);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_2;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].x;
  v_25.y = unity_WorldToObject[1].x;
  v_25.z = unity_WorldToObject[2].x;
  v_25.w = unity_WorldToObject[3].x;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].y;
  v_26.y = unity_WorldToObject[1].y;
  v_26.z = unity_WorldToObject[2].y;
  v_26.w = unity_WorldToObject[3].y;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].z;
  v_27.y = unity_WorldToObject[1].z;
  v_27.z = unity_WorldToObject[2].z;
  v_27.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(((
    (v_25.xyz * norm_24.x)
   + 
    (v_26.xyz * norm_24.y)
  ) + (v_27.xyz * norm_24.z)));
  worldNormal_4 = tmpvar_28;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  lowp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  lowp vec3 worldNormal_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec4 envFogColor_10;
  mediump vec4 tcXFORM_11;
  mediump vec3 vNormal_12;
  mediump vec3 viewDir_13;
  highp vec3 tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_15.xyz));
  viewDir_13 = tmpvar_14;
  lowp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = tmpvar_2;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((unity_ObjectToWorld * tmpvar_16).xyz);
  vNormal_12 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (dot (vNormal_12, viewDir_13), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = dot (vNormal_12, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_18;
  tmpvar_20.y = (((tmpvar_19 * 0.5) + 0.5) * 0.95);
  tmpvar_7.xy = tmpvar_20;
  tmpvar_7.z = ((tmpvar_19 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_7.w = (1.0 - tmpvar_18);
  tcXFORM_11 = tmpvar_1;
  tmpvar_8.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_8.w = tmpvar_3.w;
  highp float tmpvar_21;
  tmpvar_21 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_22;
  tmpvar_22.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_22.w = exp2((-(tmpvar_21) * tmpvar_21));
  envFogColor_10 = (tmpvar_22 * _CharacterColor);
  tmpvar_9 = envFogColor_10;
  tmpvar_6 = tmpvar_9;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  highp vec3 norm_24;
  norm_24 = tmpvar_2;
  highp vec4 v_25;
  v_25.x = unity_WorldToObject[0].x;
  v_25.y = unity_WorldToObject[1].x;
  v_25.z = unity_WorldToObject[2].x;
  v_25.w = unity_WorldToObject[3].x;
  highp vec4 v_26;
  v_26.x = unity_WorldToObject[0].y;
  v_26.y = unity_WorldToObject[1].y;
  v_26.z = unity_WorldToObject[2].y;
  v_26.w = unity_WorldToObject[3].y;
  highp vec4 v_27;
  v_27.x = unity_WorldToObject[0].z;
  v_27.y = unity_WorldToObject[1].z;
  v_27.z = unity_WorldToObject[2].z;
  v_27.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(((
    (v_25.xyz * norm_24.x)
   + 
    (v_26.xyz * norm_24.y)
  ) + (v_27.xyz * norm_24.z)));
  worldNormal_4 = tmpvar_28;
  tmpvar_5 = worldNormal_4;
  gl_Position = (glstate_matrix_mvp * tmpvar_23);
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_15.xyz;
  xlv_TEXCOORD2 = tcXFORM_11;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_TEXCOORD5 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD5;
  mediump vec3 tmpvar_3;
  mediump vec4 brdf_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD2.xy);
  tex_5 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Ramp2D, xlv_TEXCOORD3.xy);
  brdf_4 = tmpvar_7;
  tmpvar_3 = (((
    (tex_5.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_4.yyy) * xlv_TEXCOORD4.xyz)
     + 
      ((_cRimb.xyz * brdf_4.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_4.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_4.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD3.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD4.wwww).xyz);
  mediump vec4 specular_8;
  specular_8.w = 0.0;
  specular_8.xyz = vec3(0.0, 0.0, 0.0);
  c_1 = specular_8;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  lowp vec4 color_9;
  color_9.w = c_1.w;
  color_9.xyz = mix (tmpvar_2.xyz, c_1.xyz, tmpvar_2.www);
  c_1.xyz = color_9.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  envFogColor_12 = (tmpvar_28 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_31;
  norm_31 = tmpvar_3;
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * norm_31.x)
   + 
    (v_33.xyz * norm_31.y)
  ) + (v_34.xyz * norm_31.z)));
  worldNormal_7 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_6.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_7.x;
  tmpvar_40.w = tmpvar_30.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_7.y;
  tmpvar_41.w = tmpvar_30.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_7.z;
  tmpvar_42.w = tmpvar_30.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  envFogColor_12 = (tmpvar_28 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_31;
  norm_31 = tmpvar_3;
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * norm_31.x)
   + 
    (v_33.xyz * norm_31.y)
  ) + (v_34.xyz * norm_31.z)));
  worldNormal_7 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_6.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_7.x;
  tmpvar_40.w = tmpvar_30.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_7.y;
  tmpvar_41.w = tmpvar_30.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_7.z;
  tmpvar_42.w = tmpvar_30.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp vec4 unity_FogParams;
uniform mediump float _Amount_Wrap;
uniform mediump vec4 _vGren;
uniform mediump vec4 _vRedd;
uniform mediump vec4 _vBlue;
uniform mediump vec4 _CharacterColor;
uniform mediump float _EyeMirrorOffset;
uniform mediump vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  lowp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  lowp vec4 tmpvar_4;
  tmpvar_4 = _glesColor;
  lowp float tangentSign_5;
  lowp vec3 worldTangent_6;
  lowp vec3 worldNormal_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  mediump vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec4 envFogColor_12;
  mediump float mirror_13;
  mediump vec4 tcXFORM_14;
  mediump vec3 vNormal_15;
  mediump vec3 viewDir_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  viewDir_16 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 0.0;
  tmpvar_18.xyz = tmpvar_3;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((unity_ObjectToWorld * tmpvar_18).xyz);
  vNormal_15 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (dot (vNormal_15, viewDir_16), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = dot (vNormal_15, _WorldSpaceLightPos0.xyz);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_20;
  tmpvar_22.y = (((tmpvar_21 * 0.5) + 0.5) * 0.95);
  tmpvar_9.xy = tmpvar_22;
  tmpvar_9.z = ((tmpvar_21 * _Amount_Wrap) + (1.0 - _Amount_Wrap));
  tmpvar_9.w = (1.0 - tmpvar_20);
  tcXFORM_14 = tmpvar_2;
  highp float tmpvar_23;
  tmpvar_23 = (_glesMultiTexCoord0.x - _EyeMirrorOffset);
  mirror_13 = tmpvar_23;
  highp int tmpvar_24;
  if ((mirror_13 > 0.0)) {
    tmpvar_24 = -1;
  } else {
    tmpvar_24 = 1;
  };
  highp int tmpvar_25;
  if (((_glesTANGENT.x < 0.0) && (mirror_13 < 0.0))) {
    tmpvar_25 = -1;
  } else {
    tmpvar_25 = 1;
  };
  highp vec4 tmpvar_26;
  tmpvar_26.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_26.z = float(tmpvar_24);
  tmpvar_26.w = float(tmpvar_25);
  tcXFORM_14 = tmpvar_26;
  tmpvar_10.xyz = ((mix (vec3(1.0, 1.0, 1.0), _vGren.xyz, _glesColor.yyy) * mix (vec3(1.0, 1.0, 1.0), _vRedd.xyz, _glesColor.xxx)) * mix (vec3(1.0, 1.0, 1.0), _vBlue.xyz, _glesColor.zzz));
  tmpvar_10.w = tmpvar_4.w;
  highp float tmpvar_27;
  tmpvar_27 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_28;
  tmpvar_28.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_28.w = exp2((-(tmpvar_27) * tmpvar_27));
  envFogColor_12 = (tmpvar_28 * _CharacterColor);
  tmpvar_11 = envFogColor_12;
  tmpvar_8 = tmpvar_11;
  highp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec3 norm_31;
  norm_31 = tmpvar_3;
  highp vec4 v_32;
  v_32.x = unity_WorldToObject[0].x;
  v_32.y = unity_WorldToObject[1].x;
  v_32.z = unity_WorldToObject[2].x;
  v_32.w = unity_WorldToObject[3].x;
  highp vec4 v_33;
  v_33.x = unity_WorldToObject[0].y;
  v_33.y = unity_WorldToObject[1].y;
  v_33.z = unity_WorldToObject[2].y;
  v_33.w = unity_WorldToObject[3].y;
  highp vec4 v_34;
  v_34.x = unity_WorldToObject[0].z;
  v_34.y = unity_WorldToObject[1].z;
  v_34.z = unity_WorldToObject[2].z;
  v_34.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * norm_31.x)
   + 
    (v_33.xyz * norm_31.y)
  ) + (v_34.xyz * norm_31.z)));
  worldNormal_7 = tmpvar_35;
  highp mat3 tmpvar_36;
  tmpvar_36[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_36[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_36[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize((tmpvar_36 * _glesTANGENT.xyz));
  worldTangent_6 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_5 = tmpvar_38;
  lowp vec3 tmpvar_39;
  tmpvar_39 = (((worldNormal_7.yzx * worldTangent_6.zxy) - (worldNormal_7.zxy * worldTangent_6.yzx)) * tangentSign_5);
  highp vec4 tmpvar_40;
  tmpvar_40.x = worldTangent_6.x;
  tmpvar_40.y = tmpvar_39.x;
  tmpvar_40.z = worldNormal_7.x;
  tmpvar_40.w = tmpvar_30.x;
  highp vec4 tmpvar_41;
  tmpvar_41.x = worldTangent_6.y;
  tmpvar_41.y = tmpvar_39.y;
  tmpvar_41.z = worldNormal_7.y;
  tmpvar_41.w = tmpvar_30.y;
  highp vec4 tmpvar_42;
  tmpvar_42.x = worldTangent_6.z;
  tmpvar_42.y = tmpvar_39.z;
  tmpvar_42.z = worldNormal_7.z;
  tmpvar_42.w = tmpvar_30.z;
  gl_Position = (glstate_matrix_mvp * tmpvar_29);
  xlv_TEXCOORD0 = tmpvar_40;
  xlv_TEXCOORD1 = tmpvar_41;
  xlv_TEXCOORD2 = tmpvar_42;
  xlv_TEXCOORD3 = tcXFORM_14;
  xlv_TEXCOORD4 = tmpvar_9;
  xlv_TEXCOORD5 = tmpvar_10;
  xlv_TEXCOORD6 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp2D;
uniform mediump float _Amount_Blend;
uniform mediump float _Amount_RimLt;
uniform mediump vec4 _cDiff;
uniform mediump vec4 _cAmbn;
uniform mediump vec4 _cKeyf;
uniform mediump vec4 _cRimt;
uniform mediump vec4 _cRimb;
uniform mediump vec4 _vAmOc;
uniform mediump float _EyeSpec;
uniform mediump float _EyeGloss;
uniform mediump float _EyeIllum;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD3;
varying mediump vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_TEXCOORD5;
varying mediump vec4 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldN_1;
  lowp vec4 c_2;
  mediump vec3 tmpvar_3;
  lowp vec3 worldViewDir_4;
  lowp vec3 lightDir_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD6;
  highp vec3 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.w;
  tmpvar_7.y = xlv_TEXCOORD1.w;
  tmpvar_7.z = xlv_TEXCOORD2.w;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - tmpvar_7));
  worldViewDir_4 = tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec4 brdf_11;
  mediump vec4 tex_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD3.xy);
  tex_12 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_Ramp2D, xlv_TEXCOORD4.xy);
  brdf_11 = tmpvar_14;
  tmpvar_10 = (((
    (tex_12.xyz * (clamp ((
      (mix (_cAmbn.xyz, _cDiff.xyz, brdf_11.yyy) * xlv_TEXCOORD5.xyz)
     + 
      ((_cRimb.xyz * brdf_11.w) * (_cRimb.w * 2.0))
    ), 0.0, 1.0) + ((
      ((_cKeyf.xyz * brdf_11.z) * (_cKeyf.w * 2.0))
     + 
      ((_cRimt.xyz * brdf_11.x) * (_cRimt.w * 2.0))
    ) * _Amount_RimLt)))
   * _Amount_Blend) * xlv_TEXCOORD4.z) * mix (_vAmOc, vec4(1.0, 1.0, 1.0, 0.0), xlv_TEXCOORD5.wwww).xyz);
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_10, clamp ((
    (brdf_11.y * tex_12.xyz)
   * _EyeIllum), 0.0, 1.0), tex_12.www);
  tmpvar_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = xlv_TEXCOORD0.z;
  worldN_1.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = xlv_TEXCOORD1.z;
  worldN_1.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD2.z;
  worldN_1.z = tmpvar_18;
  tmpvar_3 = worldN_1;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_5;
  mediump vec3 viewDir_20;
  viewDir_20 = worldViewDir_4;
  mediump vec4 specular_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_3);
  specular_21.w = 0.0;
  specular_21.xyz = (pow (vec3(clamp (
    dot (tmpvar_22, normalize((viewDir_20 + lightDir_19)))
  , 0.0, 1.0)), vec3((_EyeGloss * 128.0))) * _LightColor0.xyz);
  mediump float tmpvar_23;
  tmpvar_23 = clamp (dot (viewDir_20, tmpvar_22), 0.0, 1.0);
  mediump float roughness_24;
  roughness_24 = (1.0 - _EyeGloss);
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = (-(viewDir_20) - ((2.0 * tmpvar_22) * -(tmpvar_23)));
  tmpvar_25.w = ((roughness_24 * (1.7 - 
    (0.7 * roughness_24)
  )) * 6.0);
  lowp vec4 tmpvar_26;
  tmpvar_26 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_25.xyz, tmpvar_25.w);
  mediump vec4 tmpvar_27;
  tmpvar_27 = tmpvar_26;
  specular_21.xyz = (specular_21.xyz + (clamp (
    ((tmpvar_27.w * unity_SpecCube0_HDR.x) * tmpvar_27.xyz)
  , 0.0, 1.0) * (1.0 - tmpvar_23)));
  specular_21.xyz = (specular_21.xyz * vec3((_EyeSpec * tex_12.w)));
  c_2 = specular_21;
  c_2.xyz = (c_2.xyz + tmpvar_15);
  lowp vec4 color_28;
  color_28.w = c_2.w;
  color_28.xyz = mix (tmpvar_6.xyz, c_2.xyz, tmpvar_6.www);
  c_2.xyz = color_28.xyz;
  c_2.w = 1.0;
  gl_FragData[0] = c_2;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "BRB_CHAR_FX" "BRB_SPECULAR_VERTEX" }
""
}
}
 }
}
Fallback "Mobile/Diffuse"
}