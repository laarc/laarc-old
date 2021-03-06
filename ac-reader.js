var delimiters = {"(": true, ")": true, ";": true, "\n": true, "}": true, "]": true, "{": true, "[": true};
var whitespace = {" ": true, "\n": true, "\t": true};
var stream = function (str, more) {
  return({more: more, pos: 0, len: _35(str), string: str});
};
var peek_char = function (s, count, offset) {
  var _id = s;
  var pos = _id.pos;
  var len = _id.len;
  var string = _id.string;
  var from = pos + (offset || 0);
  var n = count || 1;
  if (from <= len - n) {
    if (n === 1) {
      return(char(string, from));
    } else {
      return(clip(string, from, from + n));
    }
  }
};
var read_char = function (s, count, offset) {
  var c = peek_char(s, count, offset);
  if (c) {
    s.pos = s.pos + _35(c);
    return(c);
  }
};
var skip_non_code = function (s) {
  while (true) {
    var c = peek_char(s);
    if (nil63(c)) {
      break;
    } else {
      if (whitespace[c]) {
        read_char(s);
      } else {
        if (c === ";") {
          while (c && !( c === "\n")) {
            c = read_char(s);
          }
          skip_non_code(s);
        } else {
          break;
        }
      }
    }
  }
};
var read_table = {};
var eof = {};
var read = function (s) {
  skip_non_code(s);
  var c = peek_char(s);
  if (is63(c)) {
    return((read_table[c] || read_table[""])(s));
  } else {
    return(eof);
  }
};
var read_all = function (s) {
  var l = [];
  while (true) {
    var form = read(s);
    if (form === eof) {
      break;
    }
    add(l, form);
  }
  return(l);
};
var read_string = function (str, more) {
  var x = read(stream(str, more));
  if (!( x === eof)) {
    return(x);
  }
};
var key63 = function (atom) {
  return(string63(atom) && _35(atom) > 1 && char(atom, edge(atom)) === ":");
};
var flag63 = function (atom) {
  return(string63(atom) && _35(atom) > 1 && char(atom, 0) === ":");
};
var expected = function (s, c) {
  var _id1 = s;
  var more = _id1.more;
  var pos = _id1.pos;
  var _id2 = more;
  var _e;
  if (_id2) {
    _e = _id2;
  } else {
    throw new Error("Expected " + c + " at " + pos);
    _e = undefined;
  }
  return(_e);
};
var wrap = function (s, x) {
  var y = read(s);
  if (y === s.more) {
    return(y);
  } else {
    return([x, y]);
  }
};
on_atom = function (x) {
  if (x === undefined || x === "nil") {
    return(_37nil);
  } else {
    return(x);
  }
};
read_table[""] = function (s) {
  var str = "";
  while (true) {
    var c = peek_char(s);
    if (c && (! whitespace[c] && ! delimiters[c])) {
      str = str + read_char(s);
    } else {
      break;
    }
  }
  var _e1;
  if (str === "true") {
    _e1 = true;
  } else {
    var _e2;
    if (str === "false") {
      _e2 = false;
    } else {
      var _e3;
      if (str === "nan") {
        _e3 = nan;
      } else {
        var _e4;
        if (str === "-nan") {
          _e4 = nan;
        } else {
          var _e5;
          if (str === "inf") {
            _e5 = inf;
          } else {
            var _e6;
            if (str === "-inf") {
              _e6 = -inf;
            } else {
              var _e7;
              if (str === ".") {
                _e7 = ":rest";
              } else {
                var _e8;
                if (! number_code63(code(str, edge(str)))) {
                  _e8 = str;
                } else {
                  var n = number(str);
                  var _e9;
                  if (nil63(n) || nan63(n) || inf63(n)) {
                    _e9 = str;
                  } else {
                    _e9 = n;
                  }
                  _e8 = _e9;
                }
                _e7 = _e8;
              }
              _e6 = _e7;
            }
            _e5 = _e6;
          }
          _e4 = _e5;
        }
        _e3 = _e4;
      }
      _e2 = _e3;
    }
    _e1 = _e2;
  }
  return(on_atom(_e1));
};
on_list = function (xs) {
  return(xs);
};
read_table["("] = function (s) {
  read_char(s);
  var r = undefined;
  var l = [];
  while (nil63(r)) {
    skip_non_code(s);
    var c = peek_char(s);
    if (c === ")") {
      read_char(s);
      r = on_list(l);
    } else {
      if (nil63(c)) {
        r = expected(s, ")");
      } else {
        var x = read(s);
        if (key63(x)) {
          var k = clip(x, 0, edge(x));
          var v = read(s);
          add(l, _37kv);
          add(l, k);
          add(l, v);
        } else {
          if (flag63(x)) {
            var _k = clip(x, 1);
            var v = true;
            add(l, _37kv);
            add(l, _k);
            add(l, true);
          } else {
            add(l, x);
          }
        }
      }
    }
  }
  return(r);
};
read_table[")"] = function (s) {
  throw new Error("Unexpected ) at " + s.pos);
};
read_table["["] = function (s) {
  read_char(s);
  var r = undefined;
  var l = [];
  while (nil63(r)) {
    skip_non_code(s);
    var c = peek_char(s);
    if (c === "]") {
      read_char(s);
      r = ["fn", ["_"], l];
    } else {
      if (nil63(c)) {
        r = expected(s, "]");
      } else {
        var x = read(s);
        add(l, x);
      }
    }
  }
  return(r);
};
read_table["]"] = function (s) {
  throw new Error("Unexpected ] at " + s.pos);
};
read_table["{"] = function (s) {
  read_char(s);
  var r = undefined;
  var l = [];
  while (nil63(r)) {
    skip_non_code(s);
    var c = peek_char(s);
    if (c === "}") {
      read_char(s);
      r = join(["curly"], l);
    } else {
      if (nil63(c)) {
        r = expected(s, "}");
      } else {
        var x = read(s);
        add(l, x);
      }
    }
  }
  return(r);
};
read_table["}"] = function (s) {
  throw new Error("Unexpected } at " + s.pos);
};
read_table["\"\"\""] = function (s) {
  read_char(s, 3);
  var r = undefined;
  var str = "\"";
  while (nil63(r)) {
    var c = peek_char(s, 3);
    if (c === "\"\"\"") {
      read_char(s, 3);
      r = str + "\"";
    } else {
      if (nil63(c)) {
        r = expected(s, "\"\"\"");
      } else {
        var x = read_char(s);
        var _e10;
        if (x === "\"" || x === "\\") {
          _e10 = "\\" + x;
        } else {
          _e10 = x;
        }
        str = str + _e10;
      }
    }
  }
  return(r);
};
read_table["\""] = function (s) {
  if (peek_char(s, 3) === "\"\"\"") {
    return(read_table["\"\"\""](s));
  }
  read_char(s);
  var r = undefined;
  var str = "\"";
  while (nil63(r)) {
    var c = peek_char(s);
    if (c === "\"") {
      r = str + read_char(s);
    } else {
      if (nil63(c)) {
        r = expected(s, "\"");
      } else {
        if (c === "\\") {
          str = str + read_char(s);
        }
        str = str + read_char(s);
      }
    }
  }
  return(r);
};
read_table["||"] = function (s) {
  read_char(s, 2);
  var r = undefined;
  var str = "\"";
  while (nil63(r)) {
    var c = peek_char(s, 2);
    if (c === "||") {
      read_char(s, 2);
      r = str + "\"";
    } else {
      if (nil63(c)) {
        r = expected(s, "||");
      } else {
        var x = read_char(s);
        var _e11;
        if (x === "\"" || x === "\\") {
          _e11 = "\\" + x;
        } else {
          _e11 = x;
        }
        str = str + _e11;
      }
    }
  }
  return(r);
};
read_table["|"] = function (s) {
  read_char(s);
  var r = undefined;
  var str = "|";
  while (nil63(r)) {
    var c = peek_char(s);
    if (c === "|") {
      r = str + read_char(s);
    } else {
      if (nil63(c)) {
        r = expected(s, "|");
      } else {
        str = str + read_char(s);
      }
    }
  }
  return(r);
};
read_table["'"] = function (s) {
  read_char(s);
  return(wrap(s, "quote"));
};
read_table["`"] = function (s) {
  read_char(s);
  return(wrap(s, "quasiquote"));
};
read_table[","] = function (s) {
  read_char(s);
  if (peek_char(s) === "@") {
    read_char(s);
    return(wrap(s, "unquote-splicing"));
  } else {
    return(wrap(s, "unquote"));
  }
};
exports.stream = stream;
exports.read = read;
exports["read-all"] = read_all;
exports["read-string"] = read_string;
exports["read-table"] = read_table;
