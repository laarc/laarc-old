.PHONY: all clean test

all: rocks test

lua:
	@VERBOSE=1 monki/bin/monki luajit-rocks/

clean:
	@echo rm -rf luajit-rocks/build
	@rm -rf luajit-rocks/build

test: lua
	@luajit-rocks/build/lua52/bin/lua -e 'local cqueues = require"cqueues"; local stdin = require"cqueues.socket".fdopen(0); local cq = cqueues.new(); cq:wrap(function() for line in stdin:lines() do print("LINE", line) end end); cq:wrap(function() for i=1,10 do cqueues.sleep(1); print("SLEEP", i) end os.exit() end); cq:wrap(function() cqueues.sleep(2); local h,s=require"http.request".new_from_uri("http://google.com"):go(); print("HTTP STATUS:", h:get(":status")) os.exit() end); assert(cq:loop())'

