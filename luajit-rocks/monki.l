(clone "torch/luajit-rocks")

($ "mkdir" "build")
($ "cd build ; cmake .. -DWITH_LUA52=ON -DCMAKE_INSTALL_PREFIX=\"`pwd`/lua52/\" ; make ; make install")
($ "git clone https://github.com/daurnimator/lua-http" )
($ "cd lua-http ; ../build/lua52/bin/luarocks install https://luarocks.org/manifests/daurnimator/lpeg_patterns-0.2-0.src.rock")
($ "cd lua-http ; ../build/lua52/bin/luarocks make http-scm-0.rockspec CC=gcc" )

