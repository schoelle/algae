note
	description: "Cursor for iterating a number of times through a test"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	BENCHMARK_CURSOR

inherit
	ITERATION_CURSOR [INTEGER]
	BENCHMARK_CONSTANTS

create
	make

feature -- Initalization

	make (a_group, a_name: STRING; a_loops: INTEGER)
			-- Run `multiplier' * `a_loops' iterations, with the benchmark called `a_name'
		require
			positive_loops: a_loops > 0
		do
			item := 1
			loops := a_loops
			name := a_name
			group := a_group
			start_time := (create {TIME}.make_now).fine_seconds
			if not attached domain.item or else domain.item ~ group then
				if not attached test.item or else test.item ~ name  then
					run_tests := True
				end
			end
			if not run_tests then
				print ("# Skipping " + group + "," + name + "%N")
			end
		end

feature -- Access

	item: INTEGER
		-- Current iteration count

	loops: INTEGER
		-- Number of loops within the benchmark

	name: STRING
		-- Name of the benchmark

	group: STRING
		-- Group of the benchmark

	start_time: DOUBLE
		-- Start time of the benchmark execution

	run_tests: BOOLEAN
		-- Do we actually run the tests? (selected at command line)

feature -- Status report

	after: BOOLEAN
			-- <Precursor>
		do
			Result := not run_tests or item > (multiplier.item * loops)
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		local
			l_end_time: DOUBLE
			l_time: DOUBLE
		do
			item := item + 1
			if item > multiplier.item * loops then
				l_end_time := (create {TIME}.make_now).fine_seconds
				l_time := l_end_time - start_time
				print (group + "," + name + "," + multiplier.item.out + "," + l_time.out + "%N")
			end
		end

end
