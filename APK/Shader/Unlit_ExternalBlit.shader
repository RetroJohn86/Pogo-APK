//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ExternalBlit" {
Properties {
_texture ("Main Texture", 2D) = "white" { }
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 43835
Program "vp" {
SubProgram "gles " {
"#version 100
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 25
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 33

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


            varying vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;


            uniform samplerExternalOES _texture;
            varying vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
SubProgram "gles3 " {
"#version 300 es
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF3 1
#define UNITY_NO_FULL_STANDARD_SHADER 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER1 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define SHADER_API_GLES30 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 35
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS10
    #define SHADER_AVAILABLE_INTERPOLATORS10 1
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS15
    #define SHADER_AVAILABLE_INTERPOLATORS15 1
#endif
#ifndef SHADER_AVAILABLE_INTEGERS
    #define SHADER_AVAILABLE_INTEGERS 1
#endif
#ifndef SHADER_AVAILABLE_MRT4
    #define SHADER_AVAILABLE_MRT4 1
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_SAMPLELOD
    #define SHADER_AVAILABLE_SAMPLELOD 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_AVAILABLE_2DARRAY
    #define SHADER_AVAILABLE_2DARRAY 1
#endif
#ifndef SHADER_AVAILABLE_INSTANCING
    #define SHADER_AVAILABLE_INSTANCING 1
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 54

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;


            out vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            uniform samplerExternalOES _texture;
            in vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
SubProgram "gles " {
"#version 100
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 25
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 32

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


            varying vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;


            uniform samplerExternalOES _texture;
            varying vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
SubProgram "gles3 " {
"#version 300 es
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER2 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define SHADER_API_GLES30 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 35
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS10
    #define SHADER_AVAILABLE_INTERPOLATORS10 1
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS15
    #define SHADER_AVAILABLE_INTERPOLATORS15 1
#endif
#ifndef SHADER_AVAILABLE_INTEGERS
    #define SHADER_AVAILABLE_INTEGERS 1
#endif
#ifndef SHADER_AVAILABLE_MRT4
    #define SHADER_AVAILABLE_MRT4 1
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_SAMPLELOD
    #define SHADER_AVAILABLE_SAMPLELOD 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_AVAILABLE_2DARRAY
    #define SHADER_AVAILABLE_2DARRAY 1
#endif
#ifndef SHADER_AVAILABLE_INSTANCING
    #define SHADER_AVAILABLE_INSTANCING 1
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 53

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;


            out vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            uniform samplerExternalOES _texture;
            in vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
SubProgram "gles " {
"#version 100
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 25
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 32

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


            varying vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;


            uniform samplerExternalOES _texture;
            varying vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
SubProgram "gles3 " {
"#version 300 es
#extension GL_OES_EGL_image_external_essl3 : require
#extension GL_OES_EGL_image_external : enable
#define UNITY_NO_DXT5nm 1
#define UNITY_NO_RGBM 1
#define UNITY_FRAMEBUFFER_FETCH_AVAILABLE 1
#define UNITY_NO_CUBEMAP_ARRAY 1
#define UNITY_NO_SCREENSPACE_SHADOWS 1
#define UNITY_PBS_USE_BRDF2 1
#define SHADER_API_MOBILE 1
#define UNITY_HARDWARE_TIER3 1
#define UNITY_COLORSPACE_GAMMA 1
#define UNITY_LIGHTMAP_DLDR_ENCODING 1
#define SHADER_API_GLES30 1
#ifndef SHADER_TARGET
    #define SHADER_TARGET 25
#endif
#ifndef SHADER_REQUIRE_DERIVATIVES
    #define SHADER_REQUIRE_DERIVATIVES 1
#endif
#ifndef SHADER_TARGET_AVAILABLE
    #define SHADER_TARGET_AVAILABLE 35
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS10
    #define SHADER_AVAILABLE_INTERPOLATORS10 1
#endif
#ifndef SHADER_AVAILABLE_INTERPOLATORS15
    #define SHADER_AVAILABLE_INTERPOLATORS15 1
#endif
#ifndef SHADER_AVAILABLE_INTEGERS
    #define SHADER_AVAILABLE_INTEGERS 1
#endif
#ifndef SHADER_AVAILABLE_MRT4
    #define SHADER_AVAILABLE_MRT4 1
#endif
#ifndef SHADER_AVAILABLE_DERIVATIVES
    #define SHADER_AVAILABLE_DERIVATIVES 1
#endif
#ifndef SHADER_AVAILABLE_SAMPLELOD
    #define SHADER_AVAILABLE_SAMPLELOD 1
#endif
#ifndef SHADER_AVAILABLE_FRAGCOORD
    #define SHADER_AVAILABLE_FRAGCOORD 1
#endif
#ifndef SHADER_AVAILABLE_2DARRAY
    #define SHADER_AVAILABLE_2DARRAY 1
#endif
#ifndef SHADER_AVAILABLE_INSTANCING
    #define SHADER_AVAILABLE_INSTANCING 1
#endif
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#line 1
#ifndef GLSL_SUPPORT_INCLUDED
#define GLSL_SUPPORT_INCLUDED

// Automatically included in raw GLSL (GLSLPROGRAM) shader snippets, to map from some of the legacy OpenGL
// variable names to uniform names used by Unity.

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif

uniform mat4 unity_ObjectToWorld;
uniform mat4 unity_WorldToObject;
uniform mat4 unity_MatrixVP;
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixInvV;
uniform mat4 glstate_matrix_projection;

#define gl_ModelViewProjectionMatrix        (unity_MatrixVP * unity_ObjectToWorld)
#define gl_ModelViewMatrix                  (unity_MatrixV * unity_ObjectToWorld)
#define gl_ModelViewMatrixTranspose         (transpose(unity_MatrixV * unity_ObjectToWorld))
#define gl_ModelViewMatrixInverseTranspose  (transpose(unity_WorldToObject * unity_MatrixInvV))
#define gl_NormalMatrix                     (transpose(mat3(unity_WorldToObject * unity_MatrixInvV)))
#define gl_ProjectionMatrix                 glstate_matrix_projection

#if __VERSION__ < 120
#ifndef UNITY_GLSL_STRIP_TRANSPOSE
mat3 transpose(mat3 mtx)
{
    vec3 c0 = mtx[0];
    vec3 c1 = mtx[1];
    vec3 c2 = mtx[2];

    return mat3(
        vec3(c0.x, c1.x, c2.x),
        vec3(c0.y, c1.y, c2.y),
        vec3(c0.z, c1.z, c2.z)
    );
}
mat4 transpose(mat4 mtx)
{
    vec4 c0 = mtx[0];
    vec4 c1 = mtx[1];
    vec4 c2 = mtx[2];
    vec4 c3 = mtx[3];

    return mat4(
        vec4(c0.x, c1.x, c2.x, c3.x),
        vec4(c0.y, c1.y, c2.y, c3.y),
        vec4(c0.z, c1.z, c2.z, c3.z),
        vec4(c0.w, c1.w, c2.w, c3.w)
    );
}
#endif
#endif // __VERSION__ < 120

#endif // GLSL_SUPPORT_INCLUDED

#line 53

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 27
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            #ifdef SHADER_API_GLES3
            
            #else
            
            #endif
        
            
            
            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;


            out vec2 _textureCoord;

            void main()
            {
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                _textureCoord = gl_MultiTexCoord0.xy;
            }

            
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            uniform samplerExternalOES _texture;
            in vec2 _textureCoord;

            void main()
            {
                gl_FragColor = texture(_texture, _textureCoord);
            }

            
#endif"
}
}
}
}
}