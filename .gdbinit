alias -a var = info local

define hook-next
	var
	refresh
end

define bp
	printf "info breakpoints\n"
	info breakpoints
end
