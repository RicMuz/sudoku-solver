# Sudoku solver in prolog
Sudoku solver in SWI-prolog without using any library.

## Algorithm

The program uses backtracking to solve the puzzle.

1) Find an empty space (starting from the top left corner). If there isn't one, the puzzle is solved (output).
2) Extract the row, column, and square that contain the empty space (possible values are affected by these).
3) Try to put values from 1 to 9 there.
4) Check if the value does not violate the rules (use row,column and square from step 2).
5) If not, put the value in the empty space and try to solve the rest (go to step 1).
6) If it violates the rules, try a different value (go to step 3).

Backtracking occurs in step 4, where the values we put in empty spots before affect the values we can put now.

## Usage

It's necessary to have SWI-Prolog installed. 

Simply execute the file with the SWI-Prolog interpreter:

```bash
swipl sudoku_solver.pl
```

Once user executes the program, he can ask to solve a Sudoku.

- The grid must be represented as a matrix (a list of lists, where each list represents one line).
- Empty spaces are represented as 0 (zeros).

The predicate to solve the Sudoku is:

```
solve_sudoku/2:
solve_sudoku(+Grid, -Solved):-Solved is the solved Grid.
```

To execute the built-in tests:"

```prolog
load_test_files([]).
run_tests.
```