note
	description : "Algea Application root class - runs the benchmarks"
	author: "Bernd Schoeller"
	license: "Eiffel Forum License, Version 2"

class
	RUN_BENCHMARKS

inherit
	ARGUMENTS
	ALGAE_USER
	BENCHMARK_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			init_config
			create benchmark_dense_matrix
			create benchmark_symmetric_matrix
			create benchmark_partial_matrix
			benchmark_dense_matrix.run
			benchmark_symmetric_matrix.run
			benchmark_partial_matrix.run
		end

feature -- Access

	benchmark_dense_matrix: BENCHMARK_DENSE_MATRIX
		-- Benchmarks for AL_DENSE_MATRIX

	benchmark_symmetric_matrix: BENCHMARK_SYMMETRIC_MATRIX
		-- Benchmarks for AL_SYMMETRIC_MATRIX

	benchmark_partial_matrix: BENCHMARK_PARTIAL_MATRIX
		-- Benchmarks for AL_PARTIAL_MATRIX

feature -- Implementation

	init_config
			-- Initialize the multiplier from the argument
		local
			l_environment: EXECUTION_ENVIRONMENT
		do
			create l_environment
			if l_environment.arguments.argument_count > 0 then
				multiplier.put (l_environment.arguments.argument (1).to_integer)
			end
			if l_environment.arguments.argument_count > 1 then
				domain.put (l_environment.arguments.argument (2).out)
			end
			if l_environment.arguments.argument_count > 2 then
				test.put (l_environment.arguments.argument (3).out)
			end
		end


end
