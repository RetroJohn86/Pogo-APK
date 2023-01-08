//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Holo/Shadow/AO Blur" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_AORadius ("Max Radius", Float) = 0.03
_ShadowPower ("Shadow Power", Float) = 1.5
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  GpuProgramID 57591
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
vec4 ImmCB_0[31];
uniform 	float _AOShadowRadius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
ImmCB_0[0] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[1] = vec4(0.520261526,-0.158384502,0.656779885,0.0);
ImmCB_0[2] = vec4(-0.612989008,-0.0200189091,0.57073611,0.0);
ImmCB_0[3] = vec4(-0.2168715,-0.654387712,0.468778491,0.0);
ImmCB_0[4] = vec4(-0.338378906,0.508706689,0.573759615,0.0);
ImmCB_0[5] = vec4(-0.311143786,0.0955148563,0.872131586,0.0);
ImmCB_0[6] = vec4(0.33586821,0.445185691,0.640237629,0.0);
ImmCB_0[7] = vec4(0.240833193,-0.416449487,0.727814317,0.0);
ImmCB_0[8] = vec4(-0.962644875,-0.135864601,0.043677099,0.0);
ImmCB_0[9] = vec4(0.00912603829,-0.673168182,0.491044998,0.0);
ImmCB_0[10] = vec4(0.604493678,0.124079302,0.565849483,0.0);
ImmCB_0[11] = vec4(-0.582487881,0.0530675016,0.606806874,0.0);
ImmCB_0[12] = vec4(-0.505956173,0.266293496,0.623088717,0.0);
ImmCB_0[13] = vec4(-0.394376993,-0.594162285,0.435511112,0.0);
ImmCB_0[14] = vec4(0.208382294,0.731067896,0.367852092,0.0);
ImmCB_0[15] = vec4(-0.488620102,0.117372103,0.704302788,0.0);
ImmCB_0[16] = vec4(-0.242089793,0.777586222,0.287427008,0.0);
ImmCB_0[17] = vec4(-0.193105206,-0.179230794,0.915579975,0.0);
ImmCB_0[18] = vec4(0.327477992,-0.0105581796,0.870455921,0.0);
ImmCB_0[19] = vec4(-0.865494013,-0.497614712,0.00259370892,0.0);
ImmCB_0[20] = vec4(-0.652793586,-0.36415121,0.386318803,0.0);
ImmCB_0[21] = vec4(-0.827349007,0.345688611,0.161607295,0.0);
ImmCB_0[22] = vec4(-0.240272403,0.449280411,0.69648391,0.0);
ImmCB_0[23] = vec4(-0.752400279,0.623399615,0.0359563306,0.0);
ImmCB_0[24] = vec4(-0.393842012,0.230016604,0.754157424,0.0);
ImmCB_0[25] = vec4(0.374391407,0.885137022,0.0611285903,0.0);
ImmCB_0[26] = vec4(-0.434743404,0.298079103,0.676354408,0.0);
ImmCB_0[27] = vec4(0.0253061391,0.961220622,0.0603545606,0.0);
ImmCB_0[28] = vec4(0.0449642986,0.89035368,0.169625506,0.0);
ImmCB_0[29] = vec4(0.408700198,0.785221517,0.179325804,0.0);
ImmCB_0[30] = vec4(0.181823701,-0.268358201,0.873144388,0.0);
    u_xlat0.x = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<30 ; u_xlati_loop_1++)
    {
        u_xlat2.xy = ImmCB_0[u_xlati_loop_1].xy * vec2(_AOShadowRadius) + vs_TEXCOORD0.xy;
        u_xlat16_2 = texture(_MainTex, u_xlat2.xy).x;
        u_xlat2.x = (-u_xlat16_2) + 1.0;
        u_xlat2.x = (-u_xlat2.x) + ImmCB_0[u_xlati_loop_1].z;
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat0.x = u_xlat2.x + u_xlat0.x;
    }
    u_xlat0.x = (-u_xlat0.x) * 0.0690661147 + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlat0.xyz = exp2(u_xlat0.xxx);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
vec4 ImmCB_0[31];
uniform 	float _AOShadowRadius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
ImmCB_0[0] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[1] = vec4(0.520261526,-0.158384502,0.656779885,0.0);
ImmCB_0[2] = vec4(-0.612989008,-0.0200189091,0.57073611,0.0);
ImmCB_0[3] = vec4(-0.2168715,-0.654387712,0.468778491,0.0);
ImmCB_0[4] = vec4(-0.338378906,0.508706689,0.573759615,0.0);
ImmCB_0[5] = vec4(-0.311143786,0.0955148563,0.872131586,0.0);
ImmCB_0[6] = vec4(0.33586821,0.445185691,0.640237629,0.0);
ImmCB_0[7] = vec4(0.240833193,-0.416449487,0.727814317,0.0);
ImmCB_0[8] = vec4(-0.962644875,-0.135864601,0.043677099,0.0);
ImmCB_0[9] = vec4(0.00912603829,-0.673168182,0.491044998,0.0);
ImmCB_0[10] = vec4(0.604493678,0.124079302,0.565849483,0.0);
ImmCB_0[11] = vec4(-0.582487881,0.0530675016,0.606806874,0.0);
ImmCB_0[12] = vec4(-0.505956173,0.266293496,0.623088717,0.0);
ImmCB_0[13] = vec4(-0.394376993,-0.594162285,0.435511112,0.0);
ImmCB_0[14] = vec4(0.208382294,0.731067896,0.367852092,0.0);
ImmCB_0[15] = vec4(-0.488620102,0.117372103,0.704302788,0.0);
ImmCB_0[16] = vec4(-0.242089793,0.777586222,0.287427008,0.0);
ImmCB_0[17] = vec4(-0.193105206,-0.179230794,0.915579975,0.0);
ImmCB_0[18] = vec4(0.327477992,-0.0105581796,0.870455921,0.0);
ImmCB_0[19] = vec4(-0.865494013,-0.497614712,0.00259370892,0.0);
ImmCB_0[20] = vec4(-0.652793586,-0.36415121,0.386318803,0.0);
ImmCB_0[21] = vec4(-0.827349007,0.345688611,0.161607295,0.0);
ImmCB_0[22] = vec4(-0.240272403,0.449280411,0.69648391,0.0);
ImmCB_0[23] = vec4(-0.752400279,0.623399615,0.0359563306,0.0);
ImmCB_0[24] = vec4(-0.393842012,0.230016604,0.754157424,0.0);
ImmCB_0[25] = vec4(0.374391407,0.885137022,0.0611285903,0.0);
ImmCB_0[26] = vec4(-0.434743404,0.298079103,0.676354408,0.0);
ImmCB_0[27] = vec4(0.0253061391,0.961220622,0.0603545606,0.0);
ImmCB_0[28] = vec4(0.0449642986,0.89035368,0.169625506,0.0);
ImmCB_0[29] = vec4(0.408700198,0.785221517,0.179325804,0.0);
ImmCB_0[30] = vec4(0.181823701,-0.268358201,0.873144388,0.0);
    u_xlat0.x = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<30 ; u_xlati_loop_1++)
    {
        u_xlat2.xy = ImmCB_0[u_xlati_loop_1].xy * vec2(_AOShadowRadius) + vs_TEXCOORD0.xy;
        u_xlat16_2 = texture(_MainTex, u_xlat2.xy).x;
        u_xlat2.x = (-u_xlat16_2) + 1.0;
        u_xlat2.x = (-u_xlat2.x) + ImmCB_0[u_xlati_loop_1].z;
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat0.x = u_xlat2.x + u_xlat0.x;
    }
    u_xlat0.x = (-u_xlat0.x) * 0.0690661147 + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlat0.xyz = exp2(u_xlat0.xxx);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
vec4 ImmCB_0[31];
uniform 	float _AOShadowRadius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
int u_xlati1;
vec2 u_xlat2;
mediump float u_xlat16_2;
bool u_xlatb2;
void main()
{
ImmCB_0[0] = vec4(0.0,0.0,1.0,0.0);
ImmCB_0[1] = vec4(0.520261526,-0.158384502,0.656779885,0.0);
ImmCB_0[2] = vec4(-0.612989008,-0.0200189091,0.57073611,0.0);
ImmCB_0[3] = vec4(-0.2168715,-0.654387712,0.468778491,0.0);
ImmCB_0[4] = vec4(-0.338378906,0.508706689,0.573759615,0.0);
ImmCB_0[5] = vec4(-0.311143786,0.0955148563,0.872131586,0.0);
ImmCB_0[6] = vec4(0.33586821,0.445185691,0.640237629,0.0);
ImmCB_0[7] = vec4(0.240833193,-0.416449487,0.727814317,0.0);
ImmCB_0[8] = vec4(-0.962644875,-0.135864601,0.043677099,0.0);
ImmCB_0[9] = vec4(0.00912603829,-0.673168182,0.491044998,0.0);
ImmCB_0[10] = vec4(0.604493678,0.124079302,0.565849483,0.0);
ImmCB_0[11] = vec4(-0.582487881,0.0530675016,0.606806874,0.0);
ImmCB_0[12] = vec4(-0.505956173,0.266293496,0.623088717,0.0);
ImmCB_0[13] = vec4(-0.394376993,-0.594162285,0.435511112,0.0);
ImmCB_0[14] = vec4(0.208382294,0.731067896,0.367852092,0.0);
ImmCB_0[15] = vec4(-0.488620102,0.117372103,0.704302788,0.0);
ImmCB_0[16] = vec4(-0.242089793,0.777586222,0.287427008,0.0);
ImmCB_0[17] = vec4(-0.193105206,-0.179230794,0.915579975,0.0);
ImmCB_0[18] = vec4(0.327477992,-0.0105581796,0.870455921,0.0);
ImmCB_0[19] = vec4(-0.865494013,-0.497614712,0.00259370892,0.0);
ImmCB_0[20] = vec4(-0.652793586,-0.36415121,0.386318803,0.0);
ImmCB_0[21] = vec4(-0.827349007,0.345688611,0.161607295,0.0);
ImmCB_0[22] = vec4(-0.240272403,0.449280411,0.69648391,0.0);
ImmCB_0[23] = vec4(-0.752400279,0.623399615,0.0359563306,0.0);
ImmCB_0[24] = vec4(-0.393842012,0.230016604,0.754157424,0.0);
ImmCB_0[25] = vec4(0.374391407,0.885137022,0.0611285903,0.0);
ImmCB_0[26] = vec4(-0.434743404,0.298079103,0.676354408,0.0);
ImmCB_0[27] = vec4(0.0253061391,0.961220622,0.0603545606,0.0);
ImmCB_0[28] = vec4(0.0449642986,0.89035368,0.169625506,0.0);
ImmCB_0[29] = vec4(0.408700198,0.785221517,0.179325804,0.0);
ImmCB_0[30] = vec4(0.181823701,-0.268358201,0.873144388,0.0);
    u_xlat0.x = float(0.0);
    for(int u_xlati_loop_1 = int(0) ; u_xlati_loop_1<30 ; u_xlati_loop_1++)
    {
        u_xlat2.xy = ImmCB_0[u_xlati_loop_1].xy * vec2(_AOShadowRadius) + vs_TEXCOORD0.xy;
        u_xlat16_2 = texture(_MainTex, u_xlat2.xy).x;
        u_xlat2.x = (-u_xlat16_2) + 1.0;
        u_xlat2.x = (-u_xlat2.x) + ImmCB_0[u_xlati_loop_1].z;
        u_xlat2.x = max(u_xlat2.x, 0.0);
        u_xlat0.x = u_xlat2.x + u_xlat0.x;
    }
    u_xlat0.x = (-u_xlat0.x) * 0.0690661147 + 1.0;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * 1.5;
    u_xlat0.xyz = exp2(u_xlat0.xxx);
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}