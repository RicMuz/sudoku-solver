%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                              TRANSPOSE OF MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%get_head(+List,-Value):-returns first value of the List 
get_head([X|_],X).

%extract_head(+List,-List2):-List2 is List without first value
extract_head([_|Xs],Xs).

%empty_list(+List):-true if list is empty
empty_list([]).

%empty_matrix(+Matrix):-true if the matrix is empty (list of empty lists)
empty_matrix(Matrix):-maplist(empty_list, Matrix).

%transpose(+Matrix, -Transpose):-Transpose is transposed Matrix
transpose(Matrix,[]):-empty_matrix(Matrix),!.
transpose(Matrix, [First_column|Rest_columns]):-maplist(get_head, Matrix, First_column),
                                                maplist(extract_head, Matrix, Matrix_without_first_column),
                                                transpose(Matrix_without_first_column, Rest_columns).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        FINDING COORDINATES OF FIRST APPEARENCE OF GIVEN ELEMENT IN MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%find_first_appearence_in_matrix(+Value, +Matrix, -X, -Y):-X, Y are coordinates of first appearence of Value in Matrix
%                                                         -indexed from zero, from first line down, from left to right 
find_first_appearence_in_matrix(Value, Matrix, X, Y):-find_line(Value,Matrix,0,X,Y).

%find_first_in_list(+Value, +List, +X, -X_acumulator):-find first appearence of Value in List and returns it's coordinates in X_acumulator
%                                                     -parameter X is used for incrementing current position
find_first_in_list(Value,[Value|_],X,X).
find_first_in_list(Value,[Element|Rest],X,X_acumulator):-Value\=Element,
                                                         X_new is X + 1,
                                                         find_first_in_list(Value,Rest,X_new,X_acumulator).


%find_line(+Value, +Matrix, +Y, -X_acumulator, -Y_acumulator):-finds first line which contain Value in Matrix and count it's Y coordinate
%                                                             -after the line is found calls function that count X coordinate
%                                                             -both counted values are then returned via acumulators
find_line(Value, [Row|_], Y, X_acumulator, Y):-member(Value, Row),                               
                                               find_first_in_list(Value, Row,0,X_acumulator),!.  
find_line(Value, [Row|Rest_rows],Y,X_acumulator,Y_acumulator):- \+member(Value, Row),           
                                                                Y_new is Y + 1,        
                                                                find_line(Value, Rest_rows, Y_new, X_acumulator, Y_acumulator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    EXTRACTING LINE, ROW AND SQUARE BY COORDINATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%nth_row(+N, +Matrix, -Row):-Row is row number N in Matrix (indexed from zero)
nth_row(0, [X|_], X):-!.
nth_row(N, [_|Xs], Row):-N=\=0,
                         N_new is N - 1,
                         nth_row(N_new, Xs, Row).

%nth_column(+N, +Matrix, -Column):-Column is column number N in Matrix (indexed from zero)
nth_column(N, Matrix, Column):-transpose(Matrix, Transposed),
                               nth_row(N,Transposed,Column).

%nth_trinity(+N, +List, -Sub_list):-Sub_list is trinity number N in the list
nth_trinity(0, [X,Y,Z|_], [X,Y,Z]):-!.
nth_trinity(N,[_,_,_|Xs],Acumulator):-N_new is N - 1,
                                     nth_trinity(N_new,Xs,Acumulator).

%square(+X, +Y, +Matrix, -Square):-Square is submatrix 3x3 represented as list containing coordinates X, Y in Matrix
%                                 -squares are non-overlapping starting in left upper corner
square(X, Y, Matrix, Square):-Square_X_index is X // 3,     
                              Square_Y_index is Y // 3,
                              % extracting lines:
                              nth_trinity(Square_Y_index, Matrix, Rows),
                              Rows = [Row1, Row2, Row3],
                              % extracting elements:
                              nth_trinity(Square_X_index, Row1, First_3),
                              nth_trinity(Square_X_index, Row2, Second_3),
                              nth_trinity(Square_X_index, Row3, Third_3),
                              % connecting together:
                              append([First_3, Second_3,Third_3],Square).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                           REPLACING ELEMENT AT GIVEN COORDINATES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%replace_nth_element(+N, +Value, +List, -New_list):-New_list is copy of List with changed element on position N to Value
replace_nth_element(0, Value, [_|Xs], [Value|Xs]):-!.
replace_nth_element(N, Value, [X|Xs], [X|New_list]):-N_new is N - 1,
                                                    replace_nth_element(N_new,Value,Xs,New_list).


%replace_in_matrix(+X, +Y, +Value, +Matrix, -New_matrix):-New_matrix is copy of Matrix with changed element on X,Y to Value
replace_element_in_matrix(X,0,Value,[Row|Rest_rows],[New_row|Rest_rows]):-replace_nth_element(X,Value,Row,New_row),!.
replace_element_in_matrix(X,Y,Value,[Row|Rest_rows],[Row|New_rest_rows]):-Y_new is Y - 1,
                                                                          replace_element_in_matrix(X,Y_new,Value,Rest_rows,New_rest_rows).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       SOLVE SUDOKU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%solve_sudoku(+Grid, -Solved):-Solved is solved Grid (not known are zeros)
solve_sudoku(Grid,Grid):- \+find_first_appearence_in_matrix(0,Grid,_,_).
solve_sudoku(Grid,Solved):-% find first empty spot:
                           find_first_appearence_in_matrix(0,Grid,X,Y),
                           % changing it will affect:
                           nth_row(Y,Grid,Row),
                           nth_column(X,Grid,Column),
                           square(X,Y,Grid,Square),
                           % possible values:
                           between(1, 9, Value),
                           % check if correct:
                           \+member(Value,Row),
                           \+member(Value,Column),
                           \+member(Value,Square),
                           % replace:
                           replace_element_in_matrix(X,Y,Value,Grid,New_grid),
                           % try to solve with inserted value:
                           solve_sudoku(New_grid,Solved).                    
