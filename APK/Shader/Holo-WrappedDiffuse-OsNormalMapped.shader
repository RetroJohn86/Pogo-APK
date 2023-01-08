//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Wrapped Diffuse/OS Normal Mapped" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)]  _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0.000000
[Toggle(_MIRROR_V_CLAMP_U)]  _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0.000000
 _OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
 _RampOverlayColor ("Ramp Overlay Color (RGB)", Color) = (0.500000,0.500000,0.500000,0.500000)
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 43528
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_31;
  tmpvar_31 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_31)));
  tmpvar_32.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_34;
  v_34.x = tmpvar_15;
  v_34.y = tmpvar_16;
  v_34.z = tmpvar_17;
  v_34.w = tmpvar_18;
  highp vec4 v_35;
  v_35.x = tmpvar_20;
  v_35.y = tmpvar_21;
  v_35.z = tmpvar_22;
  v_35.w = tmpvar_23;
  highp vec4 v_36;
  v_36.x = tmpvar_25;
  v_36.y = tmpvar_26;
  v_36.z = tmpvar_27;
  v_36.w = tmpvar_28;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_4.x)
   + 
    (v_35.xyz * tmpvar_4.y)
  ) + (v_36.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_37;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_32;
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
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_31;
  tmpvar_31 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_31)));
  tmpvar_32.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_34;
  v_34.x = tmpvar_15;
  v_34.y = tmpvar_16;
  v_34.z = tmpvar_17;
  v_34.w = tmpvar_18;
  highp vec4 v_35;
  v_35.x = tmpvar_20;
  v_35.y = tmpvar_21;
  v_35.z = tmpvar_22;
  v_35.w = tmpvar_23;
  highp vec4 v_36;
  v_36.x = tmpvar_25;
  v_36.y = tmpvar_26;
  v_36.z = tmpvar_27;
  v_36.w = tmpvar_28;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_4.x)
   + 
    (v_35.xyz * tmpvar_4.y)
  ) + (v_36.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_37;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_32;
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
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_31;
  tmpvar_31 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_32;
  tmpvar_32.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_31)));
  tmpvar_32.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_33;
  tmpvar_33.w = 1.0;
  tmpvar_33.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_34;
  v_34.x = tmpvar_15;
  v_34.y = tmpvar_16;
  v_34.z = tmpvar_17;
  v_34.w = tmpvar_18;
  highp vec4 v_35;
  v_35.x = tmpvar_20;
  v_35.y = tmpvar_21;
  v_35.z = tmpvar_22;
  v_35.w = tmpvar_23;
  highp vec4 v_36;
  v_36.x = tmpvar_25;
  v_36.y = tmpvar_26;
  v_36.z = tmpvar_27;
  v_36.w = tmpvar_28;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(((
    (v_34.xyz * tmpvar_4.x)
   + 
    (v_35.xyz * tmpvar_4.y)
  ) + (v_36.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_37;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_33);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_32;
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_30 = clamp ((1.0 - (
    (tmpvar_31.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_32;
  tmpvar_32 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_32)));
  tmpvar_33.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_35;
  v_35.x = tmpvar_15;
  v_35.y = tmpvar_16;
  v_35.z = tmpvar_17;
  v_35.w = tmpvar_18;
  highp vec4 v_36;
  v_36.x = tmpvar_20;
  v_36.y = tmpvar_21;
  v_36.z = tmpvar_22;
  v_36.w = tmpvar_23;
  highp vec4 v_37;
  v_37.x = tmpvar_25;
  v_37.y = tmpvar_26;
  v_37.z = tmpvar_27;
  v_37.w = tmpvar_28;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_4.x)
   + 
    (v_36.xyz * tmpvar_4.y)
  ) + (v_37.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_38;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_34);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_31);
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
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_30 = clamp ((1.0 - (
    (tmpvar_31.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_32;
  tmpvar_32 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_32)));
  tmpvar_33.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_35;
  v_35.x = tmpvar_15;
  v_35.y = tmpvar_16;
  v_35.z = tmpvar_17;
  v_35.w = tmpvar_18;
  highp vec4 v_36;
  v_36.x = tmpvar_20;
  v_36.y = tmpvar_21;
  v_36.z = tmpvar_22;
  v_36.w = tmpvar_23;
  highp vec4 v_37;
  v_37.x = tmpvar_25;
  v_37.y = tmpvar_26;
  v_37.z = tmpvar_27;
  v_37.w = tmpvar_28;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_4.x)
   + 
    (v_36.xyz * tmpvar_4.y)
  ) + (v_37.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_38;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_34);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_31);
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
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
  highp vec4 v_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[0].x;
  v_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[1].x;
  v_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_WorldToObject[2].x;
  v_14.z = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[3].x;
  v_14.w = tmpvar_18;
  highp vec4 v_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[0].y;
  v_19.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[1].y;
  v_19.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_WorldToObject[2].y;
  v_19.z = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[3].y;
  v_19.w = tmpvar_23;
  highp vec4 v_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[0].z;
  v_24.x = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[1].z;
  v_24.y = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = unity_WorldToObject[2].z;
  v_24.z = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = unity_WorldToObject[3].z;
  v_24.w = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = normalize(((
    (v_14.xyz * tmpvar_4.x)
   + 
    (v_19.xyz * tmpvar_4.y)
  ) + (v_24.xyz * tmpvar_4.z)));
  worldNormal_6 = tmpvar_29;
  highp float tmpvar_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_30 = clamp ((1.0 - (
    (tmpvar_31.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_32;
  tmpvar_32 = max (0.0, -(worldNormal_6.y));
  highp vec4 tmpvar_33;
  tmpvar_33.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_30 * tmpvar_30) * tmpvar_32)));
  tmpvar_33.w = (tmpvar_11 * tmpvar_12).w;
  highp vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp vec4 v_35;
  v_35.x = tmpvar_15;
  v_35.y = tmpvar_16;
  v_35.z = tmpvar_17;
  v_35.w = tmpvar_18;
  highp vec4 v_36;
  v_36.x = tmpvar_20;
  v_36.y = tmpvar_21;
  v_36.z = tmpvar_22;
  v_36.w = tmpvar_23;
  highp vec4 v_37;
  v_37.x = tmpvar_25;
  v_37.y = tmpvar_26;
  v_37.z = tmpvar_27;
  v_37.w = tmpvar_28;
  highp vec3 tmpvar_38;
  tmpvar_38 = normalize(((
    (v_35.xyz * tmpvar_4.x)
   + 
    (v_36.xyz * tmpvar_4.y)
  ) + (v_37.xyz * tmpvar_4.z)));
  worldNormal_1 = tmpvar_38;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_34);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_33;
  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_31);
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
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 68391
Program "vp" {
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_12)));
  tmpvar_13.w = (tmpvar_4 * tmpvar_5).w;
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
      (v_18.xyz * tmpvar_1.x)
     + 
      (v_19.xyz * tmpvar_1.y)
    ) + (v_20.xyz * tmpvar_1.z)));
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_12)));
  tmpvar_13.w = (tmpvar_4 * tmpvar_5).w;
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
      (v_18.xyz * tmpvar_1.x)
     + 
      (v_19.xyz * tmpvar_1.y)
    ) + (v_20.xyz * tmpvar_1.z)));
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_12;
  tmpvar_12 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_13;
  tmpvar_13.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_12)));
  tmpvar_13.w = (tmpvar_4 * tmpvar_5).w;
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
      (v_18.xyz * tmpvar_1.x)
     + 
      (v_19.xyz * tmpvar_1.y)
    ) + (v_20.xyz * tmpvar_1.z)));
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = clamp ((1.0 - (
    (tmpvar_12.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_13)));
  tmpvar_14.w = (tmpvar_4 * tmpvar_5).w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_12.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD1 = tmpvar_14;
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = clamp ((1.0 - (
    (tmpvar_12.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_13)));
  tmpvar_14.w = (tmpvar_4 * tmpvar_5).w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_12.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD1 = tmpvar_14;
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
    (v_7.xyz * tmpvar_1.x)
   + 
    (v_8.xyz * tmpvar_1.y)
  ) + (v_9.xyz * tmpvar_1.z)));
  worldNormal_2 = tmpvar_10;
  highp float tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_11 = clamp ((1.0 - (
    (tmpvar_12.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_13;
  tmpvar_13 = max (0.0, -(worldNormal_2.y));
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3(((tmpvar_11 * tmpvar_11) * tmpvar_13)));
  tmpvar_14.w = (tmpvar_4 * tmpvar_5).w;
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_12.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_15);
  xlv_TEXCOORD1 = tmpvar_14;
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
CustomEditor "CustomMaterialInspector"
Fallback "Holo/Wrapped Diffuse/Pixel Lit"
}