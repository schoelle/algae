note
	description: "Data structure storing labels"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_REAL_MATRIX_LABELS

inherit
	AL_LABELS
		redefine
			copy_into, wipe_out
		end

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_count: INTEGER; a_matrix: AL_MATRIX)
			-- Create a labels store of size `a_count'
		require
			valid_count: a_count >= 0
		do
			count := a_count
			create labels.make_filled (Void, 1, count)
			create table.make_equal (count)
			matrix := a_matrix
		end

feature -- Access

	item alias "[]" (a_index: INTEGER): detachable STRING assign put
			-- <Precursor>
		do
			Result := labels.item (a_index)
		end

	underlying_matrix: AL_REAL_MATRIX
			-- <Precursor>
		do
			Result := matrix.underlying_matrix
		end

feature -- Status report

	is_valid_label (a_label: detachable STRING): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	has (a_label: STRING): BOOLEAN
			-- <Precursor>
		do
			Result := table.has (a_label)
		end

feature -- Measurement

	count: INTEGER
			-- <Precursor>

	index (a_label: STRING): INTEGER
			-- <Precursor>
		do
			Result := table.item (a_label)
		end

feature -- Settors

	put (a_label: detachable STRING; a_index: INTEGER)
			-- <Precursor>
		do
			if attached a_label as l_label then
				if attached labels.item (a_index) as l_old_label and then l_old_label /~ a_label then
					table.remove (l_old_label)
				end
				table.put (a_index, l_label)
				labels.put (l_label, a_index)
			elseif attached labels.item (a_index) as l_old_label then
				table.remove (l_old_label)
				labels.put (Void, a_index)
			end
		end

	wipe_out
			-- <Precursor>
		do
			labels.fill_with (Void)
			table.wipe_out
		end

feature -- INTO Operations

	copy_into (a_target: AL_LABELS)
			-- Copy all labels from `Current' into `a_target'.
		do
			if attached {AL_REAL_MATRIX_LABELS} a_target as l_dense_target then
				l_dense_target.table.copy (table)
				l_dense_target.labels.copy (labels)
			else
				Precursor (a_target)
			end
		end

feature {AL_INTERNAL} -- Implementation

	matrix: AL_MATRIX
		-- Matrix these labels are part of

	table: HASH_TABLE [INTEGER, STRING]
		-- Table for lookups label to index

	labels: ARRAY [detachable STRING]
		-- Array for lookup index to label

end
