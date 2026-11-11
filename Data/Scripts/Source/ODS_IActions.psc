Scriptname ODS_IActions Hidden
{O'Deadly Skyrim: soft interface to iActions' extra_alcohol.json. Only called when iActions.esp and JContainers are loaded; never a master.}

Form[] Function ExtraAlcohol() Global
	Form[] r = new Form[64]
	int root = JValue.readFromFile("Data/SKSE/Plugins/iActions/extra_alcohol.json")
	If root == 0
		return r
	EndIf
	int arr = JValue.solveObj(root, ".extra_alcohol")
	int n = 0
	If arr != 0
		n = JArray.count(arr)
	EndIf
	int c = 0
	int i = 0
	While i < n && c < 48
		int e = JArray.getObj(arr, i)
		string hex = JValue.solveStr(e, ".formID")
		If hex == ""
			hex = JValue.solveStr(e, ".form")
		EndIf
		string plugin = JValue.solveStr(e, ".plugin")
		int id = HexToInt(hex)
		If id > 0 && plugin != "" && (Game.GetModByName(plugin) != 255 || Game.GetLightModByName(plugin) != 65535)
			Form f = Game.GetFormFromFile(id, plugin)
			If f
				r[c] = f
				c += 1
			EndIf
		EndIf
		i += 1
	EndWhile
	JValue.release(root)
	return r
EndFunction

int Function HexToInt(string h) Global
	If h == ""
		return 0
	EndIf
	If StringUtil.Find(h, "0x") == 0 || StringUtil.Find(h, "0X") == 0
		h = StringUtil.Substring(h, 2)
	EndIf
	int v = 0
	int i = 0
	int n = StringUtil.GetLength(h)
	While i < n
		string ch = StringUtil.GetNthChar(h, i)
		int d = StringUtil.Find("0123456789ABCDEF", ch)
		If d < 0
			d = StringUtil.Find("0123456789abcdef", ch)
		EndIf
		If d < 0
			return 0
		EndIf
		v = v * 16 + d
		i += 1
	EndWhile
	return Math.LogicalAnd(v, 0x00FFFFFF)
EndFunction
