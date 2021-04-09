; Write your own check here.
; Feel free to add arguments to @f, so its signature becomes @f(i32 %x, ...).
; But, this file should contain one function @f() only.
; FileCheck syntax: https://llvm.org/docs/CommandGuide/FileCheck.html

define i32 @f() {
; CHECK-LABEL: define i32 @f
; CHECK: ret i32 0
  ret i32 0
}