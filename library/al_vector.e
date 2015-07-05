note
	description: "A data vector (always a view on top of a AL_REAL_MATRIX)"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_VECTOR

inherit
	AL_INTERNAL
	ITERABLE [DOUBLE]

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

feature -- Operations

	put (a_value: DOUBLE; a_index: INTEGER)
			-- Store `a_value' at `a_index'.
		require
			valid_index: is_valid_index (a_index)
		deferred
		ensure
			value_set: item (a_index) = a_value
		end

	set_all (a_values: ARRAY[DOUBLE])
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

	set_name (a_name: detachable STRING)
			-- Set name to `a_name'.
		deferred
		ensure
			name_set: name ~ a_name
		end

end
