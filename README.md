# MyTranslator

## 🚀 Overview
MyTranslator is a rare example of my boneheaded attempt at cobbling together things I found on the internet / github with free AI tools and limited coding experience and actually having some success resulting in a barely functional WoW addon - enjoy I guess, or don't. Most of the rest of this readme is a slightly edited version of the original so it might be correct or might not be.

---

## ✨ Features
- Translate chat messages from one language to another seamlessly.
- Expand the add-on's functionality by adding your own key terms or in-game phrases.
- Build a personalized translation table based on your needs and preferences.
- Optimized to run smoothly without impacting gameplay.

---

## 🛠️ Installation
1. Download the code zip.
2. Extract the folder named MyTranslator into your WoW `Interface/AddOns` directory.
3. Restart the game, and enable the add-on from the add-ons menu.

---

## 📚 Usage
The addon uses the /mtr command - just typing that command should display other commands available.

For additions to the translations, you basically have to edit the translate tables at the top of the lua file.

Also, for which chats it applies to, it requires editing the lua file right now - might change this soon.

## 📝 Todo
- [ ] Add more common phrases / terminologies
  - In order to do this you can enable copy paste for Chinese charcters using these instructions https://forum.turtle-wow.org/viewtopic.php?p=137793#p137793
  - Then just sign up to a free https://claude.ai account and paste in messages from World chat or other source with Classic WoW terms in Chinese
  - Prime it with something like "Hi Claude, I'm trying to translate some World of Warcraft Classic terminologies stated in the Chinese language to English - with that context I will give you some individual examples in order to help translate"
  - Then add atomic pieces of the breakdown for translations to translation tables in the lua file

- [ ] Add ability to change which chat contexts the addon targets from the cli interface in game


---

## 🛡️ License
This project is licensed under the [MIT License](LICENSE).

---

## ❤️ Acknowledgments
Thanks https://github.com/JayStalt for the original work, and thanks to Claude cause you saved me a lot of time - I don't know lua or Chinese.
