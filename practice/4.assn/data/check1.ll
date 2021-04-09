declare void @f(i32, i32)

define i32 @main(i32 %a, i32 %b) {
; CHECK-LABEL: @main(i32 %a, i32 %b)
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]])
; CHECK-NEXT:    br label [[BB_EXIT:%.*]]
; CHECK:       bb_false:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    br label [[BB_EXIT]]
; CHECK:       bb_exit:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i32 [[B]]
;
  %cond = icmp eq i32 %a, %b
  br i1 %cond, label %bb_true, label %bb_false
bb_true:
  call void @f(i32 %a, i32 %b)
  br label %bb_exit
bb_false:
  call void @f(i32 %a, i32 %b)
  br label %bb_exit
bb_exit:
  call void @f(i32 %a, i32 %b)
  ret i32 %b
}
