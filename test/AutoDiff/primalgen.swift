// RUN: %target-swift-frontend -emit-sil %s | %FileCheck %s

import TensorFlow

@inline(never)
func print<T>(_ x: T) {
  Swift.print(x)
}

func squared(_ x: Float) -> Float {
  print("test output")
  return x * x
}

#gradient(squared)(20)

// CHECK-LABEL: sil hidden @{{.*}}squared{{.*}}__primal_src_0_wrt_0
// CHECK: [[PV:%.*]] = struct ${{.*}}squared{{.*}}__Type ({{.*}} : $Builtin.FPIEEE32)
// CHECK: [[RESULT:%.*]] = tuple ([[PV]] : $$S9primalgen7squaredyS2fF__Type, {{.*}} : $Float)
// CHECK: return %19 : $(${{.*}}squared{{.*}}__Type, Float)