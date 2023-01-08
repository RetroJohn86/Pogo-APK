//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Holo/Character/Vertex Lit + Unlit" {
Properties {
[KeywordEnum(Opaque, Cutout)] _Render ("Rendering Mode", Float) = 0
_MainTex ("Base (RGBA)", 2D) = "white" { }
[Toggle(_MIRROR_U_CLAMP_V)] _MirrorU ("    Mirror U (only use if texture is clamped, but you want V wrapped)", Float) = 0
[Toggle(_MIRROR_V_CLAMP_U)] _MirrorV ("    Mirror V (only use if texture is clamped, but you want U wrapped)", Float) = 0
[KeywordEnum(None, Unlit,, DesaturatedRamp, LinearRamp)] _BaseAlpha ("    Alpha Mode", Float) = 0
_AlphaTestRef ("    Alpha Cutoff", Range(0, 1)) = 0.5
_Ramp ("Toon Ramp (RGBA)", 2D) = "gray" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "ForwardBase" "RenderType" = "Opaque" }
  ZClip Off
  Cull Off
  GpuProgramID 51909
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float sky2ground_2;
  lowp vec3 wPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_7).xyz;
  wPos_3 = tmpvar_8;
  sky2ground_2 = 1.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (glstate_matrix_mvp * _glesVertex);
  if ((((_glesColor.x > 0.95) && (_glesColor.y > 0.95)) && (_glesColor.z > 0.95))) {
    tmpvar_5 = vec4(1.0, 1.0, 1.0, 1.0);
    tmpvar_6 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    lowp float vdn_10;
    lowp vec4 ldn_11;
    lowp vec3 wsLight_12;
    lowp vec3 wsNormal_13;
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
    wsNormal_13 = tmpvar_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
    wsLight_12 = tmpvar_16;
    lowp float tmpvar_17;
    tmpvar_17 = dot (wsNormal_13, wsLight_12);
    ldn_11.xyz = vec3(tmpvar_17);
    ldn_11.w = ((tmpvar_17 * 0.5) + 0.5);
    lowp float tmpvar_18;
    tmpvar_18 = max (0.0, tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = mix (tmpvar_18, ldn_11.w, _glesColor.w);
    ldn_11.w = tmpvar_19;
    lowp vec3 tmpvar_20;
    tmpvar_20 = normalize(wsNormal_13);
    highp float tmpvar_21;
    tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_3)));
    vdn_10 = tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22.z = 0.0;
    tmpvar_22.xy = ldn_11.ww;
    tmpvar_22.w = (1.0 - clamp (vdn_10, 0.0, 1.0));
    tmpvar_5 = tmpvar_22;
    mediump float tmpvar_23;
    highp float N_24;
    N_24 = wsNormal_13.y;
    tmpvar_23 = ((N_24 * 0.5) + 0.5);
    sky2ground_2 = tmpvar_23;
    lowp vec4 tmpvar_25;
    tmpvar_25.xyz = unity_AmbientEquator.xyz;
    tmpvar_25.w = sky2ground_2;
    tmpvar_6 = tmpvar_25;
    tmpvar_6.xyz = (tmpvar_6.xyz * ((_glesColor.w * 
      (1.0 - unity_AmbientEquator.w)
    ) + unity_AmbientEquator.w));
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_4.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * ((diffuse_1.xyz * 
    (1.0 - xlv_TEXCOORD1.z)
  ) + xlv_TEXCOORD1.z));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float sky2ground_2;
  lowp vec3 wPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_7).xyz;
  wPos_3 = tmpvar_8;
  sky2ground_2 = 1.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (glstate_matrix_mvp * _glesVertex);
  if ((((_glesColor.x > 0.95) && (_glesColor.y > 0.95)) && (_glesColor.z > 0.95))) {
    tmpvar_5 = vec4(1.0, 1.0, 1.0, 1.0);
    tmpvar_6 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    lowp float vdn_10;
    lowp vec4 ldn_11;
    lowp vec3 wsLight_12;
    lowp vec3 wsNormal_13;
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
    wsNormal_13 = tmpvar_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
    wsLight_12 = tmpvar_16;
    lowp float tmpvar_17;
    tmpvar_17 = dot (wsNormal_13, wsLight_12);
    ldn_11.xyz = vec3(tmpvar_17);
    ldn_11.w = ((tmpvar_17 * 0.5) + 0.5);
    lowp float tmpvar_18;
    tmpvar_18 = max (0.0, tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = mix (tmpvar_18, ldn_11.w, _glesColor.w);
    ldn_11.w = tmpvar_19;
    lowp vec3 tmpvar_20;
    tmpvar_20 = normalize(wsNormal_13);
    highp float tmpvar_21;
    tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_3)));
    vdn_10 = tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22.z = 0.0;
    tmpvar_22.xy = ldn_11.ww;
    tmpvar_22.w = (1.0 - clamp (vdn_10, 0.0, 1.0));
    tmpvar_5 = tmpvar_22;
    mediump float tmpvar_23;
    highp float N_24;
    N_24 = wsNormal_13.y;
    tmpvar_23 = ((N_24 * 0.5) + 0.5);
    sky2ground_2 = tmpvar_23;
    lowp vec4 tmpvar_25;
    tmpvar_25.xyz = unity_AmbientEquator.xyz;
    tmpvar_25.w = sky2ground_2;
    tmpvar_6 = tmpvar_25;
    tmpvar_6.xyz = (tmpvar_6.xyz * ((_glesColor.w * 
      (1.0 - unity_AmbientEquator.w)
    ) + unity_AmbientEquator.w));
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_4.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * ((diffuse_1.xyz * 
    (1.0 - xlv_TEXCOORD1.z)
  ) + xlv_TEXCOORD1.z));
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 vsNormal_1;
  lowp float sky2ground_2;
  lowp vec3 wPos_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_7).xyz;
  wPos_3 = tmpvar_8;
  sky2ground_2 = 1.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (glstate_matrix_mvp * _glesVertex);
  if ((((_glesColor.x > 0.95) && (_glesColor.y > 0.95)) && (_glesColor.z > 0.95))) {
    tmpvar_5 = vec4(1.0, 1.0, 1.0, 1.0);
    tmpvar_6 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    lowp float vdn_10;
    lowp vec4 ldn_11;
    lowp vec3 wsLight_12;
    lowp vec3 wsNormal_13;
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
    tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
    tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
    highp vec3 tmpvar_15;
    tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
    wsNormal_13 = tmpvar_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = normalize(_WorldSpaceLightPos0.xyz);
    wsLight_12 = tmpvar_16;
    lowp float tmpvar_17;
    tmpvar_17 = dot (wsNormal_13, wsLight_12);
    ldn_11.xyz = vec3(tmpvar_17);
    ldn_11.w = ((tmpvar_17 * 0.5) + 0.5);
    lowp float tmpvar_18;
    tmpvar_18 = max (0.0, tmpvar_17);
    highp float tmpvar_19;
    tmpvar_19 = mix (tmpvar_18, ldn_11.w, _glesColor.w);
    ldn_11.w = tmpvar_19;
    lowp vec3 tmpvar_20;
    tmpvar_20 = normalize(wsNormal_13);
    highp float tmpvar_21;
    tmpvar_21 = dot (tmpvar_20, normalize((_WorldSpaceCameraPos - wPos_3)));
    vdn_10 = tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22.z = 0.0;
    tmpvar_22.xy = ldn_11.ww;
    tmpvar_22.w = (1.0 - clamp (vdn_10, 0.0, 1.0));
    tmpvar_5 = tmpvar_22;
    mediump float tmpvar_23;
    highp float N_24;
    N_24 = wsNormal_13.y;
    tmpvar_23 = ((N_24 * 0.5) + 0.5);
    sky2ground_2 = tmpvar_23;
    lowp vec4 tmpvar_25;
    tmpvar_25.xyz = unity_AmbientEquator.xyz;
    tmpvar_25.w = sky2ground_2;
    tmpvar_6 = tmpvar_25;
    tmpvar_6.xyz = (tmpvar_6.xyz * ((_glesColor.w * 
      (1.0 - unity_AmbientEquator.w)
    ) + unity_AmbientEquator.w));
  };
  highp mat3 tmpvar_26;
  tmpvar_26[0] = glstate_matrix_modelview0[0].xyz;
  tmpvar_26[1] = glstate_matrix_modelview0[1].xyz;
  tmpvar_26[2] = glstate_matrix_modelview0[2].xyz;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize((tmpvar_26 * _glesNormal));
  vsNormal_1 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.z = 0.0;
  tmpvar_28.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_28.w = vsNormal_1.x;
  lowp vec3 tmpvar_29;
  if ((vsNormal_1.x < 0.0)) {
    tmpvar_29 = (1.0 - unity_AmbientSky.xyz);
  } else {
    tmpvar_29 = unity_AmbientSky.xyz;
  };
  lowp float tmpvar_30;
  tmpvar_30 = abs(vsNormal_1.x);
  tmpvar_4.xyz = ((tmpvar_29 * tmpvar_30) * _glesColor.w);
  gl_Position = tmpvar_9;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_28;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform lowp vec4 _LightColor0;
varying highp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 diffuse_1;
  lowp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  col_2.w = tmpvar_3.w;
  mediump vec4 tmpvar_4;
  mediump float ldn_5;
  ldn_5 = xlv_TEXCOORD1.x;
  mediump float fresnel_6;
  fresnel_6 = xlv_TEXCOORD1.w;
  lowp vec4 color_7;
  color_7 = xlv_TEXCOORD2;
  lowp vec4 rimColor_8;
  rimColor_8 = xlv_COLOR0;
  mediump vec2 tmpvar_9;
  tmpvar_9.x = ldn_5;
  tmpvar_9.y = fresnel_6;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_Ramp, tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10.www;
  lowp vec4 tmpvar_12;
  tmpvar_12.xyz = ((tmpvar_10.xyz * _LightColor0.xyz) + ((rimColor_8 * tmpvar_11) + color_7).xyz);
  tmpvar_12.w = color_7.w;
  tmpvar_4 = tmpvar_12;
  diffuse_1 = tmpvar_4;
  col_2.xyz = (tmpvar_3.xyz * ((diffuse_1.xyz * 
    (1.0 - xlv_TEXCOORD1.z)
  ) + xlv_TEXCOORD1.z));
  gl_FragData[0] = col_2;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
SubProgram "gles " {
""
}
}
}
}
Fallback "Hidden/Holo/Glass Fallback"
CustomEditor "CustomMaterialInspector"
}