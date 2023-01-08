//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Toony/Pixel Lit" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Toggle(BRB_SHADOW)]  _Shadow ("Treat as environment?", Float) = 0.000000
[Toggle(BRB_FX_DISABLE)]  _FX ("Ignore environment FX Color", Float) = 0.000000
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  GpuProgramID 42846
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  highp vec4 v_31;
  v_31.x = tmpvar_13;
  v_31.y = tmpvar_14;
  v_31.z = tmpvar_15;
  v_31.w = tmpvar_16;
  highp vec4 v_32;
  v_32.x = tmpvar_18;
  v_32.y = tmpvar_19;
  v_32.z = tmpvar_20;
  v_32.w = tmpvar_21;
  highp vec4 v_33;
  v_33.x = tmpvar_23;
  v_33.y = tmpvar_24;
  v_33.z = tmpvar_25;
  v_33.w = tmpvar_26;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(((
    (v_31.xyz * _glesNormal.x)
   + 
    (v_32.xyz * _glesNormal.y)
  ) + (v_33.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_34;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  highp vec4 v_31;
  v_31.x = tmpvar_13;
  v_31.y = tmpvar_14;
  v_31.z = tmpvar_15;
  v_31.w = tmpvar_16;
  highp vec4 v_32;
  v_32.x = tmpvar_18;
  v_32.y = tmpvar_19;
  v_32.z = tmpvar_20;
  v_32.w = tmpvar_21;
  highp vec4 v_33;
  v_33.x = tmpvar_23;
  v_33.y = tmpvar_24;
  v_33.z = tmpvar_25;
  v_33.w = tmpvar_26;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(((
    (v_31.xyz * _glesNormal.x)
   + 
    (v_32.xyz * _glesNormal.y)
  ) + (v_33.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_34;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_29;
  tmpvar_29 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_29))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = _glesVertex.xyz;
  highp vec4 v_31;
  v_31.x = tmpvar_13;
  v_31.y = tmpvar_14;
  v_31.z = tmpvar_15;
  v_31.w = tmpvar_16;
  highp vec4 v_32;
  v_32.x = tmpvar_18;
  v_32.y = tmpvar_19;
  v_32.z = tmpvar_20;
  v_32.w = tmpvar_21;
  highp vec4 v_33;
  v_33.x = tmpvar_23;
  v_33.y = tmpvar_24;
  v_33.z = tmpvar_25;
  v_33.w = tmpvar_26;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(((
    (v_31.xyz * _glesNormal.x)
   + 
    (v_32.xyz * _glesNormal.y)
  ) + (v_33.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_34;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_30);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_28 = clamp ((1.0 - (
    (tmpvar_29.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_30))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  highp vec4 v_32;
  v_32.x = tmpvar_13;
  v_32.y = tmpvar_14;
  v_32.z = tmpvar_15;
  v_32.w = tmpvar_16;
  highp vec4 v_33;
  v_33.x = tmpvar_18;
  v_33.y = tmpvar_19;
  v_33.z = tmpvar_20;
  v_33.w = tmpvar_21;
  highp vec4 v_34;
  v_34.x = tmpvar_23;
  v_34.y = tmpvar_24;
  v_34.z = tmpvar_25;
  v_34.w = tmpvar_26;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * _glesNormal.x)
   + 
    (v_33.xyz * _glesNormal.y)
  ) + (v_34.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_35;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_29);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_28 = clamp ((1.0 - (
    (tmpvar_29.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_30))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  highp vec4 v_32;
  v_32.x = tmpvar_13;
  v_32.y = tmpvar_14;
  v_32.z = tmpvar_15;
  v_32.w = tmpvar_16;
  highp vec4 v_33;
  v_33.x = tmpvar_18;
  v_33.y = tmpvar_19;
  v_33.z = tmpvar_20;
  v_33.w = tmpvar_21;
  highp vec4 v_34;
  v_34.x = tmpvar_23;
  v_34.y = tmpvar_24;
  v_34.z = tmpvar_25;
  v_34.w = tmpvar_26;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * _glesNormal.x)
   + 
    (v_33.xyz * _glesNormal.y)
  ) + (v_34.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_35;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_29);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  mediump vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec3 vlight_5;
  lowp vec3 worldNormal_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_4 = tmpvar_7;
  tmpvar_3.w = _glesColor.w;
  highp float tmpvar_8;
  tmpvar_8 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_9.w = exp2((-(tmpvar_8) * tmpvar_8));
  highp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = unity_FogColor.xyz;
  tmpvar_10 = tmpvar_11;
  highp vec4 v_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_WorldToObject[0].x;
  v_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = unity_WorldToObject[1].x;
  v_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = unity_WorldToObject[2].x;
  v_12.z = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_WorldToObject[3].x;
  v_12.w = tmpvar_16;
  highp vec4 v_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_WorldToObject[0].y;
  v_17.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_WorldToObject[1].y;
  v_17.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = unity_WorldToObject[2].y;
  v_17.z = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_WorldToObject[3].y;
  v_17.w = tmpvar_21;
  highp vec4 v_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_WorldToObject[0].z;
  v_22.x = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_WorldToObject[1].z;
  v_22.y = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_WorldToObject[2].z;
  v_22.z = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = unity_WorldToObject[3].z;
  v_22.w = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(((
    (v_12.xyz * _glesNormal.x)
   + 
    (v_17.xyz * _glesNormal.y)
  ) + (v_22.xyz * _glesNormal.z)));
  worldNormal_6 = tmpvar_27;
  highp float tmpvar_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_28 = clamp ((1.0 - (
    (tmpvar_29.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_30;
  tmpvar_30 = max (0.0, -(worldNormal_6.y));
  vlight_5 = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_28 * tmpvar_28)
   * tmpvar_30))) * tmpvar_4.x);
  tmpvar_3.xyz = vlight_5;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = _glesVertex.xyz;
  highp vec4 v_32;
  v_32.x = tmpvar_13;
  v_32.y = tmpvar_14;
  v_32.z = tmpvar_15;
  v_32.w = tmpvar_16;
  highp vec4 v_33;
  v_33.x = tmpvar_18;
  v_33.y = tmpvar_19;
  v_33.z = tmpvar_20;
  v_33.w = tmpvar_21;
  highp vec4 v_34;
  v_34.x = tmpvar_23;
  v_34.y = tmpvar_24;
  v_34.z = tmpvar_25;
  v_34.w = tmpvar_26;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(((
    (v_32.xyz * _glesNormal.x)
   + 
    (v_33.xyz * _glesNormal.y)
  ) + (v_34.xyz * _glesNormal.z)));
  worldNormal_1 = tmpvar_35;
  tmpvar_2 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_31);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (tmpvar_9 * tmpvar_10);
  xlv_TEXCOORD4 = (unity_WorldToShadow[0] * tmpvar_29);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec3 lightDir_4;
  highp vec4 tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_4 = tmpvar_6;
  tmpvar_5 = xlv_COLOR0;
  tmpvar_2 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_7;
  lowp float tmpvar_8;
  lowp vec4 tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10.xyz = tmpvar_3.xyz;
  mediump vec3 vlight_11;
  mediump vec4 c_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_12 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.xyz = c_12.xyz;
  tmpvar_14.w = tmpvar_5.w;
  tmpvar_7 = tmpvar_14;
  tmpvar_8 = c_12.w;
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_5.xyz;
  vlight_11 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = vlight_11;
  tmpvar_9 = tmpvar_16;
  tmpvar_10.w = c_12.w;
  tmpvar_3 = tmpvar_10;
  mediump vec4 tmpvar_17;
  lowp vec3 tmpvar_18;
  mediump vec3 lightDir_19;
  lightDir_19 = lightDir_4;
  lowp vec3 color_20;
  lowp vec4 ldn_21;
  tmpvar_18 = normalize(tmpvar_2);
  mediump vec4 tmpvar_22;
  tmpvar_22 = vec4(dot (tmpvar_18, lightDir_19));
  ldn_21 = tmpvar_22;
  ldn_21.w = ((ldn_21.x * 0.5) + 0.5);
  ldn_21.y = max (0.0, ldn_21.x);
  mediump float tmpvar_23;
  tmpvar_23 = mix (ldn_21.y, ldn_21.w, tmpvar_7.w);
  ldn_21.z = tmpvar_23;
  lowp vec2 tmpvar_24;
  tmpvar_24.x = ldn_21.z;
  tmpvar_24.y = tmpvar_9.w;
  lowp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = ((texture2D (_Ramp, tmpvar_24).xyz * _LightColor0.xyz) + tmpvar_9.xyz);
  mediump vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_7.xyz * tmpvar_25.xyz);
  color_20 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = color_20;
  tmpvar_27.w = tmpvar_8;
  tmpvar_17 = tmpvar_27;
  c_1 = tmpvar_17;
  lowp vec4 color_28;
  color_28.w = c_1.w;
  highp vec3 tmpvar_29;
  tmpvar_29 = mix (xlv_TEXCOORD3.xyz, c_1.xyz, xlv_TEXCOORD3.www);
  color_28.xyz = tmpvar_29;
  c_1.xyz = color_28.xyz;
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
  GpuProgramID 82380
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].x;
    v_12.y = unity_WorldToObject[1].x;
    v_12.z = unity_WorldToObject[2].x;
    v_12.w = unity_WorldToObject[3].x;
    highp vec4 v_13;
    v_13.x = unity_WorldToObject[0].y;
    v_13.y = unity_WorldToObject[1].y;
    v_13.z = unity_WorldToObject[2].y;
    v_13.w = unity_WorldToObject[3].y;
    highp vec4 v_14;
    v_14.x = unity_WorldToObject[0].z;
    v_14.y = unity_WorldToObject[1].z;
    v_14.z = unity_WorldToObject[2].z;
    v_14.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize(((
      (v_12.xyz * _glesNormal.x)
     + 
      (v_13.xyz * _glesNormal.y)
    ) + (v_14.xyz * _glesNormal.z)));
    highp float tmpvar_16;
    tmpvar_16 = dot (tmpvar_15, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_17;
    tmpvar_17.w = 1.0;
    tmpvar_17.xyz = (tmpvar_11 - (tmpvar_15 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_16 * tmpvar_16)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_17);
  } else {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_18);
  };
  highp vec4 clipPos_19;
  clipPos_19.xyw = clipPos_9.xyw;
  clipPos_19.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].x;
    v_12.y = unity_WorldToObject[1].x;
    v_12.z = unity_WorldToObject[2].x;
    v_12.w = unity_WorldToObject[3].x;
    highp vec4 v_13;
    v_13.x = unity_WorldToObject[0].y;
    v_13.y = unity_WorldToObject[1].y;
    v_13.z = unity_WorldToObject[2].y;
    v_13.w = unity_WorldToObject[3].y;
    highp vec4 v_14;
    v_14.x = unity_WorldToObject[0].z;
    v_14.y = unity_WorldToObject[1].z;
    v_14.z = unity_WorldToObject[2].z;
    v_14.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize(((
      (v_12.xyz * _glesNormal.x)
     + 
      (v_13.xyz * _glesNormal.y)
    ) + (v_14.xyz * _glesNormal.z)));
    highp float tmpvar_16;
    tmpvar_16 = dot (tmpvar_15, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_17;
    tmpvar_17.w = 1.0;
    tmpvar_17.xyz = (tmpvar_11 - (tmpvar_15 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_16 * tmpvar_16)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_17);
  } else {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_18);
  };
  highp vec4 clipPos_19;
  clipPos_19.xyw = clipPos_9.xyw;
  clipPos_19.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 unity_AmbientEquator;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_5;
  tmpvar_5.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_5.w = exp2((-(tmpvar_4) * tmpvar_4));
  highp vec4 tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = unity_FogColor.xyz;
  tmpvar_6 = tmpvar_7;
  tmpvar_1 = (tmpvar_5 * tmpvar_6);
  highp vec3 vertex_8;
  vertex_8 = _glesVertex.xyz;
  highp vec4 clipPos_9;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_10;
    tmpvar_10.w = 1.0;
    tmpvar_10.xyz = vertex_8;
    highp vec3 tmpvar_11;
    tmpvar_11 = (unity_ObjectToWorld * tmpvar_10).xyz;
    highp vec4 v_12;
    v_12.x = unity_WorldToObject[0].x;
    v_12.y = unity_WorldToObject[1].x;
    v_12.z = unity_WorldToObject[2].x;
    v_12.w = unity_WorldToObject[3].x;
    highp vec4 v_13;
    v_13.x = unity_WorldToObject[0].y;
    v_13.y = unity_WorldToObject[1].y;
    v_13.z = unity_WorldToObject[2].y;
    v_13.w = unity_WorldToObject[3].y;
    highp vec4 v_14;
    v_14.x = unity_WorldToObject[0].z;
    v_14.y = unity_WorldToObject[1].z;
    v_14.z = unity_WorldToObject[2].z;
    v_14.w = unity_WorldToObject[3].z;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize(((
      (v_12.xyz * _glesNormal.x)
     + 
      (v_13.xyz * _glesNormal.y)
    ) + (v_14.xyz * _glesNormal.z)));
    highp float tmpvar_16;
    tmpvar_16 = dot (tmpvar_15, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_11 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_17;
    tmpvar_17.w = 1.0;
    tmpvar_17.xyz = (tmpvar_11 - (tmpvar_15 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_16 * tmpvar_16)))
    )));
    clipPos_9 = (unity_MatrixVP * tmpvar_17);
  } else {
    highp vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = vertex_8;
    clipPos_9 = (glstate_matrix_mvp * tmpvar_18);
  };
  highp vec4 clipPos_19;
  clipPos_19.xyw = clipPos_9.xyw;
  clipPos_19.z = (clipPos_9.z + clamp ((unity_LightShadowBias.x / clipPos_9.w), 0.0, 1.0));
  clipPos_19.z = mix (clipPos_19.z, max (clipPos_19.z, -(clipPos_9.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_19;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = 1.0;
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = tmpvar_1.xyz;
  mediump vec4 c_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  c_4 = tmpvar_5;
  tmpvar_3.w = c_4.w;
  tmpvar_1 = tmpvar_3;
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
attribute vec4 _glesColor;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_FogColor;
uniform highp vec4 unity_FogParams;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_1 = tmpvar_2;
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
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_7);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = (tmpvar_4 * tmpvar_5);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
uniform sampler2D _MainTex;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 1.0;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = tmpvar_2.xyz;
  mediump vec4 c_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_3);
  c_5 = tmpvar_6;
  tmpvar_4.w = c_5.w;
  tmpvar_2 = tmpvar_4;
  highp vec4 enc_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  enc_7 = (tmpvar_8 - (tmpvar_8.yzww * 0.003921569));
  tmpvar_1 = enc_7;
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
Fallback "Holo/Toony/Vertex Lit"
}