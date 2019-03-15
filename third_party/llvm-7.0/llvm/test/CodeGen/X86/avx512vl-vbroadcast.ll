; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+avx512f -mattr=+avx512vl| FileCheck %s

declare void @func_f32(float)
define <8 x float> @_256_broadcast_ss_spill(float %x) {
; CHECK-LABEL: _256_broadcast_ss_spill:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    vaddss %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq func_f32
; CHECK-NEXT:    vbroadcastss (%rsp), %ymm0 # 16-byte Folded Reload
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %a  = fadd float %x, %x
  call void @func_f32(float %a)
  %b = insertelement <8 x float> undef, float %a, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> undef, <8 x i32> zeroinitializer
  ret <8 x float> %c
}

define <4 x float> @_128_broadcast_ss_spill(float %x) {
; CHECK-LABEL: _128_broadcast_ss_spill:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    vaddss %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovaps %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq func_f32
; CHECK-NEXT:    vbroadcastss (%rsp), %xmm0 # 16-byte Folded Reload
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %a  = fadd float %x, %x
  call void @func_f32(float %a)
  %b = insertelement <4 x float> undef, float %a, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %c
}

declare void @func_f64(double)
define <4 x double> @_256_broadcast_sd_spill(double %x) {
; CHECK-LABEL: _256_broadcast_sd_spill:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    vaddsd %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovapd %xmm0, (%rsp) # 16-byte Spill
; CHECK-NEXT:    callq func_f64
; CHECK-NEXT:    vbroadcastsd (%rsp), %ymm0 # 16-byte Folded Reload
; CHECK-NEXT:    addq $24, %rsp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  %a  = fadd double %x, %x
  call void @func_f64(double %a)
  %b = insertelement <4 x double> undef, double %a, i32 0
  %c = shufflevector <4 x double> %b, <4 x double> undef, <4 x i32> zeroinitializer
  ret <4 x double> %c
}

define   <8 x float> @_inreg8xfloat(float %a) {
; CHECK-LABEL: _inreg8xfloat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vbroadcastss %xmm0, %ymm0
; CHECK-NEXT:    retq
  %b = insertelement <8 x float> undef, float %a, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> undef, <8 x i32> zeroinitializer
  ret <8 x float> %c
}

define   <8 x float> @_ss8xfloat_mask(<8 x float> %i, float %a, <8 x i32> %mask1) {
; CHECK-LABEL: _ss8xfloat_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %ymm2, %ymm2, %k1
; CHECK-NEXT:    vbroadcastss %xmm1, %ymm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i32> %mask1, zeroinitializer
  %b = insertelement <8 x float> undef, float %a, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> undef, <8 x i32> zeroinitializer
  %r = select <8 x i1> %mask, <8 x float> %c, <8 x float> %i
  ret <8 x float> %r
}

define   <8 x float> @_ss8xfloat_maskz(float %a, <8 x i32> %mask1) {
; CHECK-LABEL: _ss8xfloat_maskz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %ymm1, %ymm1, %k1
; CHECK-NEXT:    vbroadcastss %xmm0, %ymm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i32> %mask1, zeroinitializer
  %b = insertelement <8 x float> undef, float %a, i32 0
  %c = shufflevector <8 x float> %b, <8 x float> undef, <8 x i32> zeroinitializer
  %r = select <8 x i1> %mask, <8 x float> %c, <8 x float> zeroinitializer
  ret <8 x float> %r
}

define   <4 x float> @_inreg4xfloat(float %a) {
; CHECK-LABEL: _inreg4xfloat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vbroadcastss %xmm0, %xmm0
; CHECK-NEXT:    retq
  %b = insertelement <4 x float> undef, float %a, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> undef, <4 x i32> zeroinitializer
  ret <4 x float> %c
}

define   <4 x float> @_ss4xfloat_mask(<4 x float> %i, float %a, <4 x i32> %mask1) {
; CHECK-LABEL: _ss4xfloat_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %xmm2, %xmm2, %k1
; CHECK-NEXT:    vbroadcastss %xmm1, %xmm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <4 x i32> %mask1, zeroinitializer
  %b = insertelement <4 x float> undef, float %a, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> undef, <4 x i32> zeroinitializer
  %r = select <4 x i1> %mask, <4 x float> %c, <4 x float> %i
  ret <4 x float> %r
}

define   <4 x float> @_ss4xfloat_maskz(float %a, <4 x i32> %mask1) {
; CHECK-LABEL: _ss4xfloat_maskz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %xmm1, %xmm1, %k1
; CHECK-NEXT:    vbroadcastss %xmm0, %xmm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <4 x i32> %mask1, zeroinitializer
  %b = insertelement <4 x float> undef, float %a, i32 0
  %c = shufflevector <4 x float> %b, <4 x float> undef, <4 x i32> zeroinitializer
  %r = select <4 x i1> %mask, <4 x float> %c, <4 x float> zeroinitializer
  ret <4 x float> %r
}

define   <4 x double> @_inreg4xdouble(double %a) {
; CHECK-LABEL: _inreg4xdouble:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vbroadcastsd %xmm0, %ymm0
; CHECK-NEXT:    retq
  %b = insertelement <4 x double> undef, double %a, i32 0
  %c = shufflevector <4 x double> %b, <4 x double> undef, <4 x i32> zeroinitializer
  ret <4 x double> %c
}

define   <4 x double> @_ss4xdouble_mask(<4 x double> %i, double %a, <4 x i32> %mask1) {
; CHECK-LABEL: _ss4xdouble_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %xmm2, %xmm2, %k1
; CHECK-NEXT:    vbroadcastsd %xmm1, %ymm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <4 x i32> %mask1, zeroinitializer
  %b = insertelement <4 x double> undef, double %a, i32 0
  %c = shufflevector <4 x double> %b, <4 x double> undef, <4 x i32> zeroinitializer
  %r = select <4 x i1> %mask, <4 x double> %c, <4 x double> %i
  ret <4 x double> %r
}

define   <4 x double> @_ss4xdouble_maskz(double %a, <4 x i32> %mask1) {
; CHECK-LABEL: _ss4xdouble_maskz:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmd %xmm1, %xmm1, %k1
; CHECK-NEXT:    vbroadcastsd %xmm0, %ymm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <4 x i32> %mask1, zeroinitializer
  %b = insertelement <4 x double> undef, double %a, i32 0
  %c = shufflevector <4 x double> %b, <4 x double> undef, <4 x i32> zeroinitializer
  %r = select <4 x i1> %mask, <4 x double> %c, <4 x double> zeroinitializer
  ret <4 x double> %r
}

define <2 x double> @test_v2f64_broadcast_fold(<2 x double> *%a0, <2 x double> %a1) {
; CHECK-LABEL: test_v2f64_broadcast_fold:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vaddpd (%rdi){1to2}, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %1 = load <2 x double>, <2 x double> *%a0, align 16
  %2 = shufflevector <2 x double> %1, <2 x double> undef, <2 x i32> zeroinitializer
  %3 = fadd <2 x double> %2, %a1
  ret <2 x double> %3
}

define <2 x double> @test_v2f64_broadcast_fold_mask(<2 x double> *%a0, <2 x double> %a1, <2 x i64> %mask1, <2 x double> %a2) {
; CHECK-LABEL: test_v2f64_broadcast_fold_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmq %xmm1, %xmm1, %k1
; CHECK-NEXT:    vaddpd (%rdi){1to2}, %xmm0, %xmm2 {%k1}
; CHECK-NEXT:    vmovapd %xmm2, %xmm0
; CHECK-NEXT:    retq
  %mask = icmp ne <2 x i64> %mask1, zeroinitializer
  %1 = load <2 x double>, <2 x double> *%a0, align 16
  %2 = shufflevector <2 x double> %1, <2 x double> undef, <2 x i32> zeroinitializer
  %3 = fadd <2 x double> %2, %a1
  %4 = select <2 x i1> %mask, <2 x double> %3, <2 x double> %a2
  ret <2 x double> %4
}
