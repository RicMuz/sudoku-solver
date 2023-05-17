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