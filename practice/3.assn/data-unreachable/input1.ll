define void @f(i1 %cond) {
entry:
  br i1 %cond, label %bb1, label %bb2
bb1:
  br label %bb2
bb2:
  ret void
}
