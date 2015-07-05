note
	description: "Simple wrapper class, to make creating a benchmark nicer to read"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_USER

feature -- Access

	benchmark (a_group, a_name: STRING; a_loops: INTEGER): BENCHMARK_FRAME
			-- Run benchmark `a_name' using `a_loops' number of iterations, and print the time
		require
			positive_loops: a_loops > 0
		do
			create Result.make (a_group, a_name, a_loops)
		end

end
