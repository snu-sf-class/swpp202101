define void @main(i32 %a, i32 %b) {
; CHECK-LABEL: @main(i32 %a, i32 %b)
; CHECK-NEXT:    [[COND:%.*]] = icmp ne i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret void
; CHECK:       bb_false:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret void
;
  %cond = icmp ne i32 %a, %b
  br i1 %cond, label %bb_true, label %bb_false
bb_true:
  call void @f(i32 %a, i32 %b)
  ret void
bb_false:
  call void @f(i32 %a, i32 %b)
  ret void
}

declare void @f(i32, i32)
