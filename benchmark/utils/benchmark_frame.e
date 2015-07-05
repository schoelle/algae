note
	description: "Frame that contains a benchmark"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_FRAME

inherit
	ITERABLE [INTEGER]

create
	make

feature -- Initialization

	make (a_group, a_name: STRING; a_loops: INTEGER)
			-- Setup this benchmark frame to run `a_loops' iterations, with name `a_name'.
		require
			positive_loops: a_loops > 0
		do
			group := a_group
			name := a_name
			loops := a_loops
		end

feature -- Access

	group: STRING
		-- Group of the frame

	name: STRING
		-- Name of the frame

	loops: INTEGER
		-- Number of iterations within the benchmark

	new_cursor: BENCHMARK_CURSOR
			-- The cursor counting the iterations
		do
			create Result.make (group, name, loops)
		end

end
