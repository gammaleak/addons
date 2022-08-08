_addon.name     = "Currency"
_addon.author   = "Tewl"
_addon.version  = "0.2"
_addon.command  = "cur"

require 'tables'
require 'actions'
require 'pack'

res         = require 'resources'
packets     = require 'packets'
config      = require 'config'
              require 'lists'
texts       = require('texts')

local name_accolades        = "Acc"
local name_bayld            = "Bld"
local name_beads            = "Bead"
local name_canteens         = "Cant"
local name_deeds            = "Deed"
local name_gallantry        = "Gall"
local name_hallmarks        = "Hmrk"
local name_hallmrks_total   = "HmrkT"
local name_ichor            = "Ich"
local name_imprimaturs      = "Imp"
local name_login_points     = "LgPt"
local name_nyzul            = "Nyz"
local name_plasm            = "Plasm"
local name_silver_vouchers  = "SVch"
local name_sparks           = "Sprk"
local name_zeni             = "Zeni"

currencies = { }

windower.register_event('addon command', function(command, ...)
    if command:lower() == "update" then
        windower.packets.inject_outgoing(0x10F, '0000') -- Request Currencies 1
    end
end)

windower.register_event('load', function()
    local player = windower.ffxi.get_player()
    if curBox then curBox:destroy() end
    curBox = texts.new({flags = {draggable=false}}) -- If you want to be able to move the text change this line to: curBox = texts.new()
	curBox:pos(370,1092) -- X,Y coordinates for where the text will appear on load, default 0,0 is top left
	curBox:font('Final Fantasy 3/6 Font')
    curBox:size(11.5)
	curBox:bold(true)
    curBox:bg_alpha(0)
	curBox:right_justified(false)
	curBox:stroke_width(2)
    curBox:stroke_transparency(192)
    if player then
      windower.packets.inject_outgoing(0x10F, '0000') -- Request Currencies 1
    end
end)

windower.register_event('login', function()
    local player = windower.ffxi.get_player()
    if player then
        windower.packets.inject_outgoing(0x10F, '0000') -- Request Currencies 1
    end
end)

windower.register_event('zone change', function(new, old)
    windower.packets.inject_outgoing(0x10F, '0000') -- Request Currencies 1
end)

windower.register_event('incoming chunk',function (id,original,modified,is_injected,is_blocked)
    if id == 0x61 then
        currencies[name_accolades] = math.floor(original:byte(0x5A)/4) + original:byte(0x5B)*2^6 + original:byte(0x5C)*2^14
        update_currency()
    end

    if id == 0x110 then
        local p = packets.parse('incoming', original)
        currencies[name_sparks]  = p['Sparks Total']
        if p['_unknown1'] == 1 then currencies[name_sparks] = currencies[name_sparks] + 65536  end
        update_currency()
    end

    if id == 0x2D then
        local am = {}
        am.actor_id = original:unpack("I",0x05)
        am.target_id = original:unpack("I",0x09)
        am.param_1 = original:unpack("I",0x0D)
        am.param_2 = original:unpack("H",0x11)%2^9 -- First 7 bits
        am.param_3 = math.floor(original:unpack("I",0x11)/2^5) -- Rest
        am.actor_index = original:unpack("H",0x15)
        am.target_index = original:unpack("H",0x17)
        am.message_id = original:unpack("H",0x19)%2^15 -- Cut off the most significant bit
        
        if T{692,694,707,741}:contains(am.message_id) then
            if am.message_id == 692 then currencies[name_sparks] = currencies[name_sparks] + am.param_2 end
            if am.message_id == 694 then currencies[name_sparks] = currencies[name_sparks] + am.param_2 end
            if am.message_id == 707 then currencies[name_sparks] = currencies[name_sparks] + am.param_2 end
            if am.message_id == 741 then currencies[name_accolades] = currencies[name_accolades] + am.param_2 end
            if currencies[name_sparks] > 99999 then currencies[name_sparks] = 99999 end
            if currencies[name_accolades] > 99999 then currencies[name_accolades] = 99999 end
            update_currency()
        end
    end

    if id == 0x113 then -- Currencies 1
        local p = packets.parse('incoming', original)
        currencies[name_sparks]         = p["Sparks of Eminence"]
        currencies[name_deeds]          = p["Deeds"]
        currencies[name_nyzul]          = p["Nyzul Tokens"]
        currencies[name_zeni]           = p["Zeni"]
        currencies[name_ichor]          = p["Therion Ichor"]
        currencies[name_accolades]      = p["Unity Accolades"]
        currencies[name_login_points]   = p["Login Points"]
        windower.packets.inject_outgoing(0x115, '0000') -- Request Currencies 2
    end

    if id == 0x118 then -- Currencies 2
        local p = packets.parse('incoming', original)
        currencies[name_bayld]          = p["Bayld"]
        currencies[name_imprimaturs]    = p["Coalition Imprimaturs"]
        currencies[name_plasm]          = p["Mweya Plasm Corpuscles"]
        currencies[name_beads]          = p["Escha Beads"]
        currencies[name_hallmarks]      = p["Hallmarks"]
        currencies[name_hallmrks_total] = p["Total Hallmarks"]
        currencies[name_gallantry]      = p["Badges of Gallantry"]
        currencies[name_silver_vouchers]= p["Silver A.M.A.N. Vouchers Stored"]
        currencies[name_canteens]       = p["Mystical Canteens"]
        update_currency()
    end

    if id == 0x00A and curBox then
        curBox:show()
    end
end)

windower.register_event('outgoing chunk', function(id, data)
    if id == 0x00D and curBox then
        curBox:hide()
    end
end)

function update_currency()
	local spc = '   '
    curBox:clear()
    curBox:append(spc)
    table.sort(currencies)
    for k,v in pairsByKeys(currencies) do
        curBox:append(string.format("%s %s:%s %s", '\\cs(255,255,255)', k, '\\cs(140,160,255)', v))
        curBox:append(spc)
    end
	curBox:append(spc)
    curBox:show()
end

function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0 
    local iter = function ()
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
    end
    return iter
end