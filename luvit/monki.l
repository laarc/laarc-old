(clone "luvit/luvit")

;
; Modify luvit's require function to use a shared global namespace.
; (Lumen's design necessitates this.)
;
(patch "deps/require.lua"
||setfenv(fn, setmetatable(global, { __index = _G }))||
||setfenv(fn, setmetatable(global, { __index = _G, __newindex = _G }))||
)

; rebuild luvit.
($ "make" "clean")
($ "make")


