define i32 @main(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @main(i32 %a, i32 %b, i32 %c)
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_EXIT:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]], i32 [[C:%.*]])
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i32 [[A]], [[C]]
; CHECK-NEXT:    br i1 [[COND2]], label [[BB_TRUE2:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true2:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]], i32 [[A]])
; CHECK-NEXT:    br label [[BB_EXIT]]
; CHECK:       bb_false:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]], i32 [[C]])
; CHECK-NEXT:    br label [[BB_EXIT]]
; CHECK:       bb_exit:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[B]]
;
  %cond = icmp eq i32 %a, %b
  br i1 %cond, label %bb_true, label %bb_exit

bb_true:
  call void @f(i32 %a, i32 %b, i32 %c)
  %cond2 = icmp eq i32 %b, %c
  br i1 %cond2, label %bb_true2, label %bb_false

bb_true2:
  call void @f(i32 %a, i32 %b, i32 %c)
  br label %bb_exit

bb_false:
  call void @f(i32 %a, i32 %b, i32 %c)
  br label %bb_exit

bb_exit:
  call void @f(i32 %a, i32 %b, i32 %c)
  ret i32 %b
}

declare void @f(i32, i32, i32)
