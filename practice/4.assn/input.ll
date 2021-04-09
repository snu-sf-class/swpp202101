define void @f(i32 %x, i32 %y) {
  %cond = icmp eq i32 %x, %y
  br i1 %cond, label %BB_true, label %BB_false
BB_true:
  call void @f(i32 %x, i32 %y)
  br label %BB_end
BB_false:
  call void @f(i32 %x, i32 %y)
  br label %BB_end
BB_end:
  call void @f(i32 %x, i32 %y)
  ret void
}