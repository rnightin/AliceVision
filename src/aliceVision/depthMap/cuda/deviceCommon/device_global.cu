// This file is part of the AliceVision project.
// Copyright (c) 2017 AliceVision contributors.
// This Source Code Form is subject to the terms of the Mozilla Public License,
// v. 2.0. If a copy of the MPL was not distributed with this file,
// You can obtain one at https://mozilla.org/MPL/2.0/.

#pragma once

#include <aliceVision/depthMap/cuda/commonStructures.hpp>

namespace aliceVision {
namespace depthMap {

// Helper functions
// function clamping x between a and b
__device__ int clamp(int x, int a, int b)
{
    return max(a, min(b, x));
}


// Global data handlers and parameters
// defines

texture<unsigned char, 2, cudaReadModeNormalizedFloat> rtex;
texture<unsigned char, 2, cudaReadModeNormalizedFloat> ttex;
texture<unsigned char, 2, cudaReadModeNormalizedFloat> gtex;
texture<unsigned char, 2, cudaReadModeNormalizedFloat> btex;

texture<uchar4, 2, cudaReadModeNormalizedFloat> r4tex;
texture<uchar4, 2, cudaReadModeNormalizedFloat> t4tex;

texture<unsigned char, 2, cudaReadModeNormalizedFloat> wshtex;
texture<float, 2, cudaReadModeElementType> watex;

////////////////////////////////////////////////////////////////////////////////
// CONSTANT MEMORY

// MATLAB: x = [-2:2]; delta = 1; y = exp( - (x .* x) / (2 * delta * delta)); format long g; y
__device__ __constant__ float gauss5[5] = {0.135335283236613f, 0.606530659712633f, 1.0f, 0.606530659712633f,
                                           0.135335283236613f};
__device__ __constant__ float sumGauss55 = 6.16892408102888f;

// MATLAB: distFcnHeight=1.0; maxDist = 0.3;  dist = 0:0.01:1; y =
// 1-distFcnHeight*exp(-(dist.*dist)/(2*maxDist*maxDist)); plot(dist,y);
// MATLAB: distFcnHeight=1.0; maxDist = 0.3;  dist = 0:0.25:1; y =
// 1-distFcnHeight*exp(-(dist.*dist)/(2*maxDist*maxDist)); plot(dist,y); int32(125*y)
__device__ __constant__ unsigned char distFcnConst5[5] = {0, 37, 94, 120, 125};

// MATLAB: distFcnHeight=1.0; maxDist = 0.3;  dist = 0:1/2:1; y =
// 1-distFcnHeight*exp(-(dist.*dist)/(2*maxDist*maxDist)); plot(dist,y); int32(125*y)
__device__ __constant__ unsigned char distFcnConst3[3] = {0, 94, 125};

#define BLOCK_DIM 8

// cameras matrices

__device__ __constant__ DeviceCameraStructBase sg_s_r;
__device__ __constant__ DeviceCameraStructBase sg_s_t;

} // namespace depthMap
} // namespace aliceVision

