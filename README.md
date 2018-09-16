# ALGAE - Algebra and Eiffel

This library implements two-dimensional matrices for the Eiffel
programming language (http://www.eiffel.com).

## Version history

  - 2018-09-16: Version 0.9 - First public beta release

## Prerequisits

The code has been implemented against a recent release of
EiffelStudio, using Eiffel in Void-Safe mode. It should also work with
GOBO Eiffel, but has not been tested.

## Getting started

Checkout the code from the repository. Add the 'algae.ecf' as a
library to your project.

To create matrices, you must inherit from the `ALGAE_USER` class. This
will make the `al` feature available to you, which is a shared
factory.

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

## Documentation

*Please note that this documentation should form an introduction and
tutorial to the Algea library, and does not mention all features
available to users. Please use the corresponding class interfaces and
comments for a complete reference.*

### Matrix Creation

To create a new matrix, the client needs to inherit from the
`ALGAE_USER` class. This will provide access to the `al` factory object
used for creating all objects.

Users must avoid creating ALGAE objects directly. To enforce this, the
creation features are unavailable to the client. Please read the class
comment in `AL_INTERNAL` for more details on why this was done.

A matrix is a two-dimentional array for double values. Matrices are
mutable on their values, but immutable on their size. For example, it is
not possible to resize a 2x2 matrix into a 3x2 matrix. To do this, a new
matrix needs to be created. Algae supports this through the use of
*builders*.

To create a matrix, you can use the `matrix` feature:

```eiffel
local
	x: AL_MATRIX
do
	x := al.matrix (3, 4)
end
```

|     |     |     |     |
| --- | --- | --- | --- |
| 0.0 | 0.0 | 0.0 | 0.0 |
| 0.0 | 0.0 | 0.0 | 0.0 |
| 0.0 | 0.0 | 0.0 | 0.0 |

This will create an empty matrix with 3 rows and 4 columns. All values
are initialized to 0. If instead, you would like to have the matrix
initialized with a different value, you can use `matrix_filled`.

```eiffel
	x := al.matrix_filled (3, 4, 1.2)
```

|     |     |     |     |
| --- | --- | --- | --- |
| 1.2 | 1.2 | 1.2 | 1.2 |
| 1.2 | 1.2 | 1.2 | 1.2 |
| 1.2 | 1.2 | 1.2 | 1.2 |

### Basic Manipulation

Matrices offer basic reading and writing, using either `put` and `item`,
or the `[row, column]` array notation.

```eiffel
	x := al.matrix(3, 4)
	x.put (6.0, 2, 1)
	x.put (x.item (2, 1) + 3.0, 2, 2)
	x[1, 1] := 5.0
	x[2, 3] := 2.0
	x[3, 3] := x[1, 1] + x[2, 3]
```

|     |     |     |     |
| --- | --- | --- | --- |
| 5.0 | 0.0 | 0.0 | 0.0 |
| 6.0 | 9.0 | 2.0 | 0.0 |
| 0.0 | 0.0 | 7.0 | 0.0 |

### Transformations

Algae offers a number of operations that transform a given matrix into
a new matrix. To improve efficiency, all of these operations are offered in
two forms:

1.  The function that returns a fresh, new matrix.
2.  A procedure with the `_into` prefix where the target of the operation
    is provided.

The second form allows the re-use of existing matrices and thus
minimizes the need for object creation and memory allocation. The
first version of the operation is implemented by creating a few target
and then calling the second version. They are provided for convenience
and readability.

Supported operations are:

  - `to_real` and `copy_values_into` will create an exact copy of the
    current matrix (or view).
  - `transposed` and `transpose_into` to get the transposed matrix.
  - `times` and `multiply_into` to do matrix multiplication.
  - `ata` and `ata_into` to do multiply the transposed version of the
    matrix by itself (a<sup>T</sup>a).

### Labels

It is possible to associate rows and columns with labels. These labels
are `STRING` objects.

If labels are used, the label for each row and column must be
unique. It is allowed to only label some of the rows and
columns. Algae offers the lookup of rows and columns by label (using
`row_labeled, column_labeled` and `item_labeled`). Values can be
stored using `put_labeled`. 

```eiffel
	x := al.matrix (3, 4)
	x.row_labels.set_all (<< "A", "B", "C" >>)
	x.columns_labels.set_default ("X")
	x.put_labeled (1.3, "B", "X3")
```

|       | X1  | X2  | X3  | X4  |
| ----- | --- | --- | --- | --- |
| **A** | 0.0 | 0.0 | 0.0 | 0.0 |
| **B** | 0.0 | 0.0 | 1.3 | 0.0 |
| **C** | 0.0 | 0.0 | 0.0 | 0.0 |

### Vectors

A vector is a linear list of cells in a matrix. Thus, vectors do never
exist by themselves, but are instead a linear way to access the cells
of a matrix.

For example, a single column or row is a vector. Changes to the vector
will change the underlying matrix.

```eiffel
	x := al.matrix (3, 4)
	x.column (3).fill (2.0)
	x.row (2).fill (3.0)
```

|     |     |     |     |
| --- | --- | --- | --- |
| 0.0 | 0.0 | 2.0 | 0.0 |
| 3.0 | 3.0 | 3.0 | 3.0 |
| 0.0 | 0.0 | 2.0 | 0.0 |

Vectors are a powerful construct to manipulate the matrix. Other than
the normal row/column vectors, Algae also offers vectors for the
diagonal, and a special vector that contains all fields of a matrix,
column by column. As vectors offer iterators, this makes it very easy
and efficient to have an operation that manipulates all values of a
matrix:

```eiffel
	x := al.matrix (3, 4)
	across
		x.column_by_column as cell
	loop
		cell.put (cell.row + cell.column)
	end
```

|     |     |     |     |
| --- | --- | --- | --- |
| 2.0 | 3.0 | 4.0 | 5.0 |
| 3.0 | 4.0 | 5.0 | 6.0 |
| 4.0 | 5.0 | 6.0 | 7.0 |

### Views

Algae differentiates between `AL_MATRIX` and subclass called
`AL_REAL_MATRIX`. The difference between the two is that the second is
a real, independent data-structure, while the first might actually
just be a aliased *view* on another matrix.

Examples for views are partial matrices that only contain subsets of a
given matrix, or transposted views that swap the access to columns and
rows without duplicating the data.

The feature `underlying_matrix` gives access to the `AL_REAL_MATRIX`
that is storing the actual values.

#### Transposed View

The `transposed_view` will return a view on a matrix that swaps around
rows and columns:

```eiffel
	x := al.matrix (3, 4)
	x.transposed_view[1, 2] := 8.0
```

|     |     |     |     |
| --- | --- | --- | --- |
| 0.0 | 0.0 | 0.0 | 0.0 |
| 8.0 | 0.0 | 0.0 | 0.0 |
| 0.0 | 0.0 | 0.0 | 0.0 |

This is different from the `transposed` feature that returns a new
`AL_REAL_MATRIX` and transposes by copying.

#### Maps and Partial Matrix

Mathematically, an `AL_MAP` is a injective mapping from integers to
integers. It allows the easy selection and reshuffling of a subset of
rows or columns of a matrix. Being injective means that two inputs
cannot map to the same output.

`AL_PARTIAL_MATRIX` is a view that takes two `AL_MAP` objects, one for
rows and one for columns, and will map every access to a cell using
these two maps.

Maps and partial matrices are an extremely powerful tool to access and
manipulate matrices.

For example, the following will create a view to a 3 by 4 matrix that
only selects rows 1 and 3 and columns 2, 3 and 4:

```eiffel
	x := al.matrix (3, 4)
	r := al.map_from_array(<<1, 3>>, 3)
	c := al.map_from_array(<<2, 3, 4>>, 4)
	y := x.mapped_view (r, c)
	y.fill(5.0)
```

|     |     |     |     |
| --- | --- | --- | --- |
| 0.0 | 5.0 | 5.0 | 5.0 |
| 0.0 | 0.0 | 0.0 | 0.0 |
| 0.0 | 5.0 | 5.0 | 5.0 |

### Special Matices

#### Array Matrix

An array matrix is a matrix that relies on a standard array of arrays
to store its internal state. The outer array captures the rows, while
the inner array the columns in a row.

Together with the possibility to specify arrays inline in Eiffel, this
makes it very easy to define matrices in code. The main downside of
using an array matrix is that Algae has no control over the internal
data-structure (as it is passed in on construction) and arrays are
mutable in size. Also, this double-array representation is not very
efficient for large matrices.

```eiffel
	x := al.array_matrix (<< << 0.0, 1.0, 0.0 >>,
	                         << 1.0, 0.0, 0.0 >>,
	                         << 0.0, 0.0, 1.0 >> >>)
```

|     |     |     |
| --- | --- | --- |
| 0.0 | 1.0 | 0.0 |
| 1.0 | 0.0 | 0.0 |
| 0.0 | 0.0 | 1.0 |


#### Symmetric Matrix

A symmetric matrix is a square matrix that always has the same value
at `[x, y]` and `[y, x]`. This makes it possible to store a symmetric
matrix using half the amount of memory, as only one triangle is
stored.

Reading a symmetric matrix is the same as for a normal matrix, but
setting a value at `[x, y]` will also change `[y, x]`. The fields are
not independent from each other anymore, which is expressed by the
property `are_all_fields_independent`. A few features require that all
fields are independent, so symmetric matrices cannot be used.

```eiffel
	x := al.symmetric_matrix (4)
	x[1, 2] := 1.0
	x[3, 2] := 2.0
```

|     |     |     |     |
| --- | --- | --- | --- |
| 0.0 | 1.0 | 0.0 | 0.0 |
| 1.0 | 0.0 | 2.0 | 0.0 |
| 0.0 | 2.0 | 0.0 | 0.0 |
| 0.0 | 0.0 | 0.0 | 0.0 |

### Algorithms

The goal of Algae is to provide efficient implementations of a number
of standard algorithms on matrices.

Algorithms live outside the general Algae matrix classes, as they
operate *on* matrices. Thus, algorithm objects are create directly and
not using the `al` factory.

Remember to check the value of `last_successful` if available, before
using the output of an algorithm.

#### Gaussian Elimination

Algae implements solving a system of equations by using the Gaussian
Elimination method.

```eiffel
local
	l_in, l_out: AL_MATRIX
	l_algo: AL_GAUSSIAN_ELIMINATION
do
	l_in := al.array_matrix (<< << 2.0, 4.0, 3.0 >>, 
	                            << 1.0, 1.0, 5.0 >>, 
								<< 8.0, 0.0, 1.0 >> >>)
	l_out := al.array_matrix (<< << 10.0 >>, 
	                             << 13.0 >>, 
								 << 34.0 >> >>)
	create l_algo.make (l_in.to_real)
	l_algo.set_output (l_out.to_real)
	l_algo.solve
	print (l_algo.output.csv)
end
```

|     |
| --- |
| 4   |
| -1  |
| 2   |

### Output

#### CSV output

Algae implements a simple transformation of a matrix into CSV
format. This is available calling the `csv` function.

### Handling of Double Values

Most forms of computations on float point values create problems with
rounding. This makes it impossible to compare two float point values
using `=`.  Instead, they require comparison using an *epsilon*
value. If two values are closer to each other than the epsion value,
they are considered the same.

Algae sometimes has to compare double values for its algorithms and
properties. To do this, it uses the `same_double` feature.

The default epsilon value is 0.0000000000000001. This is a good default
value if the values in the matrix are between -10.0 and 10.0. If you are
processing values of a different magnitude in the matrix, you should
consider changing the value using the `set_epsilon` feature.

Comparing two matrices requires that both have the same
epsilon. Matrices that are derived from other matrices (through copy
operations, multiplication etc) copy the epsilon value from the target
of the call.

```eiffel
	x := al.matrix_filled (2, 2, 5.0)
	y := al.matrix_filled (2, 2, 5.01)
	x.set_epsilon (0.001)
	y.set_epsilon (0.001)
	check not x.is_same (y) end
	x.set_epsilon (0.1)
	y.set_epsilon (0.1)
	check x.is_same (y) end
```

## License

This library is released under the *Eiffel Forum License, version
2*. Please see the LICENSE.txt file for details.
