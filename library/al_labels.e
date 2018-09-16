note
	description: "A sequence of labels, for vectors and matrix column/rows"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

deferred class
	AL_LABELS

inherit
	AL_INTERNAL
	ITERABLE [detachable STRING]

feature -- Access

	item alias "[]" (a_index: INTEGER): detachable STRING assign put
			-- Label at position `a_index'
		require
			valid_index: is_valid_index (a_index)
		deferred
		end

	new_cursor: AL_LABEL_CURSOR
			-- <Precursor>
		do
			create {AL_LABEL_CURSOR} Result.make (Current)
		end

	underlying_matrix: AL_REAL_MATRIX
			-- The underlying matrix for these labels
		deferred
		end

	to_array: ARRAY [detachable STRING]
			-- All the labels in a single array
		do
			create Result.make_filled (Void, 1, count)
			across
				Current as l_cursor
			loop
				Result [l_cursor.index] := l_cursor.item
			end
		ensure
			correct_length: Result.count = count
		end

feature -- Status report

	is_valid_index (a_index: INTEGER): BOOLEAN
			-- Is `a_index' a valid index?
		do
			Result := (a_index >= 1) and (a_index <= count)
		ensure
			definition: Result = ((a_index >= 1) and (a_index <= count))
		end

	is_valid_label (a_label: detachable STRING): BOOLEAN
			-- Is `a_label' a valid label?
		deferred
		end

	has (a_label: STRING): BOOLEAN
			-- Is there a label called `a_label'?
		deferred
		end

	is_same (a_other: AL_LABELS): BOOLEAN
			-- If `a_other' the same as `Current'?
		local
			l_index: INTEGER
		do
			if count = a_other.count then
				from
					l_index := 1
					Result := True
				until
					l_index > count or not Result
				loop
					Result := Result and (item (l_index) ~ a_other.item (l_index))
					l_index := l_index + 1
				end
			end
		end

	are_all_labels_valid (a_labels: AL_LABELS): BOOLEAN
			-- Are all labels in `a_labels' valid in `Current'?
		local
			l_index: INTEGER
		do
			from
				l_index := 1
				Result := True
			until
				not Result or l_index > a_labels.count
			loop
				Result := is_valid_label (a_labels.item (l_index))
				l_index := l_index + 1
			end
		end

feature -- Measurement

	count: INTEGER
			-- Number of labels
		deferred
		ensure
			positive: Result >= 0
		end

	index (a_label: STRING): INTEGER
			-- Index of label `a_label'
		require
			has_label: has (a_label)
		deferred
		end

feature -- INTO Operations

	copy_into (a_target: AL_LABELS)
			-- Copy all labels from `Current' into `a_target'.
		require
			same_size: a_target.count = count
			labels_are_valid: a_target.are_all_labels_valid (Current)
		local
			l_index: INTEGER
		do
			a_target.wipe_out
			from
				l_index := 1
			until
				l_index > count
			loop
				a_target.put (item (l_index), l_index)
				l_index := l_index + 1
			end
		end

feature -- Settors

	put (a_label: detachable STRING; a_index: INTEGER)
			-- Set `label' at index `a_index' to `a_label'.
		require
			valid_index: is_valid_index (a_index)
			valid_label: is_valid_label (a_label)
			not_there_already: attached a_label implies (has (a_label) implies (a_index = index (a_label)))
		deferred
		ensure
			label_set: item (a_index) ~ a_label
		end

	set_all (a_labels: ARRAY [detachable STRING])
			-- Set all labels to `a_labels'.
		require
			size_ok: a_labels.count = count
			no_duplicates: not has_duplicates (a_labels)
		local
			l_offset: INTEGER
			l_index: INTEGER
		do
			from
				l_offset := a_labels.lower - 1
				l_index := 1
			until
				l_index > count
			loop
				put (a_labels.item (l_index - l_offset), l_index)
				l_index := l_index + 1
			end
		end

	wipe_out
			-- Remove all labels
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				put (Void, l_index)
				l_index := l_index + 1
			end
		end

	set_default (a_prefix: STRING)
			-- Set some default labels ("prefix1", "prefix2", ...) for all unset labels
		local
			l_index: INTEGER
		do
			from
				l_index := 1
			until
				l_index > count
			loop
				if not attached item (l_index) then
					put (a_prefix + l_index.out, l_index)
				end
				l_index := l_index + 1
			end
		end

	swap (a_first_index, a_second_index: INTEGER)
			-- Swap the labels at `a_first_index' and `a_second_index'.
		require
			first_valid: is_valid_index (a_first_index)
			second_valid: is_valid_index (a_second_index)
		local
			l_tmp_first, l_tmp_second: detachable STRING
		do
			l_tmp_first := item (a_first_index)
			l_tmp_second := item (a_second_index)
			put (Void, a_first_index)
			put (l_tmp_first, a_second_index)
			put (l_tmp_second, a_first_index)
		end

feature -- Contract support

	has_duplicates (a_labels: ARRAY[detachable STRING]): BOOLEAN
			-- Does `a_labels' have any duplicates?
		local
			l_set: HASH_TABLE [BOOLEAN, STRING]
			l_index: INTEGER
			l_item: detachable STRING
		do
			create l_set.make_equal (a_labels.count)
			from
				l_index := a_labels.lower
			until
				l_index > a_labels.upper or Result
			loop
				l_item := a_labels [l_index]
				if attached l_item as l_string then
					Result := l_set.has (l_string)
					if not Result then
						l_set [l_string] := True
					end
				end
				l_index := l_index + 1
			end
		end

end
