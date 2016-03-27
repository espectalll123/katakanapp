#!/usr/bin/env julia

using Gtk

bld = @GtkBuilder(filename="ui.glade")
win = GAccessor.object(bld, "appWindow")
sendBtn = GAccessor.object(bld, "sendButton")
input = GAccessor.object(bld, "userInput")
kanaLbl = GAccessor.object(bld, "kanaLabel")
answerLbl = GAccessor.object(bld, "answerLabel")

dic = [["ア" "エ" "ウ" "エ"　"オ"
	"カ" "キ" "ク" "ケ"　"コ"
	"サ" "シ" "ス" "セ" "ソ"
	"タ" "チ" "ツ" "テ" "ト"
	"ナ" "ニ" "ヌ" "ネ" "ノ"
	"ハ" "ヒ" "フ" "ヘ" "ホ"
	"マ" "ミ" "ム" "メ" "モ"
	"ヤ" ( ) "ユ" ( ) "ヨ" 
	"ラ" "リ" "ル" "レ" "ロ"
	"ワ" "ヰ" ( ) "ヱ" "ヲ"];
	["a" "i" "u" "e"　"o"
	"ka" "ki" "ku" "ke"　"ko"
	"sa" "shi" "su" "se" "so"
	"ta" "ti" "tsu" "te" "to"
	"na" "ni" "nu" "ne" "no"
	"ha" "hi" "hu" "he" "ho"
	"ma" "mi" "mu" "me" "mo"
	"ya" ( ) "yu" ( ) "yo" 
	"ra" "ri" "ru" "re" "ro"
	"wa" "wi" ( ) "we" "wo"]]

function pickUpKanaId()
    return round(Int, rand() * 51)
end

signal_connect(sendBtn, :clicked) do widget
	idata = getproperty(input, :text, AbstractString)
	setproperty!(kanaLbl, :label, "Text A");
    setproperty!(answerLbl, :label, "Text B");
end
signal_connect(win, :destroy) do widget
	Gtk.gtk_quit()
end

rndId = pickUpKanaId()
setproperty!(kanaLbl, :label, dic[rndId]);
setproperty!(answerLbl, :label, dic[rndId]);

showall(win)
Gtk.gtk_main()
