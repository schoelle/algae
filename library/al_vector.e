note
	description: "A data vector (always a view on top of a AL_REAL_MATRIX)"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_VECTOR

inherit
	AL_INTERNAL
	ITERABLE [DOUBLE]
	AL_DOUBLE_HANDLER

feature -- Access

	underlying_matrix: AL_REAL_MATRIX
			-- Matrix underlying this vector
		deferred
		end

	item alias "[]" (a_index: INTEGER): DOUBLE assign put
			-- Value at index `a_index'
		require
			valid_index: is_valid_index (a_index)
		deferred
		end

	name: detachable STRING
			-- Name of the vector
		deferred
		end

	labels: AL_LABELS
			-- Labels of the vector
		deferred
		end

	new_cursor: AL_VECTOR_CURSOR
			-- <Precursor>
		deferred
		end

	row_for_index (a_index: INTEGER): INTEGER
			-- Row in `matrix' that represents field at `a_index'
		require
			valid_index: is_valid_index (a_index)
		deferred
		end

	column_for_index (a_index: INTEGER): INTEGER
			-- Column in `matrix' that represents field at `a_index'
		require
			valid_index: is_valid_index (a_index)
		deferred
		end

	matrix: AL_MATRIX
			-- Marix this vector is taken from
		deferred
		end

	to_array: ARRAY[DOUBLE]
			-- Values of the vector as an array of doubles
		do
			create Result.make (1, count)
			across
				Current as l_cursor
			loop
				Result.put (l_cursor.item, l_cursor.index)
			end
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements in the vector
		deferred
		ensure
			positive: count >= 0
		end

feature -- Statistics

	mean: DOUBLE
			-- Mean value of all values
		require
			not_empty: not is_empty
		do
			Result := sum / count
		end

	median: DOUBLE
			-- Median value of all values (mean of two median values on even count)
		require
			not_empty: not is_empty
		local
			l_mid: INTEGER
			l_values: ARRAY[DOUBLE]
		do
			l_values := to_array
			quick_sort (l_values.area, 0, count)
			l_mid := count // 2
			if count \\ 2 = 0 then
				Result := (l_values.item (l_mid) + l_values.item (l_mid + 1)) / 2
			else
				Result := l_values.item (l_mid + 1)
			end
		end

	sum: DOUBLE
			-- Sum of all values
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				Result := Result + item (l_index)
				l_index := l_index + 1
			end
		end

	max: DOUBLE
			-- Maximum of all values
		require
			not_empty: not is_empty
		local
			l_index: INTEGER
		do
			Result := item (1)
			from
				l_index := 2
			until
				l_index > count
			loop
				if item (l_index) > Result then
					Result := item (l_index)
				end
				l_index := l_index + 1
			end
		end

	min: DOUBLE
			-- Minimum of all values
		require
			not_empty: not is_empty
		local
			l_index: INTEGER
		do
			Result := item (1)
			from
				l_index := 2
			until
				l_index > count
			loop
				if item (l_index) < Result then
					Result := item (l_index)
				end
				l_index := l_index + 1
			end
		end

	times (a_other: AL_VECTOR): DOUBLE
			-- Vector product
		require
			same_length: count = a_other.count
		local
			l_index: INTEGER
		do
			from
				Result := 0
				l_index := 1
			until
				l_index > count
			loop
				Result := Result + item (l_index) * a_other.item (l_index)
				l_index := l_index + 1
			end
		end

feature -- Status

	is_valid_index (a_index: INTEGER): BOOLEAN
			-- Is `a_index' a valid index?
		do
			Result := a_index >= 0 and a_index <= count
		ensure
			definition: Result = (a_index >= 0 and a_index <= count)
		end

	is_empty: BOOLEAN
			-- Is this the empty vector?
		do
			Result := count = 0
		ensure
			definition: Result = (count = 0)
		end

	has_same_values (a_other: AL_VECTOR): BOOLEAN
			-- Has `a_other' the same values as `Current'?
		local
			l_i: INTEGER
		do
			if count = a_other.count then
				Result := True
				from
					l_i := 1
				until
					l_i > count or not Result
				loop
					Result := same_double (item(l_i), a_other.item (l_i))
					l_i := l_i + 1
				end
			end
		end

	is_same (a_other: AL_VECTOR): BOOLEAN
			-- Is `a_other' the same vector as `Current'?
		do
			Result := has_same_values (a_other) and
				(name ~ a_other.name) and
				labels.is_same (a_other.labels)
		end

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- Store `a_value' at `a_index'.
		require
			valid_index: is_valid_index (a_index)
		deferred
		ensure
			value_set: same_double (item (a_index), a_value)
		end

	set_all (a_values: AL_VECTOR)
			-- Set all values to match `a_values'.
		require
			same_length: a_values.count = count
		do
			across
				Current as l_cursor
			loop
				l_cursor.put (a_values [l_cursor.index])
			end
		end

	set_all_array (a_values: ARRAY[DOUBLE])
			-- Set all values to match `a_values'.
		require
			same_length: a_values.count = count
		do
			across
				Current as l_cursor
			loop
				l_cursor.put (a_values [l_cursor.index + a_values.lower - 1])
			end
		end

	fill (a_value: DOUBLE)
			-- Fill all elements of the vector with `a_value'.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (a_value, l_index)
				l_index := l_index + 1
			end
		end

	fill_sequence (a_first, a_increment: DOUBLE)
			-- Fill all elements of the vector, starting at `a_first' and incrementing by `a_increment'.
		local
			l_index: INTEGER
			l_value: DOUBLE
		do
			from
				l_index := 1
				l_value := a_first
			until
				l_index > count
			loop
				put (l_value, l_index)
				l_value := l_value + a_increment
				l_index := l_index + 1
			end
		end

	scale (a_value: DOUBLE)
			-- Scale all values by `a_value'.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (item (l_index) * a_value, l_index)
				l_index := l_index + 1
			end
		end

	multiply (a_vector: AL_VECTOR)
			-- Multiply each value by the corresponding value of `a_vector'.
		require
			same_size: a_vector.count = count
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (item (l_index) * a_vector.item (l_index), l_index)
				l_index := l_index + 1
			end
		end

	add (a_value: DOUBLE)
			-- Add `a_value' to all values
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (item (l_index) + a_value, l_index)
				l_index := l_index + 1
			end
		end

	add_vector (a_vector: AL_VECTOR)
			-- Add `a_value' to all values
		require
			same_size: a_vector.count = count
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (item (l_index) + a_vector.item (l_index), l_index)
				l_index := l_index + 1
			end
		end

	add_scaled_vector (a_vector: AL_VECTOR; a_scale: DOUBLE)
			-- Add `a_value' times `a_scale' to all values.
		require
			same_size: a_vector.count = count
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (item (l_index) + a_vector.item (l_index) * a_scale, l_index)
				l_index := l_index + 1
			end
		end

	round_all
			-- Round all values according to `epsilon'.
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (round_double (item (l_index)), l_index)
				l_index := l_index + 1
			end
		end

	set_name (a_name: detachable STRING)
			-- Set name to `a_name'.
		deferred
		ensure
			name_set: name ~ a_name
		end

feature {NONE} -- Implementation

	quick_sort (a_data: SPECIAL[DOUBLE]; a_start, a_count: INTEGER)
			-- Sort `a_data' region starting at index `a_start' (from 0) and `a_count' elements long.
		require
			valid_start: a_start >= 0 and a_start < a_data.count
			valid_count: a_count > 0 and (a_start + a_count) <= a_data.count
		local
			l_pivot, l_tmp: DOUBLE
			i, j: INTEGER
		do
			if a_count > 2 then
				l_pivot := a_data[a_start]
				from
					i := a_start + 1
					j := a_start + a_count - 1
				until
					i >= j
				loop
					from
					until
						a_data[j] < l_pivot or i >= j
					loop
						j := j - 1
					end
					from
					until
						a_data[i] > l_pivot or i >= j
					loop
						i := i + 1
					end
					if i < j then
						l_tmp := a_data[i]
						a_data[i] := a_data[j]
						a_data[j] := l_tmp
					end
				end
				a_data[a_start] := a_data[i]
				a_data[i] := l_pivot
				quick_sort (a_data, a_start, i - a_start)
				quick_sort (a_data, i + 1, a_count + a_start - i - 1)
			elseif a_count = 2 and a_data[a_start] > a_data[a_start + 1] then
				l_tmp := a_data[a_start]
				a_data[a_start] := a_data[a_start + 1]
				a_data[a_start + 1] := l_tmp
			end
		end

end
