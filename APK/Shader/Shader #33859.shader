//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "" {
Properties {
_TintColor ("Tint Color", Color) = (1,1,1,1)
_GlowColor ("Edge Glow", Color) = (1,1,1,1)
_Glow ("Intensity", Range(0, 3)) = 1
}
SubShader {
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 55858
}
}
}