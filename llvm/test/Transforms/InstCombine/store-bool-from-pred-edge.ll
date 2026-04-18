; RUN: opt -passes=instcombine -S %s | FileCheck %s

define i32 @src(ptr %p, i1 %c1, i1 %c2) {
entry:
  %notc2 = xor i1 %c2, true
  %sel = select i1 %c2, i1 %c1, i1 false
  %cond = or i1 %sel, %notc2
  br i1 %cond, label %ret, label %storebb

storebb:
  store i1 %c1, ptr %p, align 4
  br label %ret

ret:
  ret i32 0
}

; CHECK-LABEL: @src(
; CHECK: store i1 false, ptr %p, align 4
