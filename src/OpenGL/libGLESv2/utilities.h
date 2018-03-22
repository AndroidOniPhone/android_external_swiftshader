// Copyright 2016 The SwiftShader Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// utilities.h: Conversion functions and other utility routines.

#ifndef LIBGLESV2_UTILITIES_H
#define LIBGLESV2_UTILITIES_H

#include "Device.hpp"
#include "common/Image.hpp"
#include "Texture.h"

#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <GL/glcorearb.h>
#include <GL/glext.h>

#include <string>

namespace es2
{
	struct Color;
	class Framebuffer;

	unsigned int UniformComponentCount(GLenum type);
	GLenum UniformComponentType(GLenum type);
	size_t UniformTypeSize(GLenum type);
	bool IsSamplerUniform(GLenum type);
	int VariableRowCount(GLenum type);
	int VariableColumnCount(GLenum type);
	int VariableRegisterCount(GLenum type);
	int VariableRegisterSize(GLenum type);

	int AllocateFirstFreeBits(unsigned int *bits, unsigned int allocationSize, unsigned int bitsSize);

	bool IsCompressed(GLint intenalformat, GLint clientVersion);
	bool IsSizedInternalFormat(GLint internalformat);   // Not compressed.
	GLenum ValidateSubImageParams(bool compressed, bool copy, GLenum target, GLint level, GLint xoffset, GLint yoffset,
	                              GLsizei width, GLsizei height, GLenum format, GLenum type, Texture *texture, GLint clientVersion);
	GLenum ValidateSubImageParams(bool compressed, bool copy, GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset,
	                              GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, Texture *texture, GLint clientVersion);
	bool ValidateCopyFormats(GLenum textureFormat, GLenum colorbufferFormat);
	bool IsValidReadPixelsFormatType(const Framebuffer *framebuffer, GLenum format, GLenum type, GLint clientVersion);
	bool IsDepthTexture(GLenum format);
	bool IsStencilTexture(GLenum format);
	bool IsCubemapTextureTarget(GLenum target);
	int CubeFaceIndex(GLenum cubeTarget);
	bool IsTextureTarget(GLenum target);
	GLenum ValidateTextureFormatType(GLenum format, GLenum type, GLint internalformat, GLenum target, GLint clientVersion);
	size_t GetTypeSize(GLenum type);

	bool IsColorRenderable(GLint internalformat, GLint clientVersion);
	bool IsDepthRenderable(GLint internalformat, GLint clientVersion);
	bool IsStencilRenderable(GLint internalformat, GLint clientVersion);
	bool IsMipmappable(GLint internalformat, GLint clientVersion);

	GLuint GetAlphaSize(GLint internalformat);
	GLuint GetRedSize(GLint internalformat);
	GLuint GetGreenSize(GLint internalformat);
	GLuint GetBlueSize(GLint internalformat);
	GLuint GetDepthSize(GLint internalformat);
	GLuint GetStencilSize(GLint internalformat);

	GLenum GetColorComponentType(GLint internalformat);
	GLenum GetComponentType(GLint internalformat, GLenum attachment);
	bool IsNormalizedInteger(GLint internalformat);
	bool IsNonNormalizedInteger(GLint internalformat);
	bool IsFloatFormat(GLint internalformat);
	bool IsSignedNonNormalizedInteger(GLint internalformat);
	bool IsUnsignedNonNormalizedInteger(GLint internalformat);
	GLenum GetColorEncoding(GLint internalformat);

	// Parse the base uniform name and array index.  Returns the base name of the uniform. outSubscript is
	// set to GL_INVALID_INDEX if the provided name is not an array or the array index is invalid.
	std::string ParseUniformName(const std::string &name, unsigned int *outSubscript);
}

namespace es2sw
{
	sw::DepthCompareMode ConvertDepthComparison(GLenum comparison);
	sw::StencilCompareMode ConvertStencilComparison(GLenum comparison);
	sw::Color<float> ConvertColor(es2::Color color);
	sw::BlendFactor ConvertBlendFunc(GLenum blend);
	sw::BlendOperation ConvertBlendOp(GLenum blendOp);
	sw::LogicalOperation ConvertLogicalOperation(GLenum logicalOperation);
	sw::StencilOperation ConvertStencilOp(GLenum stencilOp);
	sw::AddressingMode ConvertTextureWrap(GLenum wrap);
	sw::CompareFunc ConvertCompareFunc(GLenum compareFunc, GLenum compareMode);
	sw::SwizzleType ConvertSwizzleType(GLenum swizzleType);
	sw::CullMode ConvertCullMode(GLenum cullFace, GLenum frontFace);
	unsigned int ConvertColorMask(bool red, bool green, bool blue, bool alpha);
	sw::MipmapType ConvertMipMapFilter(GLenum minFilter);
	sw::FilterType ConvertTextureFilter(GLenum minFilter, GLenum magFilter, float maxAnisotropy);
	bool ConvertPrimitiveType(GLenum primitiveType, GLsizei elementCount,  GLenum elementType, sw::DrawType &swPrimitiveType, int &primitiveCount, int &verticesPerPrimitive);
}

namespace sw2es
{
	GLenum ConvertBackBufferFormat(sw::Format format);
	GLenum ConvertDepthStencilFormat(sw::Format format);
}

#endif  // LIBGLESV2_UTILITIES_H
