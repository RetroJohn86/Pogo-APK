//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ARCoreFrameLegacy" {
Properties {
_texture ("Texture", 2D) = "black" { }
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  ZWrite Off
  Cull Off
  GpuProgramID 12620
Program "vp" {
SubProgram "gles " {
"#version 100
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

#line 31

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma exclude_renderers gles3

        // #extension GL_OES_EGL_image_external : enable
        
        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        uniform mat4 _displayTransform;
        varying vec2 _colorUV;

        void main()
        {
            #if defined(SHADER_API_GLES)
            vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
            _colorUV = (_displayTransform * texCoord).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;

        
        varying vec2 _colorUV;

        // Currently, we render camera images using a cached version of the native texture.
        // We don't require an OES sampler for the cached texture.
        // uniform samplerExternalOES _texture;
        uniform sampler2D _texture;

        void main()
        {
          #if defined(SHADER_API_GLES)
          gl_FragColor = texture(_texture, _colorUV);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
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

#line 30

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma exclude_renderers gles3

        // #extension GL_OES_EGL_image_external : enable
        
        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        uniform mat4 _displayTransform;
        varying vec2 _colorUV;

        void main()
        {
            #if defined(SHADER_API_GLES)
            vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
            _colorUV = (_displayTransform * texCoord).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;

        
        varying vec2 _colorUV;

        // Currently, we render camera images using a cached version of the native texture.
        // We don't require an OES sampler for the cached texture.
        // uniform samplerExternalOES _texture;
        uniform sampler2D _texture;

        void main()
        {
          #if defined(SHADER_API_GLES)
          gl_FragColor = texture(_texture, _colorUV);
          #endif
        }

        
#endif"
}
SubProgram "gles " {
"#version 100
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

#line 30

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 15
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

        // #pragma exclude_renderers gles3

        // #extension GL_OES_EGL_image_external : enable
        
        
        
        

#ifdef VERTEX
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;


        uniform mat4 _displayTransform;
        varying vec2 _colorUV;

        void main()
        {
            #if defined(SHADER_API_GLES)
            vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
            _colorUV = (_displayTransform * texCoord).xy;
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            #endif
        }

        
#endif
#ifdef FRAGMENT
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
precision highp int;

        
        varying vec2 _colorUV;

        // Currently, we render camera images using a cached version of the native texture.
        // We don't require an OES sampler for the cached texture.
        // uniform samplerExternalOES _texture;
        uniform sampler2D _texture;

        void main()
        {
          #if defined(SHADER_API_GLES)
          gl_FragColor = texture(_texture, _colorUV);
          #endif
        }

        
#endif"
}
}
}
}
}