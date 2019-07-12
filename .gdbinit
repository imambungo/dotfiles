alias -a var = info local

define hook-next
	var
	refresh
end

define bp
	printf "info breakpoints\n"
	info breakpoints
end

define ro
	printf "run > gdb.out\n\n"
	printf "Don't forget to include fflush(stdout);\n\n"
	run > gdb.out
end
