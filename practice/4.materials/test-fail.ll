define i32 @constant_fold_fail() {
; CHECK-LABEL: @constant_fold_fail(
; CHECK-NEXT:    ret i32 3
	%a = add i32 1, 2
  %b = sub i32 %a, 1
  ret i32 %b
}
