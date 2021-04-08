define i32 @f(i1 %cond, i32 %arg) {
  %inst = add i32 1, 1
  br i1 %cond, label %undef_zone, label %normal_zone
undef_zone:
  %x1 = add i32 %arg, 0
  ret i32 %inst
normal_zone:
  %x2 = add i32 %arg, 0
  ret i32 %inst
}