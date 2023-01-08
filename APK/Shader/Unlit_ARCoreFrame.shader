//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/ARCoreFrame" {
Properties {
_textureDepthSuppressionMask ("Depth Suppresion Mask", 2D) = "black" { }
_textureDepth ("Depth", 2D) = "black" { }
_texture ("Texture", 2D) = "black" { }
}
SubShader {
 Tags { "FORCENOSHADOWCASTING" = "true" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  LOD 100
  Tags { "FORCENOSHADOWCASTING" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Background" "RenderType" = "Background" }
  ZTest Always
  Cull Off
  GpuProgramID 60374
Program "vp" {
SubProgram "gles3 " {
"#version 300 es
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
"#version 300 es
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

#line 51

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
"#version 300 es
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

#line 51

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" }
"#version 300 es
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
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" }
"#version 300 es
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
#define DEPTH_DEBUG 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" }
"#version 300 es
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
#define DEPTH_DEBUG 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" }
"#version 300 es
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
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
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

#line 52

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 55

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
SubProgram "gles3 " {
Local Keywords { "DEPTH_DEBUG" "DEPTH_SUPPRESSION" "DEPTH_ZWRITE" }
"#version 300 es
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
#define DEPTH_ZWRITE 1
#define DEPTH_SUPPRESSION 1
#define DEPTH_DEBUG 1
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

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 28
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif
/* UNITY: Original start of shader */

            // #pragma multi_compile_local __ DEPTH_ZWRITE
            // #pragma multi_compile_local __ DEPTH_SUPPRESSION
            // #pragma multi_compile_local __ DEPTH_DEBUG

            // #pragma only_renderers gles3

            #line 1
#ifndef UNITY_CG_INCLUDED
#define UNITY_CG_INCLUDED

// -------------------------------------------------------------------
// Common functions

float saturate(float x)
{
    return max(0.0, min(1.0, x));
}


// -------------------------------------------------------------------
//  builtin values exposed from Unity

// Time values from Unity
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;

// x = 1 or -1 (-1 if projection is flipped)
// y = near plane
// z = far plane
// w = 1/far plane
uniform vec4 _ProjectionParams;

// x = width
// y = height
// z = 1 + 1.0/width
// w = 1 + 1.0/height
uniform vec4 _ScreenParams;

uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _WorldSpaceLightPos0;

uniform vec4 _LightPositionRange; // xyz = pos, w = 1/range

// -------------------------------------------------------------------
//  helper functions and macros used in many standard shaders

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE
#define USING_DIRECTIONAL_LIGHT
#endif

#if defined DIRECTIONAL || defined DIRECTIONAL_COOKIE || defined POINT || defined SPOT || defined POINT_NOATT || defined POINT_COOKIE
#define USING_LIGHT_MULTI_COMPILE
#endif


// VERTEX



// Calculates UV offset for parallax bump mapping
vec2 ParallaxOffset( float h, float height, vec3 viewDir )
{
    h = h * height - height/2.0;
    vec3 v = normalize(viewDir);
    v.z += 0.42;
    return h * (v.xy / v.z);
}


// Converts color to luminance (grayscale)
float Luminance( vec3 c )
{
    return dot( c, vec3(0.22, 0.707, 0.071) );
}


#endif

#line 38


            // #ifdef SHADER_API_GLES3
            // #extension GL_OES_EGL_image_external_essl3 : require
            // #endif
            


            

#ifdef VERTEX
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_TexCoord _glesTexCoord
out highp vec4 _glesTexCoord[1];


// Computes world space light direction
vec3 WorldSpaceLightDir( vec4 v )
{
    vec3 worldPos = (unity_ObjectToWorld * v).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return _WorldSpaceLightPos0.xyz - worldPos * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return _WorldSpaceLightPos0.xyz - worldPos;
        #else
        return _WorldSpaceLightPos0.xyz;
        #endif
    #endif
}

// Computes object space light direction
vec3 ObjSpaceLightDir( vec4 v )
{
    vec3 objSpaceLightPos = (unity_WorldToObject * _WorldSpaceLightPos0).xyz;
    #ifndef USING_LIGHT_MULTI_COMPILE
        return objSpaceLightPos.xyz - v.xyz * _WorldSpaceLightPos0.w;
    #else
        #ifndef USING_DIRECTIONAL_LIGHT
        return objSpaceLightPos.xyz - v.xyz;
        #else
        return objSpaceLightPos.xyz;
        #endif
    #endif
}

// Computes world space view direction
vec3 WorldSpaceViewDir( vec4 v )
{
    return _WorldSpaceCameraPos.xyz - (unity_ObjectToWorld * v).xyz;
}

// Computes object space view direction
vec3 ObjSpaceViewDir( vec4 v )
{
    vec3 objSpaceCameraPos = (unity_WorldToObject * vec4(_WorldSpaceCameraPos.xyz, 1.0)).xyz;
    return objSpaceCameraPos - v.xyz;
}

// Declares 3x3 matrix 'rotation', filled with tangent space basis
// Do not use multiline define here, nVidia OpenGL drivers are buggy in parsing that.
#define TANGENT_SPACE_ROTATION vec3 binormal = cross( gl_Normal.xyz, Tangent.xyz ) * Tangent.w; mat3 rotation = mat3( Tangent.x, binormal.x, gl_Normal.x, Tangent.y, binormal.y, gl_Normal.y, Tangent.z, binormal.z, gl_Normal.z );


// Transforms float2 UV by scale/bias property (new method)
// GLSL ES does not support ## concat operator so we also provide macro that expects xxx_ST
#define TRANSFORM_TEX_ST(tex,namest) (tex.xy * namest.xy + namest.zw)
#ifndef GL_ES
    #define TRANSFORM_TEX(tex,name) TRANSFORM_TEX_ST(tex, name##_ST)
#endif

// Deprecated. Used to transform 4D UV by a fixed function texture matrix. Now just returns the passed UV.
#define TRANSFORM_UV(idx) (gl_TexCoord[0].xy)



            // Transform used to sample the color planes
            uniform mat4 _displayTransform;

            // Transform used to sample the context awareness textures
            uniform mat4 _depthTransform;
            uniform mat4 _semanticsTransform;

            // Transformed UVs
            out vec2 _colorUV;
            out vec3 _depthUV;
            out vec3 _semanticsUV;

            void main()
            {
                #ifdef SHADER_API_GLES3
                
                // Transform UVs for the color texture
                vec4 texCoord = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 0.0f, 1.0f);
                _colorUV = (_displayTransform * texCoord).xy;

                #ifdef DEPTH_ZWRITE

                // Transform UVs for the context awareness textures
                vec4 uv = vec4(gl_MultiTexCoord0.x, gl_MultiTexCoord0.y, 1.0f, 1.0f);
                _depthUV = (_depthTransform * uv).xyz;

                #ifdef DEPTH_SUPPRESSION
                _semanticsUV = (_semanticsTransform * uv).xyz;
                #endif

                #endif

                // Transform vertex position
                gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
                
                #endif
            }

#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragColor
layout(location = 0) out mediump vec4 _glesFragColor;

precision highp float;


            // Transformed texture coordinates
            in vec2 _colorUV;
            in vec3 _depthUV;
            in vec3 _semanticsUV;

            // Depth range used for scaling
            uniform float _depthScaleMin;
            uniform float _depthScaleMax;

            uniform sampler2D _textureDepth;
            uniform sampler2D _textureDepthSuppressionMask;

            // Currently, we render camera images using a cached version of the native texture.
            // We don't require an OES sampler for the cached texture.
            // uniform samplerExternalOES _texture;
            uniform sampler2D _texture;

#if defined(SHADER_API_GLES3) && defined(DEPTH_ZWRITE)

            uniform vec4 _ZBufferParams;
            
            // Inverse of LinearEyeDepth
            float EyeDepthToNonLinear(float eyeDepth)
            {   
                return (1.0f - (eyeDepth * _ZBufferParams.w)) / (eyeDepth * _ZBufferParams.z);
            }         
#endif            
            void main()
            {      
#ifdef SHADER_API_GLES3

                // Sample color
                vec4 color = texture(_texture, _colorUV);

                // Reset depth
                float depth = 1.0f;

    #ifdef DEPTH_ZWRITE
    #ifdef DEPTH_SUPPRESSION
                    // If depth is not suppressed at this pixel
                    vec2 semanticsUV = vec2(_semanticsUV.x / _semanticsUV.z, _semanticsUV.y / _semanticsUV.z);
                    if (texture(_textureDepthSuppressionMask, semanticsUV).x == 0.0f)
    #endif
                    {
                        // Sample depth
                        vec2 depthUV = vec2(_depthUV.x / _depthUV.z, _depthUV.y / _depthUV.z);
                        float rawDepth = texture(_textureDepth, depthUV).x;

                        // Scale depth in case it is normalized
                        // Note: If depth is not normalized, min and max should
                        // be 0 and 1 respectively to leave the value intact
                        float scaledDepth = rawDepth * (_depthScaleMax - _depthScaleMin) + _depthScaleMin;

                        // Convert depth to z-value and write the zbuffer
                        depth = EyeDepthToNonLinear(scaledDepth);

                        #ifdef DEPTH_DEBUG
                        // Write disparity to the color channels for debug purposes
                        float MAX_VIEW_DISP = 4.0f;
                        float scaledDisparity = 1.0f/scaledDepth;
                        float normDisparity = scaledDisparity/MAX_VIEW_DISP;
                        color = vec4(normDisparity, normDisparity, normDisparity, 1.0f);
                        #endif 
                    }     
    #endif
                gl_FragColor = color;
                gl_FragDepth = depth;
#endif
            }


#endif"
}
}
}
}
Fallback "Unlit/ARCoreFrameLegacy"
}