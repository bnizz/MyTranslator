--[[ 
    Enhanced MyTranslator.lua
    Bidirectional translator for Chinese/English in WoW Classic
    Supports all chat channels with comprehensive WoW terminology
    Now supports multiple Chinese terms mapping to single English terms
--]]

-- Enhanced Translation Tables with multiple Chinese terms support
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
    ["队"] = "Party",  -- Short form
    ["团队"] = "Raid",
    ["团"] = "Raid",   -- Short form
    ["公会"] = "Guild",
    ["会"] = "Guild",  -- Short form
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
    ["T"] = "Tank",    -- Short form
    ["输出"] = "DPS",
    ["法师"] = "Mage",
    ["法"] = "Mage",   -- Short form
    ["牧师"] = "Priest",
    ["牧"] = "Priest", -- Short form
    ["盗贼"] = "Rogue",
    ["贼"] = "Rogue",  -- Short form
    ["战士"] = "Warrior",
    ["战"] = "Warrior", -- Short form
    ["猎人"] = "Hunter",
    ["猎"] = "Hunter",  -- Short form
    ["术士"] = "Warlock",
    ["术"] = "Warlock", -- Short form
    ["圣骑士"] = "Paladin",
    ["骑士"] = "Paladin", -- Medium form
    ["骑"] = "Paladin",   -- Short form
    ["圣骑"] = "Paladin", -- Medium form
    ["德鲁伊"] = "Druid",
    ["德"] = "Druid",     -- Short form
    ["小德"] = "Druid",   -- Alternative short form
    ["萨满"] = "Shaman",
    ["萨"] = "Shaman",    -- Short form
    ["死亡骑士"] = "Death Knight",
    ["死骑"] = "Death Knight", -- Short form
    ["DK"] = "Death Knight",   -- English abbreviation used by Chinese players
    
    -- Dungeon/Raid Terms
    ["副本"] = "Instance",
    ["本"] = "Instance", -- Short form
    ["地下城"] = "Dungeon", 
    ["地城"] = "Dungeon",  -- Short form
    ["团本"] = "Raid",
    ["BOSS"] = "Boss",
    ["小怪"] = "Mob",
    ["怪"] = "Mob",       -- Short form
    ["精英"] = "Elite",
    ["传送"] = "Summon",
    ["拉人"] = "Summon",   -- Alternative
    ["复活"] = "Resurrect",
    ["复"] = "Resurrect",  -- Short form
    ["活"] = "Resurrect",  -- Short form
    ["尸体"] = "Corpse",
    ["灵魂"] = "Spirit",
    ["修装备"] = "Repair",
    ["修"] = "Repair",     -- Short form
    ["开怪"] = "Pull",
    ["拉怪"] = "Pull",     -- Alternative
    ["仇恨"] = "Threat",
    ["仇恨值"] = "Aggro",
    ["仇"] = "Threat",     -- Short form
    ["集火"] = "Focus fire",
    ["AOE"] = "AOE",
    ["群攻"] = "AoE",
    ["单体"] = "Single target",
    ["打断"] = "Interrupt",
    ["驱散"] = "Dispel",
    ["净化"] = "Cleanse",

    -- Dungeons (with abbreviations)
    ["大水任务"] = "Blackfathom deeps",
    ["大水"] = "Blackfathom deeps", -- Short form
    ["BFD"] = "Blackfathom deeps",  -- English abbreviation
    
    -- LFG terms
    ["自由许愿"] = "open roll",
    ["自由"] = "open roll",  -- Short form
    ["奶"] = "healer",
    ["治疗"] = "healer",     -- Alternative
    ["近战"] = "melee dps",
    ["开打了"] = "starting now",
    ["开"] = "starting now", -- Short form

    -- Items & Equipment
    ["装备"] = "Equipment",
    ["装"] = "Equipment",   -- Short form
    ["武器"] = "Weapon",
    ["护甲"] = "Armor",
    ["头盔"] = "Helmet",
    ["头"] = "Helmet",      -- Short form
    ["胸甲"] = "Chestplate",
    ["胸"] = "Chestplate",  -- Short form
    ["护腿"] = "Leggings",
    ["腿"] = "Leggings",    -- Short form
    ["靴子"] = "Boots",
    ["鞋"] = "Boots",       -- Short form
    ["手套"] = "Gloves",
    ["手"] = "Gloves",      -- Short form
    ["戒指"] = "Ring",
    ["戒"] = "Ring",        -- Short form
    ["项链"] = "Necklace",
    ["饰品"] = "Trinket",
    ["盾牌"] = "Shield",
    ["盾"] = "Shield",      -- Short form
    ["弓"] = "Bow",
    ["法杖"] = "Staff",
    ["杖"] = "Staff",       -- Short form
    ["法器"] = "Wand",
    ["匕首"] = "Dagger",
    ["剑"] = "Sword",
    ["锤"] = "Mace",
    ["斧"] = "Axe",
    
    -- Item Quality
    ["白色"] = "Poor",
    ["白"] = "Poor",        -- Short form
    ["灰色"] = "Junk", 
    ["灰"] = "Junk",        -- Short form
    ["绿色"] = "Uncommon",
    ["绿"] = "Uncommon",    -- Short form
    ["蓝色"] = "Rare",
    ["蓝"] = "Rare",        -- Short form
    ["紫色"] = "Epic",
    ["紫"] = "Epic",        -- Short form
    ["橙色"] = "Legendary",
    ["橙"] = "Legendary",   -- Short form
    ["稀有"] = "Rare",
    ["史诗"] = "Epic", 
    ["传奇"] = "Legendary",
    ["神器"] = "Artifact",
    
    -- Trading & Economy
    ["拍卖行"] = "Auction House",
    ["拍卖"] = "Auction House", -- Short form
    ["AH"] = "Auction House",    -- English abbreviation
    ["交易"] = "Trade",
    ["购买"] = "Buy",
    ["买"] = "Buy",             -- Short form
    ["出售"] = "Sell",
    ["卖"] = "Sell",            -- Short form
    ["价格"] = "Price",
    ["价"] = "Price",           -- Short form
    ["金币"] = "Gold",
    ["金"] = "Gold",            -- Short form
    ["G"] = "Gold",             -- English abbreviation
    ["银币"] = "Silver",
    ["银"] = "Silver",          -- Short form
    ["S"] = "Silver",           -- English abbreviation
    ["铜币"] = "Copper",
    ["铜"] = "Copper",          -- Short form
    ["C"] = "Copper",           -- English abbreviation
    ["便宜"] = "Cheap",
    ["贵"] = "Expensive",
    ["免费"] = "Free",
    ["赠送"] = "Gift",
    ["竞标"] = "Bid",
    ["一口价"] = "Buyout",
    ["最低价"] = "Lowest price",
    ["市场价"] = "Market price",
    
    -- Crafting & Professions (with abbreviations)
    ["制造"] = "Crafting",
    ["专业"] = "Profession",
    ["锻造"] = "Blacksmithing",
    ["锻"] = "Blacksmithing",   -- Short form
    ["裁缝"] = "Tailoring",
    ["裁"] = "Tailoring",       -- Short form
    ["炼金"] = "Alchemy",
    ["炼"] = "Alchemy",         -- Short form
    ["附魔"] = "Enchanting",
    ["附"] = "Enchanting",      -- Short form
    ["工程"] = "Engineering",
    ["工"] = "Engineering",     -- Short form
    ["制皮"] = "Leatherworking",
    ["皮"] = "Leatherworking",  -- Short form
    ["珠宝"] = "Jewelcrafting",
    ["珠"] = "Jewelcrafting",   -- Short form
    ["铭文"] = "Inscription",
    ["采矿"] = "Mining",
    ["矿"] = "Mining",          -- Short form
    ["草药学"] = "Herbalism",
    ["草药"] = "Herbalism",     -- Medium form
    ["草"] = "Herbalism",       -- Short form
    ["剥皮"] = "Skinning",
    ["剥"] = "Skinning",        -- Short form
    ["钓鱼"] = "Fishing",
    ["钓"] = "Fishing",         -- Short form
    ["烹饪"] = "Cooking",
    ["烹"] = "Cooking",         -- Short form
    ["急救"] = "First Aid",
    
    -- Materials & Consumables
    ["材料"] = "Materials",
    ["药水"] = "Potion",
    ["药"] = "Potion",          -- Short form
    ["药剂"] = "Elixir",
    ["食物"] = "Food",
    ["饮料"] = "Drink",
    ["面包"] = "Bread",
    ["水"] = "Water",
    ["法力"] = "Mana",
    ["蓝"] = "Mana",            -- Short form (context dependent)
    ["生命"] = "Health",
    ["血"] = "Health",          -- Short form
    ["耐力"] = "Stamina",
    ["耐"] = "Stamina",         -- Short form
    ["力量"] = "Strength",
    ["力"] = "Strength",        -- Short form
    ["敏捷"] = "Agility",
    ["敏"] = "Agility",         -- Short form
    ["智力"] = "Intellect",
    ["智"] = "Intellect",       -- Short form
    ["精神"] = "Spirit",
    ["精"] = "Spirit",          -- Short form
    
    -- PvP Terms
    ["PVP"] = "PvP",
    ["荣誉"] = "Honor",
    ["战场"] = "Battleground",
    ["BG"] = "Battleground",    -- English abbreviation
    ["竞技场"] = "Arena",
    ["联盟"] = "Alliance",
    ["LM"] = "Alliance",        -- Chinese abbreviation
    ["部落"] = "Horde",
    ["BL"] = "Horde",           -- Chinese abbreviation
    ["杀戮"] = "Kill",
    ["杀"] = "Kill",            -- Short form
    ["死亡"] = "Death",
    ["死"] = "Death",           -- Short form
    ["复仇"] = "Revenge",
    ["旗帜"] = "Flag",
    ["旗"] = "Flag",            -- Short form
    ["占领"] = "Capture",
    ["占"] = "Capture",         -- Short form
    ["防守"] = "Defend",
    ["防"] = "Defend",          -- Short form
    
    -- Common WoW Locations (with abbreviations)
    ["暴风城"] = "Stormwind",
    ["暴风"] = "Stormwind",     -- Short form
    ["SW"] = "Stormwind",       -- English abbreviation
    ["奥格瑞玛"] = "Orgrimmar",
    ["奥格"] = "Orgrimmar",     -- Short form
    ["OG"] = "Orgrimmar",       -- English abbreviation
    ["铁炉堡"] = "Ironforge",
    ["铁炉"] = "Ironforge",     -- Short form
    ["IF"] = "Ironforge",       -- English abbreviation
    ["雷霆崖"] = "Thunder Bluff",
    ["雷霆"] = "Thunder Bluff", -- Short form
    ["TB"] = "Thunder Bluff",   -- English abbreviation
    ["达纳苏斯"] = "Darnassus",
    ["达纳"] = "Darnassus",     -- Short form
    ["幽暗城"] = "Undercity",
    ["幽暗"] = "Undercity",     -- Short form
    ["UC"] = "Undercity",       -- English abbreviation
    ["荆棘谷"] = "Stranglethorn Vale",
    ["荆棘"] = "Stranglethorn Vale", -- Short form
    ["STV"] = "Stranglethorn Vale",  -- English abbreviation
    ["贫瘠之地"] = "The Barrens",
    ["贫瘠"] = "The Barrens",        -- Short form
    ["艾尔文森林"] = "Elwynn Forest",
    ["艾尔文"] = "Elwynn Forest",    -- Short form
    
    -- General Game Terms
    ["等级"] = "Level",
    ["级"] = "Level",           -- Short form
    ["LV"] = "Level",           -- English abbreviation
    ["经验"] = "Experience",
    ["经"] = "Experience",      -- Short form
    ["EXP"] = "Experience",     -- English abbreviation
    ["任务"] = "Quest",
    ["完成"] = "Complete",
    ["失败"] = "Failed",
    ["奖励"] = "Reward",
    ["技能"] = "Skill",
    ["天赋"] = "Talent",
    ["属性"] = "Stats",
    ["冷却"] = "Cooldown",
    ["CD"] = "Cooldown",        -- English abbreviation
    ["范围"] = "Range",
    ["伤害"] = "Damage",
    ["治疗量"] = "Healing",
    ["暴击"] = "Critical",
    ["暴"] = "Critical",        -- Short form
    ["命中"] = "Hit",
    ["闪避"] = "Dodge",
    ["格挡"] = "Block",
    ["招架"] = "Parry",

    -- Misc or not yet categorized.
    ["我"] = "me",
    ["谁"] = "who",
    ["能"] = "can",
    ["组一"] = "group up",
    ["随便来"] = "pug",
}

-- Create reverse translation table (English to Chinese) - prioritize longer forms
local englishToChinese = {}
-- First pass: collect all Chinese terms for each English term
local englishTerms = {}
for chinese, english in pairs(chineseToEnglish) do
    local lowerEnglish = string.lower(english)
    if not englishTerms[lowerEnglish] then
        englishTerms[lowerEnglish] = {}
    end
    table.insert(englishTerms[lowerEnglish], chinese)
end

-- Second pass: choose the longest Chinese term as the primary translation
for english, chineseList in pairs(englishTerms) do
    -- Sort by length (longest first)
    table.sort(chineseList, function(a, b) return string.len(a) > string.len(b) end)
    englishToChinese[english] = chineseList[1] -- Use the longest form
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

-- Enhanced translation function with better word boundary detection
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
        -- For Chinese to English: Sort by length (longest first) to match longer terms first
        local sortedTerms = {}
        for chinese, english in pairs(chineseToEnglish) do
            table.insert(sortedTerms, {chinese = chinese, english = english, len = string.len(chinese)})
        end
        table.sort(sortedTerms, function(a, b) return a.len > b.len end)
        
        -- Apply translations in order of length (longest first)
        for _, term in ipairs(sortedTerms) do
            if term.chinese and term.english and string.find(result, term.chinese, 1, true) then
                result = string.gsub(result, term.chinese, term.english)
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
        local testPairs = {
            {"德", "Druid"},
            {"德鲁伊", "Druid"}, 
            {"法", "Mage"},
            {"法师", "Mage"},
            {"Hello", "你好"}
        }
        for _, pair in ipairs(testPairs) do
            local direction = containsChinese(pair[1]) and "cn2en" or "en2cn"
            local translated, hasTranslation = translateMessage(pair[1], direction)
            DEFAULT_CHAT_FRAME:AddMessage("Test: '" .. pair[1] .. "' -> '" .. translated .. "' (expected: " .. pair[2] .. ", changed: " .. tostring(hasTranslation) .. ")")
        end
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
