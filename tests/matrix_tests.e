note
	description: "Test for AL_DENSE_MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	MATRIX_TESTS

inherit
	EQA_TEST_SET
	MATRIX_TEST_SUPPORT
		undefine
			default_create
		end

feature -- Test routines

	test_creation
			-- Test the creation of a matrix
		local
			m: AL_MATRIX
		do
			m := al.matrix (1, 2)
			assert ("height_ok", m.height = 1)
			assert ("width_ok", m.width = 2)
			assert ("no_labels1", m.row_labels [1] = Void)
			assert ("no_labels2", m.column_labels [1] = Void)
			assert ("no_labels3", m.column_labels [2] = Void)
			assert ("field_zero1", m [1,1] = 0.0)
			assert ("field_zero2", m [1,2] = 0.0)
		end

	test_filled_creation
			-- Test the creation of a filled matrix
		local
			m: AL_MATRIX
		do
			m := al.matrix_filled (1, 2, 3.0)
			assert ("height_ok", m.height = 1)
			assert ("width_ok", m.width = 2)
			assert ("no_labels1", m.row_labels [1] = Void)
			assert ("no_labels2", m.column_labels [1] = Void)
			assert ("no_labels3", m.column_labels [2] = Void)
			assert ("field_zero1", m [1,1] = 3.0)
			assert ("field_zero2", m [1,2] = 3.0)
		end

	test_zero_height_matrix
			-- Create a matrix with zero height
		local
			m: AL_MATRIX
		do
			m := al.matrix (0, 1)
			assert ("height_ok", m.height = 0)
			assert ("width_ok", m.width = 1)
			assert ("no_labels2", m.column_labels [1] = Void)
		end


	test_zero_width_matrix
			-- Create a matrix with zero height
		local
			m: AL_MATRIX
		do
			m := al.matrix (1, 0)
			assert ("height_ok", m.height = 1)
			assert ("width_ok", m.width = 0)
			assert ("no_labels2", m.row_labels [1] = Void)
		end

	test_zero_matrix
			-- Create a matrix with zero height
		local
			m: AL_MATRIX
		do
			m := al.matrix (0, 0)
			assert ("height_ok", m.height = 0)
			assert ("width_ok", m.width = 0)
		end

	test_item
			-- Accessing fields
		local
			m: AL_MATRIX
		do
			m := new_matrix
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m.item (2, 1) = 3.0)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m.item (1, 2) = 1.5)
			assert ("field_ok5", m[2, 2] = 2.5)
			assert ("field_ok6", m.item (3, 2) = 3.5)
		end

	test_item_labeled
			-- Accessing fields by label
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.set_default_labels
			assert ("field_ok1", m.item_labeled ("row1", "column1") = 2.0)
			assert ("field_ok2", m.item_labeled ("row2", "column1") = 3.0)
			assert ("field_ok3", m.item_labeled ("row3", "column1") = 4.0)
			assert ("field_ok4", m.item_labeled ("row1", "column2") = 1.5)
			assert ("field_ok5", m.item_labeled ("row2", "column2") = 2.5)
			assert ("field_ok6", m.item_labeled ("row3", "column2") = 3.5)
		end

	test_row_labels
			-- Test access to row labels
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.row_labels [2] := "Hello"
			assert ("label_void1", m.row_labels [1] = Void)
			assert ("label_not_void", m.row_labels [2] ~ "Hello")
			assert ("label_void2", m.row_labels [3] = Void)
		end

	test_column_labels
			-- Test access to column labels
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.column_labels [2] := "Hello"
			assert ("label_void", m.column_labels [1] = Void)
			assert ("label_not_void", m.column_labels [2] ~ "Hello")
		end

	test_row
			-- Test access to a row
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			v := m.row (1)
			m.set_default_labels
			assert ("size_ok", v.count = 2)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 1.5)
			assert ("label_ok", v.name ~ "row1")
		end

	test_rows
			-- Test access to rows using an iterator
		local
			m: AL_MATRIX
			c: AL_MATRIX_ROWS_CURSOR
		do
			m := new_matrix
			m.set_default_labels
			c := m.rows.new_cursor
			assert ("index1_ok", c.index = 1)
			assert ("count1_ok", c.item.count = 2)
			assert ("value1_ok1", c.item.item (1) = 2.0)
			assert ("value1_ok2", c.item.item (2) = 1.5)
			assert ("after1_ok", not c.after)
			assert ("label1_ok", c.item.name ~ "row1")
			c.forth
			assert ("index2_ok", c.index = 2)
			assert ("count2_ok", c.item.count = 2)
			assert ("value2_ok1", c.item.item (1) = 3.0)
			assert ("value2_ok2", c.item.item (2) = 2.5)
			assert ("after2_ok", not c.after)
			assert ("label2_ok", c.item.name ~ "row2")
			c.forth
			assert ("index3_ok", c.index = 3)
			assert ("count3_ok", c.item.count = 2)
			assert ("value3_ok1", c.item.item (1) = 4.0)
			assert ("value3_ok2", c.item.item (2) = 3.5)
			assert ("after3_ok", not c.after)
			assert ("label3_ok", c.item.name ~ "row3")
			c.forth
			assert ("after4_ok", c.after)
		end

	test_columns
			-- Test access to columns using an iterator
		local
			m: AL_MATRIX
			c: AL_MATRIX_COLUMNS_CURSOR
		do
			m := new_matrix
			m.set_default_labels
			c := m.columns.new_cursor
			assert ("index1_ok", c.index = 1)
			assert ("count1_ok", c.item.count = 3)
			assert ("value1_ok1", c.item.item (1) = 2.0)
			assert ("value1_ok2", c.item.item (2) = 3.0)
			assert ("value1_ok3", c.item.item (3) = 4.0)
			assert ("after1_ok", not c.after)
			assert ("label1_ok", c.item.name ~ "column1")
			c.forth
			assert ("index2_ok", c.index = 2)
			assert ("count2_ok", c.item.count = 3)
			assert ("value2_ok1", c.item.item (1) = 1.5)
			assert ("value2_ok2", c.item.item (2) = 2.5)
			assert ("value2_ok3", c.item.item (3) = 3.5)
			assert ("after2_ok", not c.after)
			assert ("label2_ok", c.item.name ~ "column2")
			c.forth
			assert ("after3_ok", c.after)
		end

	test_column
			-- Test access to a column
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			v := m.column (2)
			m.set_default_labels
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 1.5)
			assert ("value_ok2", v [2] = 2.5)
			assert ("value_ok3", v [3] = 3.5)
			assert ("label_ok", v.name ~ "column2")
		end

	test_row_labeled
			-- Test access to a row by label
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			m.set_default_labels
			v := m.row_labeled ("row1")
			assert ("size_ok", v.count = 2)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 1.5)
			assert ("label_ok", v.name ~ "row1")
		end

	test_column_labeled
			-- Test access to a column by label
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			m.set_default_labels
			v := m.column_labeled ("column2")
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 1.5)
			assert ("value_ok2", v [2] = 2.5)
			assert ("value_ok3", v [3] = 3.5)
			assert ("label_ok", v.name ~ "column2")
		end

	test_diagonal
			-- Test access to the diagonal
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_square_matrix
			m.set_default_labels
			v := m.diagonal
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 2.5)
			assert ("value_ok3", v [3] = 3.0)
			assert ("label_ok", v.name = Void)
		end

	test_column_by_column
			-- Test access to the column_by_column vector
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_matrix
			m.set_default_labels
			v := m.column_by_column
			assert ("size_ok", v.count = 6)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 3.0)
			assert ("value_ok3", v [3] = 4.0)
			assert ("value_ok4", v [4] = 1.5)
			assert ("value_ok5", v [5] = 2.5)
			assert ("value_ok6", v [6] = 3.5)
			assert ("label_ok", v.name = Void)
		end

	test_underlying_matrix
			-- Test the underlying matrix
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := m.transposed_view
			assert ("original_real", m.underlying_matrix = m)
			assert ("view_not_real", n.underlying_matrix /= n)
			assert ("view_on_original", n.underlying_matrix = m)
		end

	test_real
			-- Test access to the real matrix
		local
			m, n, o: AL_MATRIX
		do
			m := new_matrix
			n := m.transposed_view
			o := n.as_real
			assert ("original_real", m.underlying_matrix = m)
			assert ("view_not_real", n.underlying_matrix /= n)
			assert ("view_made_reall", o.underlying_matrix = o)
		end

	test_duplicated
			-- Test for matrix duplication
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := m.to_real
			m.put (11.00, 2, 2)
			m.row_labels [1] := "First"
			n.put (22.00, 1, 1)
			n.row_labels [2] := "Second"
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m[2, 1] = 3.0)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m[1, 2] = 1.5)
			assert ("field_ok5", m[2, 2] = 11.00)
			assert ("field_ok6", m[3, 2] = 3.5)
			assert ("label_ok1", m.row_labels[1] ~ "First")
			assert ("label_ok2", m.row_labels[2] = Void)
			assert ("field_ok7", n[1, 1] = 22.00)
			assert ("field_ok8", n[2, 1] = 3.0)
			assert ("field_ok9", n[3, 1] = 4.0)
			assert ("field_ok10", n[1, 2] = 1.5)
			assert ("field_ok11", n[2, 2] = 2.5)
			assert ("field_ok12", n[3, 2] = 3.5)
			assert ("label_ok1", n.row_labels[1] = Void)
			assert ("label_ok2", n.row_labels[2] ~ "Second")
		end

	test_times
			-- Test for matrix multiplication
		local
			m, n, o: AL_MATRIX
		do
			m := new_square_matrix
			m.row_labels [2] := "ROW"
			n := new_matrix
			n.column_labels [2] := "COLUMN"
			o := m.times (n)
			assert ("width_ok", o.width = n.width)
			assert ("height_ok", o.height = m.height)
			assert ("field_ok1", o[1, 1] = 12.5)
			assert ("field_ok2", o[2, 1] = 21.5)
			assert ("field_ok3", o[3, 1] = 30.5)
			assert ("field_ok4", o[1, 2] = 10.25)
			assert ("field_ok5", o[2, 2] = 17.75)
			assert ("field_ok6", o[3, 2] = 25.25)
			assert ("label_ok1", o.row_labels [2] ~ "ROW")
			assert ("label_ok2", o.column_labels [2] ~ "COLUMN")
		end

	test_times_large
			-- Test for matrix multiplication on a larger matrix
		local
			m, n, o: AL_MATRIX
		do
			m := al.matrix (70, 70)
			m.diagonal.fill (1.0)
			m[1,70] := 1.0
			n := al.matrix (70, 70)
			n.diagonal.fill (1.0)
			n[1,70] := 1.0
			o := m.times (n)

			assert ("width_ok", o.width = n.width)
			assert ("height_ok", o.height = m.height)
			assert ("diagonal_ok", o.diagonal.sum = 70)
			assert ("corner_ok", o[1,70] = 2)
			assert ("sum_ok", o.column_by_column.sum = 72)
		end

	test_aat
			-- Test for AAT
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			m.row_labels [2] := "ROW"
			n := m.aat
			assert ("width_ok", n.width = 3)
			assert ("height_ok", n.height = 3)
			assert ("square", n.is_square)
			assert ("symmetric", n.is_symmetric)
			assert ("field_ok1", n[1, 1] = 6.25)
			assert ("field_ok2", n[2, 1] = 9.75)
			assert ("field_ok3", n[3, 1] = 13.25)
			assert ("field_ok4", n[1, 2] = 9.75)
			assert ("field_ok5", n[2, 2] = 15.25)
			assert ("field_ok6", n[3, 2] = 20.75)
			assert ("field_ok7", n[1, 3] = 13.25)
			assert ("field_ok8", n[2, 3] = 20.75)
			assert ("field_ok9", n[3, 3] = 28.25)
			assert ("label_ok1", n.row_labels [2] ~ "ROW")
			assert ("label_ok2", n.column_labels [2] ~ "ROW")
		end

	test_ata
			-- Test for ATA
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			m.column_labels [2] := "COLUMN"
			n := m.ata
			assert ("width_ok", n.width = 2)
			assert ("height_ok", n.height = 2)
			assert ("square", n.is_square)
			assert ("symmetric", n.is_symmetric)
			assert ("field_ok1", n[1, 1] = 29)
			assert ("field_ok2", n[2, 1] = 24.5)
			assert ("field_ok3", n[1, 2] = 24.5)
			assert ("field_ok4", n[2, 2] = 20.75)
			assert ("label_ok1", n.row_labels [2] ~ "COLUMN")
			assert ("label_ok2", n.column_labels [2] ~ "COLUMN")
		end

	test_csv
			-- Test export to CSV
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.row_labels [1] := "A"
			m.column_labels [2] := "B"
			assert ("csv_ok", m.csv ~ ",,B%NA,2,1.5%N,3,2.5%N,4,3.5")
		end

	test_markdown
			-- Test export to markdown
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.row_labels [1] := "A"
			m.column_labels [2] := "B"
			print (m.markdown)
			assert ("markdown_ok", m.markdown ~ "|   |   | B   |%N|---|---|-----|%N| A | 2 | 1.5 |%N|   | 3 | 2.5 |%N|   | 4 | 3.5 |%N")
		end

	test_transposed
			-- Test a transposed matrix
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			m.row_labels [1] := "A"
			m.column_labels [2] := "B"
			m.put (11.00, 2, 2)
			m.put (22.00, 3, 2)
			n := m.transposed
			assert ("width_ok", n.width = 3)
			assert ("height_ok", n.height = 2)
			assert ("label_ok1", n.column_labels [1] ~ "A")
			assert ("label_ok2", n.row_labels [2] ~ "B")
			assert ("field_ok7", n[1, 1] = 2.0)
			assert ("field_ok8", n[1, 2] = 3.0)
			assert ("field_ok9", n[1, 3] = 4.0)
			assert ("field_ok10", n[2, 1] = 1.5)
			assert ("field_ok11", n[2, 2] = 11.00)
			assert ("field_ok12", n[2, 3] = 22.00)
		end

	test_transposed_large
			-- Test for matrix multiplication on a larger matrix
		local
			m, n: AL_MATRIX
			i: INTEGER
		do
			m := al.matrix (70, 30)
			m.column_by_column.fill_sequence (1.0, 1.0)
			n := m.transposed
			from
				i := 1
			until
				i > 70
			loop
				assert ("line_ok", n.column (i).is_same (m.row (i)))
				i := i + 1
			end
		end

	test_transposed_view
			-- Test a transposed view
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := m.transposed_view
			m.row_labels [1] := "A"
			n.row_labels [2] := "B"
			m.put (11.00, 2, 2)
			n.put (22.00, 2, 3)
			assert ("width_ok", n.width = 3)
			assert ("height_ok", n.height = 2)
			assert ("label_ok1", n.column_labels [1] ~ "A")
			assert ("label_ok2", m.column_labels [2] ~ "B")
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m[2, 1] = 3.0)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m[1, 2] = 1.5)
			assert ("field_ok5", m[2, 2] = 11.00)
			assert ("field_ok6", m[3, 2] = 22.00)
			assert ("field_ok7", n[1, 1] = 2.0)
			assert ("field_ok8", n[1, 2] = 3.0)
			assert ("field_ok9", n[1, 3] = 4.0)
			assert ("field_ok10", n[2, 1] = 1.5)
			assert ("field_ok11", n[2, 2] = 11.00)
			assert ("field_ok12", n[2, 3] = 22.00)
		end

	test_area
			-- Test accessing the area of a matrix
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := m.area (2, 1, 3, 2)
			m.row_labels [2] := "A"
			n.column_labels [2] := "B"
			m.put (11.00, 2, 2)
			n.put (22.00, 1, 1)
			assert ("width_ok", n.width = 2)
			assert ("height_ok", n.height = 2)
			assert ("label_ok1", n.row_labels [1] ~ "A")
			assert ("label_ok2", m.column_labels [2] ~ "B")
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m[2, 1] = 22.00)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m[1, 2] = 1.5)
			assert ("field_ok5", m[2, 2] = 11.00)
			assert ("field_ok6", m[3, 2] = 3.5)
			assert ("field_ok7", n[1, 1] = 22.00)
			assert ("field_ok8", n[2, 1] = 4.0)
			assert ("field_ok9", n[1, 2] = 11.00)
			assert ("field_ok10", n[2, 2] = 3.5)
		end

	test_area_swap
			-- Test accessing the area of a matrix, swapping elements
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := m.area (2, 1, 3, 2)
			n.swap_columns (2, 1)
			m.row_labels [2] := "A"
			n.column_labels [2] := "B"
			m.put (11.00, 2, 2)
			n.put (22.00, 2, 1)
			assert ("width_ok", n.width = 2)
			assert ("height_ok", n.height = 2)
			assert ("label_ok1", n.row_labels [1] ~ "A")
			assert ("label_ok2", m.column_labels [1] ~ "B")
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m[2, 1] = 3.0)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m[1, 2] = 1.5)
			assert ("field_ok5", m[2, 2] = 11.0)
			assert ("field_ok6", m[3, 2] = 22.0)
			assert ("field_ok7", n[1, 1] = 11.0)
			assert ("field_ok8", n[2, 1] = 22.0)
			assert ("field_ok9", n[1, 2] = 3.0)
			assert ("field_ok10", n[2, 2] = 4.0)
		end

	test_valid_row_and_column
			-- Test valid_row and valid_column
		local
			m: AL_MATRIX
		do
			m := new_matrix
			assert ("too_small", not m.is_valid_row (0))
			assert ("small", m.is_valid_row (1))
			assert ("large", m.is_valid_row (3))
			assert ("too_large", not m.is_valid_row (4))
			assert ("too_small", not m.is_valid_column (0))
			assert ("small", m.is_valid_column (1))
			assert ("large", m.is_valid_column (2))
			assert ("too_large", not m.is_valid_column (3))
		end

	test_is_square
			-- Test valid_row and valid_column
		local
			m, n: AL_MATRIX
		do
			m := new_matrix
			n := new_square_matrix
			assert ("not_sqare", not m.is_square)
			assert ("square", n.is_square)
		end

	test_is_symmetric
			-- Test symmetric detection
		local
			m: AL_MATRIX
		do
			m := al.matrix (0, 0)
			assert ("symmetric1", m.is_symmetric)
			m := al.matrix (1, 0)
			assert ("not_symmetric1", not m.is_symmetric)
			m := al.matrix (1, 1)
			assert ("symmetric2", m.is_symmetric)
			m := al.matrix_filled (2, 2, 2.0)
			assert ("symmetric3", m.is_symmetric)
			m [1, 1] := 3.0
			assert ("symmetric4", m.is_symmetric)
			m [2, 1] := 4.0
			assert ("not_symmetric2", not m.is_symmetric)
			m [1, 2] := 4.0
			assert ("symmetric5", m.is_symmetric)
		end

	test_triangle
			-- Testing for lower and upper triangle
		local
			m: AL_MATRIX
		do
			m := al.matrix (0, 0)
			assert ("upper1", m.is_upper_triangle)
			assert ("lower1", m.is_lower_triangle)
			m := al.matrix (1, 0)
			assert ("not_upper1", not m.is_upper_triangle)
			assert ("not_lower1", not m.is_lower_triangle)
			m := al.matrix (1, 1)
			assert ("upper2", m.is_upper_triangle)
			assert ("lower2", m.is_lower_triangle)
			m := al.matrix_filled (1, 1, 1.0)
			assert ("upper3", m.is_upper_triangle)
			assert ("lower3", m.is_lower_triangle)
			m := al.matrix_filled (2, 2, 1.0)
			assert ("not_upper2", not m.is_upper_triangle)
			assert ("not_lower2", not m.is_lower_triangle)
			m := al.matrix_filled (2, 2, 1.0)
			m.put (0.0, 2, 1)
			assert ("upper4", m.is_upper_triangle)
			assert ("not_lower3", not m.is_lower_triangle)
			m.put (0.0, 1, 2)
			assert ("upper5", m.is_upper_triangle)
			assert ("lower4", m.is_lower_triangle)
			m.put (-1.0, 2, 1)
			assert ("not_upper3", not m.is_upper_triangle)
			assert ("lower5", m.is_lower_triangle)
		end

	test_put
			-- Test put for matrix
		local
			m: AL_MATRIX
		do
			m := al.matrix (2, 2)
			m.put (-1.0, 1, 1)
			m.put (1.0, 1, 1)
			m.put (2.0, 2, 1)
			m [1, 2] := 3.0
			m [2, 2] := 4.0
			assert ("field_ok1", m [1,1] = 1.0)
			assert ("field_ok2", m [2,1] = 2.0)
			assert ("field_ok3", m [1,2] = 3.0)
			assert ("field_ok4", m [2,2] = 4.0)
		end

	test_fill
			-- Test fill a matrix with values
		local
			m: AL_MATRIX
		do
			m := al.matrix (3, 3)
			m.fill (11.00)
			m.area (2, 2, 3, 3).fill (22.00)
			assert ("field_ok1", m [1,1] = 11.0)
			assert ("field_ok2", m [2,1] = 11.0)
			assert ("field_ok3", m [3,1] = 11.0)
			assert ("field_ok4", m [1,2] = 11.0)
			assert ("field_ok5", m [2,2] = 22.0)
			assert ("field_ok6", m [3,2] = 22.0)
			assert ("field_ok7", m [1,3] = 11.0)
			assert ("field_ok8", m [2,3] = 22.0)
			assert ("field_ok9", m [3,3] = 22.0)
		end

	test_set_default_labels
			-- Test setting the default labels
		local
			m: AL_MATRIX
		do
			m := new_matrix
			assert ("label_ok1", m.row_labels [1] = Void)
			assert ("label_ok2", m.row_labels [2] = Void)
			assert ("label_ok3", m.row_labels [3] = Void)
			assert ("label_ok4", m.column_labels [1] = Void)
			assert ("label_ok5", m.column_labels [2] = Void)
			m.set_default_labels
			assert ("label_ok6", m.row_labels [1] ~ "row1")
			assert ("label_ok7", m.row_labels [2] ~ "row2")
			assert ("label_ok8", m.row_labels [3] ~ "row3")
			assert ("label_ok9", m.column_labels [1] ~ "column1")
			assert ("label_ok10", m.column_labels [2] ~ "column2")
		end

	test_are_all_fields_independent
			-- Testing if field are correct mark at independent
		local
			m: AL_MATRIX
		do
			m := new_matrix
			assert ("independent1", m.are_all_fields_independent)
			m := new_square_matrix
			assert ("independent2", m.are_all_fields_independent)
		end

	test_swap_rows
			-- Swapping rows
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.set_default_labels
			m.swap_rows (1, 3)
			assert ("field_ok1", m[1, 1] = 4.0)
			assert ("field_ok2", m.item (2, 1) = 3.0)
			assert ("field_ok3", m[3, 1] = 2.0)
			assert ("field_ok4", m.item (1, 2) = 3.5)
			assert ("field_ok5", m[2, 2] = 2.5)
			assert ("field_ok6", m.item (3, 2) = 1.5)
			assert ("label1_ok", m.row_labels[1] ~ "row3")
			assert ("label2_ok", m.row_labels[2] ~ "row2")
			assert ("label3_ok", m.row_labels[3] ~ "row1")
		end

	test_swap_columns
			-- Swapping columns
		local
			m: AL_MATRIX
		do
			m := new_matrix
			m.set_default_labels
			m.swap_columns (1, 2)
			print (m.csv)

			assert ("field_ok1", m[1, 1] = 1.5)
			assert ("field_ok2", m.item (2, 1) = 2.5)
			assert ("field_ok3", m[3, 1] = 3.5)
			assert ("field_ok4", m.item (1, 2) = 2.0)
			assert ("field_ok5", m[2, 2] = 3.0)
			assert ("field_ok6", m.item (3, 2) = 4.0)
			assert ("label1_ok", m.column_labels[1] ~ "column2")
			assert ("label2_ok", m.column_labels[2] ~ "column1")
		end

	test_is_unit
			-- Test `is_unit' status
		local
			m: AL_MATRIX
		do
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("unit1", m.is_unit)
			assert ("echolon1", m.is_row_echolon)
			m := al.unit (7)
			assert ("unit2", m.is_unit)
			assert ("echolon2", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 0.0 >> >>)
			assert ("unit3", not m.is_unit)
			assert ("echolon3", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 0.0, 1.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("unit4", not m.is_unit)
			assert ("echolon4", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >>, << 0.0, 0.0, 0.0 >> >>)
			assert ("unit5", not m.is_unit)
			assert ("echolon5", m.is_row_echolon)
		end

	test_is_pivot
			-- Test `is_pivot' status
		local
			m: AL_MATRIX
		do
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("pivot1", m.is_pivot)
			m := al.array_matrix (<< << 0.0, 0.0, 1.0 >>, << 0.0, 1.0, 0.0 >>, << 1.0, 0.0, 0.0 >> >>)
			assert ("pivot2", m.is_pivot)
			m := al.array_matrix (<< << 0.0, 1.0, 0.0 >>, << 1.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("pivot3", m.is_pivot)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >>, << 0.0, 1.0, 0.0 >> >>)
			assert ("pivot4", m.is_pivot)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 1.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("pivot5", not m.is_pivot)
			m := al.array_matrix (<< << 0.0, 1.0, 1.0 >>, << 0.0, 1.0, 0.0 >>, << 1.0, 0.0, 0.0 >> >>)
			assert ("pivot6", not m.is_pivot)
			m := al.array_matrix (<< << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >> >>)
			assert ("pivot7", not m.is_pivot)
			m := al.array_matrix (<< << 2.0, 0.0, 0.0 >>, << 0.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >> >>)
			assert ("pivot8", not m.is_pivot)
		end

	test_is_row_echolon
			-- Some extra `is_row_echolon' tests
		local
			m: AL_MATRIX
		do
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 1.0 >>, << 0.0, 0.0, 0.0 >>  >>)
			assert ("echolon1", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0 >>, << 0.0, 1.0, 0.0 >>, << 0.0, 0.0, 0.0 >>, << 0.0, 0.0, 1.0 >>  >>)
			assert ("echolon2", not m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 2.0, 3.0 >>, << 0.0, 1.0, 2.0 >>, << 0.0, 0.0, 1.0 >>  >>)
			assert ("echolon3", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 2.0, 3.0 >>, << 0.0, 2.0, 2.0 >>, << 0.0, 0.0, 1.0 >>  >>)
			assert ("echolon4", m.is_row_echolon)
			m := al.array_matrix (<< << 1.0, 0.0, 0.0, 0.0 >>, << 0.0, 1.0, 2.0, 1.0 >>, << 0.0, 0.0, 0.0, 1.0 >>  >>)
			assert ("echolon5", m.is_row_echolon)
		end


end


