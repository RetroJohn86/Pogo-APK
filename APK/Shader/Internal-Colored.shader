//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-Colored" {
Properties {
 _Color ("Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _SrcBlend ("SrcBlend", Float) = 5.000000
 _DstBlend ("DstBlend", Float) = 10.000000
 _ZWrite ("ZWrite", Float) = 1.000000
 _ZTest ("ZTest", Float) = 4.000000
 _Cull ("Cull", Float) = 0.000000
 _ZBias ("ZBias", Float) = 0.000000
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest [_ZTest]
  ZWrite [_ZWrite]
  Cull [_Cull]
  Blend [_SrcBlend] [_DstBlend]
  Offset [_ZBias], [_ZBias]
  GpuProgramID 18728
Program "vp" {
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles hw_tier03 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Color;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (_glesColor * _Color);
  xlv_COLOR = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * tmpvar_2);
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR;
void main ()
{
  gl_FragData[0] = xlv_COLOR;
}


#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es
uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out lowp vec4 vs_COLOR0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp int;
in lowp vec4 vs_COLOR0;
layout(location = 0) out lowp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}
#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es
uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out lowp vec4 vs_COLOR0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp int;
in lowp vec4 vs_COLOR0;
layout(location = 0) out lowp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
}
#endif
"
}
SubProgram "gles3 hw_tier03 " {
"#ifdef VERTEX
#version 300 es
uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
out lowp vec4 vs_COLOR0;
vec4 u_xlat0;
void main()
{
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
    return;
}
#endif
#ifdef FRAGMENT
#version 300 es
precision highp int;
in lowp vec4 vs_COLOR0;
layout(location = 0) out lowp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_COLOR0;
    return;
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
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier03 " {
""
}
}
 }
}
}