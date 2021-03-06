environment = [{}];
target = "js";
nil63 = function (x) {
  return(x === undefined || x === null);
};
is63 = function (x) {
  return(! nil63(x));
};
_35 = function (x) {
  return(x.length || 0);
};
none63 = function (x) {
  return(_35(x) === 0);
};
some63 = function (x) {
  return(_35(x) > 0);
};
one63 = function (x) {
  return(_35(x) === 1);
};
two63 = function (x) {
  return(_35(x) === 2);
};
hd = function (l) {
  return(l[0]);
};
type = function (x) {
  return(typeof(x));
};
string63 = function (x) {
  return(type(x) === "string");
};
number63 = function (x) {
  return(type(x) === "number");
};
boolean63 = function (x) {
  return(type(x) === "boolean");
};
function63 = function (x) {
  return(type(x) === "function");
};
obj63 = function (x) {
  return(is63(x) && type(x) === "object");
};
atom63 = function (x) {
  return(nil63(x) || string63(x) || number63(x) || boolean63(x) || function63(x));
};
nan = 0 / 0;
inf = 1 / 0;
nan63 = function (n) {
  return(!( n === n));
};
inf63 = function (n) {
  return(n === inf || n === -inf);
};
clip = function (s, from, upto) {
  return(s.substring(from, upto));
};
cut = function (x, from, upto) {
  var l = [];
  var j = 0;
  var _e;
  if (nil63(from) || from < 0) {
    _e = 0;
  } else {
    _e = from;
  }
  var i = _e;
  var n = _35(x);
  var _e1;
  if (nil63(upto) || upto > n) {
    _e1 = n;
  } else {
    _e1 = upto;
  }
  var _upto = _e1;
  while (i < _upto) {
    l[j] = x[i];
    i = i + 1;
    j = j + 1;
  }
  var _o = x;
  var k = undefined;
  for (k in _o) {
    var v = _o[k];
    var _e2;
    if (numeric63(k)) {
      _e2 = parseInt(k);
    } else {
      _e2 = k;
    }
    var _k = _e2;
    if (! number63(_k)) {
      l[_k] = v;
    }
  }
  return(l);
};
keys = function (x) {
  var t = [];
  var _o1 = x;
  var k = undefined;
  for (k in _o1) {
    var v = _o1[k];
    var _e3;
    if (numeric63(k)) {
      _e3 = parseInt(k);
    } else {
      _e3 = k;
    }
    var _k1 = _e3;
    if (! number63(_k1)) {
      t[_k1] = v;
    }
  }
  return(t);
};
edge = function (x) {
  return(_35(x) - 1);
};
inner = function (x) {
  return(clip(x, 1, edge(x)));
};
tl = function (l) {
  return(cut(l, 1));
};
char = function (s, n) {
  return(s.charAt(n));
};
code = function (s, n) {
  return(s.charCodeAt(n));
};
string_literal63 = function (x) {
  return(string63(x) && char(x, 0) === "\"");
};
id_literal63 = function (x) {
  return(string63(x) && char(x, 0) === "|");
};
add = function (l, x) {
  l.push(x);
  return(undefined);
};
drop = function (l) {
  return(l.pop());
};
last = function (l) {
  return(l[edge(l)]);
};
almost = function (l) {
  return(cut(l, 0, edge(l)));
};
reverse = function (l) {
  var l1 = keys(l);
  var i = edge(l);
  while (i >= 0) {
    add(l1, l[i]);
    i = i - 1;
  }
  return(l1);
};
reduce = function (f, x) {
  if (none63(x)) {
    return(x);
  } else {
    if (one63(x)) {
      return(hd(x));
    } else {
      return(f(hd(x), reduce(f, tl(x))));
    }
  }
};
join = function () {
  var ls = unstash(Array.prototype.slice.call(arguments, 0));
  if (two63(ls)) {
    var _id = ls;
    var a = _id[0];
    var b = _id[1];
    if (a && b) {
      var c = [];
      var o = _35(a);
      var _o2 = a;
      var k = undefined;
      for (k in _o2) {
        var v = _o2[k];
        var _e4;
        if (numeric63(k)) {
          _e4 = parseInt(k);
        } else {
          _e4 = k;
        }
        var _k2 = _e4;
        c[_k2] = v;
      }
      var _o3 = b;
      var k = undefined;
      for (k in _o3) {
        var v = _o3[k];
        var _e5;
        if (numeric63(k)) {
          _e5 = parseInt(k);
        } else {
          _e5 = k;
        }
        var _k3 = _e5;
        if (number63(_k3)) {
          _k3 = _k3 + o;
        }
        c[_k3] = v;
      }
      return(c);
    } else {
      return(a || b || []);
    }
  } else {
    return(reduce(join, ls));
  }
};
find = function (f, t) {
  var _o4 = t;
  var _i4 = undefined;
  for (_i4 in _o4) {
    var x = _o4[_i4];
    var _e6;
    if (numeric63(_i4)) {
      _e6 = parseInt(_i4);
    } else {
      _e6 = _i4;
    }
    var __i4 = _e6;
    var y = f(x);
    if (y) {
      return(y);
    }
  }
};
first = function (f, l) {
  var _x1 = l;
  var _n5 = _35(_x1);
  var _i5 = 0;
  while (_i5 < _n5) {
    var x = _x1[_i5];
    var y = f(x);
    if (y) {
      return(y);
    }
    _i5 = _i5 + 1;
  }
};
in63 = function (x, t) {
  return(find(function (y) {
    return(x === y);
  }, t));
};
pair = function (l) {
  var l1 = [];
  var i = 0;
  while (i < _35(l)) {
    add(l1, [l[i], l[i + 1]]);
    i = i + 1;
    i = i + 1;
  }
  return(l1);
};
tuple = function (lst, n) {
  if (nil63(n)) {
    n = 2;
  }
  var l1 = [];
  var i = 0;
  while (i < _35(lst)) {
    var l2 = [];
    var j = 0;
    while (j < n) {
      add(l2, lst[i + j]);
      j = j + 1;
    }
    add(l1, l2);
    i = i + (n - 1);
    i = i + 1;
  }
  return(l1);
};
vals = function (lst) {
  var r = [];
  var _x3 = lst;
  var _n6 = _35(_x3);
  var _i6 = 0;
  while (_i6 < _n6) {
    var x = _x3[_i6];
    add(r, x);
    _i6 = _i6 + 1;
  }
  return(r);
};
sort = function (l, f) {
  var _e7;
  if (f) {
    _e7 = function (a, b) {
      if (f(a, b)) {
        return(-1);
      } else {
        return(1);
      }
    };
  }
  return(l.sort(_e7));
};
map = function (f, x) {
  var t = [];
  var _x4 = x;
  var _n7 = _35(_x4);
  var _i7 = 0;
  while (_i7 < _n7) {
    var v = _x4[_i7];
    var y = f(v);
    if (is63(y)) {
      add(t, y);
    }
    _i7 = _i7 + 1;
  }
  var _o5 = x;
  var k = undefined;
  for (k in _o5) {
    var v = _o5[k];
    var _e8;
    if (numeric63(k)) {
      _e8 = parseInt(k);
    } else {
      _e8 = k;
    }
    var _k4 = _e8;
    if (! number63(_k4)) {
      var y = f(v);
      if (is63(y)) {
        t[_k4] = y;
      }
    }
  }
  return(t);
};
keep = function (f, x) {
  return(map(function (v) {
    if (f(v)) {
      return(v);
    }
  }, x));
};
keys63 = function (t) {
  var _o6 = t;
  var k = undefined;
  for (k in _o6) {
    var v = _o6[k];
    var _e9;
    if (numeric63(k)) {
      _e9 = parseInt(k);
    } else {
      _e9 = k;
    }
    var _k5 = _e9;
    if (! number63(_k5)) {
      return(true);
    }
  }
  return(false);
};
empty63 = function (t) {
  var _o7 = t;
  var _i10 = undefined;
  for (_i10 in _o7) {
    var x = _o7[_i10];
    var _e10;
    if (numeric63(_i10)) {
      _e10 = parseInt(_i10);
    } else {
      _e10 = _i10;
    }
    var __i10 = _e10;
    return(false);
  }
  return(true);
};
stash = function (args) {
  if (keys63(args)) {
    var p = [];
    var _o8 = args;
    var k = undefined;
    for (k in _o8) {
      var v = _o8[k];
      var _e11;
      if (numeric63(k)) {
        _e11 = parseInt(k);
      } else {
        _e11 = k;
      }
      var _k6 = _e11;
      if (! number63(_k6)) {
        p[_k6] = v;
      }
    }
    p._stash = true;
    add(args, p);
  }
  return(args);
};
unstash = function (args) {
  if (none63(args)) {
    return([]);
  } else {
    var l = last(args);
    if (! atom63(l) && l._stash) {
      var args1 = almost(args);
      var _o9 = l;
      var k = undefined;
      for (k in _o9) {
        var v = _o9[k];
        var _e12;
        if (numeric63(k)) {
          _e12 = parseInt(k);
        } else {
          _e12 = k;
        }
        var _k7 = _e12;
        if (!( _k7 === "_stash")) {
          args1[_k7] = v;
        }
      }
      return(args1);
    } else {
      return(args);
    }
  }
};
search = function (s, pattern, start) {
  var i = s.indexOf(pattern, start);
  if (i >= 0) {
    return(i);
  }
};
split = function (s, sep) {
  if (s === "" || sep === "") {
    return([]);
  } else {
    var l = [];
    var n = _35(sep);
    while (true) {
      var i = search(s, sep);
      if (nil63(i)) {
        break;
      } else {
        add(l, clip(s, 0, i));
        s = clip(s, i + n);
      }
    }
    add(l, s);
    return(l);
  }
};
cat = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  if (none63(xs)) {
    return("");
  } else {
    return(reduce(function (a, b) {
      return(a + b);
    }, xs));
  }
};
_43 = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  return(reduce(function (a, b) {
    return(a + b);
  }, xs));
};
_ = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  return(reduce(function (b, a) {
    return(a - b);
  }, reverse(xs)));
};
_42 = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  return(reduce(function (a, b) {
    return(a * b);
  }, xs));
};
_47 = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  return(reduce(function (b, a) {
    return(a / b);
  }, reverse(xs)));
};
_37 = function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  return(reduce(function (b, a) {
    return(a % b);
  }, reverse(xs)));
};
_62 = function (a, b) {
  return(a > b);
};
_60 = function (a, b) {
  return(a < b);
};
_61 = function (a, b) {
  return(a === b);
};
_6261 = function (a, b) {
  return(a >= b);
};
_6061 = function (a, b) {
  return(a <= b);
};
number = function (s) {
  var n = parseFloat(s);
  if (! isNaN(n)) {
    return(n);
  }
};
number_code63 = function (n) {
  return(n > 47 && n < 58);
};
numeric63 = function (s) {
  var n = _35(s);
  var i = 0;
  while (i < n) {
    if (! number_code63(code(s, i))) {
      return(false);
    }
    i = i + 1;
  }
  return(true);
};
var tostring = function (x) {
  return(x.toString());
};
escape = function (s) {
  var s1 = "\"";
  var i = 0;
  while (i < _35(s)) {
    var c = char(s, i);
    var _e13;
    if (c === "\n") {
      _e13 = "\\n";
    } else {
      var _e14;
      if (c === "\"") {
        _e14 = "\\\"";
      } else {
        var _e15;
        if (c === "\\") {
          _e15 = "\\\\";
        } else {
          _e15 = c;
        }
        _e14 = _e15;
      }
      _e13 = _e14;
    }
    var c1 = _e13;
    s1 = s1 + c1;
    i = i + 1;
  }
  return(s1 + "\"");
};
str = function (x, depth, ancestors) {
  if (nil63(x)) {
    return("nil");
  } else {
    if (nan63(x)) {
      return("nan");
    } else {
      if (x === inf) {
        return("inf");
      } else {
        if (x === -inf) {
          return("-inf");
        } else {
          if (boolean63(x)) {
            if (x) {
              return("true");
            } else {
              return("false");
            }
          } else {
            if (string63(x)) {
              return(escape(x));
            } else {
              if (atom63(x)) {
                return(tostring(x));
              } else {
                if (function63(x)) {
                  return("fn");
                } else {
                  if (! obj63(x)) {
                    return("|" + type(x) + "|");
                  } else {
                    var s = "(";
                    var sp = "";
                    var xs = [];
                    var ks = [];
                    var d = (depth || 0) + 1;
                    var ans = join([x], ancestors || []);
                    if (in63(x, ancestors || [])) {
                      return("circular");
                    }
                    var _o10 = x;
                    var k = undefined;
                    for (k in _o10) {
                      var v = _o10[k];
                      var _e16;
                      if (numeric63(k)) {
                        _e16 = parseInt(k);
                      } else {
                        _e16 = k;
                      }
                      var _k8 = _e16;
                      if (number63(_k8)) {
                        xs[_k8] = str(v, d, ans);
                      } else {
                        add(ks, _k8 + ":");
                        add(ks, str(v, d, ans));
                      }
                    }
                    var _o11 = join(xs, ks);
                    var _i14 = undefined;
                    for (_i14 in _o11) {
                      var v = _o11[_i14];
                      var _e17;
                      if (numeric63(_i14)) {
                        _e17 = parseInt(_i14);
                      } else {
                        _e17 = _i14;
                      }
                      var __i14 = _e17;
                      s = s + sp + v;
                      sp = " ";
                    }
                    return(s + ")");
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};
apply = function (f, args) {
  var _args = stash(args);
  return(f.apply(f, _args));
};
call = function (f) {
  return(f());
};
toplevel63 = function () {
  return(one63(environment));
};
setenv = function (k) {
  var _r71 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id1 = _r71;
  var _keys = cut(_id1, 0);
  if (string63(k)) {
    var _e18;
    if (_keys.toplevel) {
      _e18 = hd(environment);
    } else {
      _e18 = last(environment);
    }
    var frame = _e18;
    var entry = frame[k] || {};
    var _o12 = _keys;
    var _k9 = undefined;
    for (_k9 in _o12) {
      var v = _o12[_k9];
      var _e19;
      if (numeric63(_k9)) {
        _e19 = parseInt(_k9);
      } else {
        _e19 = _k9;
      }
      var _k10 = _e19;
      entry[_k10] = v;
    }
    frame[k] = entry;
    return(frame[k]);
  }
};
print = function (x) {
  return(console.log(x));
};
var math = Math;
abs = math.abs;
acos = math.acos;
asin = math.asin;
atan = math.atan;
atan2 = math.atan2;
ceil = math.ceil;
cos = math.cos;
floor = math.floor;
log = math.log;
log10 = math.log10;
max = math.max;
min = math.min;
pow = math.pow;
random = math.random;
sin = math.sin;
sinh = math.sinh;
sqrt = math.sqrt;
tan = math.tan;
tanh = math.tanh;

setenv("quote", {_stash: true, macro: function (form) {
  return(quoted(form));
}});
setenv("quasiquote", {_stash: true, macro: function (form) {
  return(quasiexpand(form, 1));
}});
setenv("at", {_stash: true, macro: function (l, i) {
  if (target === "lua" && number63(i)) {
    i = i + 1;
  } else {
    if (target === "lua") {
      i = ["+", i, 1];
    }
  }
  return(["get", l, i]);
}});
setenv("wipe", {_stash: true, macro: function (place) {
  if (target === "lua") {
    return(["set", place, "nil"]);
  } else {
    return(["%delete", place]);
  }
}});
setenv("list", {_stash: true, macro: function () {
  var body = unstash(Array.prototype.slice.call(arguments, 0));
  var x = unique("x");
  var l = [];
  var forms = [];
  var _o1 = body;
  var k = undefined;
  for (k in _o1) {
    var v = _o1[k];
    var _e3;
    if (numeric63(k)) {
      _e3 = parseInt(k);
    } else {
      _e3 = k;
    }
    var _k = _e3;
    if (number63(_k)) {
      l[_k] = v;
    } else {
      add(forms, ["set", ["get", x, ["quote", _k]], v]);
    }
  }
  if (some63(forms)) {
    return(join(["let", x, join(["%array"], l)], forms, [x]));
  } else {
    return(join(["%array"], l));
  }
}});
setenv("if", {_stash: true, macro: function () {
  var branches = unstash(Array.prototype.slice.call(arguments, 0));
  return(hd(expand_if(branches)));
}});
setenv("case", {_stash: true, macro: function (x) {
  var _r10 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id2 = _r10;
  var clauses = cut(_id2, 0);
  var bs = map(function (_x31) {
    var _id3 = _x31;
    var a = _id3[0];
    var b = _id3[1];
    if (nil63(b)) {
      return([a]);
    } else {
      return([["=", ["quote", a], x], b]);
    }
  }, pair(clauses));
  return(join(["if"], apply(join, bs)));
}});
setenv("when", {_stash: true, macro: function (cond) {
  var _r13 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id5 = _r13;
  var body = cut(_id5, 0);
  return(["if", cond, join(["do"], body)]);
}});
setenv("unless", {_stash: true, macro: function (cond) {
  var _r15 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id7 = _r15;
  var body = cut(_id7, 0);
  return(["if", ["not", cond], join(["do"], body)]);
}});
setenv("obj", {_stash: true, macro: function () {
  var body = unstash(Array.prototype.slice.call(arguments, 0));
  return(join(["%object"], mapo(function (x) {
    return(x);
  }, body)));
}});
setenv("let", {_stash: true, macro: function (bs) {
  var _r19 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id11 = _r19;
  var body = cut(_id11, 0);
  if (atom63(bs)) {
    return(join(["let", [bs, hd(body)]], tl(body)));
  } else {
    if (none63(bs)) {
      return(join(["do"], body));
    } else {
      var _id12 = bs;
      var lh = _id12[0];
      var rh = _id12[1];
      var bs2 = cut(_id12, 2);
      var _id13 = bind(lh, rh);
      var id = _id13[0];
      var val = _id13[1];
      var bs1 = cut(_id13, 2);
      var renames = [];
      if (bound63(id) || toplevel63()) {
        var id1 = unique(id);
        renames = [id, id1];
        id = id1;
      } else {
        setenv(id, {_stash: true, variable: true});
      }
      return(["do", ["%local", id, val], ["let-symbol", renames, join(["let", join(bs1, bs2)], body)]]);
    }
  }
}});
setenv("with", {_stash: true, macro: function (x, v) {
  var _r21 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id15 = _r21;
  var body = cut(_id15, 0);
  return(join(["let", [x, v]], body, [x]));
}});
setenv("let-when", {_stash: true, macro: function (x, v) {
  var _r23 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id17 = _r23;
  var body = cut(_id17, 0);
  var y = unique("y");
  return(["let", y, v, ["when", y, join(["let", [x, y]], body)]]);
}});
setenv("define-macro", {_stash: true, macro: function (name, args) {
  var _r25 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id19 = _r25;
  var body = cut(_id19, 0);
  var _x89 = ["setenv", ["quote", name]];
  _x89.macro = join(["fn", args], body);
  var form = _x89;
  eval(form);
  return(form);
}});
setenv("define-special", {_stash: true, macro: function (name, args) {
  var _r27 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id21 = _r27;
  var body = cut(_id21, 0);
  var _x96 = ["setenv", ["quote", name]];
  _x96.special = join(["fn", args], body);
  var form = join(_x96, keys(body));
  eval(form);
  return(form);
}});
setenv("define-symbol", {_stash: true, macro: function (name, expansion) {
  setenv(name, {_stash: true, symbol: expansion});
  var _x102 = ["setenv", ["quote", name]];
  _x102.symbol = ["quote", expansion];
  return(_x102);
}});
setenv("define-reader", {_stash: true, macro: function (_x111) {
  var _id24 = _x111;
  var char = _id24[0];
  var s = _id24[1];
  var _r31 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id25 = _r31;
  var body = cut(_id25, 0);
  return(["set", ["get", "read-table", char], join(["fn", [s]], body)]);
}});
setenv("define", {_stash: true, macro: function (name, x) {
  var _r33 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id27 = _r33;
  var body = cut(_id27, 0);
  setenv(name, {_stash: true, variable: true});
  if (some63(body)) {
    return(join(["%local-function", name], bind42(x, body)));
  } else {
    return(["%local", name, x]);
  }
}});
setenv("define-global", {_stash: true, macro: function (name, x) {
  var _r35 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id29 = _r35;
  var body = cut(_id29, 0);
  setenv(name, {_stash: true, toplevel: true, variable: true});
  if (some63(body)) {
    return(join(["%global-function", name], bind42(x, body)));
  } else {
    return(["set", name, x]);
  }
}});
setenv("with-frame", {_stash: true, macro: function () {
  var body = unstash(Array.prototype.slice.call(arguments, 0));
  var x = unique("x");
  return(["do", ["add", "environment", ["obj"]], ["with", x, join(["do"], body), ["drop", "environment"]]]);
}});
setenv("with-bindings", {_stash: true, macro: function (_x144) {
  var _id32 = _x144;
  var names = _id32[0];
  var _r37 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id33 = _r37;
  var body = cut(_id33, 0);
  var x = unique("x");
  var _x147 = ["setenv", x];
  _x147.variable = true;
  return(join(["with-frame", ["each", x, names, _x147]], body));
}});
setenv("let-macro", {_stash: true, macro: function (definitions) {
  var _r40 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id35 = _r40;
  var body = cut(_id35, 0);
  add(environment, {});
  map(function (m) {
    return(macroexpand(join(["define-macro"], m)));
  }, definitions);
  var _x152 = join(["do"], macroexpand(body));
  drop(environment);
  return(_x152);
}});
setenv("let-symbol", {_stash: true, macro: function (expansions) {
  var _r44 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id38 = _r44;
  var body = cut(_id38, 0);
  add(environment, {});
  map(function (_x161) {
    var _id39 = _x161;
    var name = _id39[0];
    var exp = _id39[1];
    return(macroexpand(["define-symbol", name, exp]));
  }, pair(expansions));
  var _x160 = join(["do"], macroexpand(body));
  drop(environment);
  return(_x160);
}});
setenv("let-unique", {_stash: true, macro: function (names) {
  var _r48 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id41 = _r48;
  var body = cut(_id41, 0);
  var bs = map(function (n) {
    return([n, ["unique", ["quote", n]]]);
  }, names);
  return(join(["let", apply(join, bs)], body));
}});
setenv("fn", {_stash: true, macro: function (args) {
  var _r51 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id43 = _r51;
  var body = cut(_id43, 0);
  return(join(["%function"], bind42(args, body)));
}});
setenv("guard", {_stash: true, macro: function (expr) {
  if (target === "js") {
    return([["fn", join(), ["%try", ["list", true, expr]]]]);
  } else {
    var x = unique("x");
    var msg = unique("msg");
    var trace = unique("trace");
    return(["let", [x, "nil", msg, "nil", trace, "nil"], ["if", ["xpcall", ["fn", join(), ["set", x, expr]], ["fn", ["m"], ["set", msg, ["clip", "m", ["+", ["search", "m", "\": \""], 2]]], ["set", trace, [["get", "debug", ["quote", "traceback"]]]]]], ["list", true, x], ["list", false, msg, trace]]]);
  }
}});
setenv("each", {_stash: true, macro: function (x, t) {
  var _r55 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id46 = _r55;
  var body = cut(_id46, 0);
  var o = unique("o");
  var n = unique("n");
  var i = unique("i");
  var _e4;
  if (atom63(x)) {
    _e4 = [i, x];
  } else {
    var _e5;
    if (_35(x) > 1) {
      _e5 = x;
    } else {
      _e5 = [i, hd(x)];
    }
    _e4 = _e5;
  }
  var _id47 = _e4;
  var k = _id47[0];
  var v = _id47[1];
  var _e6;
  if (target === "lua") {
    _e6 = body;
  } else {
    _e6 = [join(["let", k, ["if", ["numeric?", k], ["parseInt", k], k]], body)];
  }
  return(["let", [o, t, k, "nil"], ["%for", o, k, join(["let", [v, ["get", o, k]]], _e6)]]);
}});
setenv("for", {_stash: true, macro: function (i, to) {
  var _r57 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id49 = _r57;
  var body = cut(_id49, 0);
  return(["let", i, 0, join(["while", ["<", i, to]], body, [["inc", i]])]);
}});
setenv("step", {_stash: true, macro: function (v, t) {
  var _r59 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id51 = _r59;
  var body = cut(_id51, 0);
  var x = unique("x");
  var n = unique("n");
  var i = unique("i");
  return(["let", [x, t, n, ["#", x]], ["for", i, n, join(["let", [v, ["at", x, i]]], body)]]);
}});
setenv("set-of", {_stash: true, macro: function () {
  var xs = unstash(Array.prototype.slice.call(arguments, 0));
  var l = [];
  var _o3 = xs;
  var _i3 = undefined;
  for (_i3 in _o3) {
    var x = _o3[_i3];
    var _e7;
    if (numeric63(_i3)) {
      _e7 = parseInt(_i3);
    } else {
      _e7 = _i3;
    }
    var __i3 = _e7;
    l[x] = true;
  }
  return(join(["obj"], l));
}});
setenv("language", {_stash: true, macro: function () {
  return(["quote", target]);
}});
setenv("target", {_stash: true, macro: function () {
  var clauses = unstash(Array.prototype.slice.call(arguments, 0));
  return(clauses[target]);
}});
setenv("join!", {_stash: true, macro: function (a) {
  var _r63 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id53 = _r63;
  var bs = cut(_id53, 0);
  return(["set", a, join(["join", a], bs)]);
}});
setenv("cat!", {_stash: true, macro: function (a) {
  var _r65 = unstash(Array.prototype.slice.call(arguments, 1));
  var _id55 = _r65;
  var bs = cut(_id55, 0);
  return(["set", a, join(["cat", a], bs)]);
}});
setenv("inc", {_stash: true, macro: function (n, by) {
  return(["set", n, ["+", n, by || 1]]);
}});
setenv("dec", {_stash: true, macro: function (n, by) {
  return(["set", n, ["-", n, by || 1]]);
}});
setenv("with-indent", {_stash: true, macro: function (form) {
  var x = unique("x");
  return(["do", ["inc", "indent-level"], ["with", x, form, ["dec", "indent-level"]]]);
}});
setenv("export", {_stash: true, macro: function () {
  var names = unstash(Array.prototype.slice.call(arguments, 0));
  if (target === "js") {
    return(join(["do"], map(function (k) {
      return(["set", ["get", "exports", ["quote", k]], k]);
    }, names)));
  } else {
    var x = {};
    var _o5 = names;
    var _i5 = undefined;
    for (_i5 in _o5) {
      var k = _o5[_i5];
      var _e8;
      if (numeric63(_i5)) {
        _e8 = parseInt(_i5);
      } else {
        _e8 = _i5;
      }
      var __i5 = _e8;
      x[k] = k;
    }
    return(["return", join(["obj"], x)]);
  }
}});

env = require("system")["get-environment-variable"];
home = env("laarc_home");
stdin_tty63 = env("laarc_stdin_tty");
stdout_tty63 = env("laarc_stdout_tty");
setenv("eval-now", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  eval(join(["do"], l));
  return(join(["do"], l));
}});
if (last(environment).laarc) {
  drop(environment);
}
add(environment, {laarc: true});
setenv("eval-now", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  eval(join(["do"], l));
  return(join(["do"], l));
}});
setenv("during-compile", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  eval(join(["do"], l));
  return(undefined);
}});
compiler = require("compiler");
print_compiled = function (expr) {
  print(compile(compiler.expand(["do", expr])));
  return(expr);
};
print_env = function () {
  var _x16 = environment;
  var _n2 = _35(_x16);
  var _i2 = 0;
  while (_i2 < _n2) {
    var frame = _x16[_i2];
    print("----------------");
    var _o1 = frame;
    var k = undefined;
    for (k in _o1) {
      var v = _o1[k];
      var _e4;
      if (numeric63(k)) {
        _e4 = parseInt(k);
      } else {
        _e4 = k;
      }
      var _k = _e4;
      print(str(_k) + ": " + str(v));
    }
    _i2 = _i2 + 1;
  }
};
map3 = function (f, lst) {
  var r = [];
  var i = 0;
  while (i < _35(lst)) {
    if (i > 0) {
      add(r, f(lst[i - 1], lst[i], lst[i + 1]));
    }
    i = i + 1;
  }
  return(r);
};
setenv("def?", {_stash: true, macro: function (x) {
  return(["not", ["=", ["typeof", x], "\"undefined\""]]);
}});
_37kv = ["%kv"];
_37nil = ["%nil"];
setenv("%nil", {_stash: true, macro: function () {
  return(["do", "nil"]);
}});
setenv("lumen-eq", {_stash: true, symbol: ["do", "="]});
setenv("lumen-assign", {_stash: true, symbol: ["do", "set"]});
setenv("lumen-len", {_stash: true, symbol: ["do", "#"]});
setenv("lumen-str", {_stash: true, symbol: ["do", "str"]});
setenv("lumen-cat", {_stash: true, symbol: ["do", "cat"]});
setenv("arc-toplevel?", {_stash: true, macro: function () {
  return(["two?", "environment"]);
}});
setenv("each", {_stash: true, macro: function (x, t) {
  var _r15 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id2 = _r15;
  var body = cut(_id2, 0);
  var o = unique("o");
  var n = unique("n");
  var i = unique("i");
  var c = unique("c");
  var _e5;
  if (atom63(x)) {
    _e5 = [i, x];
  } else {
    var _e6;
    if (_35(x) > 1) {
      _e6 = x;
    } else {
      _e6 = [i, hd(x)];
    }
    _e5 = _e6;
  }
  var _id3 = _e5;
  var k = _id3[0];
  var v = _id3[1];
  var _x81 = ["target"];
  _x81.js = ["if", ["numeric?", k], ["set", k, ["parseInt", k]]];
  return(["let", [o, t, c, 0, k, "nil"], ["%for", o, k, ["if", [">", c, 0], ["dec", c], join(["let", [v, ["get", o, k]], _x81, ["when", ["lumen-eq", v, "%kv"], ["set", c, 2], ["set", v, ["get", o, ["+", k, 2]]], ["set", k, ["get", o, ["+", k, 1]]]], ["when", ["lumen-eq", v, "%nil"], ["set", v, "nil"]]], body)]]]);
}});
setenv("for", {_stash: true, macro: function (i, to) {
  var _r17 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id5 = _r17;
  var body = cut(_id5, 0);
  return(["let", i, 0, join(["while", ["<", i, to]], body, [["inc", i]])]);
}});
setenv("step", {_stash: true, macro: function (v, t) {
  var _r19 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id7 = _r19;
  var body = cut(_id7, 0);
  var x = unique("x");
  var n = unique("n");
  var i = unique("i");
  var c = unique("c");
  var u = unique("u");
  return(["let", [x, t, n, ["#", x], c, 0], ["for", i, n, ["when", [">=", i, c], ["let", [u, ["at", x, i]], ["when", ["lumen-eq", u, "%nil"], ["set", u, "nil"]], ["if", ["lumen-eq", u, "%kv"], ["set", c, ["+", i, 3]], ["let", [v, u], join(["do"], body)]]]]]]);
}});
setenv("list", {_stash: true, macro: function () {
  var body = unstash(Array.prototype.slice.call(arguments, 0));
  var x = unique("x");
  var l = [];
  var forms = [];
  var _o3 = body;
  var _c1 = 0;
  var k = undefined;
  for (k in _o3) {
    if (_c1 > 0) {
      _c1 = _c1 - 1;
    } else {
      var v = _o3[k];
      if (numeric63(k)) {
        k = parseInt(k);
      }
      if (v === _37kv) {
        _c1 = 2;
        v = _o3[k + 2];
        k = _o3[k + 1];
      }
      if (v === _37nil) {
        v = undefined;
      }
      if (nil63(v)) {
        v = _37nil;
      }
      if (number63(k)) {
        l[k] = v;
      } else {
        add(forms, ["set", ["get", x, ["quote", k]], v]);
      }
    }
  }
  if (some63(forms)) {
    return(join(["let", x, join(["%array"], l)], forms, [x]));
  } else {
    return(join(["%array"], l));
  }
}});
parse_args = function (xs, inits) {
  if (atom63(xs)) {
    return(xs);
  } else {
    var l = [];
    var rest63 = undefined;
    var kwargs = [];
    var _o6 = xs;
    var _c5 = 0;
    var k = undefined;
    for (k in _o6) {
      if (_c5 > 0) {
        _c5 = _c5 - 1;
      } else {
        var v = _o6[k];
        if (numeric63(k)) {
          k = parseInt(k);
        }
        if (v === _37kv) {
          _c5 = 2;
          v = _o6[k + 2];
          k = _o6[k + 1];
        }
        if (v === _37nil) {
          v = undefined;
        }
        if (number63(k)) {
          k = v;
          v = undefined;
        }
        if (nil63(v)) {
          if (rest63 === true) {
            l.rest = parse_args(k, inits);
            rest63 = k;
          } else {
            add(l, parse_args(k, inits));
          }
        } else {
          if (k === "rest") {
            l.rest = true;
            rest63 = true;
          } else {
            if (atom63(k)) {
              add(inits, ["if", ["nil?", k], ["set", k, v]]);
              if (rest63) {
                add(kwargs, k);
              } else {
                add(l, k);
              }
            } else {
              throw new Error("todo");
            }
          }
        }
      }
    }
    if (rest63 === true) {
      throw new Error(". in an arg list must be followed by an atom");
    } else {
      var _x173 = kwargs;
      var _n10 = _35(_x173);
      var _c6 = 0;
      var _i10 = 0;
      while (_i10 < _n10) {
        if (_i10 >= _c6) {
          var _u1 = _x173[_i10];
          if (_u1 === _37nil) {
            _u1 = undefined;
          }
          if (_u1 === _37kv) {
            _c6 = _i10 + 3;
          } else {
            var k = _u1;
            l[k] = true;
            add(inits, ["wipe", ["get", rest63, ["quote", k]]]);
          }
        }
        _i10 = _i10 + 1;
      }
    }
    return(l);
  }
};
parse_body = function (xs) {
  if (atom63(xs)) {
    return(xs);
  } else {
    var l = [];
    var _o7 = xs;
    var _c7 = 0;
    var k = undefined;
    for (k in _o7) {
      if (_c7 > 0) {
        _c7 = _c7 - 1;
      } else {
        var v = _o7[k];
        if (numeric63(k)) {
          k = parseInt(k);
        }
        if (v === _37kv) {
          _c7 = 2;
          v = _o7[k + 2];
          k = _o7[k + 1];
        }
        if (v === _37nil) {
          v = undefined;
        }
        if (number63(k)) {
          add(l, parse_body(v));
        } else {
          l[k] = parse_body(v);
        }
      }
    }
    return(l);
  }
};
setenv("mac", {_stash: true, macro: function (name, args) {
  var _r25 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id9 = _r25;
  var body = cut(_id9, 0);
  var inits = [];
  return(join(["define-macro", name, parse_args(args, inits)], inits, parse_body(body)));
}});
setenv("def", {_stash: true, macro: function (name, args) {
  var _r27 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id11 = _r27;
  var body = cut(_id11, 0);
  if (none63(body)) {
    return(["define-global", name, args]);
  } else {
    var inits = [];
    return(join(["define-global", name, parse_args(args, inits)], inits, parse_body(body)));
  }
}});
setenv("var", {_stash: true, macro: function (name, args) {
  var _r29 = unstash(Array.prototype.slice.call(arguments, 2));
  var _id13 = _r29;
  var body = cut(_id13, 0);
  if (none63(body)) {
    return(["define", name, args]);
  } else {
    var inits = [];
    return(join(["define", name, parse_args(args, inits)], inits, parse_body(body)));
  }
}});
setenv("sym", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  return(join(["define-symbol"], l));
}});
setenv("t", {_stash: true, symbol: true});
setenv("len", {_stash: true, symbol: "lumen-len"});
setenv("is", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  if (0 === _35(l)) {
    return(true);
  } else {
    if (1 === _35(l)) {
      return(join(["is?"], l));
    } else {
      if (2 === _35(l)) {
        return(join(["lumen-eq"], l));
      } else {
        return(join(["and"], map3(function (x, y) {
          return(["is", x, y]);
        }, l)));
      }
    }
  }
}});
is_var63 = function (x) {
  var _x203 = environment;
  var _n13 = _35(_x203);
  var _c9 = 0;
  var _i13 = 0;
  while (_i13 < _n13) {
    if (_i13 >= _c9) {
      var _u3 = _x203[_i13];
      if (_u3 === _37nil) {
        _u3 = undefined;
      }
      if (_u3 === _37kv) {
        _c9 = _i13 + 3;
      } else {
        var frame = _u3;
        var u = frame[x];
        if (is63(u) && is63(u.variable)) {
          return(true);
        }
      }
    }
    _i13 = _i13 + 1;
  }
};
setenv("=", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  var e = ["do"];
  var final = undefined;
  var _x210 = pair(l);
  var _n15 = _35(_x210);
  var _c11 = 0;
  var _i15 = 0;
  while (_i15 < _n15) {
    if (_i15 >= _c11) {
      var _u5 = _x210[_i15];
      if (_u5 === _37nil) {
        _u5 = undefined;
      }
      if (_u5 === _37kv) {
        _c11 = _i15 + 3;
      } else {
        var _id15 = _u5;
        var x = _id15[0];
        var y = _id15[1];
        final = x;
        if (! is_var63(x)) {
          var _e7;
          if (two63(environment)) {
            _e7 = "def";
          } else {
            _e7 = "var";
          }
          add(e, [_e7, x, "nil"]);
        }
        add(e, ["lumen-assign", x, y]);
      }
    }
    _i15 = _i15 + 1;
  }
  add(e, final);
  return(e);
}});
filechars = require("system")["read-file"];
lumen_readstr = function (x, more) {
  var reader = require("reader");
  var s = reader.stream(x, more);
  return(reader["read-all"](s));
};
readstr = function (x, more, reader) {
  if (nil63(reader)) {
    reader = true;
  }
  var _e8;
  if (reader === true) {
    _e8 = require("ac-reader");
  } else {
    _e8 = r;
  }
  var r = _e8;
  var s = r.stream(x, more);
  return(map(function (x) {
    if (atom63(x)) {
      return(x);
    } else {
      if (hd(x) === "%list") {
        return(tl(x));
      } else {
        return(x);
      }
    }
  }, r["read-all"](s)));
};
_37run = require("compiler").run;
_37expand = require("compiler").expand;
macex = function (expr) {
  return(_37expand(expr));
};
ac_compile = function (expr) {
  return(compile(macex(expr)));
};
ac_compile_str = function (s) {
  return(compile(macex(join(["do"], readstr(s)))));
};
ac_compile_file = function (file) {
  return(ac_compile_str(filechars(file)));
};
ac_load = function (file) {
  var code = ac_compile_file(file);
  if (env("VERBOSE")) {
    print("\n> (ac-load " + file + ")");
    print(code);
  }
  var parts = split(file, ".");
  var name = hd(parts);
  var ext = last(parts);
  ext = "la";
  if (! ext) {
    throw new Error("todo: non-.la files");
  }
  if (! two63(parts)) {
    throw new Error("todo: filepaths containing multiple dots");
  }
  var filename = name + "." + "js";
  require("system")["write-file"](filename, code);
  return(require(last(split(name, "/"))));
};
setenv("prdo", {_stash: true, macro: function () {
  var l = unstash(Array.prototype.slice.call(arguments, 0));
  return(join(["do"], map(function (x) {
    return(["print", ["cat", "\"> \"", ["lumen-str", ["quote", x]], "\"\\n\"", ["lumen-str", [["fn", join(), x]]]]]);
  }, l)));
}});
endswith = function (s, ending) {
  var i = _35(s) - _35(ending);
  return(i === search(s, ending, i));
};
startswith = function (s, prefix) {
  return(search(s, prefix) === 0);
};
pp = function (x) {
  return(print(str(x)));
};
var args = require("system").argv;
var i = 0;
while (i < _35(args)) {
  var arg = args[i];
  if (endswith(arg, ".la")) {
    ac_load(arg);
  } else {
    if (arg === "test") {
      ac_load(home + "/test.la");
      test();
    } else {
      if (arg === "-e") {
        i = i + 1;
        var s = "";
        var _x231 = cut(args, i);
        var _n16 = _35(_x231);
        var _c12 = 0;
        var _i16 = 0;
        while (_i16 < _n16) {
          if (_i16 >= _c12) {
            var _u6 = _x231[_i16];
            if (_u6 === _37nil) {
              _u6 = undefined;
            }
            if (_u6 === _37kv) {
              _c12 = _i16 + 3;
            } else {
              var x = _u6;
              s = s + " " + x;
            }
          }
          _i16 = _i16 + 1;
        }
        _37run(ac_compile_str("(set %result " + s + ")"));
        if (is63(_37result)) {
          pp(_37result);
        }
      } else {
        _37run(arg);
      }
    }
  }
  i = i + 1;
}

