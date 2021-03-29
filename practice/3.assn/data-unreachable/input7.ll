define void @f(i1 %cond){
entry:
  ret void

bb_unreachable:
  ret void

bb_unreachable2:
  br label %bb_unreachable3
bb_unreachable3:
  br i1 %cond, label %bb_unreachable4, label %bb_unreachable2
bb_unreachable4:
  br label %bb_unreachable

bb_unreachable5:
  ret void
}
