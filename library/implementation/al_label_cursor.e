note
	description: "Cursor on a AL_LABELS structure"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	AL_LABEL_CURSOR

inherit
	ITERATION_CURSOR [detachable STRING]

create {AL_INTERNAL}
	make

feature {NONE} -- Initialization

	make (a_target: AL_LABELS)
			-- Create a cursor at position 1 on `a_target'.
		do
			target := a_target
			index := 1
		end

feature -- Access

	item: detachable STRING
			-- Item at current cursor position.
		do
			Result := target.item (index)
		end

feature -- Status report	

	after: BOOLEAN
			-- Are there no more items to iterate over?
		do
			Result := (index > target.count)
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			index := index + 1
		end

	index: INTEGER
		-- Current index

feature {NONE} -- Implementation

	target: AL_LABELS
		-- Target AL_LABESL

end
