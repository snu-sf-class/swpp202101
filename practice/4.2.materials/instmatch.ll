define void @f(i32 %a, i32 %b, i32 %c) {
  %tmp = add i32 %a, %b
  %match1 = sub i32 %tmp, %b
  %match_not1 = sub i32 %tmp, %c

  %match2 = icmp eq i32 %a, %a
  %match_not2 = icmp eq i32 %a, %b
  %match_not2_2 = icmp ne i32 %a, %a

  %match3 = mul i32 %a, 0
  %match_not3 = mul i32 %a, 1
  %match_not3_2 = mul i32 0, %a

  ret void
}