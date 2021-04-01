define i32 @f() {
  %x = add i32 0, 1
  %y = add i32 %x, 2
  %z = sub i32 %y, 4
  %w = mul i32 %z, 0
  ret i32 %w
}
