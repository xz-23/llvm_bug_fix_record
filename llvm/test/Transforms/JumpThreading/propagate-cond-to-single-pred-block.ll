; RUN: opt -passes=jump-threading -S %s | FileCheck %s

define i32 @src(ptr %p, i1 %c1, i1 %c2) {
entry:
  br i1 %c2, label %a, label %ret

a:
  br i1 %c1, label %ret, label %storebb

storebb:
  store i1 %c1, ptr %p, align 4
  br label %ret

ret:
  ret i32 0
}

; CHECK-LABEL: @src(
; CHECK: store i1 false, ptr %p, align 4
