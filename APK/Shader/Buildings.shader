//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/World Map/Buildings" {
Properties {
 _yFaceColor ("Up Facing Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _blendedFaceColor ("Blended (distant) Face Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _wallColor ("Wall Color 1", Color) = (1.000000,1.000000,1.000000,1.000000)
 _wallColorSecondary ("Wall Color 2", Color) = (1.000000,1.000000,1.000000,1.000000)
 _NearOpacity ("Near Opacity", Range(0.000000,1.000000)) = 0.000000
 _FarOpacity ("Far Opacity", Range(0.000000,1.000000)) = 1.000000
 _NearDist ("Near Distance", Float) = 100.000000
 _FarDist ("Far Distance", Float) = 250.000000
 _BlendedColorNearDist ("Blended Near Distance", Float) = 80.000000
 _BlendedColorFarDist ("Blended Far Distance", Float) = 250.000000
}
SubShader { 
 Pass {
  Tags { "QUEUE"="Transparent-1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Stencil {
   Ref 1.000000
   Comp NotEqual
   Pass Replace
  }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 50665
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
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
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
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
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
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
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
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
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
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
  tmpvar_9 = ((tmpvar_8.y + 1.0) * 0.5);
  up_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_8.z + 1.0) * 0.5);
  left_2 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_4 = tmpvar_12;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
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
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_9.y + 1.0) * 0.5);
  up_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9.z + 1.0) * 0.5);
  left_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
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
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_9.y + 1.0) * 0.5);
  up_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9.z + 1.0) * 0.5);
  left_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_FogParams;
uniform lowp vec4 _wallColor;
uniform lowp vec4 _wallColorSecondary;
uniform lowp vec4 _yFaceColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 wall_1;
  mediump float left_2;
  mediump float up_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
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
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_9.y + 1.0) * 0.5);
  up_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9.z + 1.0) * 0.5);
  left_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = mix (_wallColor, _wallColorSecondary, vec4(left_2));
  wall_1 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = mix (wall_1, _yFaceColor, vec4(up_3));
  tmpvar_5 = tmpvar_13;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
}


#endif
#ifdef FRAGMENT
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _blendedFaceColor;
uniform highp vec4 _playerPosition;
uniform mediump float _NearOpacity;
uniform mediump float _FarOpacity;
uniform mediump float _NearDist;
uniform mediump float _FarDist;
uniform mediump float _BlendedColorNearDist;
uniform mediump float _BlendedColorFarDist;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float tmpvar_2;
  highp vec3 x_3;
  x_3 = (_playerPosition.xyz - xlv_TEXCOORD1);
  tmpvar_2 = sqrt(dot (x_3, x_3));
  mediump float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp (((tmpvar_2 - _NearDist) / (_FarDist - _NearDist)), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (((tmpvar_2 - _BlendedColorNearDist) / (_BlendedColorFarDist - _BlendedColorNearDist)), 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_blendedFaceColor, xlv_TEXCOORD0, vec4(tmpvar_6)).xyz;
  c_1.xyz = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = mix (_NearOpacity, _FarOpacity, tmpvar_4);
  c_1.w = (tmpvar_9 * xlv_TEXCOORD0.w);
  highp float tmpvar_10;
  tmpvar_10 = clamp (xlv_TEXCOORD2, 0.0, 1.0);
  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_10));
  gl_FragData[0] = c_1;
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
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LINEAR" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "FOG_LINEAR" }
""
}
}
 }
}
}