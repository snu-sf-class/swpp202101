define void @f(i1 %cond, i1 %cond2, i1 %cond3) {
entry:
  br i1 %cond, label %bb1, label %bb2
bb1:
  br label %bb3
bb2:
  br label %bb3
bb3:
  br i1 %cond2, label %bb4, label %bb5
bb4:
  ret void
bb5:
  br label %bb6
bb6:
  br label %bb1

bb_unreachable:
  br i1 %cond3, label %bb_unreachable2, label %bb1

bb_unreachable2:
  br label %bb_unreachable
}
