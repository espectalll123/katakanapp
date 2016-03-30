#!/usr/bin/env julia

using Gtk

bld = @GtkBuilder(filename="ui.glade")
win = GAccessor.object(bld, "appWindow")
sendBtn = GAccessor.object(bld, "sendButton")
input = GAccessor.object(bld, "userInput")
kanaLbl = GAccessor.object(bld, "kanaLabel")
answerLbl = GAccessor.object(bld, "answerLabel")

dic = Vector{AbstractString}[
    ["ア", "エ", "ウ", "エ",　"オ",
	"カ", "キ", "ク", "ケ",　"コ",
	"キャ", "キュ",　"キョ",
	"サ", "シ", "ス", "セ", "ソ",
	"シャ", "シュ", "ショ",
	"タ", "チ", "ツ", "テ", "ト",
	"チャ", "チュ", "チョ",
	"ナ", "ニ", "ヌ", "ネ", "ノ",
	"ニャ", "ニュ", "ニョ",
	"ハ", "ヒ", "フ", "ヘ", "ホ",
	"ヒャ", "ヒュ", "ヒョ",
	"マ", "ミ", "ム", "メ", "モ",
	"ミャ", "ミュ", "ミョ",
	"ヤ",       "ユ",       "ヨ",
	"ラ", "リ", "ル", "レ", "ロ",
	"リャ", "リュ", "リュ",
	"ワ", "ヰ",       "ヱ", "ヲ",
	"ガ", "ギ", "グ", "ゲ", "ゴ",
	"ギャ", "ギュ", "ギョ",
	"ザ", "ジ", "ズ", "ゼ", "ゾ",
	"ジャ", "ジュ", "ジョ",
	"ダ", "ヂ", "ヅ", "デ", "ド",
	"ヂャ", "ヂュ", "ヂョ",
	"バ", "ビ", "ブ", "ベ", "ボ",
	"ビャ", "ビュ", "ビョ",
	"パ", "ピ", "プ", "ペ", "ポ",
	"ピャ", "ピュ", "ピョ"],
	["a", "i", "u", "e",　"o",
	"ka", "ki", "ku", "ke",　"ko",
	"kya", "kyo", "kyu",
	"sa", "shi", "su", "se", "so",
	"sha", "sho", "shu",
	"ta", "chi", "tsu", "te", "to",
	"cha", "cho", "chu",
	"na", "ni", "nu", "ne", "no",
	"nya", "nyo", "nyu",
	"ha", "hi", "hu", "he", "ho",
	"hya", "hyo", "hyu",
	"ma", "mi", "mu", "me", "mo",
	"mya", "myu", "myo",
	"ya",       "yu",       "yo",
	"ra", "ri", "ru", "re", "ro",
	"rya", "ryu", "ryo",
	"wa", "wi",       "we", "wo",
	"ga", "gi", "gu", "ge", "go",
	"gya", "gyu", "gyo",
	"za", "ji", "zu", "ze", "zo",
	"ja", "ju", "jo",
	"da", "(d)ji", "(d)zu", "de", "do",
	"(d)ja", "(d)ju", "(d)jo",
	"ba", "bi", "bu", "be", "bo",
	"bya", "byu", "byo",
	"pa", "pi", "pu", "pe", "po",
	"pya", "pyu", "pyo"]]

function pickUpKana()
    rndId = round(Int, rand() * length(dic[1]))
    return (dic[1][rndId], dic[2][rndId])
end

signal_connect(sendBtn, :clicked) do widget
    global kana
	idata = getproperty(input, :text, AbstractString)
	if idata == kana[2]
	    kana = pickUpKana()
	    setproperty!(kanaLbl, :label, kana[1])
        setproperty!(answerLbl, :label, kana[2])
    end
end
signal_connect(win, :destroy) do widget
	Gtk.gtk_quit()
end

kana = pickUpKana()
setproperty!(kanaLbl, :label, kana[1])
setproperty!(answerLbl, :label, kana[2])

showall(win)
Gtk.gtk_main()
