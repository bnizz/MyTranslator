-- MyTranslator.lua
-- Classic WoW 1.12 compatible translation addon
-- Based on DifficultBulletinBoard event handling pattern

-- Initialize addon tables
MyTranslator = MyTranslator or {}
MyTranslatorDB = MyTranslatorDB or {
    enabled = true,
    translateCNtoEN = true,
    translateENtoCN = true,
    showOriginal = false,
    translateOutgoing = true,
    channels = {
        world = true,
        general = true,
        trade = true,
        guild = true,
        party = true,
        raid = true,
        say = true,
        yell = true,
        whisper = true,
        officer = true,
        channel = true
    }
}

-- Translation data will be loaded from separate files
local TranslationsTable = nil
local englishToChinese = nil
local debugMode = false

-- Character sets for language detection
local chineseCharPattern = "[\228-\233][\128-\191][\128-\191]"
local englishCharPattern = "[a-zA-Z]"

-- Initialize translation data from loaded tables
local function initializeTranslationData()
    if chineseToEnglish then
        TranslationsTable = chineseToEnglish
        
        -- Build reverse lookup table for English to Chinese
        englishToChinese = {}
        for chinese, english in pairs(TranslationsTable) do
            englishToChinese[english] = chinese
        end
          if debugMode then
            local count = 0
            for _ in pairs(TranslationsTable) do count = count + 1 end
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Loaded " .. count .. " translation entries")
        end
        return true
    end
    return false
end

-- Language detection functions
local function containsChinese(text)
    return string.find(text or "", chineseCharPattern)
end

local function containsEnglish(text)
    return string.find(text or "", englishCharPattern)
end

-- Core translation function
local function translateMessage(message, direction)
    if not TranslationsTable or not message then
        return nil, false
    end
    
    local translatedMessage = message
    local hasTranslation = false
    
    if direction == "cn2en" then
        -- Chinese to English: Sort by length (longest first) for proper priority
        local sortedEntries = {}
        for chinese, english in pairs(TranslationsTable) do
            table.insert(sortedEntries, {chinese = chinese, english = english, length = string.len(chinese)})
        end
        table.sort(sortedEntries, function(a, b) return a.length > b.length end)
          -- Apply translations starting with longest matches
        for _, entry in ipairs(sortedEntries) do
            if string.find(translatedMessage, entry.chinese, 1, true) then
                -- Add space before English translation (except at start of string)
                local replacement = entry.english
                local startPos, endPos = string.find(translatedMessage, entry.chinese, 1, true)
                if startPos and startPos > 1 then
                    -- Check if there's already a space before the replacement position
                    local charBefore = string.sub(translatedMessage, startPos - 1, startPos - 1)
                    if charBefore ~= " " then
                        replacement = " " .. replacement
                    end
                end
                
                translatedMessage = string.gsub(translatedMessage, entry.chinese, replacement)
                hasTranslation = true
            end
        end
    elseif direction == "en2cn" and englishToChinese then
        -- English to Chinese: Whole word/phrase matching only
        local lowerMessage = string.lower(translatedMessage)
        
        -- Sort English phrases by length (longest first) to match multi-word phrases before single words
        local sortedEntries = {}
        for english, chinese in pairs(englishToChinese) do
            table.insert(sortedEntries, {english = english, chinese = chinese, length = string.len(english)})
        end
        table.sort(sortedEntries, function(a, b) return a.length > b.length end)
        
        -- Check for whole word/phrase matches using word boundary logic
        for _, entry in ipairs(sortedEntries) do
            local englishLower = string.lower(entry.english)
            
            -- Check if it's a whole word match (not part of another word)
            local startPos, endPos = string.find(lowerMessage, englishLower, 1, true)
            while startPos do
                local isWholeWord = true
                
                -- Check character before (must be non-alphanumeric or start of string)
                if startPos > 1 then
                    local charBefore = string.sub(lowerMessage, startPos - 1, startPos - 1)
                    if string.find(charBefore, "[a-zA-Z0-9]") then
                        isWholeWord = false
                    end
                end
                
                -- Check character after (must be non-alphanumeric or end of string)
                if endPos < string.len(lowerMessage) then
                    local charAfter = string.sub(lowerMessage, endPos + 1, endPos + 1)
                    if string.find(charAfter, "[a-zA-Z0-9]") then
                        isWholeWord = false
                    end
                end
                
                if isWholeWord then
                    -- Replace the match in the original message
                    local beforeText = string.sub(translatedMessage, 1, startPos - 1)
                    local afterText = string.sub(translatedMessage, endPos + 1)
                    translatedMessage = beforeText .. entry.chinese .. afterText
                    lowerMessage = string.lower(translatedMessage) -- Update for next iteration
                    hasTranslation = true
                    break -- Only replace first occurrence of each word
                else
                    -- Find next occurrence
                    startPos, endPos = string.find(lowerMessage, englishLower, endPos + 1, true)
                end
            end
        end
    end
    
    return translatedMessage, hasTranslation
end

-- Process translation for incoming messages
local function processTranslation(message, sender, channel)
    if not MyTranslatorDB.enabled or not message or message == "" then
        return
    end
    
    local translatedMessage = nil
    local hasTranslation = false
    
    -- Determine translation direction based on message content
    if containsChinese(message) and MyTranslatorDB.translateCNtoEN then
        translatedMessage, hasTranslation = translateMessage(message, "cn2en")
    elseif containsEnglish(message) and MyTranslatorDB.translateENtoCN then
        translatedMessage, hasTranslation = translateMessage(message, "en2cn")
    end
    
    -- Display translation if found
    if translatedMessage and hasTranslation then
        local displayText = translatedMessage
        if MyTranslatorDB.showOriginal then
            displayText = translatedMessage .. " |cff888888(" .. message .. ")|r"
        end        local channelTag = channel and "[" .. channel .. "]" or ""
        DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffeda55f[MyTranslator]|r %s %s: %s", 
            channelTag, sender or "Unknown", displayText))
    end
end

-- Event handler for chat messages - Classic WoW 1.12 compatible
local function onChatMessage(message, sender, language, channelString, target, flags, zoneID, channelIndex, channelBaseName, unused, lineID, guid)
    if not message then return end
    
    -- Determine channel from various sources
    local channel = nil
    if type(channelBaseName) == "string" and channelBaseName ~= "" then
        channel = string.lower(channelBaseName)
    elseif type(channelString) == "string" and channelString ~= "" then
        channel = string.lower(channelString)
    elseif type(channelIndex) == "number" and channelIndex > 0 and GetChannelName then
        local name = GetChannelName(channelIndex)
        if type(name) == "string" and name ~= "" then
            channel = string.lower(name)
        end
    end
      -- Channel name normalization
    if type(channel) == "string" and channel ~= "" then
        if string.find(channel, "world") or string.find(channel, "世") then
            channel = "world"
        elseif string.find(channel, "trade") then
            channel = "trade"
        elseif string.find(channel, "general") then
            channel = "general"
        elseif string.find(channel, "raid") then
            channel = "raid"
        elseif string.find(channel, "guild") then
            channel = "guild"
        elseif string.find(channel, "party") then
            channel = "party"
        elseif string.find(channel, "whisper") then
            channel = "whisper"
        end
    end
      if debugMode then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Channel: " .. tostring(channel) .. 
            ", Event: " .. tostring(event) .. ", Sender: " .. tostring(sender))
    end
    
    -- Check if this channel is enabled for translation
    if channel and MyTranslatorDB.channels[channel] then
        processTranslation(message, sender or "Unknown", channel)
    end
end

-- Outgoing message translation
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

-- Slash command handler
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
        if initializeTranslationData() then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Translation data initialized successfully!")
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cffff0000MyTranslator:|r Failed to initialize translation data!")
        end    elseif command == "test" then
        -- Test translation with known words
        local testChinese = "哈喽"  -- Should translate to "hello"
        local testEnglish = "hello"  -- Should translate to "哈喽"
        
        local result1, translated1 = translateMessage(testChinese, "cn2en")
        local result2, translated2 = translateMessage(testEnglish, "en2cn")
        
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Test:|r")
        DEFAULT_CHAT_FRAME:AddMessage("CN->EN: " .. testChinese .. " -> " .. (result1 or "FAILED") .. " (Success: " .. tostring(translated1) .. ")")
        DEFAULT_CHAT_FRAME:AddMessage("EN->CN: " .. testEnglish .. " -> " .. (result2 or "FAILED") .. " (Success: " .. tostring(translated2) .. ")")
        
        -- Test whole word matching
        local testPhrase = "say hello to everyone"
        local result3, translated3 = translateMessage(testPhrase, "en2cn")
        DEFAULT_CHAT_FRAME:AddMessage("Phrase test: '" .. testPhrase .. "' -> '" .. (result3 or "FAILED") .. "' (Success: " .. tostring(translated3) .. ")")
    elseif command == "testchat" then
        -- Test chat message processing
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Testing chat message processing...")
        onChatMessage("你好", "TestPlayer", "Common", "1. World", nil, nil, nil, 1, "World")
        onChatMessage("hello", "TestPlayer", "Common", "1. World", nil, nil, nil, 1, "World")
    elseif string.sub(command, 1, 7) == "enable " then
        local channel = string.sub(command, 8)
        MyTranslatorDB.channels[channel] = true
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Enabled for channel: " .. channel)
    elseif string.sub(command, 1, 8) == "disable " then
        local channel = string.sub(command, 9)
        MyTranslatorDB.channels[channel] = false
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Disabled for channel: " .. channel)
    elseif command == "status" then
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Status:|r")
        DEFAULT_CHAT_FRAME:AddMessage("Enabled: " .. (MyTranslatorDB.enabled and "YES" or "NO"))
        DEFAULT_CHAT_FRAME:AddMessage("CN->EN: " .. (MyTranslatorDB.translateCNtoEN and "YES" or "NO"))
        DEFAULT_CHAT_FRAME:AddMessage("EN->CN: " .. (MyTranslatorDB.translateENtoCN and "YES" or "NO"))
        DEFAULT_CHAT_FRAME:AddMessage("Show Original: " .. (MyTranslatorDB.showOriginal and "YES" or "NO"))
        DEFAULT_CHAT_FRAME:AddMessage("Translate Outgoing: " .. (MyTranslatorDB.translateOutgoing and "YES" or "NO"))
        DEFAULT_CHAT_FRAME:AddMessage("Active channels:")
        for channel, enabled in pairs(MyTranslatorDB.channels) do
            if enabled then
                DEFAULT_CHAT_FRAME:AddMessage("  - " .. channel)
            end
        end
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator Commands:|r")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr toggle - Enable/disable addon")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr cn - Toggle Chinese to English")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr en - Toggle English to Chinese") 
        DEFAULT_CHAT_FRAME:AddMessage("/mtr original - Toggle showing original text")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr outgoing - Toggle translating your own messages")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr debug - Toggle debug mode")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr init - Manually initialize translation data")        DEFAULT_CHAT_FRAME:AddMessage("/mtr test - Test translation function")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr testchat - Test chat message processing")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr enable <channel> - Enable channel")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr disable <channel> - Disable channel")
        DEFAULT_CHAT_FRAME:AddMessage("/mtr status - Show current settings")
    end
end

-- Create frame and register events
local frame = CreateFrame("Frame", "MyTranslatorFrameUnique")

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

-- Initialize translation data when addon loads
local function onAddonLoaded(addonName)
    if addonName == "MyTranslator" then
        if initializeTranslationData() then
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r Initialized successfully on addon load!")
            end
        else
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cffffd700MyTranslator:|r Translation data not available yet, will retry...")
            end
        end
        
        -- Unregister the event only after our addon has loaded
        frame:UnregisterEvent("ADDON_LOADED")
    end
end

-- Try to initialize immediately when file loads
local function tryInitialize()
    if not TranslationsTable and chineseToEnglish then
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

-- Classic WoW 1.12 compatible event handler (uses global arg variables)
frame:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" then
        onAddonLoaded(arg1)    elseif event == "PLAYER_LOGIN" then
        -- Fallback initialization on player login
        if not TranslationsTable and chineseToEnglish then
            if debugMode then
                DEFAULT_CHAT_FRAME:AddMessage("|cffffd700Debug:|r Attempting PLAYER_LOGIN fallback initialization...")
            end
            if initializeTranslationData() then
                if debugMode then
                    DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00MyTranslator:|r PLAYER_LOGIN initialized successfully!")
                end
            else
                if debugMode then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000MyTranslator:|r PLAYER_LOGIN initialization failed - data not available")
                end
            end
        end
        frame:UnregisterEvent("PLAYER_LOGIN")
    elseif event == "CHAT_MSG_SAY" or event == "CHAT_MSG_YELL" or event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_GUILD" or event == "CHAT_MSG_OFFICER" or event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_BATTLEGROUND_LEADER" then
        onChatMessage(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    end
end)

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

-- Try immediate initialization (in case MyTranslatorData is already loaded)
tryInitialize()