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