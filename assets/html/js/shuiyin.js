/*! tianshengjie */ !
function(t) {
	var e = {};

	function n(i) {
		if(e[i]) return e[i].exports;
		var r = e[i] = {
			i: i,
			l: !1,
			exports: {}
		};
		return t[i].call(r.exports, r, r.exports, n), r.l = !0, r.exports
	}
	n.m = t, n.c = e, n.d = function(t, e, i) {
		n.o(t, e) || Object.defineProperty(t, e, {
			enumerable: !0,
			get: i
		})
	}, n.r = function(t) {
		"undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, {
			value: "Module"
		}), Object.defineProperty(t, "__esModule", {
			value: !0
		})
	}, n.t = function(t, e) {
		if(1 & e && (t = n(t)), 8 & e) return t;
		if(4 & e && "object" == typeof t && t && t.__esModule) return t;
		var i = Object.create(null);
		if(n.r(i), Object.defineProperty(i, "default", {
				enumerable: !0,
				value: t
			}), 2 & e && "string" != typeof t)
			for(var r in t) n.d(i, r, function(e) {
				return t[e]
			}.bind(null, r));
		return i
	}, n.n = function(t) {
		var e = t && t.__esModule ? function() {
			return t.default
		} : function() {
			return t
		};
		return n.d(e, "a", e), e
	}, n.o = function(t, e) {
		return Object.prototype.hasOwnProperty.call(t, e)
	}, n.p = "/dist/", n(n.s = 81)
}({
	81: function(t, e, n) {
		"use strict";
		var i = new(n(82));
		$("#change").on("click", function() {
			i.resetText($("#text").val())
		})
	},
	82: function(t, e, n) {
		"use strict";
		var i = function() {
			function t(t, e) {
				for(var n = 0; n < e.length; n++) {
					var i = e[n];
					i.enumerable = i.enumerable || !1, i.configurable = !0, "value" in i && (i.writable = !0), Object.defineProperty(t, i.key, i)
				}
			}
			return function(e, n, i) {
				return n && t(e.prototype, n), i && t(e, i), e
			}
		}();
		t.exports = function() {
			function t(e) {
				(function(t, e) {
					if(!(t instanceof e)) throw new TypeError("Cannot call a class as a function")
				})(this, t), this.params = Object.assign({
					size: "30px",
					color: "#f1f1f1",
					id: "fingerprint",
					text: "删不掉的水印！",
					density: 250,
					clarity: 1,
					supportTip: "你的浏览器不支持Canvas"
				}, e), this._init(), this._intervalometer()
			}
			return i(t, [{
				key: "resetText",
				value: function(t) {
					this.params.text = t, this._init()
				}
			}, {
				key: "_init",
				value: function() {
					this._createCanvas(), this._fill()
				}
			}, {
				key: "_intervalometer",
				value: function() {
					var t = this;
					window.setInterval(function() {
						document.getElementById(t.params.id) || t._init()

					}, 1e3)
				}
			}, {
				key: "_createCanvas",
				value: function() {
					var t = document.getElementById(this.params.id);
					t && t.parentNode.removeChild(t);
					var e = document.getElementsByTagName("body"),
						n = window.screen.width,
						i = window.screen.height,
						r = document.createElement("canvas");
					r.setAttribute("id", this.params.id), r.innerHTML = this.params.supportTip, r.width = n * this.params.clarity, r.height = i * this.params.clarity, r.style.cssText = "position: fixed;width: 100%;height: 100%;left:0;top:0;z-index: -1;", e[0].appendChild(r)
				}
			}, {
				key: "_fill",
				value: function() {
					var t = document.getElementById(this.params.id).getContext("2d"),
						e = window.screen.width * this.params.clarity / this.params.density + 10,
						n = window.screen.height * this.params.clarity * 1.5 / this.params.density;
					t.rotate(-15 * Math.PI / 180);
					for(var i = 0; i < e; i++)
						for(var r = 0; r < n; r++) t.fillStyle = this.params.color, t.font = this.params.size + " Arial", t.fillText(this.params.text, this.params.density * (i - 5), r * this.params.density)
				}
			}]), t
		}()
	}
});