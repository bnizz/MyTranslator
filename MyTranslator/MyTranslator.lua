--[[ 
    Enhanced MyTranslator.lua
    Bidirectional translator for Chinese/English in WoW Classic
    Supports all chat channels with comprehensive WoW terminology
--]]

-- Enhanced Translation Tables
local chineseToEnglish = {
    -- Basic Communication
    ["你好"] = "Hello",
    ["再见"] = "Goodbye", 
    ["谢谢"] = "Thank you",
    ["不客气"] = "You're welcome",
    ["对不起"] = "Sorry",
    ["没关系"] = "No problem",
    ["是的"] = "Yes",
    ["不是"] = "No",
    ["好的"] = "OK",
    ["等等"] = "Wait",
    ["快点"] = "Hurry up",
    ["慢点"] = "Slow down",
    
    -- Party & Group Management
    ["队伍"] = "Party",
    ["团队"] = "Raid",
    ["公会"] = "Guild",
    ["邀请"] = "Invite",
    ["踢出"] = "Kick",
    ["队长"] = "Leader",
    ["副队长"] = "Assistant", 
    ["离开"] = "Leave",
    ["加入"] = "Join",
    ["满了"] = "Full",
    ["有位置"] = "Have spot",
    ["需要"] = "Need",
    ["寻找"] = "Looking for",
    ["组队"] = "Group up",
    
    -- Combat & Roles
    ["战斗"] = "Battle",
    ["攻击"] = "Attack",
    ["防御"] = "Defense",
    ["治疗"] = "Heal",
    ["坦克"] = "Tank",
    ["输出"] = "DPS",
    ["法师"] = "Mage",
    ["牧师"] = "Priest", 
    ["盗贼"] = "Rogue",
    ["战士"] = "Warrior",
    ["猎人"] = "Hunter",
    ["术士"] = "Warlock",
    ["圣骑士"] = "Paladin",
    ["德鲁伊"] = "Druid",
    ["萨满"] = "Shaman",
    ["死亡骑士"] = "Death Knight",
    
    -- Dungeon/Raid Terms
    ["副本"] = "Instance",
    ["地下城"] = "Dungeon", 
    ["团本"] = "Raid",
    ["BOSS"] = "Boss",
    ["小怪"] = "Mob",
    ["精英"] = "Elite",
    ["传送"] = "Summon",
    ["复活"] = "Resurrect",
    ["尸体"] = "Corpse",
    ["灵魂"] = "Spirit",
    ["修装备"] = "Repair",
    ["开怪"] = "Pull",
    ["仇恨"] = "Threat",
    ["仇恨值"] = "Aggro",
    ["拉怪"] = "Tank",
    ["集火"] = "Focus fire",
    ["AOE"] = "AOE",
    ["群攻"] = "AoE",
    ["单体"] = "Single target",
    ["打断"] = "Interrupt",
    ["驱散"] = "Dispel",
    ["净化"] = "Cleanse",
    
    -- Items & Equipment
    ["装备"] = "Equipment",
    ["武器"] = "Weapon",
    ["护甲"] = "Armor",
    ["头盔"] = "Helmet",
    ["胸甲"] = "Chestplate",
    ["护腿"] = "Leggings", 
    ["靴子"] = "Boots",
    ["手套"] = "Gloves",
    ["戒指"] = "Ring",
    ["项链"] = "Necklace",
    ["饰品"] = "Trinket",
    ["盾牌"] = "Shield",
    ["弓"] = "Bow",
    ["法杖"] = "Staff",
    ["法器"] = "Wand",
    ["匕首"] = "Dagger",
    ["剑"] = "Sword",
    ["锤"] = "Mace",
    ["斧"] = "Axe",
    
    -- Item Quality
    ["白色"] = "Poor",
    ["灰色"] = "Junk", 
    ["绿色"] = "Uncommon",
    ["蓝色"] = "Rare",
    ["紫色"] = "Epic",
    ["橙色"] = "Legendary",
    ["稀有"] = "Rare",
    ["史诗"] = "Epic", 
    ["传奇"] = "Legendary",
    ["神器"] = "Artifact",
    
    -- Trading & Economy
    ["拍卖行"] = "Auction House",
    ["交易"] = "Trade",
    ["购买"] = "Buy",
    ["出售"] = "Sell",
    ["价格"] = "Price",
    ["金币"] = "Gold",
    ["银币"] = "Silver", 
    ["铜币"] = "Copper",
    ["便宜"] = "Cheap",
    ["贵"] = "Expensive",
    ["免费"] = "Free",
    ["赠送"] = "Gift",
    ["竞标"] = "Bid",
    ["一口价"] = "Buyout",
    ["最低价"] = "Lowest price",
    ["市场价"] = "Market price",
    
    -- Crafting & Professions
    ["制造"] = "Crafting",
    ["专业"] = "Profession",
    ["锻造"] = "Blacksmithing",
    ["裁缝"] = "Tailoring",
    ["炼金"] = "Alchemy",
    ["附魔"] = "Enchanting",
    ["工程"] = "Engineering",
    ["制皮"] = "Leatherworking",
    ["珠宝"] = "Jewelcrafting",
    ["铭文"] = "Inscription",
    ["采矿"] = "Mining",
    ["草药学"] = "Herbalism",
    ["剥皮"] = "Skinning",
    ["钓鱼"] = "Fishing",
    ["烹饪"] = "Cooking",
    ["急救"] = "First Aid",
    
    -- Materials & Consumables
    ["材料"] = "Materials",
    ["药水"] = "Potion",
    ["药剂"] = "Elixir",
    ["食物"] = "Food",
    ["饮料"] = "Drink",
    ["面包"] = "Bread",
    ["水"] = "Water",
    ["法力"] = "Mana",
    ["生命"] = "Health",
    ["耐力"] = "Stamina",
    ["力量"] = "Strength",
    ["敏捷"] = "Agility",
    ["智力"] = "Intellect",
    ["精神"] = "Spirit",
    
    -- PvP Terms
    ["PVP"] = "PvP",
    ["荣誉"] = "Honor",
    ["战场"] = "Battleground",
    ["竞技场"] = "Arena",
    ["联盟"] = "Alliance",
    ["部落"] = "Horde",
    ["杀戮"] = "Kill",
    ["死亡"] = "Death",
    ["复仇"] = "Revenge",
    ["旗帜"] = "Flag",
    ["占领"] = "Capture",
    ["防守"] = "Defend",
    
    -- Common WoW Locations
    ["暴风城"] = "Stormwind",
    ["奥格瑞玛"] = "Orgrimmar", 
    ["铁炉堡"] = "Ironforge",
    ["雷霆崖"] = "Thunder Bluff",
    ["达纳苏斯"] = "Darnassus",
    ["幽暗城"] = "Undercity",
    ["荆棘谷"] = "Stranglethorn Vale",
    ["贫瘠之地"] = "The Barrens",
    ["艾尔文森林"] = "Elwynn Forest",
    
    -- General Game Terms
    ["等级"] = "Level",
    ["经验"] = "Experience",
    ["任务"] = "Quest",
    ["完成"] = "Complete",
    ["失败"] = "Failed",
    ["奖励"] = "Reward",
    ["技能"] = "Skill",
    ["天赋"] = "Talent",
    ["属性"] = "Stats",
    ["冷却"] = "Cooldown",
    ["范围"] = "Range",
    ["伤害"] = "Damage",
    ["治疗量"] = "Healing",
    ["暴击"] = "Critical",
    ["命中"] = "Hit",
    ["闪避"] = "Dodge",
    ["格挡"] = "Block",
    ["招架"] = "Parry",
}

-- Create reverse translation table (English to Chinese)
local englishToChinese = {}
for chinese, english in pairs(chineseToEnglish) do
    englishToChinese[string.lower(english)] = chinese
end

-- Settings
local MyTranslatorDB = {
    enabled = true,
    translateCNtoEN = true,
    translateENtoCN = true,
    showOriginal = false,
    translateOutgoing = true,
    channels = {
        say = true,
        yell = true,
        party = true,
        guild = true,
        whisper = true,
        general = true,
        trade = true,
        raid = true,
    }
}

-- Function to detect Chinese characters (fixed)
local function containsChinese(text)
    for i = 1, string.len(text) do
        local byte = string.byte(text, i)
        -- Check for UTF-8 Chinese character sequences
        if byte >= 228 and byte <= 233 then
            return true
        end
    end
    return false
end

-- Function to detect English letters  
local function containsEnglish(text)
    return string.find(text, "[a-zA-Z]") ~= nil
end

-- Enhanced translation function with simple word matching
local function translateMessage(message, direction)
    if not message or message == "" then
        return message, false
    end
    
    local result = tostring(message)
    local hasTranslation = false
    
    if direction == "en2cn" then
        -- For English to Chinese: simple case-insensitive replacement
        for english, chinese in pairs(englishToChinese) do
            if english and chinese then
                local lowerResult = string.lower(result)
                local lowerEnglish = string.lower(english)
                
                -- Check if the word exists (case insensitive)
                if string.find(lowerResult, lowerEnglish, 1, true) then
                    -- Try different case variations
                    local oldResult = result
                    result = string.gsub(result, english, chinese)
                    if result == oldResult then
                        result = string.gsub(result, string.upper(english), chinese)
                    end
                    if result == oldResult then
                        result = string.gsub(result, string.lower(english), chinese)
                    end
                    if result == oldResult then
                        -- Try first letter capitalized
                        local firstCap = string.upper(string.sub(english, 1, 1)) .. string.lower(string.sub(english, 2))
                        result = string.gsub(result, firstCap, chinese)
                    end
                    
                    if result ~= oldResult then
                        hasTranslation = true
                    end
                end
            end
        end
    else
        -- For Chinese to English: direct replacement
        for chinese, english in pairs(chineseToEnglish) do
            if chinese and english and string.find(result, chinese, 1, true) then
                result = string.gsub(result, chinese, english)
                hasTranslation = true
            end
        end
    end
    
    return result, hasTranslation
end

-- Main translation handler
local function processTranslation(message, sender, channel)
    if not MyTranslatorDB.enabled then return end
    
    local translatedMessage = nil
    local direction = nil
    local hasTranslation = false
    
    -- Check if we should translate Chinese to English
    if MyTranslatorDB.translateCNtoEN and containsChinese(message) then
        translatedMessage, hasTranslation = translateMessage(message, "cn2en")
        direction = "Chinese"
    -- Check if we should translate English to Chinese  
    elseif MyTranslatorDB.translateENtoCN and containsEnglish(message) then
        translatedMessage, hasTranslation = translateMessage(message, "en2cn")
        direction = "English"
    end
    
    -- Only show translation if it actually changed something
    if translatedMessage and hasTranslation then
        local prefix = "|cffffd700[Translated from " .. direction .. "]:|r "
        local output = prefix .. translatedMessage
        
        if MyTranslatorDB.showOriginal then
            output = output .. " |cff888888(Original: " .. message .. ")|r"
        end
        
        output = output .. " |cff00ff00(from " .. sender .. ")|r"
        DEFAULT_CHAT_FRAME:AddMessage(output)
    end
end

-- Hook for outgoing messages
local function translateOutgoingMessage(chatFrame, msg, ...)
    if not MyTranslatorDB.enabled or not MyTranslatorDB.translateOutgoing then
        return false
    end
    
    local translatedMessage = nil
    local hasTranslation = false
    
    -- Auto-translate outgoing messages to the opposite language
    if containsChinese(msg) and MyTranslatorDB.translateCNtoEN then
        translatedMessage, hasTranslation = translateMessage(msg, "cn2en")
    elseif containsEnglish(msg) and MyTranslatorDB.translateENtoCN then
        translatedMessage, hasTranslation = translateMessage(msg, "en2cn")
    end
    
    -- If we have a translation, send that instead
    if translatedMessage and hasTranslation then
        return translatedMessage
    end
    
    return false
end

-- Event handler for all chat messages
local function onChatMessage(self, event, message, sender, ...)
    -- Make sure we have valid arguments
    if not message or not event then return end
    
    -- Extract channel type from event name
    local channel = string.lower(string.gsub(event, "CHAT_MSG_", ""))
    
    -- Handle special channel mappings
    if channel == "channel" then
        channel = "general"  -- Map CHAT_MSG_CHANNEL to general setting
    elseif channel == "whisper_inform" then
        channel = "whisper"  -- Map outgoing whispers to whisper setting
    elseif channel == "officer" then
        channel = "guild"    -- Map officer chat to guild setting
    end
    
    -- Check if this channel is enabled for translation
    if MyTranslatorDB.channels[channel] then
        processTranslation(message, sender or "Unknown", channel)
    end
end

-- Simple slash command handler
local function handleSlashCommand(msg)
    local command = string.lower(msg or "")
    
    if command == "toggle" then
        MyTranslatorDB.enabled = not MyTranslatorDB.enabled
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r " .. (MyTranslatorDB.enabled and "Enabled" or "Disabled"))
    elseif command == "cn" then
        MyTranslatorDB.translateCNtoEN = not MyTranslatorDB.translateCNtoEN
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Chinese to English: " .. (MyTranslatorDB.translateCNtoEN and "ON" or "OFF"))
    elseif command == "en" then 
        MyTranslatorDB.translateENtoCN = not MyTranslatorDB.translateENtoCN
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r English to Chinese: " .. (MyTranslatorDB.translateENtoCN and "ON" or "OFF"))
    elseif command == "original" then
        MyTranslatorDB.showOriginal = not MyTranslatorDB.showOriginal  
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Show original: " .. (MyTranslatorDB.showOriginal and "ON" or "OFF"))
    elseif command == "outgoing" then
        MyTranslatorDB.translateOutgoing = not MyTranslatorDB.translateOutgoing
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Translate outgoing messages: " .. (MyTranslatorDB.translateOutgoing and "ON" or "OFF"))
    elseif command == "test" then
        -- Test function to verify translations work
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Test:|r")
        local testMsg = "Hello"
        local translated, hasTranslation = translateMessage(testMsg, "en2cn")
        DEFAULT_CHAT_FRAME:AddMessage("Test: '" .. testMsg .. "' -> '" .. translated .. "' (changed: " .. tostring(hasTranslation) .. ")")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Commands:|r")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr toggle - Enable/disable translator")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr cn - Toggle Chinese to English")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr en - Toggle English to Chinese") 
        DEFAULT_CHAT_FRAME:AddMessage("/mtr original - Toggle showing original text")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr outgoing - Toggle translating your own messages")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr test - Test translation function")
    end
end

-- Create frame and register events
local frame = CreateFrame("Frame", "MyTranslatorFrame")

-- Register all chat events
local chatEvents = {
    "CHAT_MSG_SAY",
    "CHAT_MSG_YELL", 
    "CHAT_MSG_PARTY",
    "CHAT_MSG_PARTY_LEADER",
    "CHAT_MSG_GUILD",
    "CHAT_MSG_OFFICER", 
    "CHAT_MSG_WHISPER",
    "CHAT_MSG_WHISPER_INFORM",
    "CHAT_MSG_CHANNEL",
    "CHAT_MSG_RAID",
    "CHAT_MSG_RAID_LEADER",
    "CHAT_MSG_RAID_WARNING",
    "CHAT_MSG_BATTLEGROUND",
    "CHAT_MSG_BATTLEGROUND_LEADER",
}

for _, event in ipairs(chatEvents) do
    frame:RegisterEvent(event)
end

frame:SetScript("OnEvent", onChatMessage)

-- Hook outgoing chat messages
local originalSendChatMessage = SendChatMessage
SendChatMessage = function(msg, chatType, language, channel)
    local translatedMsg = translateOutgoingMessage(nil, msg)
    if translatedMsg then
        originalSendChatMessage(translatedMsg, chatType, language, channel)
    else
        originalSendChatMessage(msg, chatType, language, channel)
    end
end

-- Register slash command
SLASH_MYTRANSLATOR1 = "/mtr"
SLASH_MYTRANSLATOR2 = "/mytranslator"
SlashCmdList["MYTRANSLATOR"] = handleSlashCommand

-- Startup message
DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Enhanced:|r Loaded! Type /mtr for commands.")
DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Type '/mtr test' to test translation functionality.")