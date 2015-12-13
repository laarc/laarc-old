environment = {{}}
target = "lua"
function nil63(x)
  return(x == nil)
end
function is63(x)
  return(not nil63(x))
end
function _35(x)
  return(#x)
end
function none63(x)
  return(_35(x) == 0)
end
function some63(x)
  return(_35(x) > 0)
end
function one63(x)
  return(_35(x) == 1)
end
function two63(x)
  return(_35(x) == 2)
end
function hd(l)
  return(l[1])
end
function string63(x)
  return(type(x) == "string")
end
function number63(x)
  return(type(x) == "number")
end
function boolean63(x)
  return(type(x) == "boolean")
end
function function63(x)
  return(type(x) == "function")
end
function obj63(x)
  return(is63(x) and type(x) == "table")
end
function atom63(x)
  return(nil63(x) or string63(x) or number63(x) or boolean63(x) or function63(x))
end
nan = 0 / 0
inf = 1 / 0
function nan63(n)
  return(not( n == n))
end
function inf63(n)
  return(n == inf or n == -inf)
end
function clip(s, from, upto)
  return(string.sub(s, from + 1, upto))
end
function cut(x, from, upto)
  local l = {}
  local j = 0
  local _e
  if nil63(from) or from < 0 then
    _e = 0
  else
    _e = from
  end
  local i = _e
  local n = _35(x)
  local _e1
  if nil63(upto) or upto > n then
    _e1 = n
  else
    _e1 = upto
  end
  local _upto = _e1
  while i < _upto do
    l[j + 1] = x[i + 1]
    i = i + 1
    j = j + 1
  end
  local _o = x
  local k = nil
  for k in next, _o do
    local v = _o[k]
    if not number63(k) then
      l[k] = v
    end
  end
  return(l)
end
function keys(x)
  local t = {}
  local _o1 = x
  local k = nil
  for k in next, _o1 do
    local v = _o1[k]
    if not number63(k) then
      t[k] = v
    end
  end
  return(t)
end
function edge(x)
  return(_35(x) - 1)
end
function inner(x)
  return(clip(x, 1, edge(x)))
end
function tl(l)
  return(cut(l, 1))
end
function char(s, n)
  return(clip(s, n, n + 1))
end
function code(s, n)
  local _e2
  if n then
    _e2 = n + 1
  end
  return(string.byte(s, _e2))
end
function string_literal63(x)
  return(string63(x) and char(x, 0) == "\"")
end
function id_literal63(x)
  return(string63(x) and char(x, 0) == "|")
end
function add(l, x)
  return(table.insert(l, x))
end
function drop(l)
  return(table.remove(l))
end
function last(l)
  return(l[edge(l) + 1])
end
function almost(l)
  return(cut(l, 0, edge(l)))
end
function reverse(l)
  local l1 = keys(l)
  local i = edge(l)
  while i >= 0 do
    add(l1, l[i + 1])
    i = i - 1
  end
  return(l1)
end
function reduce(f, x)
  if none63(x) then
    return(x)
  else
    if one63(x) then
      return(hd(x))
    else
      return(f(hd(x), reduce(f, tl(x))))
    end
  end
end
function join(...)
  local ls = unstash({...})
  if two63(ls) then
    local _id = ls
    local a = _id[1]
    local b = _id[2]
    if a and b then
      local c = {}
      local o = _35(a)
      local _o2 = a
      local k = nil
      for k in next, _o2 do
        local v = _o2[k]
        c[k] = v
      end
      local _o3 = b
      local k = nil
      for k in next, _o3 do
        local v = _o3[k]
        if number63(k) then
          k = k + o
        end
        c[k] = v
      end
      return(c)
    else
      return(a or b or {})
    end
  else
    return(reduce(join, ls))
  end
end
function find(f, t)
  local _o4 = t
  local _i4 = nil
  for _i4 in next, _o4 do
    local x = _o4[_i4]
    local y = f(x)
    if y then
      return(y)
    end
  end
end
function first(f, l)
  local _x2 = l
  local _n5 = _35(_x2)
  local _i5 = 0
  while _i5 < _n5 do
    local x = _x2[_i5 + 1]
    local y = f(x)
    if y then
      return(y)
    end
    _i5 = _i5 + 1
  end
end
function in63(x, t)
  return(find(function (y)
    return(x == y)
  end, t))
end
function pair(l)
  local l1 = {}
  local i = 0
  while i < _35(l) do
    add(l1, {l[i + 1], l[i + 1 + 1]})
    i = i + 1
    i = i + 1
  end
  return(l1)
end
function tuple(lst, n)
  if nil63(n) then
    n = 2
  end
  local l1 = {}
  local i = 0
  while i < _35(lst) do
    local l2 = {}
    local j = 0
    while j < n do
      add(l2, lst[i + j + 1])
      j = j + 1
    end
    add(l1, l2)
    i = i + (n - 1)
    i = i + 1
  end
  return(l1)
end
function vals(lst)
  local r = {}
  local _x4 = lst
  local _n6 = _35(_x4)
  local _i6 = 0
  while _i6 < _n6 do
    local x = _x4[_i6 + 1]
    add(r, x)
    _i6 = _i6 + 1
  end
  return(r)
end
function sort(l, f)
  table.sort(l, f)
  return(l)
end
function map(f, x)
  local t = {}
  local _x5 = x
  local _n7 = _35(_x5)
  local _i7 = 0
  while _i7 < _n7 do
    local v = _x5[_i7 + 1]
    local y = f(v)
    if is63(y) then
      add(t, y)
    end
    _i7 = _i7 + 1
  end
  local _o5 = x
  local k = nil
  for k in next, _o5 do
    local v = _o5[k]
    if not number63(k) then
      local y = f(v)
      if is63(y) then
        t[k] = y
      end
    end
  end
  return(t)
end
function keep(f, x)
  return(map(function (v)
    if f(v) then
      return(v)
    end
  end, x))
end
function keys63(t)
  local _o6 = t
  local k = nil
  for k in next, _o6 do
    local v = _o6[k]
    if not number63(k) then
      return(true)
    end
  end
  return(false)
end
function empty63(t)
  local _o7 = t
  local _i10 = nil
  for _i10 in next, _o7 do
    local x = _o7[_i10]
    return(false)
  end
  return(true)
end
function stash(args)
  if keys63(args) then
    local p = {}
    local _o8 = args
    local k = nil
    for k in next, _o8 do
      local v = _o8[k]
      if not number63(k) then
        p[k] = v
      end
    end
    p._stash = true
    add(args, p)
  end
  return(args)
end
function unstash(args)
  if none63(args) then
    return({})
  else
    local l = last(args)
    if not atom63(l) and l._stash then
      local args1 = almost(args)
      local _o9 = l
      local k = nil
      for k in next, _o9 do
        local v = _o9[k]
        if not( k == "_stash") then
          args1[k] = v
        end
      end
      return(args1)
    else
      return(args)
    end
  end
end
function search(s, pattern, start)
  local _e3
  if start then
    _e3 = start + 1
  end
  local _start = _e3
  local i = string.find(s, pattern, _start, true)
  return(i and i - 1)
end
function split(s, sep)
  if s == "" or sep == "" then
    return({})
  else
    local l = {}
    local n = _35(sep)
    while true do
      local i = search(s, sep)
      if nil63(i) then
        break
      else
        add(l, clip(s, 0, i))
        s = clip(s, i + n)
      end
    end
    add(l, s)
    return(l)
  end
end
function cat(...)
  local xs = unstash({...})
  if none63(xs) then
    return("")
  else
    return(reduce(function (a, b)
      return(a .. b)
    end, xs))
  end
end
function _43(...)
  local xs = unstash({...})
  return(reduce(function (a, b)
    return(a + b)
  end, xs))
end
function _(...)
  local xs = unstash({...})
  return(reduce(function (b, a)
    return(a - b)
  end, reverse(xs)))
end
function _42(...)
  local xs = unstash({...})
  return(reduce(function (a, b)
    return(a * b)
  end, xs))
end
function _47(...)
  local xs = unstash({...})
  return(reduce(function (b, a)
    return(a / b)
  end, reverse(xs)))
end
function _37(...)
  local xs = unstash({...})
  return(reduce(function (b, a)
    return(a % b)
  end, reverse(xs)))
end
function _62(a, b)
  return(a > b)
end
function _60(a, b)
  return(a < b)
end
function _61(a, b)
  return(a == b)
end
function _6261(a, b)
  return(a >= b)
end
function _6061(a, b)
  return(a <= b)
end
function number(s)
  return(tonumber(s))
end
function number_code63(n)
  return(n > 47 and n < 58)
end
function numeric63(s)
  local n = _35(s)
  local i = 0
  while i < n do
    if not number_code63(code(s, i)) then
      return(false)
    end
    i = i + 1
  end
  return(true)
end
function escape(s)
  local s1 = "\""
  local i = 0
  while i < _35(s) do
    local c = char(s, i)
    local _e4
    if c == "\n" then
      _e4 = "\\n"
    else
      local _e5
      if c == "\"" then
        _e5 = "\\\""
      else
        local _e6
        if c == "\\" then
          _e6 = "\\\\"
        else
          _e6 = c
        end
        _e5 = _e6
      end
      _e4 = _e5
    end
    local c1 = _e4
    s1 = s1 .. c1
    i = i + 1
  end
  return(s1 .. "\"")
end
function str(x, depth, ancestors)
  if nil63(x) then
    return("nil")
  else
    if nan63(x) then
      return("nan")
    else
      if x == inf then
        return("inf")
      else
        if x == -inf then
          return("-inf")
        else
          if boolean63(x) then
            if x then
              return("true")
            else
              return("false")
            end
          else
            if string63(x) then
              return(escape(x))
            else
              if atom63(x) then
                return(tostring(x))
              else
                if function63(x) then
                  return("fn")
                else
                  if not obj63(x) then
                    return("|" .. type(x) .. "|")
                  else
                    local s = "("
                    local sp = ""
                    local xs = {}
                    local ks = {}
                    local d = (depth or 0) + 1
                    local ans = join({x}, ancestors or {})
                    if in63(x, ancestors or {}) then
                      return("circular")
                    end
                    local _o10 = x
                    local k = nil
                    for k in next, _o10 do
                      local v = _o10[k]
                      if number63(k) then
                        xs[k] = str(v, d, ans)
                      else
                        add(ks, k .. ":")
                        add(ks, str(v, d, ans))
                      end
                    end
                    local _o11 = join(xs, ks)
                    local _i14 = nil
                    for _i14 in next, _o11 do
                      local v = _o11[_i14]
                      s = s .. sp .. v
                      sp = " "
                    end
                    return(s .. ")")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
local values = unpack or table.unpack
function apply(f, args)
  local _args = stash(args)
  return(f(values(_args)))
end
function call(f)
  return(f())
end
function toplevel63()
  return(one63(environment))
end
function setenv(k, ...)
  local _r68 = unstash({...})
  local _id1 = _r68
  local _keys = cut(_id1, 0)
  if string63(k) then
    local _e7
    if _keys.toplevel then
      _e7 = hd(environment)
    else
      _e7 = last(environment)
    end
    local frame = _e7
    local entry = frame[k] or {}
    local _o12 = _keys
    local _k = nil
    for _k in next, _o12 do
      local v = _o12[_k]
      entry[_k] = v
    end
    frame[k] = entry
    return(frame[k])
  end
end
local math = math
abs = math.abs
acos = math.acos
asin = math.asin
atan = math.atan
atan2 = math.atan2
ceil = math.ceil
cos = math.cos
floor = math.floor
log = math.log
log10 = math.log10
max = math.max
min = math.min
pow = math.pow
random = math.random
sin = math.sin
sinh = math.sinh
sqrt = math.sqrt
tan = math.tan
tanh = math.tanh

setenv("quote", {_stash = true, macro = function (form)
  return(quoted(form))
end})
setenv("quasiquote", {_stash = true, macro = function (form)
  return(quasiexpand(form, 1))
end})
setenv("at", {_stash = true, macro = function (l, i)
  if target == "lua" and number63(i) then
    i = i + 1
  else
    if target == "lua" then
      i = {"+", i, 1}
    end
  end
  return({"get", l, i})
end})
setenv("wipe", {_stash = true, macro = function (place)
  if target == "lua" then
    return({"set", place, "nil"})
  else
    return({"%delete", place})
  end
end})
setenv("list", {_stash = true, macro = function (...)
  local body = unstash({...})
  local x = unique("x")
  local l = {}
  local forms = {}
  local _o1 = body
  local k = nil
  for k in next, _o1 do
    local v = _o1[k]
    if number63(k) then
      l[k] = v
    else
      add(forms, {"set", {"get", x, {"quote", k}}, v})
    end
  end
  if some63(forms) then
    return(join({"let", x, join({"%array"}, l)}, forms, {x}))
  else
    return(join({"%array"}, l))
  end
end})
setenv("if", {_stash = true, macro = function (...)
  local branches = unstash({...})
  return(hd(expand_if(branches)))
end})
setenv("case", {_stash = true, macro = function (x, ...)
  local _r10 = unstash({...})
  local _id2 = _r10
  local clauses = cut(_id2, 0)
  local bs = map(function (_x34)
    local _id3 = _x34
    local a = _id3[1]
    local b = _id3[2]
    if nil63(b) then
      return({a})
    else
      return({{"=", {"quote", a}, x}, b})
    end
  end, pair(clauses))
  return(join({"if"}, apply(join, bs)))
end})
setenv("when", {_stash = true, macro = function (cond, ...)
  local _r13 = unstash({...})
  local _id5 = _r13
  local body = cut(_id5, 0)
  return({"if", cond, join({"do"}, body)})
end})
setenv("unless", {_stash = true, macro = function (cond, ...)
  local _r15 = unstash({...})
  local _id7 = _r15
  local body = cut(_id7, 0)
  return({"if", {"not", cond}, join({"do"}, body)})
end})
setenv("obj", {_stash = true, macro = function (...)
  local body = unstash({...})
  return(join({"%object"}, mapo(function (x)
    return(x)
  end, body)))
end})
setenv("let", {_stash = true, macro = function (bs, ...)
  local _r19 = unstash({...})
  local _id11 = _r19
  local body = cut(_id11, 0)
  if atom63(bs) then
    return(join({"let", {bs, hd(body)}}, tl(body)))
  else
    if none63(bs) then
      return(join({"do"}, body))
    else
      local _id12 = bs
      local lh = _id12[1]
      local rh = _id12[2]
      local bs2 = cut(_id12, 2)
      local _id13 = bind(lh, rh)
      local id = _id13[1]
      local val = _id13[2]
      local bs1 = cut(_id13, 2)
      local renames = {}
      if bound63(id) or toplevel63() then
        local id1 = unique(id)
        renames = {id, id1}
        id = id1
      else
        setenv(id, {_stash = true, variable = true})
      end
      return({"do", {"%local", id, val}, {"let-symbol", renames, join({"let", join(bs1, bs2)}, body)}})
    end
  end
end})
setenv("with", {_stash = true, macro = function (x, v, ...)
  local _r21 = unstash({...})
  local _id15 = _r21
  local body = cut(_id15, 0)
  return(join({"let", {x, v}}, body, {x}))
end})
setenv("let-when", {_stash = true, macro = function (x, v, ...)
  local _r23 = unstash({...})
  local _id17 = _r23
  local body = cut(_id17, 0)
  local y = unique("y")
  return({"let", y, v, {"when", y, join({"let", {x, y}}, body)}})
end})
setenv("define-macro", {_stash = true, macro = function (name, args, ...)
  local _r25 = unstash({...})
  local _id19 = _r25
  local body = cut(_id19, 0)
  local _x99 = {"setenv", {"quote", name}}
  _x99.macro = join({"fn", args}, body)
  local form = _x99
  eval(form)
  return(form)
end})
setenv("define-special", {_stash = true, macro = function (name, args, ...)
  local _r27 = unstash({...})
  local _id21 = _r27
  local body = cut(_id21, 0)
  local _x107 = {"setenv", {"quote", name}}
  _x107.special = join({"fn", args}, body)
  local form = join(_x107, keys(body))
  eval(form)
  return(form)
end})
setenv("define-symbol", {_stash = true, macro = function (name, expansion)
  setenv(name, {_stash = true, symbol = expansion})
  local _x113 = {"setenv", {"quote", name}}
  _x113.symbol = {"quote", expansion}
  return(_x113)
end})
setenv("define-reader", {_stash = true, macro = function (_x122, ...)
  local _id24 = _x122
  local char = _id24[1]
  local s = _id24[2]
  local _r31 = unstash({...})
  local _id25 = _r31
  local body = cut(_id25, 0)
  return({"set", {"get", "read-table", char}, join({"fn", {s}}, body)})
end})
setenv("define", {_stash = true, macro = function (name, x, ...)
  local _r33 = unstash({...})
  local _id27 = _r33
  local body = cut(_id27, 0)
  setenv(name, {_stash = true, variable = true})
  if some63(body) then
    return(join({"%local-function", name}, bind42(x, body)))
  else
    return({"%local", name, x})
  end
end})
setenv("define-global", {_stash = true, macro = function (name, x, ...)
  local _r35 = unstash({...})
  local _id29 = _r35
  local body = cut(_id29, 0)
  setenv(name, {_stash = true, toplevel = true, variable = true})
  if some63(body) then
    return(join({"%global-function", name}, bind42(x, body)))
  else
    return({"set", name, x})
  end
end})
setenv("with-frame", {_stash = true, macro = function (...)
  local body = unstash({...})
  local x = unique("x")
  return({"do", {"add", "environment", {"obj"}}, {"with", x, join({"do"}, body), {"drop", "environment"}}})
end})
setenv("with-bindings", {_stash = true, macro = function (_x159, ...)
  local _id32 = _x159
  local names = _id32[1]
  local _r37 = unstash({...})
  local _id33 = _r37
  local body = cut(_id33, 0)
  local x = unique("x")
  local _x163 = {"setenv", x}
  _x163.variable = true
  return(join({"with-frame", {"each", x, names, _x163}}, body))
end})
setenv("let-macro", {_stash = true, macro = function (definitions, ...)
  local _r40 = unstash({...})
  local _id35 = _r40
  local body = cut(_id35, 0)
  add(environment, {})
  map(function (m)
    return(macroexpand(join({"define-macro"}, m)))
  end, definitions)
  local _x169 = join({"do"}, macroexpand(body))
  drop(environment)
  return(_x169)
end})
setenv("let-symbol", {_stash = true, macro = function (expansions, ...)
  local _r44 = unstash({...})
  local _id38 = _r44
  local body = cut(_id38, 0)
  add(environment, {})
  map(function (_x179)
    local _id39 = _x179
    local name = _id39[1]
    local exp = _id39[2]
    return(macroexpand({"define-symbol", name, exp}))
  end, pair(expansions))
  local _x178 = join({"do"}, macroexpand(body))
  drop(environment)
  return(_x178)
end})
setenv("let-unique", {_stash = true, macro = function (names, ...)
  local _r48 = unstash({...})
  local _id41 = _r48
  local body = cut(_id41, 0)
  local bs = map(function (n)
    return({n, {"unique", {"quote", n}}})
  end, names)
  return(join({"let", apply(join, bs)}, body))
end})
setenv("fn", {_stash = true, macro = function (args, ...)
  local _r51 = unstash({...})
  local _id43 = _r51
  local body = cut(_id43, 0)
  return(join({"%function"}, bind42(args, body)))
end})
setenv("guard", {_stash = true, macro = function (expr)
  if target == "js" then
    return({{"fn", join(), {"%try", {"list", true, expr}}}})
  else
    local x = unique("x")
    local msg = unique("msg")
    local trace = unique("trace")
    return({"let", {x, "nil", msg, "nil", trace, "nil"}, {"if", {"xpcall", {"fn", join(), {"set", x, expr}}, {"fn", {"m"}, {"set", msg, {"clip", "m", {"+", {"search", "m", "\": \""}, 2}}}, {"set", trace, {{"get", "debug", {"quote", "traceback"}}}}}}, {"list", true, x}, {"list", false, msg, trace}}})
  end
end})
setenv("each", {_stash = true, macro = function (x, t, ...)
  local _r55 = unstash({...})
  local _id46 = _r55
  local body = cut(_id46, 0)
  local o = unique("o")
  local n = unique("n")
  local i = unique("i")
  local _e3
  if atom63(x) then
    _e3 = {i, x}
  else
    local _e4
    if _35(x) > 1 then
      _e4 = x
    else
      _e4 = {i, hd(x)}
    end
    _e3 = _e4
  end
  local _id47 = _e3
  local k = _id47[1]
  local v = _id47[2]
  local _e5
  if target == "lua" then
    _e5 = body
  else
    _e5 = {join({"let", k, {"if", {"numeric?", k}, {"parseInt", k}, k}}, body)}
  end
  return({"let", {o, t, k, "nil"}, {"%for", o, k, join({"let", {v, {"get", o, k}}}, _e5)}})
end})
setenv("for", {_stash = true, macro = function (i, to, ...)
  local _r57 = unstash({...})
  local _id49 = _r57
  local body = cut(_id49, 0)
  return({"let", i, 0, join({"while", {"<", i, to}}, body, {{"inc", i}})})
end})
setenv("step", {_stash = true, macro = function (v, t, ...)
  local _r59 = unstash({...})
  local _id51 = _r59
  local body = cut(_id51, 0)
  local x = unique("x")
  local n = unique("n")
  local i = unique("i")
  return({"let", {x, t, n, {"#", x}}, {"for", i, n, join({"let", {v, {"at", x, i}}}, body)}})
end})
setenv("set-of", {_stash = true, macro = function (...)
  local xs = unstash({...})
  local l = {}
  local _o3 = xs
  local _i3 = nil
  for _i3 in next, _o3 do
    local x = _o3[_i3]
    l[x] = true
  end
  return(join({"obj"}, l))
end})
setenv("language", {_stash = true, macro = function ()
  return({"quote", target})
end})
setenv("target", {_stash = true, macro = function (...)
  local clauses = unstash({...})
  return(clauses[target])
end})
setenv("join!", {_stash = true, macro = function (a, ...)
  local _r63 = unstash({...})
  local _id53 = _r63
  local bs = cut(_id53, 0)
  return({"set", a, join({"join", a}, bs)})
end})
setenv("cat!", {_stash = true, macro = function (a, ...)
  local _r65 = unstash({...})
  local _id55 = _r65
  local bs = cut(_id55, 0)
  return({"set", a, join({"cat", a}, bs)})
end})
setenv("inc", {_stash = true, macro = function (n, by)
  return({"set", n, {"+", n, by or 1}})
end})
setenv("dec", {_stash = true, macro = function (n, by)
  return({"set", n, {"-", n, by or 1}})
end})
setenv("with-indent", {_stash = true, macro = function (form)
  local x = unique("x")
  return({"do", {"inc", "indent-level"}, {"with", x, form, {"dec", "indent-level"}}})
end})
setenv("export", {_stash = true, macro = function (...)
  local names = unstash({...})
  if target == "js" then
    return(join({"do"}, map(function (k)
      return({"set", {"get", "exports", {"quote", k}}, k})
    end, names)))
  else
    local x = {}
    local _o5 = names
    local _i5 = nil
    for _i5 in next, _o5 do
      local k = _o5[_i5]
      x[k] = k
    end
    return({"return", join({"obj"}, x)})
  end
end})

env = require("system")["get-environment-variable"]
home = env("laarc_home")
stdin_tty63 = env("laarc_stdin_tty")
stdout_tty63 = env("laarc_stdout_tty")
setenv("during-compile-and-run", {_stash = true, macro = function (...)
  local l = unstash({...})
  eval(join({"do"}, l))
  return(join({"do"}, l))
end})
if last(environment).laarc then
  drop(environment)
end
add(environment, {laarc = true})
setenv("during-compile-and-run", {_stash = true, macro = function (...)
  local l = unstash({...})
  eval(join({"do"}, l))
  return(join({"do"}, l))
end})
setenv("during-compile", {_stash = true, macro = function (...)
  local l = unstash({...})
  eval(join({"do"}, l))
  return(nil)
end})
compiler = require("compiler")
function print_compiled(expr)
  print(compile(compiler.expand({"do", expr})))
  return(expr)
end
function print_env()
  local _x19 = environment
  local _n2 = _35(_x19)
  local _i2 = 0
  while _i2 < _n2 do
    local frame = _x19[_i2 + 1]
    print("----------------")
    local _o1 = frame
    local k = nil
    for k in next, _o1 do
      local v = _o1[k]
      print(str(k) .. ": " .. str(v))
    end
    _i2 = _i2 + 1
  end
end
function map3(f, lst)
  local r = {}
  local i = 0
  while i < _35(lst) do
    if i > 0 then
      add(r, f(lst[i - 1 + 1], lst[i + 1], lst[i + 1 + 1]))
    end
    i = i + 1
  end
  return(r)
end
setenv("def?", {_stash = true, macro = function (x)
  return({"is?", x})
end})
_37kv = {"%kv"}
_37nil = {"%nil"}
setenv("%nil", {_stash = true, macro = function ()
  return({"do", "nil"})
end})
setenv("lumen-eq", {_stash = true, symbol = {"do", "="}})
setenv("lumen-assign", {_stash = true, symbol = {"do", "set"}})
setenv("lumen-len", {_stash = true, symbol = {"do", "#"}})
setenv("lumen-str", {_stash = true, symbol = {"do", "str"}})
setenv("lumen-cat", {_stash = true, symbol = {"do", "cat"}})
setenv("arc-toplevel?", {_stash = true, macro = function ()
  return({"two?", "environment"})
end})
setenv("each", {_stash = true, macro = function (x, t, ...)
  local _r15 = unstash({...})
  local _id2 = _r15
  local body = cut(_id2, 0)
  local o = unique("o")
  local n = unique("n")
  local i = unique("i")
  local c = unique("c")
  local _e4
  if atom63(x) then
    _e4 = {i, x}
  else
    local _e5
    if _35(x) > 1 then
      _e5 = x
    else
      _e5 = {i, hd(x)}
    end
    _e4 = _e5
  end
  local _id3 = _e4
  local k = _id3[1]
  local v = _id3[2]
  local _x83 = {"target"}
  _x83.js = {"if", {"numeric?", k}, {"set", k, {"parseInt", k}}}
  return({"let", {o, t, c, 0, k, "nil"}, {"%for", o, k, {"if", {">", c, 0}, {"dec", c}, join({"let", {v, {"get", o, k}}, _x83, {"when", {"lumen-eq", v, "%kv"}, {"set", c, 2}, {"set", v, {"get", o, {"+", k, 2}}}, {"set", k, {"get", o, {"+", k, 1}}}}, {"when", {"lumen-eq", v, "%nil"}, {"set", v, "nil"}}}, body)}}})
end})
setenv("for", {_stash = true, macro = function (i, to, ...)
  local _r17 = unstash({...})
  local _id5 = _r17
  local body = cut(_id5, 0)
  return({"let", i, 0, join({"while", {"<", i, to}}, body, {{"inc", i}})})
end})
setenv("step", {_stash = true, macro = function (v, t, ...)
  local _r19 = unstash({...})
  local _id7 = _r19
  local body = cut(_id7, 0)
  local x = unique("x")
  local n = unique("n")
  local i = unique("i")
  local c = unique("c")
  local u = unique("u")
  return({"let", {x, t, n, {"#", x}, c, 0}, {"for", i, n, {"when", {">=", i, c}, {"let", {u, {"at", x, i}}, {"when", {"lumen-eq", u, "%nil"}, {"set", u, "nil"}}, {"if", {"lumen-eq", u, "%kv"}, {"set", c, {"+", i, 3}}, {"let", {v, u}, join({"do"}, body)}}}}}})
end})
setenv("list", {_stash = true, macro = function (...)
  local body = unstash({...})
  local x = unique("x")
  local l = {}
  local forms = {}
  local _o3 = body
  local _c1 = 0
  local k = nil
  for k in next, _o3 do
    if _c1 > 0 then
      _c1 = _c1 - 1
    else
      local v = _o3[k]
      if v == _37kv then
        _c1 = 2
        v = _o3[k + 2]
        k = _o3[k + 1]
      end
      if v == _37nil then
        v = nil
      end
      if nil63(v) then
        v = _37nil
      end
      if number63(k) then
        l[k] = v
      else
        add(forms, {"set", {"get", x, {"quote", k}}, v})
      end
    end
  end
  if some63(forms) then
    return(join({"let", x, join({"%array"}, l)}, forms, {x}))
  else
    return(join({"%array"}, l))
  end
end})
function parse_args(xs, inits)
  if atom63(xs) then
    return(xs)
  else
    local l = {}
    local rest63 = nil
    local _o5 = xs
    local _c3 = 0
    local k = nil
    for k in next, _o5 do
      if _c3 > 0 then
        _c3 = _c3 - 1
      else
        local v = _o5[k]
        if v == _37kv then
          _c3 = 2
          v = _o5[k + 2]
          k = _o5[k + 1]
        end
        if v == _37nil then
          v = nil
        end
        if number63(k) then
          k = v
          v = nil
        end
        if nil63(v) then
          if rest63 == true then
            l.rest = parse_args(k, inits)
            rest63 = k
          else
            add(l, parse_args(k, inits))
          end
        else
          if k == "rest" then
            l.rest = true
            rest63 = true
          else
            if atom63(k) then
              add(inits, {"if", {"nil?", k}, {"set", k, v}})
              if rest63 then
                l[k] = true
              else
                add(l, k)
              end
            else
              error("todo")
            end
          end
        end
      end
    end
    return(l)
  end
end
setenv("mac", {_stash = true, macro = function (name, args, ...)
  local _r23 = unstash({...})
  local _id9 = _r23
  local body = cut(_id9, 0)
  local inits = {}
  return(join({"define-macro", name, parse_args(args, inits)}, inits, body))
end})
setenv("def", {_stash = true, macro = function (name, args, ...)
  local _r25 = unstash({...})
  local _id11 = _r25
  local body = cut(_id11, 0)
  if none63(body) then
    return({"define-global", name, args})
  else
    local inits = {}
    return(join({"define-global", name, parse_args(args, inits)}, inits, body))
  end
end})
setenv("var", {_stash = true, macro = function (name, args, ...)
  local _r27 = unstash({...})
  local _id13 = _r27
  local body = cut(_id13, 0)
  if none63(body) then
    return({"define", name, args})
  else
    local inits = {}
    return(join({"define", name, parse_args(args, inits)}, inits, body))
  end
end})
setenv("sym", {_stash = true, macro = function (...)
  local l = unstash({...})
  return(join({"define-symbol"}, l))
end})
setenv("t", {_stash = true, symbol = true})
setenv("len", {_stash = true, symbol = "lumen-len"})
setenv("is", {_stash = true, macro = function (...)
  local l = unstash({...})
  if 0 == _35(l) then
    return(true)
  else
    if 1 == _35(l) then
      return(join({"is?"}, l))
    else
      if 2 == _35(l) then
        return(join({"lumen-eq"}, l))
      else
        return(join({"and"}, map3(function (x, y)
          return({"is", x, y})
        end, l)))
      end
    end
  end
end})
function is_var63(x)
  local _x205 = environment
  local _n9 = _35(_x205)
  local _c5 = 0
  local _i9 = 0
  while _i9 < _n9 do
    if _i9 >= _c5 then
      local _u1 = _x205[_i9 + 1]
      if _u1 == _37nil then
        _u1 = nil
      end
      if _u1 == _37kv then
        _c5 = _i9 + 3
      else
        local frame = _u1
        local u = frame[x]
        if is63(u) and is63(u.variable) then
          return(true)
        end
      end
    end
    _i9 = _i9 + 1
  end
end
setenv("=", {_stash = true, macro = function (...)
  local l = unstash({...})
  local e = {"do"}
  local final = nil
  local _x213 = pair(l)
  local _n11 = _35(_x213)
  local _c7 = 0
  local _i11 = 0
  while _i11 < _n11 do
    if _i11 >= _c7 then
      local _u3 = _x213[_i11 + 1]
      if _u3 == _37nil then
        _u3 = nil
      end
      if _u3 == _37kv then
        _c7 = _i11 + 3
      else
        local _id15 = _u3
        local x = _id15[1]
        local y = _id15[2]
        final = x
        if not is_var63(x) then
          local _e6
          if two63(environment) then
            _e6 = "def"
          else
            _e6 = "var"
          end
          add(e, {_e6, x, "nil"})
        end
        add(e, {"lumen-assign", x, y})
      end
    end
    _i11 = _i11 + 1
  end
  add(e, final)
  return(e)
end})
filechars = require("system")["read-file"]
function lumen_readstr(x, more)
  local reader = require("reader")
  local s = reader.stream(x, more)
  return(reader["read-all"](s))
end
function readstr(x, more, reader)
  if nil63(reader) then
    reader = true
  end
  local _e7
  if reader == true then
    _e7 = require("ac-reader")
  else
    _e7 = r
  end
  local r = _e7
  local s = r.stream(x, more)
  return(map(function (x)
    if atom63(x) then
      return(x)
    else
      if hd(x) == "%list" then
        return(tl(x))
      else
        return(x)
      end
    end
  end, r["read-all"](s)))
end
_37run = require("compiler").run
_37expand = require("compiler").expand
function macex(expr)
  return(_37expand(expr))
end
function ac_compile(expr)
  return(compile(macex(expr)))
end
function ac_compile_str(s)
  return(compile(macex(join({"do"}, readstr(s)))))
end
function ac_compile_file(file)
  return(ac_compile_str(filechars(file)))
end
function ac_load(file)
  local x = ac_compile_file(file)
  print(x)
  return(_37run(x))
end
setenv("prdo", {_stash = true, macro = function (...)
  local l = unstash({...})
  return(join({"do"}, map(function (x)
    return({"print", {"cat", "\"> \"", {"lumen-str", {"quote", x}}, "\"\\n\"", {"lumen-str", {{"fn", join(), x}}}}})
  end, l), {"nil"}))
end})
function endswith(s, ending)
  local i = _35(s) - _35(ending)
  return(i == search(s, ending, i))
end
function startswith(s, prefix)
  return(search(s, prefix) == 0)
end
function pp(x)
  return(print(str(x)))
end
local _x237 = nil
local _msg = nil
local _trace = nil
local _e8
if xpcall(function ()
  _x237 = require("require")
  return(_x237)
end, function (m)
  _msg = clip(m, search(m, ": ") + 2)
  _trace = debug.traceback()
  return(_trace)
end) then
  _e8 = {true, _x237}
else
  _e8 = {false, _msg, _trace}
end
local _id16 = _e8
local ok = _id16[1]
local req = _id16[2]
if ok then
  require = req("/")
  eval({"define-global", "require", {{"require", {"quote", "require"}}, "\"/\""}})
  ppr = require("pretty-print").prettyPrint
  function pp(x)
    if string63(x) then
      return(print(x))
    else
      return(ppr(x))
    end
  end
  compiler.run("\nffi = require('ffi')\nffi.cdef[[int fcntl(int fildes, int cmd, ...);]]\nffi.cdef[[static const int F_GETFL= 3;/* get file status flags */]]\nffi.cdef[[static const int F_SETFL= 4;/* set file status flags */]]\nffi.cdef[[static const int O_NONBLOCK	= 0x0004;		/* no delay */]]\nlocal flags = ffi.C.fcntl(0, ffi.C.F_GETFL, 0)\nbit = require(\"bit\")\nflags = bit.bxor(flags, ffi.C.O_NONBLOCK)\nffi.C.fcntl(0, ffi.C.F_SETFL, flags)\n")
end
local args = require("system").argv
local i = 0
while i < _35(args) do
  local arg = args[i + 1]
  if endswith(arg, ".la") then
    _37run(ac_compile_file(arg))
  else
    if arg == "test" then
      _37run(ac_compile_file(home .. "/test.la"))
      test()
    else
      if arg == "-e" then
        i = i + 1
        local s = ""
        local _x244 = cut(args, i)
        local _n12 = _35(_x244)
        local _c8 = 0
        local _i12 = 0
        while _i12 < _n12 do
          if _i12 >= _c8 then
            local _u4 = _x244[_i12 + 1]
            if _u4 == _37nil then
              _u4 = nil
            end
            if _u4 == _37kv then
              _c8 = _i12 + 3
            else
              local x = _u4
              s = s .. " " .. x
            end
          end
          _i12 = _i12 + 1
        end
        _37run(ac_compile_str("(set %result " .. s .. ")"))
        if is63(_37result) then
          pp(_37result)
        end
      else
        _37run(arg)
      end
    end
  end
  i = i + 1
end

