# ALGAE - Algebra and Eiffel

This library implements two-dimensional matrices for the Eiffel
programming language (http://www.eiffel.com).

This is work in progress ...

## Prerequisits

The code has been implemented against a recent release of
EiffelStudio, using Eiffel in Void-Safe mode.

## Getting started

Checkout the code from the repository somewhere. Add the 'algae.ecf'
as a library to your project.

All classes that want to work with matrices should inherit from the
`ALGAE_USER` class. This will make the `al` feature available to you,
which gives access to a shared factory. Do not create instances of
Algae classes directly.

Example:

```eiffel
local
  l_matrix: AL_MATRIX
do
  l_matrix := al.matrix (3, 4)
  l_matrix[1,2] := 1.0
  l_matrix := l_matrix.transposed
  print (l_matrix.csv + "%N")
end
```

## Design decisions and hints

(incomplete list)

- Matrices are mutable, but fixed in size. To build larger matrices from existing ones, use the matrix builders.
- It is possible that a matrix has zero width and/or height. All code must be written accordingly.
- Matrices may carry `STRING` labels, identifying columns and rows. No duplicate labels are allowed.
- There are no stand-alone vectors. Instead all vectors are views selecting specific fields from existing matrices (rows, columns, diagonals, etc.)
- Whenever possible, features that create large, new matrices are just written as wrappers around a `compute_into` feature that fills an already existing matrix.
- `AL_REAL_MATRIX` are matrices that are storing information. Other matrices are only views. Using `underlying_matrix`, you can always access the matrix that stores the actual values.
