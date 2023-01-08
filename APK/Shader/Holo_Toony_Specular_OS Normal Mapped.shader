//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Toony/Specular/OS Normal Mapped" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit, Specular, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_OsNormalMap ("Object-space Normal Map", 2D) = "gray" { }
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
_RampOverlayColor ("Ramp Overlay Color (RGB)", Color) = (0.5,0.5,0.5,0.5)
_Specularity ("Specularity", Range(0, 2)) = 0.1
_Glossiness ("Specular Glossiness", Range(0.025, 1)) = 0.1
[KeywordEnum(None, Specularity)] _Fresnel ("Fresnel Mode", Float) = 0
_FresnelBias ("    Fresnel Bias", Range(0, 1)) = 0.2
_FresnelPower ("    Fresnel Power", Range(0, 5)) = 2
[Toggle(BRB_METAL)] _Metal ("Metal", Float) = 0
_Metalness ("    Metalness", Range(0, 1)) = 1
[Toggle(BRB_SHADOW)] _Shadow ("Treat as environment?", Float) = 0
[Toggle(BRB_FX_DISABLE)] _FX ("Ignore FX Color", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 400
 Tags { "RenderType" = "Opaque" }
 Pass {
  Name "FORWARD"
  LOD 400
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 3005
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldNormal_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  lowp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  lowp vec3 worldNormal_7;
  tmpvar_4 = normalize(_glesNormal);
  lowp vec4 tmpvar_8;
  tmpvar_8 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_6.xz = tmpvar_8.xz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((
    (unity_WorldToObject * tmpvar_9)
  .xyz - _glesVertex.xyz)), tmpvar_4);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10;
  tmpvar_11.y = ((1.0 - max (0.0, tmpvar_10)) * _glesColor.w);
  tmpvar_6.yw = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = ((_glesColor * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec4 tmpvar_13;
  tmpvar_13.xyz = normalize(tmpvar_12.xyz);
  tmpvar_13.w = tmpvar_12.w;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = tmpvar_4;
  tmpvar_5 = (tmpvar_13 - tmpvar_14);
  highp float tmpvar_15;
  tmpvar_15 = (unity_FogParams.x * (glstate_matrix_mvp * _glesVertex).z);
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = vec3(1.0, 1.0, 1.0);
  tmpvar_16.w = exp2((-(tmpvar_15) * tmpvar_15));
  highp vec4 tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = unity_FogColor.xyz;
  tmpvar_17 = tmpvar_18;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((tmpvar_4 * tmpvar_19));
  worldNormal_7 = tmpvar_20;
  highp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_21 = clamp ((1.0 - (
    (tmpvar_22.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_23;
  tmpvar_23 = max (0.0, -(worldNormal_7.y));
  highp vec4 tmpvar_24;
  tmpvar_24.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_21 * tmpvar_21)
   * tmpvar_23))) * tmpvar_6.x);
  tmpvar_24.w = (tmpvar_16 * tmpvar_17).w;
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _glesVertex.xyz;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _OsNormalMap_ST.xy) + _OsNormalMap_ST.zw);
  highp mat3 tmpvar_26;
  tmpvar_26[0] = unity_WorldToObject[0].xyz;
  tmpvar_26[1] = unity_WorldToObject[1].xyz;
  tmpvar_26[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_4 * tmpvar_26));
  worldNormal_1 = tmpvar_27;
  tmpvar_3 = worldNormal_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_25);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_22.xyz;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_24;
  xlv_TEXCOORD5 = (unity_WorldToShadow[0] * tmpvar_22);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_FogColor;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Ramp;
uniform lowp float _Specularity;
uniform lowp float _Glossiness;
uniform sampler2D _MainTex;
uniform sampler2D _OsNormalMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 worldViewDir_2;
  lowp vec3 lightDir_3;
  highp vec4 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  lightDir_3 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  worldViewDir_2 = tmpvar_6;
  tmpvar_4 = xlv_COLOR0;
  mediump vec4 tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  lowp vec4 tmpvar_11;
  lowp vec4 osNormal_12;
  mediump vec3 vlight_13;
  lowp vec4 leftRim_14;
  mediump vec4 c_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_15 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = c_15.xyz;
  tmpvar_17.w = tmpvar_4.w;
  tmpvar_7 = tmpvar_17;
  tmpvar_9 = c_15.w;
  leftRim_14 = xlv_TEXCOORD3;
  highp vec3 tmpvar_18;
  tmpvar_18 = xlv_TEXCOORD4.xyz;
  vlight_13 = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = vlight_13;
  tmpvar_19.w = leftRim_14.y;
  tmpvar_10 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = ((texture2D (_OsNormalMap, xlv_TEXCOORD0.zw) * vec4(-2.0, 2.0, 2.0, 1.0)) + vec4(1.0, -1.0, -1.0, 0.0));
  lowp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_20.xyz);
  lowp vec4 tmpvar_22;
  tmpvar_22.xyz = tmpvar_21;
  tmpvar_22.w = tmpvar_20.w;
  osNormal_12.w = tmpvar_22.w;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((tmpvar_21 - tmpvar_4.xyz));
  osNormal_12.xyz = tmpvar_23;
  highp mat3 tmpvar_24;
  tmpvar_24[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_24[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_24[2] = unity_ObjectToWorld[2].xyz;
  lowp vec3 tmpvar_25;
  tmpvar_25 = normalize((tmpvar_24 * osNormal_12.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26.xyz = tmpvar_25;
  tmpvar_26.w = c_15.w;
  tmpvar_11 = tmpvar_26;
  tmpvar_8 = _Glossiness;
  mediump vec4 tmpvar_27;
  lowp vec3 tmpvar_28;
  lowp vec4 tmpvar_29;
  tmpvar_29.xyz = tmpvar_10.xyz;
  mediump vec3 lightDir_30;
  lightDir_30 = lightDir_3;
  mediump vec3 viewDir_31;
  viewDir_31 = worldViewDir_2;
  lowp float nh_32;
  lowp vec4 specular_33;
  lowp vec3 color_34;
  lowp vec4 ldn_35;
  tmpvar_28 = normalize(tmpvar_11.xyz);
  mediump vec4 tmpvar_36;
  tmpvar_36 = vec4(dot (tmpvar_28, lightDir_30));
  ldn_35 = tmpvar_36;
  ldn_35.w = ((ldn_35.x * 0.5) + 0.5);
  ldn_35.y = max (0.0, ldn_35.x);
  mediump float tmpvar_37;
  tmpvar_37 = mix (ldn_35.y, ldn_35.w, tmpvar_7.w);
  ldn_35.z = tmpvar_37;
  tmpvar_29.w = ((1.0 - clamp (tmpvar_10.w, 0.0, 1.0)) * tmpvar_7.w);
  lowp vec2 tmpvar_38;
  tmpvar_38.x = ldn_35.z;
  tmpvar_38.y = tmpvar_29.w;
  lowp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((texture2D (_Ramp, tmpvar_38).xyz * _LightColor0.xyz) + tmpvar_10.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = (tmpvar_7.xyz * tmpvar_39.xyz);
  color_34 = tmpvar_40;
  lowp vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = _LightColor0.xyz;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (tmpvar_28, normalize(
    (viewDir_31 + lightDir_30)
  )));
  nh_32 = tmpvar_42;
  mediump float tmpvar_43;
  tmpvar_43 = pow (nh_32, (tmpvar_8 * 128.0));
  specular_33 = (tmpvar_41 * tmpvar_43);
  specular_33.xyz = (specular_33.xyz * vec3(_Specularity));
  color_34 = (color_34 + specular_33.xyz);
  lowp vec4 tmpvar_44;
  tmpvar_44.xyz = color_34;
  tmpvar_44.w = tmpvar_9;
  tmpvar_27 = tmpvar_44;
  c_1 = tmpvar_27;
  lowp vec4 color_45;
  color_45.w = c_1.w;
  mediump vec4 envFogColor_46;
  highp vec4 tmpvar_47;
  lowp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = unity_FogColor.xyz;
  tmpvar_47 = tmpvar_48;
  envFogColor_46 = tmpvar_47;
  envFogColor_46.w = (envFogColor_46.w * xlv_TEXCOORD4.w);
  mediump vec3 tmpvar_49;
  tmpvar_49 = mix (envFogColor_46.xyz, c_1.xyz, envFogColor_46.www);
  color_45.xyz = tmpvar_49;
  c_1.xyz = color_45.xyz;
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
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
""
}
}
}
 Pass {
  Name "SHADOWCASTER"
  LOD 400
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  ZClip Off
  Cull Off
  GpuProgramID 72365
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_2.x);
  tmpvar_16.w = (tmpvar_9 * tmpvar_10).w;
  highp vec3 vertex_17;
  vertex_17 = _glesVertex.xyz;
  highp vec4 clipPos_18;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = vertex_17;
    highp vec3 tmpvar_20;
    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = normalize((tmpvar_1 * tmpvar_21));
    highp float tmpvar_23;
    tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_20 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (tmpvar_20 - (tmpvar_22 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_23 * tmpvar_23)))
    )));
    clipPos_18 = (unity_MatrixVP * tmpvar_24);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = vertex_17;
    clipPos_18 = (glstate_matrix_mvp * tmpvar_25);
  };
  highp vec4 clipPos_26;
  clipPos_26.xyw = clipPos_18.xyw;
  clipPos_26.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
  clipPos_26.z = mix (clipPos_26.z, max (clipPos_26.z, -(clipPos_18.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_26;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_16;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_2.x);
  tmpvar_16.w = (tmpvar_9 * tmpvar_10).w;
  highp vec3 vertex_17;
  vertex_17 = _glesVertex.xyz;
  highp vec4 clipPos_18;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = vertex_17;
    highp vec3 tmpvar_20;
    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = normalize((tmpvar_1 * tmpvar_21));
    highp float tmpvar_23;
    tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_20 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (tmpvar_20 - (tmpvar_22 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_23 * tmpvar_23)))
    )));
    clipPos_18 = (unity_MatrixVP * tmpvar_24);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = vertex_17;
    clipPos_18 = (glstate_matrix_mvp * tmpvar_25);
  };
  highp vec4 clipPos_26;
  clipPos_26.xyw = clipPos_18.xyw;
  clipPos_26.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
  clipPos_26.z = mix (clipPos_26.z, max (clipPos_26.z, -(clipPos_18.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_26;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_16;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = clamp ((1.0 - (
    ((unity_ObjectToWorld * _glesVertex).y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_15;
  tmpvar_15 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_15))) * tmpvar_2.x);
  tmpvar_16.w = (tmpvar_9 * tmpvar_10).w;
  highp vec3 vertex_17;
  vertex_17 = _glesVertex.xyz;
  highp vec4 clipPos_18;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = vertex_17;
    highp vec3 tmpvar_20;
    tmpvar_20 = (unity_ObjectToWorld * tmpvar_19).xyz;
    highp mat3 tmpvar_21;
    tmpvar_21[0] = unity_WorldToObject[0].xyz;
    tmpvar_21[1] = unity_WorldToObject[1].xyz;
    tmpvar_21[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_22;
    tmpvar_22 = normalize((tmpvar_1 * tmpvar_21));
    highp float tmpvar_23;
    tmpvar_23 = dot (tmpvar_22, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_20 * _WorldSpaceLightPos0.w)
    )));
    highp vec4 tmpvar_24;
    tmpvar_24.w = 1.0;
    tmpvar_24.xyz = (tmpvar_20 - (tmpvar_22 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_23 * tmpvar_23)))
    )));
    clipPos_18 = (unity_MatrixVP * tmpvar_24);
  } else {
    highp vec4 tmpvar_25;
    tmpvar_25.w = 1.0;
    tmpvar_25.xyz = vertex_17;
    clipPos_18 = (glstate_matrix_mvp * tmpvar_25);
  };
  highp vec4 clipPos_26;
  clipPos_26.xyw = clipPos_18.xyw;
  clipPos_26.z = (clipPos_18.z + clamp ((unity_LightShadowBias.x / clipPos_18.w), 0.0, 1.0));
  clipPos_26.z = mix (clipPos_26.z, max (clipPos_26.z, -(clipPos_18.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_26;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_16;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_2.x);
  tmpvar_17.w = (tmpvar_9 * tmpvar_10).w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_15.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_18);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_17;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_2.x);
  tmpvar_17.w = (tmpvar_9 * tmpvar_10).w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_15.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_18);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_17;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 worldNormal_3;
  tmpvar_1 = normalize(_glesNormal);
  lowp vec4 tmpvar_4;
  tmpvar_4 = vec4(((_glesColor.w * (1.0 - unity_AmbientEquator.w)) + unity_AmbientEquator.w));
  tmpvar_2.xz = tmpvar_4.xz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _WorldSpaceCameraPos;
  highp float tmpvar_6;
  tmpvar_6 = dot (normalize((
    (unity_WorldToObject * tmpvar_5)
  .xyz - _glesVertex.xyz)), tmpvar_1);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = ((1.0 - max (0.0, tmpvar_6)) * _glesColor.w);
  tmpvar_2.yw = tmpvar_7;
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
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((tmpvar_1 * tmpvar_12));
  worldNormal_3 = tmpvar_13;
  highp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_14 = clamp ((1.0 - (
    (tmpvar_15.y - _Ground)
   * unity_AmbientGround.w)), 0.0, 1.0);
  lowp float tmpvar_16;
  tmpvar_16 = max (0.0, -(worldNormal_3.y));
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (mix (unity_AmbientEquator.xyz, unity_AmbientGround.xyz, vec3((
    (tmpvar_14 * tmpvar_14)
   * tmpvar_16))) * tmpvar_2.x);
  tmpvar_17.w = (tmpvar_9 * tmpvar_10).w;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = (tmpvar_15.xyz - _LightPositionRange.xyz);
  gl_Position = (glstate_matrix_mvp * tmpvar_18);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_17;
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
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
Fallback "Holo/Toony/OS Normal Mapped"
CustomEditor "CustomMaterialInspector"
}