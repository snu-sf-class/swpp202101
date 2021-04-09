define i32 @triangle(i32 %a, i32 %b) {
; CHECK-LABEL: @triangle(i32 %a, i32 %b)
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_ELSE:%.*]]
; CHECK:       bb_else:
; CHECK-NEXT:    br label [[BB_TRUE]]
; CHECK:       bb_true:
; CHECK-NEXT:    call void @g(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    ret i32 [[B]]
;
  %cond = icmp eq i32 %a, %b
  br i1 %cond, label %bb_true, label %bb_else

bb_else:
  br label %bb_true

bb_true:
  call void @g(i32 %a, i32 %b)
  ret i32 %b
}

declare void @g(i32, i32)
