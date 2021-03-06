local delimiters = {["("] = true, [")"] = true, [";"] = true, ["\n"] = true, ["}"] = true, ["]"] = true, ["{"] = true, ["["] = true}
local whitespace = {[" "] = true, ["\n"] = true, ["\t"] = true}
local function stream(str, more)
  return({more = more, pos = 0, len = _35(str), string = str})
end
local function peek_char(s, count, offset)
  local _id = s
  local pos = _id.pos
  local len = _id.len
  local string = _id.string
  local from = pos + (offset or 0)
  local n = count or 1
  if from <= len - n then
    if n == 1 then
      return(char(string, from))
    else
      return(clip(string, from, from + n))
    end
  end
end
local function read_char(s, count, offset)
  local c = peek_char(s, count, offset)
  if c then
    s.pos = s.pos + _35(c)
    return(c)
  end
end
local function skip_non_code(s)
  while true do
    local c = peek_char(s)
    if nil63(c) then
      break
    else
      if whitespace[c] then
        read_char(s)
      else
        if c == ";" then
          while c and not( c == "\n") do
            c = read_char(s)
          end
          skip_non_code(s)
        else
          break
        end
      end
    end
  end
end
local read_table = {}
local eof = {}
local function read(s)
  skip_non_code(s)
  local c = peek_char(s)
  if is63(c) then
    return((read_table[c] or read_table[""])(s))
  else
    return(eof)
  end
end
local function read_all(s)
  local l = {}
  while true do
    local form = read(s)
    if form == eof then
      break
    end
    add(l, form)
  end
  return(l)
end
local function read_string(str, more)
  local x = read(stream(str, more))
  if not( x == eof) then
    return(x)
  end
end
local function key63(atom)
  return(string63(atom) and _35(atom) > 1 and char(atom, edge(atom)) == ":")
end
local function flag63(atom)
  return(string63(atom) and _35(atom) > 1 and char(atom, 0) == ":")
end
local function expected(s, c)
  local _id1 = s
  local more = _id1.more
  local pos = _id1.pos
  local _id2 = more
  local _e
  if _id2 then
    _e = _id2
  else
    error("Expected " .. c .. " at " .. pos)
    _e = nil
  end
  return(_e)
end
local function wrap(s, x)
  local y = read(s)
  if y == s.more then
    return(y)
  else
    return({x, y})
  end
end
function on_atom(x)
  if x == nil or x == "nil" then
    return(_37nil)
  else
    return(x)
  end
end
read_table[""] = function (s)
  local str = ""
  while true do
    local c = peek_char(s)
    if c and (not whitespace[c] and not delimiters[c]) then
      str = str .. read_char(s)
    else
      break
    end
  end
  local _e1
  if str == "true" then
    _e1 = true
  else
    local _e2
    if str == "false" then
      _e2 = false
    else
      local _e3
      if str == "nan" then
        _e3 = nan
      else
        local _e4
        if str == "-nan" then
          _e4 = nan
        else
          local _e5
          if str == "inf" then
            _e5 = inf
          else
            local _e6
            if str == "-inf" then
              _e6 = -inf
            else
              local _e7
              if str == "." then
                _e7 = ":rest"
              else
                local _e8
                if not number_code63(code(str, edge(str))) then
                  _e8 = str
                else
                  local n = number(str)
                  local _e9
                  if nil63(n) or nan63(n) or inf63(n) then
                    _e9 = str
                  else
                    _e9 = n
                  end
                  _e8 = _e9
                end
                _e7 = _e8
              end
              _e6 = _e7
            end
            _e5 = _e6
          end
          _e4 = _e5
        end
        _e3 = _e4
      end
      _e2 = _e3
    end
    _e1 = _e2
  end
  return(on_atom(_e1))
end
function on_list(xs)
  return(xs)
end
read_table["("] = function (s)
  read_char(s)
  local r = nil
  local l = {}
  while nil63(r) do
    skip_non_code(s)
    local c = peek_char(s)
    if c == ")" then
      read_char(s)
      r = on_list(l)
    else
      if nil63(c) then
        r = expected(s, ")")
      else
        local x = read(s)
        if key63(x) then
          local k = clip(x, 0, edge(x))
          local v = read(s)
          add(l, _37kv)
          add(l, k)
          add(l, v)
        else
          if flag63(x) then
            local _k = clip(x, 1)
            local v = true
            add(l, _37kv)
            add(l, _k)
            add(l, true)
          else
            add(l, x)
          end
        end
      end
    end
  end
  return(r)
end
read_table[")"] = function (s)
  error("Unexpected ) at " .. s.pos)
end
read_table["["] = function (s)
  read_char(s)
  local r = nil
  local l = {}
  while nil63(r) do
    skip_non_code(s)
    local c = peek_char(s)
    if c == "]" then
      read_char(s)
      r = {"fn", {"_"}, l}
    else
      if nil63(c) then
        r = expected(s, "]")
      else
        local x = read(s)
        add(l, x)
      end
    end
  end
  return(r)
end
read_table["]"] = function (s)
  error("Unexpected ] at " .. s.pos)
end
read_table["{"] = function (s)
  read_char(s)
  local r = nil
  local l = {}
  while nil63(r) do
    skip_non_code(s)
    local c = peek_char(s)
    if c == "}" then
      read_char(s)
      r = join({"curly"}, l)
    else
      if nil63(c) then
        r = expected(s, "}")
      else
        local x = read(s)
        add(l, x)
      end
    end
  end
  return(r)
end
read_table["}"] = function (s)
  error("Unexpected } at " .. s.pos)
end
read_table["\"\"\""] = function (s)
  read_char(s, 3)
  local r = nil
  local str = "\""
  while nil63(r) do
    local c = peek_char(s, 3)
    if c == "\"\"\"" then
      read_char(s, 3)
      r = str .. "\""
    else
      if nil63(c) then
        r = expected(s, "\"\"\"")
      else
        local x = read_char(s)
        local _e10
        if x == "\"" or x == "\\" then
          _e10 = "\\" .. x
        else
          _e10 = x
        end
        str = str .. _e10
      end
    end
  end
  return(r)
end
read_table["\""] = function (s)
  if peek_char(s, 3) == "\"\"\"" then
    return(read_table["\"\"\""](s))
  end
  read_char(s)
  local r = nil
  local str = "\""
  while nil63(r) do
    local c = peek_char(s)
    if c == "\"" then
      r = str .. read_char(s)
    else
      if nil63(c) then
        r = expected(s, "\"")
      else
        if c == "\\" then
          str = str .. read_char(s)
        end
        str = str .. read_char(s)
      end
    end
  end
  return(r)
end
read_table["||"] = function (s)
  read_char(s, 2)
  local r = nil
  local str = "\""
  while nil63(r) do
    local c = peek_char(s, 2)
    if c == "||" then
      read_char(s, 2)
      r = str .. "\""
    else
      if nil63(c) then
        r = expected(s, "||")
      else
        local x = read_char(s)
        local _e11
        if x == "\"" or x == "\\" then
          _e11 = "\\" .. x
        else
          _e11 = x
        end
        str = str .. _e11
      end
    end
  end
  return(r)
end
read_table["|"] = function (s)
  read_char(s)
  local r = nil
  local str = "|"
  while nil63(r) do
    local c = peek_char(s)
    if c == "|" then
      r = str .. read_char(s)
    else
      if nil63(c) then
        r = expected(s, "|")
      else
        str = str .. read_char(s)
      end
    end
  end
  return(r)
end
read_table["'"] = function (s)
  read_char(s)
  return(wrap(s, "quote"))
end
read_table["`"] = function (s)
  read_char(s)
  return(wrap(s, "quasiquote"))
end
read_table[","] = function (s)
  read_char(s)
  if peek_char(s) == "@" then
    read_char(s)
    return(wrap(s, "unquote-splicing"))
  else
    return(wrap(s, "unquote"))
  end
end
return({["read-string"] = read_string, ["read-all"] = read_all, read = read, ["read-table"] = read_table, stream = stream})
