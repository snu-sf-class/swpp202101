## Assignment 5: Code Review

You will receive two students' propinteq.cpp via mail. Please read the
code and **leave your comments as C++ comments**.
Please submit the .cpp files with comments to ETL.


- Your review should be written in English.

- You don't need to leave your name because TAs already know who reviews the
code.

- The diff should be less than 50 lines (meaning that your comments should be
less than 50 lines), and should follow 80-column rules
(one line should be less than 80 letters in ASCII).

- You can suggest a better C++ code in the comments if you think it is helpful
for writing a good feedback.


#### Where to Leave Comments?

The contents of comments depend on their locations.
It is not strictly enforced, but please try to follow these rules if possible:

1. A comment that is left at the top of the source code contains a high-level
feedback on overall algorithm or structure of the whole code.

2. A comment that is left before a function definition contains a high-level
feedback to the specific function or relevant functions.

3. A comment that is left before/after a specific statement or code block
gives a low-level comment to the specific part.

TAs will read your comments by seeing diff from the original code as well as
reading the original program.

If there are too many things to review, leave comments on what seem to be the
most important ones first (e.g. high-level feedback, correctness of algorithms).

If the code looks great, just leave 'Looks good to me' / 'Looks great to me' /
'LGTM' or any statement that is similar to this at the top of the code
as a comment. :)


#### What Kind of Feedbacks Should I Give?

Here are a few things that you can do:

- Mention whether you could easy follow the code or not (if not, say why).

- Understand the algorithm and leave counterexamples if exist.

- Check whether C++/LLVM libraries are correctly used.

- If you know C++/LLVM library that can be used to neaten the code, suggest it.

- If the code has a problem in performance, explain how it can be addressed.

- Comment about formatting / naming issues if you want. You should follow the
naming rule from LLVM / the formatting rules from clang-format.
