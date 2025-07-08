MyTranslatorMessageProcessor = {};

-- Check translations are loaded
local function CountTableEntries(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Debug:|r chineseToEnglish loaded with " .. (CountTableEntries(chineseToEnglish) or "unknown") .. " entries")

-- Build englishToChinese table from chineseToEnglish
englishToChinese = {}
for k, v in pairs(chineseToEnglish) do
    if v and v ~= "" then
        englishToChinese[v] = k
    end
end

function MyTranslatorMessageProcessor.ProcessMessage(msg, author, language, channelString, target, flags, unknown, channelNumber, channelName)
    local translatedMessage, translated = MyTranslatorMessageProcessor.Translate(msg);

    if translated then
        DEFAULT_CHAT_FRAME:AddMessage(string.format("|cffeda55f[|r|cffffa50MyTranslator|r|cffeda55f]|r [%s] %s: %s (|cff99ccff%s|r)", channelName or "Unknown", author or "Unknown", msg, translatedMessage));
    end
end

function MyTranslatorMessageProcessor.Translate(text)
    if not text or text == "" then
        return text, false
    end
    
    local originalText = text
    local translated = false
    
    -- First pass: Look for exact English-to-Chinese matches (case insensitive)
    for englishWord, chineseWord in pairs(englishToChinese) do
        if string.lower(text) == string.lower(englishWord) then
            return chineseWord, true
        end
    end
    
    -- Second pass: Look for exact Chinese-to-English matches
    for chineseWord, englishWord in pairs(chineseToEnglish) do
        if text == chineseWord then
            return englishWord, true
        end
    end
    
    -- Third pass: Do substring replacement for longer phrases
    -- English to Chinese (case insensitive)
    for englishWord, chineseWord in pairs(englishToChinese) do
        local pattern = string.gsub(englishWord, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- escape special chars
        local lowerText = string.lower(text)
        local lowerPattern = string.lower(pattern)
        if string.find(lowerText, lowerPattern) then
            text = string.gsub(text, pattern, chineseWord)
            translated = true
        end
    end
    
    -- Chinese to English
    for chineseWord, englishWord in pairs(chineseToEnglish) do
        local pattern = string.gsub(chineseWord, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1") -- escape special chars
        if string.find(text, pattern) then
            text = string.gsub(text, pattern, englishWord)
            translated = true
        end
    end

    return text, translated
end
