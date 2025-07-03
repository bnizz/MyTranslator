-- Initialize variables
local TranslationsTable = nil
local englishToChinese = {}
local debugMode = false -- Add debug mode flag

-- Function to initialize translation data
local function initializeTranslationData()
    if debugMode then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Checking for MyTranslatorData...")
    end
    
    if not MyTranslatorData then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000MyTranslator Error:|r MyTranslatorData not found! Make sure chineseToEnglish.lua is loaded.")
        
        if debugMode then
            -- Debug: List all global variables starting with "MyTranslator"
            DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Checking globals:")
            for k, v in pairs(_G) do
                if string.find(k, "MyTranslator") then
                    DEFAULT_CHAT_FRAME:AddMessage("  Found: " .. k .. " = " .. tostring(v))
                end
            end
        end
        return false
    end
    
    if debugMode then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Success:|r MyTranslatorData found!")
    end
    
    TranslationsTable = MyTranslatorData
    
    -- Check if chineseToEnglish table exists
    if not TranslationsTable.chineseToEnglish then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Error:|r MyTranslatorData.chineseToEnglish table not found!")
        return false
    end
    
    -- Count how many translations we have
    local count = 0
    for k, v in pairs(TranslationsTable.chineseToEnglish) do
        count = count + 1
    end
    
    if debugMode then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Success:|r Found " .. count .. " translations")
    end
    
    -- First pass: collect all Chinese terms for each English term
    local englishTerms = {}
    for chinese, english in pairs(TranslationsTable.chineseToEnglish) do
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
    
    return true
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
        world = true,
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
    
    -- Check if translation data is loaded
    if not TranslationsTable then
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
        for chinese, english in pairs(TranslationsTable.chineseToEnglish) do
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
local function translateOutgoingMessage(chatFrame, msg, chatType, language, channel)
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
local function onChatMessage(self, event, message, sender, language, channelString, target, flags, unknown, channelNumber, channelName, unknown2, counter)
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
    elseif command == "debug" then
        debugMode = not debugMode
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Debug mode: " .. (debugMode and "ON" or "OFF"))
    elseif command == "init" then
        -- Manual initialization for debugging
        local oldDebugMode = debugMode
        debugMode = true -- Force debug mode for manual init
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Attempting manual initialization...")
        if initializeTranslationData() then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Success:|r Translation data loaded manually!")
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Error:|r Failed to load translation data manually!")
        end
        debugMode = oldDebugMode -- Restore debug mode
    elseif command == "test" then
        -- Test function to verify translations work
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Test:|r")
        if not TranslationsTable then
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Error:|r Translation data not loaded!")
            DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Tip:|r Try '/mtr init' to manually load the data")
            return
        end
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
        DEFAULT_CHAT_FRAME:AddMessage("/mtr debug - Toggle debug mode")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr init - Manually initialize translation data")
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

-- Initialize translation data when addon loads
local function onAddonLoaded(self, event, addonName, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    -- Always show what addon loaded for debugging
    DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Addon loaded: '" .. tostring(addonName) .. "'")
    
    -- Try to match common addon names - be more flexible
    local addonNameLower = string.lower(tostring(addonName))
    local isOurAddon = (addonNameLower == "mytranslator" or 
                       addonNameLower == "chat translator" or 
                       addonNameLower == "chattranslator" or
                       string.find(addonNameLower, "translator"))
    
    if isOurAddon then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r This appears to be our addon, initializing...")
        
        if initializeTranslationData() then
            -- Only show success message if debug mode is on
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Loaded! Type /mtr for commands.")
                DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Type '/mtr test' to test translation functionality.")
            else
                DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Ready! Type /mtr for commands.")
            end
        else
            -- Always show error messages
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000MyTranslator Error:|r Failed to load translation data!")
            DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Tip:|r Try '/mtr debug' then '/mtr init' to troubleshoot.")
        end
        
        -- Unregister the event only after our addon has loaded
        frame:UnregisterEvent("ADDON_LOADED")
    end
end

-- Try to initialize immediately when file loads
local function tryInitialize()
    if not TranslationsTable and MyTranslatorData then
        if debugMode then
            DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Attempting immediate initialization...")
        end
        if initializeTranslationData() then
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Auto-initialized successfully!")
            end
            return true
        end
    end
    return false
end

-- Register for addon loaded event
frame:RegisterEvent("ADDON_LOADED")

-- Also register for PLAYER_LOGIN as a backup
frame:RegisterEvent("PLAYER_LOGIN")

-- Set up event handler
frame:SetScript("OnEvent", function(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    if event == "ADDON_LOADED" then
        onAddonLoaded(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    elseif event == "PLAYER_LOGIN" then
        -- Backup initialization when player logs in
        if not TranslationsTable then
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r PLAYER_LOGIN: Attempting backup initialization...")
            end
            if initializeTranslationData() then
                if not debugMode then
                    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Ready! Type /mtr for commands.")
                end
            end
        end
        frame:UnregisterEvent("PLAYER_LOGIN")
    else
        onChatMessage(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    end
end)

-- Try immediate initialization (in case MyTranslatorData is already loaded)
tryInitialize()