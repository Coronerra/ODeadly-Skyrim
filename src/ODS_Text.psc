Scriptname ODS_Text Hidden
{O'Deadly Skyrim 1.2.0: narration text loader. Globals only, no state. By That Guy (Coronerra).
Templates live in Data/SKSE/Plugins/ODeadlySkyrim/narration.json (flat key to string map, read with
PapyrusUtil JsonUtil, never written). Tokens are pn, an, vn, where, x1, x2, x3 in curly braces.
Missing file, missing key, empty value or an unfilled placeholder =the short fallback from code.}

string Function FileName() Global
	return "../ODeadlySkyrim/narration"
EndFunction

; once per game load (OnGameLoaded): forget the cached file so edits apply without a recompile.
; saveChanges = false: this mod never writes the file.
Function Reload() Global
	If SKSE.GetPluginVersion("papyrusutil plugin") > 0
		JsonUtil.Unload(FileName(), false)
	EndIf
EndFunction

string Function T(string key, string fallback, string pn = "", string an = "", string vn = "", string where = "", string x1 = "", string x2 = "", string x3 = "") Global
	string s = ""
	If SKSE.GetPluginVersion("papyrusutil plugin") > 0
		s = JsonUtil.GetStringValue(FileName(), key, "")
	EndIf
	; an unfilled placeholder from the data file counts as missing (literal split so no marker text sits in code)
	If s == "" || StringUtil.Find(s, "[[GROK" + "-WRITE") >= 0
		s = fallback
	EndIf
	If StringUtil.Find(s, "{") < 0
		return s
	EndIf
	s = Rep(s, "{pn}", pn)
	s = Rep(s, "{an}", an)
	s = Rep(s, "{vn}", vn)
	s = Rep(s, "{where}", where)
	s = Rep(s, "{x1}", x1)
	s = Rep(s, "{x2}", x2)
	s = Rep(s, "{x3}", x3)
	return s
EndFunction

; replace every tok in s by val (a value that itself contains tok is not scanned again)
string Function Rep(string s, string tok, string val) Global
	string outS = ""
	int from = 0
	int guard = 0
	int n = StringUtil.GetLength(s)
	int tl = StringUtil.GetLength(tok)
	While guard < 16
		int p = StringUtil.Find(s, tok, from)
		If p < 0
			return outS + StringUtil.Substring(s, from, n - from)
		EndIf
		outS = outS + StringUtil.Substring(s, from, p - from) + val
		from = p + tl
		guard += 1
	EndWhile
	return outS + StringUtil.Substring(s, from, n - from)
EndFunction
