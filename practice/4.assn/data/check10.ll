define void @loop(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @loop(i32 %a, i32 %b, i32 %c) {
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP:%.*]], label [[EXIT:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]], i32 [[C:%.*]])
; CHECK-NEXT:    [[COND2:%.*]] = icmp eq i32 [[A]], [[C]]
; CHECK-NEXT:    br i1 [[COND2]], label [[LATCH:%.*]], label [[EXIT]]
; CHECK:       latch:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[A]], i32 [[A]])
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    call void @f(i32 [[A]], i32 [[B]], i32 [[C]])
; CHECK-NEXT:    ret void
;
  %cond = icmp eq i32 %a, %b
  br i1 %cond, label %loop, label %exit
loop:
  call void @f(i32 %a, i32 %b, i32 %c)
  %cond2 = icmp eq i32 %a, %c
  br i1 %cond2, label %latch, label %exit
latch:
  call void @f(i32 %a, i32 %b, i32 %c)
  br label %loop
exit:
  call void @f(i32 %a, i32 %b, i32 %c)
  ret void
}

declare void @f(i32, i32, i32)
