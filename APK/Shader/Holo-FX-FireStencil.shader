//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/FX/FireStencil" {
Properties {
 _Color1 ("Color1", Color) = (1.000000,1.000000,0.000000,1.000000)
 _Color2 ("Color2", Color) = (1.000000,0.282353,0.000000,1.000000)
 _MainTex ("Combo (R=A1,G=A2,B=Mask)", 2D) = "black" { }
 _Stencil ("Stencil ID", Float) = 0.000000
[Enum(UnityEngine.Rendering.CompareFunction)]  _StencilComp ("Stencil Compare Function", Float) = 3.000000
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Geometry+2" "RenderType"="Opaque" }
 Pass {
  Tags { "QUEUE"="Geometry+2" "RenderType"="Opaque" }
  Stencil {
   Ref [_Stencil]
   Comp [_StencilComp]
  }
  GpuProgramID 51657
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = unity_FogColor.xyz;
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * tmpvar_9);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * _CharacterColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * _CharacterColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_FogParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _CharacterColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_5 = tmpvar_1;
  tmpvar_2.x = _glesMultiTexCoord0.x;
  tmpvar_2.y = min (0.95, _glesMultiTexCoord0.y);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw).xyxy;
  tmpvar_3 = (tmpvar_3 - _Time.xyxz);
  highp float tmpvar_7;
  tmpvar_7 = (unity_FogParams.x * tmpvar_6.z);
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_8.w = exp2((-(tmpvar_7) * tmpvar_7));
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_TEXCOORD4 = (tmpvar_8 * _CharacterColor);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump float mask_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0).z + (0.5 * (texture2D (_MainTex, xlv_TEXCOORD1.xy).x + texture2D (_MainTex, xlv_TEXCOORD1.zw).y)));
  mask_2 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = mix (_Color2.xyz, _Color1.xyz, vec3(mask_2));
  col_1.w = tmpvar_4.w;
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (xlv_TEXCOORD4.xyz, tmpvar_4.xyz, xlv_TEXCOORD4.www);
  col_1.xyz = tmpvar_5;
  gl_FragData[0] = col_1;
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
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "BRB_CHAR_FX" }
""
}
SubProgram "gles hw_tier03 " {
Keywords { "BRB_CHAR_FX" }
""
}
}
 }
}
CustomEditor "CustomMaterialInspector"
Fallback Off
}