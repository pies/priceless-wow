# Intro #

Priceless is a World of Warcraft (WoW) addon developed by Michal Tatarynowicz (aka Tatko of RagnarosEU) that adds information to tooltips and chat messages. It's modular and aims to make it easy to create new modules with additional functionality. This document provides addon developers with information needed to write new modules.

# General information #

Priceless modules reside in the /mods directory. There's no particular requirements as to how a module should be built, other than that it should be an object containing one or more hooks for tooltips and events it wants to handle, and that it should register itself with Priceless.

# Adding hooks #

To create a hook add a method to your module object with one of the "magic" names. Here are the currently (v 0.1) available hooks:

  * `Module:OnTooltipSetItem (tooltip, item_name, item_id, item_link)`
  * `Module:OnTooltipSetUnit (tooltip, unit_name)`
  * `Module:OnTooltipSetSpell (tooltip, spell_name)`
  * `Module:OnTooltipSetObject (tooltip, object_name)`
  * `Module:OnSkillChange (skill_name, skill_value)`

Please keep in mind, that the `Module:OnTooltipSetObject()` hook is based on a hack -- there is currently no official WoW API to find out when a tooltip is shown for an object (such as a mining node, herb, or a mailbox). Priceless keeps note of when the tooltip is shown for an item, unit or spell, along with its name. When tooltip is updated (specifically, when the first line, usually containing the name, changes), yet it's not for and item, unit or spell, it's assumed that it's shown for an object.

That means, however, that the hook is called for things like user interface elements, such as 'zoom in' and 'zoom out' minimap buttons. It's up to the module developer to match the name (tooltip's first line) or other tooltip contents with the list of game objects he wants to add information for.

# Registering a module #

To register a module with Priceless, call `Priceless:AddMod('Module Name', ModuleObject)`

# Helper Classes & Syntax Candy #

There are two helper classes included with, and used troughout Priceless code. They are contained in files `util.lua` and `user.lua`. _(Todo: describe the helper classes.)_