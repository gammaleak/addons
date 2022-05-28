-- Copyright 2018, Hando
-- Copyright 2021, Yuki
-- Copyright 2022, RadialArcana
-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

    -- * Redistributions of source code must retain the above copyright
      -- notice, this list of conditions and the following disclaimer.
    -- * Redistributions in binary form must reproduce the above copyright
      -- notice, this list of conditions and the following disclaimer in the
      -- documentation and/or other materials provided with the distribution.
    -- * Neither the name of Balloon nor the
      -- names of its contributors may be used to endorse or promote products
      -- derived from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL Hando BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--
_addon.author = 'Originally created by Hando, modified by Yuki for English support and further modified by RadialArcana with help from Kenshi'
_addon.name = 'BalloonBlue'
_addon.version = '1.0'
_addon.commands = {'Balloon','Bl'}
require('chat')
config = require('config')
texts = require('texts')
images = require('images')

windower_settings = windower.get_windower_settings()
center_screen = windower_settings.ui_x_res / 2
ui_scale = { x = windower_settings.x_res / windower_settings.ui_x_res , 
                y = windower_settings.y_res / windower_settings.ui_y_res }
BalloonY = windower_settings.ui_y_res - 258
				
bl_debug = 0
defaults = {}
defaults.blswitch = 2
defaults.pos = {}
defaults.pos.x = center_screen - 280
defaults.pos.y = BalloonY - 4
defaults.text = {}
defaults.text.font = 'Segoe UI symbol'
defaults.text.size = 12
defaults.text.red = 255
defaults.text.green = 255
defaults.text.blue = 255
defaults.text.alpha = 255
defaults.bg = {}
defaults.bg.visible = false
defaults.text.stroke = {}
defaults.text.stroke.width = 3
defaults.text.stroke.alpha = 200
defaults.text.stroke.red = 0
defaults.text.stroke.green = 0
defaults.text.stroke.blue = 20
defaults.text.visible = true
defaults.flags = {}
defaults.flags.draggable = false
defaults.bg.visible = false
defaults.flags = {}
defaults.flags.draggable = false
defaults.blImage = {}
defaults.blImage.color = {}
defaults.blImage.color.alpha = 255
defaults.blImage.color.red = 255
defaults.blImage.color.green = 255
defaults.blImage.color.blue = 255
defaults.blImage.visible = false
defaults.blImage.pos = {}
defaults.blImage.pos.x = center_screen - 365
defaults.blImage.pos.y = BalloonY
defaults.name = {}
defaults.name.pos = {}
defaults.name.pos.x = center_screen - 280
defaults.name.pos.y = BalloonY - 10
defaults.name.text = {}
defaults.name.text.font = 'Segoe UI'
defaults.name.text.size = 16
defaults.name.text.red = 182
defaults.name.text.green = 255
defaults.name.text.blue = 213
defaults.name.text.alpha = 255
defaults.name.bg = {}
defaults.name.bg.visible = false
defaults.name.text.stroke = {}
defaults.name.text.stroke.width = 3
defaults.name.text.stroke.alpha = 200
defaults.name.text.stroke.red = 0
defaults.name.text.stroke.green = 0
defaults.name.text.stroke.blue = 0
defaults.name.text.visible = true
defaults.name.flags = {}
defaults.name.flags.draggable = false

local settings = config.load(defaults)


settings.blImage.texture = {}
settings.blImage.texture.path = windower.addon_path..'balloon.png'
settings.blImage.texture.fit = true
settings.blImage.size = {}
settings.blImage.size.height = 145
settings.blImage.size.width = 365
settings.blImage.draggable = true
settings.blImage.repeatable = {}
settings.blImage.repeatable.x = 1
settings.blImage.repeatable.y = 1


local Balloon_name = texts.new(settings.name)
local Balloon_txt = texts.new(settings)
local Balloon_Image = images.new(settings.blImage)
--Balloon_Image:pos( center_screen - 330,510)
local moving = false	
local old_x = "0"
local old_y = "0"
local balloon_on = false
local keydown = false
local keyup = false
mouseON = 0

-------------------------------------------------------------------------------



windower.register_event('unload', function()
	config.save(settings)
end)

windower.register_event('incoming chunk',function(id,original,modified,injected,blocked)
	--会話中かの確認 (Check if you are in a conversation)
	if (id == 82) then
		if (bl_debug ==2 ) then print("**chunk** id: " .. id,"original: " .. original) end
		close_balloon()
    elseif id == 0xB then
        close_balloon()
	end
end)

--閉じる (close)
function close_balloon()
	Balloon_Image:hide()
	Balloon_name:clear()
	Balloon_txt:clear()
	balloon_on = false
end

windower.register_event('incoming text',function(original,modified,original_mode,modified_mode,blocked)
    if original:startswith(string.char(0x1E)) then return end
    if not ( S{150,151,142,190,144}[original_mode] ) then return end
	if ( bl_debug == 1 ) then print("** Mode: " .. original_mode , "Text: '" .. original .."'") end
	if ( bl_debug == 1 ) then 
		local teststr = ""
		for i = 1, #original do
		local c = string.byte(original:sub(i,i),1)
		-- do something with c
		teststr = teststr .. (original:sub(i,i) .. "(" .. c .. ")")
		end
		print("codes: " .. teststr)
	end
	local noenter = true
	local endchar1 = string.byte(original:sub(string.len(original)-1,string.len(original)-1),1)
	local endchar2 = string.byte(original:sub(string.len(original),string.len(original)),1)
	local startchar1 = string.byte(original:sub(1,1),1)
	local startchar2 = string.byte(original:sub(2,2),1)
	if (endchar1 == 127 and endchar2 == 49 and not S{144,142}[original_mode]) or (startchar1 == 30 and startchar2 == 1) then
		noenter = false
 

 end
	local npcname = ""
	local result = original
	if ( S{150,151,142,190,144}[original_mode] ) and (settings.blswitch >= 1)then
		-- 発言者名の抽出 (Speaker name extraction)
		s,e = original:find(".- : ")
		npcname = ""
		if s ~= nil then
			if e < 32 and s > 0 then npcname = original:sub(s,e) end
		end	
		Balloon_name:clear()
		Balloon_name:append(npcname:sub(0,string.len(npcname)-2))
		
		if npcname =="" then
			result = "" .. "\n"
		else
			result = original:sub(string.len(original)-1,string.len(original))
			--original = original:sub(0,string.len(original)-2)
			--original = original:strip_format()
			if ( bl_debug == 1 ) then print("Pre-shift-jis: " .. original) end
			original = SubElements(original)
			mes = windower.from_shift_jis(original) --utf8へ変換 (Convert to utf8)
			if ( bl_debug == 1 ) then print("Pre-ctrl char cut: " .. mes) end
			mes = mes:strip_format()   --制御文字カット (Control character cut)
		end
		--print(result)
		if settings.blswitch == 2 then result = modified or original end
		--print(result)
		-- 発言 (Remark)
		original = SubElements(original)
		mes = windower.from_shift_jis(original)
		if npcname ~= "" then 
			mes = mes:gsub(npcname:gsub("-","--"),"") --タルタル等対応 (Correspondence such as tartar)
		end
		mess = split(mes,"")
		Balloon_txt:clear()
		if ( bl_debug == 1 ) then print("Pre-process: " .. mes) end
		
        --local mes_len = string.len(mes)
        --mes = string.gsub(mes, "", " ")
        ----mes = string.gsub(mes, "", "\\cs(84,155,17)")
        ----mes = string.gsub(mes, "", "\\cs(97,127,217)")
        ----mes = string.gsub(mes, "", "\\cs(0,0,0)")
        --mes = string.gsub(mes, "1", "")
        --mes = string.gsub(mes, "4", "")		
        --mes = string.gsub(mes, "", "")
        --mes = string.gsub(mes, "", "")
        --mes = string.gsub(mes, "6", "")
        --mes = string.gsub(mes, "^?", "")
        --mes = string.gsub(mes, "　　 ", "")
        --mes = string.gsub(mes, "", "")
        --mes = string.gsub(mes, "", "")
        --mes = string.gsub(mes, "", "")
        --mes = string.gsub(mes, "5", "")
        --mes = string.gsub(mes, string.char(187), "\"")
        --mes = string.gsub(mes, string.char(131), "")
        --mes = string.gsub(mes, string.char(227), "")
        --mes = " " .. mes
        --mes = SplitLines(mes, mes_len)
        --mes = string.gsub(mes, "", "\\cs(84,155,17)")
        --mes = string.gsub(mes, "", "\\cs(97,127,217)")
        --mes = string.gsub(mes, "", "\\cs(0,0,0)")
        --Balloon_txt:append('\n%s':format(mes))
		
		for k,v in ipairs(mess) do
			v = string.gsub(v, string.char(0x1E,0x02), "ɑ") --colour code 1
			v = string.gsub(v, string.char(0x1E,0x03), "β") --colour code 2
			v = string.gsub(v, string.char(0x1E,0x01), "ɣ") --colour code 3
			v = string.gsub(v, string.char(0x1E,0x05), "£") --colour code purple
			v = string.gsub(v, string.char(0x7F,0x31), "")
			v = string.gsub(v, string.char(0x7F,0x34), "")
			v = string.gsub(v, string.char(0x03), "")
			v = string.gsub(v, string.char(0x02), "")
			v = string.gsub(v, string.char(0x7F,0x36), "")
			v = string.gsub(v, "^?", "")
  			v = string.gsub(v, "　　 ", "")
 			v = string.gsub(v, string.char(0x81,0x40), "")
 			v = string.gsub(v, string.char(0xEF,0xBD,0x9E), "~")
            v = string.gsub(v, string.char(0x01), "")
			v = string.gsub(v, string.char(0x04), "")
			v = string.gsub(v, string.char(0x06), "")
			v = string.gsub(v, string.char(0x7F,0x35), "")
            v = string.gsub(v, string.char(0xE3), "")
            v = string.gsub(v, string.char(0x83,0xBB), "\"")
			v = " " .. v
			v = SplitLines(v, string.len(v))
            v = string.gsub(v, "ɑEarth ɣ", "\\cs(153,76,0)Earth \\cr")
            v = string.gsub(v, "ɑWater ɣ", "\\cs(0,76,153)Water \\cr")
            v = string.gsub(v, "ɑDark ɣ", "\\cs(82,82,82)Dark \\cr")
            v = string.gsub(v, "ɑFire ɣ", "\\cs(255,0,0)Fire \\cr")
            v = string.gsub(v, "ɑIce ɣ", "\\cs(0,255,255)Ice \\cr")
            v = string.gsub(v, "ɑWind ɣ", "\\cs(0,255,0)Wind \\cr")
            v = string.gsub(v, "ɑLightning ɣ", "\\cs(127,0,255)Lightning \\cr")
            v = string.gsub(v, "ɑLight ɣ", "\\cs(224,224,224)Light \\cr")
			v = string.gsub(v, "ɑ", "\\cs(134,240,41)")
			v = string.gsub(v, "β", "\\cs(97,127,217)")
			v = string.gsub(v, "£", "\\cs(255,51,255)")
		   	v = string.gsub(v, "ɣ", "\\cr")
			Balloon_txt:append('\n%s':format(v))
		end

		update()
		Balloon_name:show()
		Balloon_Image:show()
		Balloon_txt:show()
		balloon_on = true
		--if S{144}[original_mode] then
		player = windower.ffxi.get_player()
	if noenter == true and player.status == 1 then
			coroutine.sleep(5)
			close_balloon()
			else
			if player.status == 0 and noenter == true then
            treebeard = 0
			coroutine.sleep(1)
			if treebeard == 0 then
			coroutine.sleep(1)
			if treebeard == 0 then
			coroutine.sleep(1)
			if treebeard == 0 then
			coroutine.sleep(1)
			if treebeard == 0 then
			close_balloon() end else end else end else end else end
		end
	 end
    return(result)

end)

windower.register_event('keyboard',function(dik,pressed,flags,blocked)
	if windower.ffxi.get_info().chat_open or blocked then return end
	if balloon_on == true then
		--print("dik:", dik, "pressed:", pressed, "flags:", flags, "blocked:", blocked)
		if dik == 28 and pressed and not keydown then
			keydown = true
			close_balloon()
			treebeard = 1
        end	
	end
	if dik == 28 and not pressed then keydown = false end
end)

function SubElements(str)
	local new_str = str
	if bl_debug == 1 then print("Pre-elementsub: " .. new_str) end
	new_str = string.gsub(new_str, string.char(0xEF, 0x22), string.char(0x1E,0x02).."Earth "..string.char(0x1E,0x01)) -- ɑEarth ɣ
	new_str = string.gsub(new_str, string.char(0xEF, 0x25, 0x24), string.char(0x1E,0x02).."Water "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x26), string.char(0x1E,0x02).."Dark "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x1F), string.char(0x1E,0x02).."Fire "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x20), string.char(0x1E,0x02).."Ice "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x21), string.char(0x1E,0x02).."Wind "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x23), string.char(0x1E,0x02).."Lightning "..string.char(0x1E,0x01))
	new_str = string.gsub(new_str, string.char(0xEF, 0x25, 0x25), string.char(0x1E,0x02).."Light "..string.char(0x1E,0x01))
	if bl_debug == 1 then print("Post-elementsub: " .. new_str) end
	return new_str
end

function SplitLines(str, length)
    local new_str = str
	local split_constant = 35
    local splits = length/split_constant
    local position = split_constant
    while splits > 0 do
        local pos = string.find(new_str, ' ', position)
        if pos then
            new_str = new_str:gsub('()',{[pos]='\n'})
            position = pos + split_constant
        end
        splits = splits - 1
    end
    if splits < 1 then
        return new_str
    end
end

function split(str, delim)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end

    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local lastPos
    for part, pos in string.gfind(str, pat) do
        table.insert(result, part)
        lastPos = pos
    end
    table.insert(result, string.sub(str, lastPos))
    return result
end


windower.register_event("addon command", function(command,arg1)

	if command == 'help' then
		local t = {}
		t[#t+1] = "Balloon(Bl)" .. "Ver." .._addon.version
		t[#t+1] = "  <コマンド> (<Command>)" 
		t[#t+1] = "     //Balloon 0  	:吹き出し非表示＆ログ表示 (Hiding balloon & displaying log)"
		t[#t+1] = "     //Balloon 1  	:吹き出し表示＆ログ非表示 (Show balloon & hide log)" 
		t[#t+1] = "     //Balloon 2  	:吹き出し表示＆ログ表示 (Balloon display & log display)"
		t[#t+1] = "     //Balloon reset :吹き出し位置初期化 (Initialize balloon position)"
		t[#t+1] = "　"
		for tk,tv in pairs(t) do
			windower.add_to_chat(207, windower.to_shift_jis(tv))
		end

	elseif command == '1' then
		settings.blswitch = 1
		printFF11("モード (mode) 1　　:吹き出し表示＆ログ非表示 (Show balloon & hide log)")

	elseif command == '0' then
		settings.blswitch = 0
		printFF11("モード (mode) 0　　:吹き出し非表示＆ログ表示 (Hiding balloon & displaying log)")

	elseif command == '2' then
		settings.blswitch = 2
		printFF11("モード (mode) 2　　:吹き出し表示＆ログ表示 (Balloon display & log display)")
		
	elseif command == 'reset' then
		settings.blImage.pos.x = center_screen - 330
		settings.blImage.pos.y = BalloonY
		printFF11("Balloon位置リセットしました。 (Balloon position reset.)")
	elseif command == 'debug' and arg1 ~= nil then
		bl_debug = tonumber(arg1)
		print( "Balloon: debug " .. bl_debug )
	end
	
	config.save(settings)
end)

windower.register_event("mouse",function(type,x,y,delta,blocked)
	if type == 1 then
		mouseON = 1
	end
	if type == 2 then
		mouseON = 0
		config.save(settings)
	end
	if mouseON == 1 then
		update()
	end
end)


function printFF11( text )
	windower.add_to_chat(207, windower.to_shift_jis(text))
end

function update()
	settings.pos.x = settings.blImage.pos.x + 50
	settings.pos.y = settings.blImage.pos.y - 4
	Balloon_txt:pos( settings.pos.x, settings.pos.y)
	settings.name.pos.x = settings.blImage.pos.x + 50
	settings.name.pos.y = settings.blImage.pos.y - 10	
	Balloon_name:pos( settings.name.pos.x, settings.name.pos.y)
	Balloon_Image:pos(settings.blImage.pos.x,settings.blImage.pos.y)
end



