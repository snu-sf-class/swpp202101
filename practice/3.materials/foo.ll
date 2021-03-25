define i32 @average(i32 %x, i32 %y) {
entry:
  %sum = add i32 %x, %y
  %average = sdiv i32 %sum, 2
  ret i32 %average
}

define i1 @is_even(i32 %x) {
entry:
  %i = srem i32 %x, 2
  %cmp = icmp eq i32 %i, 0
  br i1 %cmp, label %yes, label %no
yes:
  ret i1 true
no:
  ret i1 false
}
