:-include(sudoku_solver).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              TRANSPOSE OF MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(transpose).

test(empty):-transpose([],[]).

test(one_by_one):-transpose([[1]],[[1]]).

test(three_by_three):-transpose([[1,2,3],[4,5,6],[7,8,9]],[[1,4,7],[2,5,8],[3,6,9]]).

test(two_by_three):-transpose([[1,2,3],[4,5,6]],[[1,4],[2,5],[3,6]]).

test(bad_input,[fail]):-transpose([1],_).

:-end_tests(transpose).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        FINDING COORDINATES OF FIRST APPEARENCE OF GIVEN ELEMENT IN MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-begin_tests(find_first_appearence_in_matrix).

test(single_appearence_first):-find_first_appearence_in_matrix(0,[[0,2,3],[4,5,6],[7,8,9]],0,0).

test(single_appearence_middle):-find_first_appearence_in_matrix(0,[[1,2,3],[4,0,6],[7,8,9]],1,1).

test(single_appearence_last):-find_first_appearence_in_matrix(0,[[1,2,3],[4,5,6],[7,8,0]],2,2).

test(multiple_appearences_fist_line):-find_first_appearence_in_matrix(0,[[0,2,0],[4,0,6],[7,8,0]],0,0).

test(multiple_appearences_second_line):-find_first_appearence_in_matrix(0,[[1,2,3],[0,0,6],[7,8,0]],0,1).

test(multiple_appearences_third_line):-find_first_appearence_in_matrix(0,[[1,2,3],[4,5,6],[7,0,0]],1,2).

test(does_not_contain,[fail]):-find_first_appearence_in_matrix(0,[[1,2,3],[4,5,6],[7,8,9]],_,_).

:-end_tests(find_first_appearence_in_matrix).


