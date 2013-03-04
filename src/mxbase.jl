
libmx = C_NULL
libeng = C_NULL

# libmx (loaded when the module is imported)

function load_libmx()
	global libmx
	if libmx == C_NULL
		libmx = dlopen("libmx", RTLD_GLOBAL | RTLD_LAZY)
		if libmx == C_NULL
			error("Failed to load libmx.")
		end
	end
end

load_libmx()

# libeng (loaded when needed)

startcmd = "/Applications/MATLAB_R2012b.app/bin/matlab"

function load_libeng()
	global libeng
	if libeng == C_NULL
		libeng = dlopen("libeng", RTLD_GLOBAL | RTLD_LAZY)
		if libeng == C_NULL
			error("Failed to load libeng.")
		end
	end
end

engfunc(fun::Symbol) = dlsym(libeng::Ptr{Void}, fun)
mxfunc(fun::Symbol) = dlsym(libmx::Ptr{Void}, fun)
