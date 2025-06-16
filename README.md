wow-stunnable

# World of Warcraft addon: Track controllable mobs.

### Description

The purpose of this addon is to add a green check or a red cross icon to your **control spells that indicate if they are effective on your curent target** or not.
This addon tracks the npc that you (or someone near you) have controlled and fill its own database.
If you have [MDT](https://github.com/Nnoggie/MythicDungeonTools) installed, the addon will also load a preset of NPC from it (PS: there are a few mistakes in their data).

> [!IMPORTANT]
> This addon works with **WoW native UI** and with **ElvUI**. It hasn't been tested on other UI addons.

### Usefull informations

There is a full list of controls below, but it seems that npc can have only two immunes : one to the **slow** and/or one to the **other controls**.

List of controls:
- Slow
- Stun
- Disorient <sub>_that is a Stun that may break if target takes damage_</sub>
- Incapacitate <sub>_that is a Stun that may break if target takes damage_</sub>
- Fear <sub>_that seems to be a Disorient or Incapacitate_</sub>
- Root
- Silence
- Mind Soothe
- Mind Control <sub>_that can be Charm or Possess, only on certain NPC type_</sub>
- Polymorph <sub>_that is basically an Incapacitate but only on certain NPC type_</sub>
- Imprison <sub>_that is basically an Incapacitate but only on certain NPC type_</sub>
- Repentance <sub>_that is basically an Incapacitate but only on certain NPC type_</sub>
- Sap <sub>_that is basically an Incapacitate but only on certain NPC type_</sub>
- Control Undead <sub>_that is basically a Mind Control but only on certain NPC type_</sub>
- Shackle Undead <sub>_that is basically a Stun but only on certain NPC type_</sub>

### Developer section

#### Maintainability

When the game is updated, I mostly only have to check if control spells have changed. They are listed in [Presets.lua](Presets.lua).

#### Backlog & to do list

- [x] Make it work on native UI.
- [x] Make it work on ElvUI.
- [x] Get mobs preset from MDT if the user have it installed.
- [x] Also handle slows.
- [ ] Add options/customizations.
  - [ ] Option to only activate the addon if player is in a dungeon.
  - [ ] Customize the size and positions of the icon on the spells.
  - [ ] Different icons to choose from.
- [ ] Are there other incapaciting auras that I forgot?