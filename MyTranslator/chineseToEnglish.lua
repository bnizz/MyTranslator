DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Debug:|r chineseToEnglish.lua is loading...")

MyTranslatorData = {
    chineseToEnglish = {
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

            -- Dungeons and raids (with abbreviations)
        ["全通"] = "full clear",
        ["大水任务"] = "Blackfathom deeps",
        ["大水"] = "Blackfathom deeps", -- Short form
        ["BFD"] = "Blackfathom deeps",  -- English abbreviation
        ["死矿"] = "Deadmines",
        ["DM"] = "Deadmines", -- English abbreviation
        ["黑龙团"] = "Onyxia", -- Literally Onyxia raid (long form)
        ["黑龙"] = "Onyxia",
        ["黑翼"] = "Blackwing Lair",


        
        -- LFG terms
        ["许愿彪"] = "wish roll",
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
        ["来的密"] = "whisper me",
    }
}

DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00Debug:|r MyTranslatorData created with " .. 
    (MyTranslatorData and MyTranslatorData.chineseToEnglish and 
     table.getn(MyTranslatorData.chineseToEnglish) or "unknown") .. " entries")