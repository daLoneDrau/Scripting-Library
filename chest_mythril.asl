ON INIT {
 SETNAME [description_chainmail_chest_unidentified]
 SET_PRICE 1300
 SET_MATERIAL METAL
 SET_ARMOR_MATERIAL METAL_CHAIN
 SET_GROUP ARMORY
 SETPLAYERTWEAK MESH "human_chainmail.teo"
 SETPLAYERTWEAK SKIN "npc_human_chainmail_body" "npc_human_chainmail_mithril_body"
 SETOBJECTTYPE ARMOR
 SETEQUIP identify_value 30
 SETEQUIP armor_class 5
 SETEQUIP resist_magic -2%
 SETEQUIP casting -2%
 SETEQUIP defense 3
 SET_DURABILITY 90
 SET_WEIGHT 1
 ACCEPT
}

ON EQUIPIN {
 PLAY "equip_armor_chain"
 ACCEPT
}

ON INVENTORYUSE {
 EQUIP PLAYER
 ACCEPT
}

ON IDENTIFY {
 IF (�identified == 1) ACCEPT
 SET �identified 1
 SETNAME [description_mithril_chest]
 SET_PRICE 1800
 SETEQUIP armor_class 10
 SETEQUIP resist_magic 2%
 SETEQUIP casting 2%
 SETEQUIP defense 5
 ACCEPT
}

//#armor
ON COMBINE {
 IF (�enchanted == 1) { 
  SPEAK -p [player_no] NOP
  ACCEPT
 }
 IF (^$PARAM1 ISCLASS "GARLIC" ) {
  SET �reagent "garlic"
  HALO -ocs 0 1 0 30
  GOTO REGENTMIXED
  ACCEPT
 }
 IF (^$PARAM1 ISCLASS "rock_amikar" ) {
  SET �reagent "rock_amikar"
  HALO -ocs 1 1 1 30
  GOTO REGENTMIXED
  ACCEPT
 }
 ACCEPT
}

>>REGENTMIXED
 DESTROY ^$PARAM1
 TIMERoff 1 1 HALO -f
 IF (�identified == 1) {
  SETNAME [description_mithril_chest_ready]
  SPEAK -p [Player_off_interesting] NOP
  ACCEPT
 }
 SETNAME [description_chainmail_chest_unidentified_ready]
 SPEAK -p [Player_off_interesting] NOP
 ACCEPT


ON SPELLCAST {
 IF (^$PARAM1 != ENCHANT_WEAPON) ACCEPT
 IF (�enchanted == 1) { 
  SPEAK -p [player_no] NOP
  ACCEPT
 }
 IF (�reagent == 0) { 
  SPEAK -p [player_wrong] NOP
  ACCEPT
 }
 SET �enchanted 1
 PLAY -o "Magic_Spell_Enchant_Weapon"
 IF (�identified == 1) SETNAME [description_mithril_chest]
 IF (�identified == 0) SETNAME [description_chainmail_chest_unidentified]
  IF (�reagent == "garlic") {
  HALO -ocs 0 1 0 30
  SETEQUIP defense 5
  SET �tmp ~^PRICE~
  MUL �tmp 1.2
  //HALO -ocs 0 1 1 30
  GOTO ENCHANTED
 }
  IF (�reagent == "rock_amikar") {
  HALO -ocs 1 1 1 30
  SET_DURABILITY 100
  SET_DURABILITY -c 100
  SET �tmp ~^PRICE~
  MUL �tmp 2
  //HALO -ocs 1 1 1 30
  GOTO ENCHANTED
 }
 ACCEPT
}

>>ENCHANTED
  SET_PRICE �tmp
  UNSET �tmp
  UNSET �reagent
  //HALO -ocs 0.6 0.6 1 30
  ACCEPT


ON REPAIRED {
 IF (^$PARAM1 == "checkdur") {
  IF (^DURABILITY == ^MAXDURABILITY) {
   SPEAK -p [player_weapon_already_repaired] NOP
   ACCEPT
  }
  SENDEVENT REPAIR ^SENDER ""
  ACCEPT
 }
 SET �tmp ~^MAXDURABILITY~
 REPAIR SELF ~^PLAYER_SKILL_MECANISM~
 if (^DURABILITY < �tmp) {
  SPEAK -p [player_weapon_repaired_partially] NOP
  ACCEPT
 }
 SPEAK -p [player_weapon_repaired_in_full] NOP
 UNSET �tmp
 ACCEPT
}

ON BREAK {
PLAY "Crushing"
DESTROY SELF
ACCEPT
}
//#
ON DURABILITY_ARMOR {
 SET_DURABILITY -c ~^$PARAM1~
 ACCEPT
} 