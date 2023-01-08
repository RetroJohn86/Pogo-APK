//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Distort" {
Properties {
 _Color ("    Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _RefractionAmount ("Refraction Amount", Float) = 100.000000
}
SubShader { 
 LOD 400
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 GrabPass {
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Opaque" }
  GpuProgramID 723
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].x;
  v_10.y = unity_WorldToObject[1].x;
  v_10.z = unity_WorldToObject[2].x;
  v_10.w = unity_WorldToObject[3].x;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].y;
  v_11.y = unity_WorldToObject[1].y;
  v_11.z = unity_WorldToObject[2].y;
  v_11.w = unity_WorldToObject[3].y;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].z;
  v_12.y = unity_WorldToObject[1].z;
  v_12.z = unity_WorldToObject[2].z;
  v_12.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * tmpvar_3.x)
   + 
    (v_11.xyz * tmpvar_3.y)
  ) + (v_12.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].x;
  v_10.y = unity_WorldToObject[1].x;
  v_10.z = unity_WorldToObject[2].x;
  v_10.w = unity_WorldToObject[3].x;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].y;
  v_11.y = unity_WorldToObject[1].y;
  v_11.z = unity_WorldToObject[2].y;
  v_11.w = unity_WorldToObject[3].y;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].z;
  v_12.y = unity_WorldToObject[1].z;
  v_12.z = unity_WorldToObject[2].z;
  v_12.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * tmpvar_3.x)
   + 
    (v_11.xyz * tmpvar_3.y)
  ) + (v_12.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform mediump float _RefractionAmount;
uniform highp vec2 _GrabTexture_TexelSize;
varying mediump vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  highp vec3 tmpvar_3;
  mediump vec3 vsNormal_4;
  tmpvar_3 = normalize(_glesNormal);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_5[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_5[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((tmpvar_5 * tmpvar_3));
  vsNormal_4 = tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (glstate_matrix_mvp * tmpvar_8);
  highp vec3 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp vec4 v_10;
  v_10.x = unity_WorldToObject[0].x;
  v_10.y = unity_WorldToObject[1].x;
  v_10.z = unity_WorldToObject[2].x;
  v_10.w = unity_WorldToObject[3].x;
  highp vec4 v_11;
  v_11.x = unity_WorldToObject[0].y;
  v_11.y = unity_WorldToObject[1].y;
  v_11.z = unity_WorldToObject[2].y;
  v_11.w = unity_WorldToObject[3].y;
  highp vec4 v_12;
  v_12.x = unity_WorldToObject[0].z;
  v_12.y = unity_WorldToObject[1].z;
  v_12.z = unity_WorldToObject[2].z;
  v_12.w = unity_WorldToObject[3].z;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(((
    (v_10.xyz * tmpvar_3.x)
   + 
    (v_11.xyz * tmpvar_3.y)
  ) + (v_12.xyz * tmpvar_3.z)));
  worldNormal_1 = tmpvar_13;
  tmpvar_2 = worldNormal_1;
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_9;
  xlv_TEXCOORD2 = o_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD3 = ((vsNormal_4.xy * vsNormal_4.z) * ((_RefractionAmount * _glesColor.w) * _GrabTexture_TexelSize));
  xlv_TEXCOORD4 = (_WorldSpaceCameraPos - tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GrabTexture;
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD2;
  tmpvar_1 = xlv_COLOR0;
  lowp vec4 refractColor_3;
  mediump vec2 uvgrab_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_2.xy / tmpvar_2.w);
  uvgrab_4 = (tmpvar_5 - ((xlv_TEXCOORD3 / tmpvar_2.w) * (1.0 - 
    pow ((1.0 - clamp ((
      (0.5 - abs((tmpvar_5 - 0.5)))
     * 2.0), 0.0, 1.0)), vec2(5.0, 5.0))
  )));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_GrabTexture, uvgrab_4);
  refractColor_3.w = tmpvar_6.w;
  refractColor_3.xyz = (tmpvar_6.xyz * tmpvar_1.xyz);
  gl_FragData[0] = refractColor_3;
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
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}