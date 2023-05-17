:-include(sudoku_solver).

:-begin_tests(transpose).

test(empty):-transpose([],[]).

test(one_by_one):-transpose([[1]],[[1]]).

test(three_by_three):-transpose([[1,2,3],[4,5,6],[7,8,9]],[[1,4,7],[2,5,8],[3,6,9]]).

test(two_by_three):-transpose([[1,2,3],[4,5,6]],[[1,4],[2,5],[3,6]]).

test(bad_input,[fail]):-transpose([1],_).

:-end_tests(transpose).

