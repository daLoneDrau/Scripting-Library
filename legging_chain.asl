ON INIT {
 SETNAME [description_chainmail_leggings]
 SET_PRICE 850
 SET_MATERIAL METAL
 SET_ARMOR_MATERIAL METAL_CHAIN
 SET_STEP_MATERIAL Foot_metal_chain
 SET_GROUP ARMORY
 SETPLAYERTWEAK MESH "human_chainmail.teo"
 SETOBJECTTYPE LEGGINGS
 SETEQUIP identify_value 15
 SETEQUIP armor_class 5
 SETEQUIP resist_magic -2%
 SETEQUIP casting -2%
 SETEQUIP defense 3
 SETEQUIP STEALTH -2%
 SET_DURABILITY 80
 SET_WEIGHT 1
 ACCEPT
}

ON EQUIPIN {
 PLAY "equip_armor_chain"
 ACCEPT
}

ON INVENTORYUSE {
 IF (^PLAYER_ATTRIBUTE_STRENGTH < 8) {
  SPEAK -p [player_not_skilled_enough] NOP
  HEROSAY [required_st_8] 
  //COLORISE SELF 1 0 0
  ACCEPT
 }
 //COLORISE SELF 0 0 0
 EQUIP PLAYER
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
 SETNAME [description_chainmail_leggings_ready]
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
 SETNAME [description_chainmail_leggings]
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