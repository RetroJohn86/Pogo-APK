//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Wrapped Diffuse/OS Normal Mapped" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_RampOverlayColor ("Ramp Overlay Color (RGB)", Color) = (0.5,0.5,0.5,0.5)
}
SubShader {
 LOD 300
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 300
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 59880
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_17)));
  tmpvar_18.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_17)));
  tmpvar_18.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_17;
  tmpvar_17 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_18;
  tmpvar_18.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_17)));
  tmpvar_18.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_WorldToObject[0].xyz;
  tmpvar_20[1] = unity_WorldToObject[1].xyz;
  tmpvar_20[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_4 * tmpvar_20));
  worldNormal_1 = tmpvar_21;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_19);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_18;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_16 = clamp ((1.0 - (
    (tmpvar_17.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_18)));
  tmpvar_19.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((tmpvar_4 * tmpvar_21));
  worldNormal_1 = tmpvar_22;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_17);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_16 = clamp ((1.0 - (
    (tmpvar_17.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_18)));
  tmpvar_19.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((tmpvar_4 * tmpvar_21));
  worldNormal_1 = tmpvar_22;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_17);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_WorldToShadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _OsNormalMap_ST;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  lowp vec3 worldNormal_6;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_7;
  tmpvar_7 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_8;
  tmpvar_8.xyz = normalize(tmpvar_7.xyz);
  tmpvar_8.w = tmpvar_7.w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_8 - tmpvar_9);
  highp float tmpvar_10;
  tmpvar_10 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_11.w = exp2((-(tmpvar_10) * tmpvar_10));
  highp vec4 tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = unity_FogColor.xyz;
  tmpvar_12 = tmpvar_13;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_4 * tmpvar_14));
  worldNormal_6 = tmpvar_15;
  highp float tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_16 = clamp ((1.0 - (
    (tmpvar_17.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_18;
  tmpvar_18 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_16 * tmpvar_16) * tmpvar_18)));
  tmpvar_19.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_21;
  tmpvar_21[0] = unity_WorldToObject[0].xyz;
  tmpvar_21[1] = unity_WorldToObject[1].xyz;
  tmpvar_21[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((tmpvar_4 * tmpvar_21));
  worldNormal_1 = tmpvar_22;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_20);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_17);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 lightDir_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _WorldSpaceLightPos0.xyz;
  lightDir_2 = tmpvar_4;
  tmpvar_3 = xlv_COLOR0;
  mediump vec4 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  lowp vec4 tmpvar_8;
  lowp vec4 osNormal_9;
  mediump vec3 vlight_10;
  mediump vec4 c_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_11 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = c_11.xyz;
  tmpvar_13.w = tmpvar_3.w;
  tmpvar_5 = tmpvar_13;
  tmpvar_6 = c_11.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  vlight_10 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = vlight_10;
  tmpvar_7 = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_17;
  tmpvar_17 = normalize(tmpvar_16.xyz);
  lowp vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17;
  tmpvar_18.w = tmpvar_16.w;
  osNormal_9.w = tmpvar_18.w;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_17 - tmpvar_3.xyz));
  osNormal_9.xyz = tmpvar_19;
  highp mat3 tmpvar_20;
  tmpvar_20[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_20[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_20[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize((tmpvar_20 * osNormal_9.xyz));
  mediump vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = c_11.w;
  tmpvar_8 = tmpvar_22;
  mediump vec4 tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 lightDir_25;
  lightDir_25 = lightDir_2;
  lowp vec3 color_26;
  lowp vec4 ldn_27;
  tmpvar_24 = normalize(tmpvar_8.xyz);
  mediump vec4 tmpvar_28;
  tmpvar_28 = vec4(dot (tmpvar_24, lightDir_25));
  ldn_27 = tmpvar_28;
  ldn_27.w = ((ldn_27.x * 0.5) + 0.5);
  lowp vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = ((ldn_27.www * _LightColor0.xyz) + tmpvar_7.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_5.xyz * tmpvar_29.xyz);
  color_26 = tmpvar_30;
  lowp vec4 tmpvar_31;
  tmpvar_31.xyz = color_26;
  tmpvar_31.w = tmpvar_6;
  tmpvar_23 = tmpvar_31;
  c_1 = tmpvar_23;
  lowp vec4 color_32;
  color_32.w = c_1.w;
  mediump vec4 envFogColor_33;
  highp vec4 tmpvar_34;
  lowp vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = unity_FogColor.xyz;
  tmpvar_34 = tmpvar_35;
  envFogColor_33 = tmpvar_34;
  envFogColor_33.w = (envFogColor_33.w * xlv_TEXCOORD2.w);
  mediump vec3 tmpvar_36;
  tmpvar_36 = mix (envFogColor_33.xyz, c_1.xyz, envFogColor_33.www);
  color_32.xyz = tmpvar_36;
  c_1.xyz = color_32.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 300
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  GpuProgramID 108993
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  lowp vec3 worldNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_1 * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_9 * tmpvar_9) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_4 * tmpvar_5).w;
  highp vec3 vertex_12;
  vertex_12 = _glesVertex.xyz;
  highp vec4 clipPos_13;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_12;
    highp vec3 tmpvar_15;
    tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((tmpvar_1 * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_15 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (tmpvar_15 - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
    clipPos_13 = (unity_MatrixVP * tmpvar_19);
  } else {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_12;
    clipPos_13 = (glstate_matrix_mvp * tmpvar_20);
  };
  highp vec4 clipPos_21;
  clipPos_21.xyw = clipPos_13.xyw;
  clipPos_21.z = (clipPos_13.z + clamp ((unity_LightShadowBias.x / clipPos_13.w), 0.0, 1.0));
  clipPos_21.z = mix (clipPos_21.z, max (clipPos_21.z, -(clipPos_13.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_21;
  xlv_TEXCOORD1 = tmpvar_11;
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
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  lowp vec3 worldNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_1 * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_9 * tmpvar_9) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_4 * tmpvar_5).w;
  highp vec3 vertex_12;
  vertex_12 = _glesVertex.xyz;
  highp vec4 clipPos_13;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_12;
    highp vec3 tmpvar_15;
    tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((tmpvar_1 * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_15 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (tmpvar_15 - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
    clipPos_13 = (unity_MatrixVP * tmpvar_19);
  } else {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_12;
    clipPos_13 = (glstate_matrix_mvp * tmpvar_20);
  };
  highp vec4 clipPos_21;
  clipPos_21.xyw = clipPos_13.xyw;
  clipPos_21.z = (clipPos_13.z + clamp ((unity_LightShadowBias.x / clipPos_13.w), 0.0, 1.0));
  clipPos_21.z = mix (clipPos_21.z, max (clipPos_21.z, -(clipPos_13.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_21;
  xlv_TEXCOORD1 = tmpvar_11;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec3 tmpvar_1;
  lowp vec3 worldNormal_2;
  tmpvar_1 = normalize(_glesNormal);
  highp float tmpvar_3;
  tmpvar_3 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_4;
  tmpvar_4.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_4.w = exp2((-(tmpvar_3) * tmpvar_3));
  highp vec4 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = unity_FogColor.xyz;
  tmpvar_5 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_1 * tmpvar_7));
  worldNormal_2 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_9 * tmpvar_9) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_4 * tmpvar_5).w;
  highp vec3 vertex_12;
  vertex_12 = _glesVertex.xyz;
  highp vec4 clipPos_13;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = vertex_12;
    highp vec3 tmpvar_15;
    tmpvar_15 = (unity_ObjectToWorld * tmpvar_14).xyz;
    highp mat3 tmpvar_16;
    tmpvar_16[0] = unity_WorldToObject[0].xyz;
    tmpvar_16[1] = unity_WorldToObject[1].xyz;
    tmpvar_16[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize((tmpvar_1 * tmpvar_16));
    highp float tmpvar_18;
    tmpvar_18 = dot (tmpvar_17, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_15 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = (tmpvar_15 - (tmpvar_17 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_18 * tmpvar_18)))
    )));
    clipPos_13 = (unity_MatrixVP * tmpvar_19);
  } else {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 1.0;
    tmpvar_20.xyz = vertex_12;
    clipPos_13 = (glstate_matrix_mvp * tmpvar_20);
  };
  highp vec4 clipPos_21;
  clipPos_21.xyw = clipPos_13.xyw;
  clipPos_21.z = (clipPos_13.z + clamp ((unity_LightShadowBias.x / clipPos_13.w), 0.0, 1.0));
  clipPos_21.z = mix (clipPos_21.z, max (clipPos_21.z, -(clipPos_13.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_21;
  xlv_TEXCOORD1 = tmpvar_11;
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((normalize(_glesNormal) * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = clamp ((1.0 - (
    (tmpvar_9.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_1.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_8 * tmpvar_8) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_3 * tmpvar_4).w;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD1 = tmpvar_11;
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
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((normalize(_glesNormal) * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = clamp ((1.0 - (
    (tmpvar_9.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_1.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_8 * tmpvar_8) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_3 * tmpvar_4).w;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD1 = tmpvar_11;
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
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
uniform highp float _Ground;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec3 worldNormal_1;
  highp float tmpvar_2;
  tmpvar_2 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_3;
  tmpvar_3.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_3.w = exp2((-(tmpvar_2) * tmpvar_2));
  highp vec4 tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = unity_FogColor.xyz;
  tmpvar_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((normalize(_glesNormal) * tmpvar_6));
  worldNormal_1 = tmpvar_7;
  highp float tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_8 = clamp ((1.0 - (
    (tmpvar_9.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_10;
  tmpvar_10 = max (0.0, -(worldNormal_1.y));
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_8 * tmpvar_8) * tmpvar_10)));
  tmpvar_11.w = (tmpvar_3 * tmpvar_4).w;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_9.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_12);
  xlv_TEXCOORD1 = tmpvar_11;
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
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
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
}
}
}
Fallback "Holo/Wrapped Diffuse/Pixel Lit"
CustomEditor "CustomMaterialInspector"
}