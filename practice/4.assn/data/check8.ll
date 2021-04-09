define i32 @main(i32 %b, i32 %c) {
; CHECK-LABEL: @main(i32 %b, i32 %c)
; CHECK-NEXT:    [[A:%.*]] = call i32 @g(i32 [[B:%.*]], i32 [[C:%.*]])
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A]], [[B]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_EXIT:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i32 [[B]], [[C]]
; CHECK-NEXT:    call void @f(i32 [[B]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    br i1 [[COND2]], label [[BB_TRUE2:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true2:
; CHECK-NEXT:    call void @f(i32 [[B]], i32 [[B]], i32 [[B]])
; CHECK-NEXT:    ret i32 [[B]]
; CHECK:       bb_false:
; CHECK-NEXT:    call void @f(i32 [[B]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[B]]
; CHECK:       bb_exit:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[A]]
;
  %a = call i32 @g(i32 %b, i32 %c)
  %cond = icmp eq i32 %a, %b
  br i1 %cond, label %bb_true, label %bb_exit

bb_true:
  %cond2 = icmp eq i32 %b, %c
  call void @f(i32 %a, i32 %b, i32 %c)
  br i1 %cond2, label %bb_true2, label %bb_false

bb_true2:
  call void @f(i32 %a, i32 %b, i32 %c)
  ret i32 %c

bb_false:
  call void @f(i32 %a, i32 %b, i32 %c)
  ret i32 %a

bb_exit:
  call void @f(i32 %a, i32 %b, i32 %c)
  ret i32 %a
}

declare i32 @g(i32, i32)
declare void @f(i32, i32, i32)
