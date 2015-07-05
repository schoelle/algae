note
	description: "Test for AL_SYMMETRIC_MATRIX"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"
	testing: "type/manual"

class
	SYMMETRIC_MATRIX_TESTS

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
			m := al.symmetric_matrix (2)
			assert ("height_ok", m.height = 2)
			assert ("width_ok", m.width = 2)
			assert ("no_labels1", m.row_labels [1] = Void)
			assert ("no_labels2", m.row_labels [2] = Void)
			assert ("no_labels3", m.column_labels [1] = Void)
			assert ("no_labels4", m.column_labels [2] = Void)
			assert ("field_zero1", m [1,1] = 0.0)
			assert ("field_zero2", m [1,2] = 0.0)
			assert ("field_zero3", m [2,1] = 0.0)
			assert ("field_zero4", m [2,2] = 0.0)
		end

	test_filled_creation
			-- Test the creation of a filled matrix
		local
			m: AL_MATRIX
		do
			m := al.symmetric_matrix_filled (2, 3.0)
			assert ("height_ok", m.height = 2)
			assert ("width_ok", m.width = 2)
			assert ("no_labels1", m.row_labels [1] = Void)
			assert ("no_labels2", m.row_labels [2] = Void)
			assert ("no_labels3", m.column_labels [1] = Void)
			assert ("no_labels4", m.column_labels [2] = Void)
			assert ("field_zero1", m [1,1] = 3.0)
			assert ("field_zero2", m [1,2] = 3.0)
			assert ("field_zero3", m [2,1] = 3.0)
			assert ("field_zero4", m [2,2] = 3.0)
		end

	test_zero_matrix
			-- Create a matrix with zero height
		local
			m: AL_MATRIX
		do
			m := al.symmetric_matrix (0)
			assert ("height_ok", m.height = 0)
			assert ("width_ok", m.width = 0)
		end

	test_item
			-- Accessing fields
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok2", m.item (2, 1) = 3.0)
			assert ("field_ok3", m[3, 1] = 4.0)
			assert ("field_ok4", m.item (1, 2) = 3.0)
			assert ("field_ok5", m[2, 2] = 5.0)
			assert ("field_ok6", m.item (3, 2) = 6.0)
			assert ("field_ok7", m[1, 3] = 4.0)
			assert ("field_ok8", m.item (2, 3) = 6.0)
			assert ("field_ok9", m[3, 3] = 7.0)
		end

	test_labels
			-- Test access to row labels
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			m.row_labels [2] := "A"
			m.column_labels [3] := "B"
			assert ("label_void1", m.row_labels [1] = Void)
			assert ("label_void2", m.column_labels [1] = Void)
			assert ("label_not_void1", m.row_labels [2] ~ "A")
			assert ("label_not_void2", m.column_labels [2] ~ "A")
			assert ("label_not_void3", m.row_labels [3] ~ "B")
			assert ("label_not_void4", m.column_labels [3] ~ "B")
		end

	test_row
			-- Test access to a row
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			v := m.row (1)
			m.set_default_labels
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 3.0)
			assert ("value_ok3", v [3] = 4.0)
			assert ("label_ok", v.name ~ "item1")
		end

	test_column
			-- Test access to a column
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			v := m.column (3)
			m.set_default_labels
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 4.0)
			assert ("value_ok2", v [2] = 6.0)
			assert ("value_ok3", v [3] = 7.0)
			assert ("label_ok", v.name ~ "item3")
		end

	test_row_labeled
			-- Test access to a row by label
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			m.set_default_labels
			v := m.row_labeled ("item1")
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 3.0)
			assert ("value_ok3", v [3] = 4.0)
			assert ("label_ok", v.name ~ "item1")
		end

	test_column_labeled
			-- Test access to a column by label
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			m.set_default_labels
			v := m.column_labeled ("item3")
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 4.0)
			assert ("value_ok2", v [2] = 6.0)
			assert ("value_ok3", v [3] = 7.0)
			assert ("label_ok", v.name ~ "item3")
		end

	test_diagonal
			-- Test access to the diagonal
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			m.set_default_labels
			v := m.diagonal
			assert ("size_ok", v.count = 3)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 5.0)
			assert ("value_ok3", v [3] = 7.0)
			assert ("label_ok", v.name = Void)
		end

	test_column_by_column
			-- Test access to the column_by_column vector
		local
			m: AL_MATRIX
			v: AL_VECTOR
		do
			m := new_symmetric_matrix
			m.set_default_labels
			v := m.column_by_column
			assert ("size_ok", v.count = 9)
			assert ("value_ok1", v [1] = 2.0)
			assert ("value_ok2", v [2] = 3.0)
			assert ("value_ok3", v [3] = 4.0)
			assert ("value_ok4", v [4] = 3.0)
			assert ("value_ok5", v [5] = 5.0)
			assert ("value_ok6", v [6] = 6.0)
			assert ("value_ok7", v [7] = 4.0)
			assert ("value_ok8", v [8] = 6.0)
			assert ("value_ok9", v [9] = 7.0)
			assert ("label_ok", v.name = Void)
		end

	test_underlying_matrix
			-- Test the underlying matrix
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			n := m.transposed_view
			assert ("original_real", m.underlying_matrix = m)
			assert ("view_on_original", n.underlying_matrix = m)
		end

	test_real
			-- Test access to the real matrix
		local
			m, n, o: AL_MATRIX
		do
			m := new_symmetric_matrix
			n := m.transposed_view
			o := n.real
			assert ("original_real", m.underlying_matrix = m)
			assert ("view_made_real", o.underlying_matrix = o)
		end

	test_duplicated
			-- Test for matrix duplication
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			n := m.duplicated
			m.put (11.00, 2, 2)
			m.row_labels [1] := "First"
			n.put (22.00, 1, 1)
			n.row_labels [2] := "Second"
			assert ("field_ok1", m[1, 1] = 2.0)
			assert ("field_ok5", m[2, 2] = 11.00)
			assert ("label_ok1", m.row_labels[1] ~ "First")
			assert ("label_ok2", m.row_labels[2] = Void)
			assert ("field_ok7", n[1, 1] = 22.00)
			assert ("field_ok11", n[2, 2] = 5.0)
			assert ("label_ok1", n.row_labels[1] = Void)
			assert ("label_ok2", n.row_labels[2] ~ "Second")
		end

	test_times
			-- Test for matrix multiplication
		local
			m, n, o: AL_MATRIX
		do
			m := new_symmetric_matrix
			m.row_labels [2] := "ROW"
			n := new_matrix
			n.column_labels [2] := "COLUMN"
			o := m.times (n)
			assert ("width_ok", o.width = 2)
			assert ("height_ok", o.height = 3)
			assert ("field_ok1", o[1, 1] = 29)
			assert ("field_ok2", o[2, 1] = 45)
			assert ("field_ok3", o[3, 1] = 54)
			assert ("field_ok4", o[1, 2] = 24.5)
			assert ("field_ok5", o[2, 2] = 38)
			assert ("field_ok6", o[3, 2] = 45.5)
			assert ("label_ok1", o.row_labels [2] ~ "ROW")
			assert ("label_ok2", o.column_labels [2] ~ "COLUMN")
		end

	test_aat
			-- Test for AAT
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			m.row_labels [2] := "ROW"
			n := m.aat
			assert ("width_ok", n.width = 3)
			assert ("height_ok", n.height = 3)
			assert ("square", n.is_square)
			assert ("symmetric", n.is_symmetric)
			assert ("field_ok1", n[1, 1] = 29)
			assert ("field_ok2", n[2, 1] = 45)
			assert ("field_ok3", n[3, 1] = 54)
			assert ("field_ok4", n[1, 2] = 45)
			assert ("field_ok5", n[2, 2] = 70)
			assert ("field_ok6", n[3, 2] = 84)
			assert ("field_ok7", n[1, 3] = 54)
			assert ("field_ok8", n[2, 3] = 84)
			assert ("field_ok9", n[3, 3] = 101)
			assert ("label_ok1", n.row_labels [2] ~ "ROW")
			assert ("label_ok2", n.column_labels [2] ~ "ROW")
		end

	test_ata
			-- Test for ATA
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			m.row_labels [2] := "ROW"
			n := m.ata
			assert ("width_ok", n.width = 3)
			assert ("height_ok", n.height = 3)
			assert ("square", n.is_square)
			assert ("symmetric", n.is_symmetric)
			assert ("field_ok1", n[1, 1] = 29)
			assert ("field_ok2", n[2, 1] = 45)
			assert ("field_ok3", n[3, 1] = 54)
			assert ("field_ok4", n[1, 2] = 45)
			assert ("field_ok5", n[2, 2] = 70)
			assert ("field_ok6", n[3, 2] = 84)
			assert ("field_ok7", n[1, 3] = 54)
			assert ("field_ok8", n[2, 3] = 84)
			assert ("field_ok9", n[3, 3] = 101)
			assert ("label_ok1", n.row_labels [2] ~ "ROW")
			assert ("label_ok2", n.column_labels [2] ~ "ROW")
		end

	test_csv
			-- Test export to CSV
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			m.row_labels [1] := "A"
			m.column_labels [2] := "B"
			assert ("csv_ok", m.csv ~ ",A,B,%NA,2,3,4%NB,3,5,6%N,4,6,7")
		end

	test_transposed_view
			-- Test a transposed view
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			n := m.transposed_view
			m.row_labels [1] := "A"
			n.row_labels [2] := "B"
			assert ("same", m.is_same (n))
		end

	test_area
			-- Test accessing the area of a matrix
		local
			m, n: AL_MATRIX
		do
			m := new_symmetric_matrix
			n := m.area (2, 1, 3, 2)
			m.row_labels [2] := "A"
			n.column_labels [1] := "B"
			m.put (11.00, 2, 2)
			n.put (22.00, 1, 1)
			assert ("width_ok", n.width = 2)
			assert ("height_ok", n.height = 2)
			assert ("label_ok1", m.row_labels [1] ~ "B")
			assert ("label_ok2", m.column_labels [2] ~ "A")
			assert ("label_ok3", n.row_labels [1] ~ "A")
			assert ("label_ok4", n.column_labels [2] ~ "A")
			assert ("field_ok1", m[1, 1] = 2)
			assert ("field_ok2", m[2, 1] = 22)
			assert ("field_ok3", m[3, 1] = 4)
			assert ("field_ok4", m[1, 2] = 22)
			assert ("field_ok5", m[2, 2] = 11)
			assert ("field_ok6", m[3, 2] = 6)
			assert ("field_ok7", m[1, 3] = 4)
			assert ("field_ok8", m[2, 3] = 6)
			assert ("field_ok9", m[3, 3] = 7)
			assert ("field_ok10", n[1, 1] = 22)
			assert ("field_ok11", n[2, 1] = 4)
			assert ("field_ok12", n[1, 2] = 11)
			assert ("field_ok13", n[2, 2] = 6)
		end

	test_valid_row_and_column
			-- Test valid_row and valid_column
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("too_small", not m.is_valid_row (0))
			assert ("small", m.is_valid_row (1))
			assert ("large", m.is_valid_row (3))
			assert ("too_large", not m.is_valid_row (4))
			assert ("too_small", not m.is_valid_column (0))
			assert ("small", m.is_valid_column (1))
			assert ("large", m.is_valid_column (3))
			assert ("too_large", not m.is_valid_column (4))
		end

	test_is_square
			-- Test valid_row and valid_column
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("square", m.is_square)
		end

	test_is_symmetric
			-- Test symmetric detection
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("symmetric", m.is_symmetric)
		end

	test_put
			-- Test put for matrix
		local
			m: AL_MATRIX
		do
			m := al.symmetric_matrix (2)
			m.put (-1.0, 1, 1)
			m.put (1.0, 1, 1)
			m.put (2.0, 2, 1)
			m [2, 2] := 3.0
			assert ("field_ok1", m [1,1] = 1.0)
			assert ("field_ok2", m [2,1] = 2.0)
			assert ("field_ok3", m [1,2] = 2.0)
			assert ("field_ok4", m [2,2] = 3.0)
		end

	test_fill
			-- Test fill a matrix with values
		local
			m: AL_MATRIX
		do
			m := al.symmetric_matrix (3)
			m.fill (11.00)
			m.area (2, 1, 3, 2).fill (22.00)
			assert ("field_ok1", m [1,1] = 11.0)
			assert ("field_ok2", m [2,1] = 22.0)
			assert ("field_ok3", m [3,1] = 22.0)
			assert ("field_ok4", m [1,2] = 22.0)
			assert ("field_ok5", m [2,2] = 22.0)
			assert ("field_ok6", m [3,2] = 22.0)
			assert ("field_ok7", m [1,3] = 22.0)
			assert ("field_ok8", m [2,3] = 22.0)
			assert ("field_ok9", m [3,3] = 11.0)
		end

	test_set_default_labels
			-- Test setting the default labels
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("label_ok1", m.row_labels [1] = Void)
			assert ("label_ok2", m.row_labels [2] = Void)
			assert ("label_ok3", m.row_labels [3] = Void)
			assert ("label_ok4", m.column_labels [1] = Void)
			assert ("label_ok5", m.column_labels [2] = Void)
			assert ("label_ok6", m.column_labels [3] = Void)
			m.set_default_labels
			assert ("label_ok7", m.row_labels [1] ~ "item1")
			assert ("label_ok8", m.row_labels [2] ~ "item2")
			assert ("label_ok9", m.row_labels [3] ~ "item3")
			assert ("label_ok10", m.column_labels [1] ~ "item1")
			assert ("label_ok11", m.column_labels [2] ~ "item2")
			assert ("label_ok12", m.column_labels [3] ~ "item3")
		end

	test_are_all_fields_independent
			-- Testing of field are correct mark at NOT independent
		local
			m: AL_MATRIX
		do
			m := new_symmetric_matrix
			assert ("not_independent", not m.are_all_fields_independent)
		end



end


