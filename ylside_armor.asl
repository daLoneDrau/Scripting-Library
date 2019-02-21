ON INIT {
 SETNAME [description_ylside_armor]
 SET_PRICE 2100
 SET_MATERIAL METAL
 SET_ARMOR_MATERIAL METAL
 SET_GROUP ARMORY
 SETPLAYERTWEAK MESH "human_ylside.teo"
 SETOBJECTTYPE ARMOR
 SETEQUIP armor_class 38
 SETEQUIP resist_magic 20%
 SETEQUIP casting -4%
 SETEQUIP STEALTH -20%
 SETEQUIP STRENGTH 3
 SETEQUIP defense 25
 SET_DURABILITY 100
 SET §enchanted 1
 SET §call 0
 SET_WEIGHT 1
 ACCEPT
}

ON INVENTORYUSE {
IF (^PLAYER_ATTRIBUTE_STRENGTH < 12) {
  SPEAK -p [player_not_skilled_enough] NOP
  HEROSAY [required_st_12] 
  ACCEPT
 }
 EQUIP PLAYER
 IF (#PLAYER_ON_QUEST > 7) ACCEPT
 IF (§call == 0) {
  SET §call 1
  TIMERspk 1 3 GOTO STARTSPK
  ACCEPT
 }
 ACCEPT
}
>>STARTSPK
 SET_PLAYER_CONTROLS OFF
 CINEMASCOPE -s ON
 PLAYER_INTERFACE -s HIDE
 SPEAK -o [Iserbius_call_ylside2] GOTO ENDSPK
 ACCEPT

>>ENDSPK
 SPEAK -o [Iserbius_call_ylside3] GOTO ENDSPK2
 ACCEPT

>>ENDSPK2
 CINEMASCOPE -s OFF
 PLAYER_INTERFACE -s SHOW
 SET_PLAYER_CONTROLS ON
 ACCEPT

ON EQUIPIN {
 PLAY "equip_armor_plate"
 ACCEPT
}

//#armor
ON COMBINE {
 IF (§enchanted == 1) { 
  SPEAK -p [player_no] NOP
  ACCEPT
 }
 IF (^$PARAM1 ISCLASS "GARLIC" ) {
  SET £reagent "garlic"
  HALO -ocs 0 1 0 30
  GOTO REGENTMIXED
  ACCEPT
 }
 IF (^$PARAM1 ISCLASS "rock_amikar" ) {
  SET £reagent "rock_amikar"
  HALO -ocs 1 1 1 30
  GOTO REGENTMIXED
  ACCEPT
 }
 ACCEPT
}

>>REGENTMIXED
 DESTROY ^$PARAM1
 //HALO -ocs 1 1 0 30
 SPEAK -p [Player_off_interesting] NOP
 ACCEPT


ON SPELLCAST {
 IF (^$PARAM1 != ENCHANT_WEAPON) ACCEPT
 IF (§enchanted == 1) { 
  SPEAK -p [player_no] NOP
  ACCEPT
 }
 IF (£reagent == 0) { 
  SPEAK -p [player_wrong] NOP
  ACCEPT
 }
 SET §enchanted 1
 PLAY -o "Magic_Spell_Enchant_Weapon"
  IF (£reagent == "garlic") {
  SETEQUIP defense 5
  SET §tmp ~^PRICE~
  MUL §tmp 1.2
  //HALO -ocs 0 1 1 30
  GOTO ENCHANTED
 }
  IF (£reagent == "rock_amikar") {
  SET_DURABILITY 100
  SET_DURABILITY -c 100
  SET §tmp ~^PRICE~
  MUL §tmp 2
  //HALO -ocs 1 1 1 30
  GOTO ENCHANTED
 }
 ACCEPT
}

>>ENCHANTED
  SET_PRICE §tmp
  UNSET §tmp
  UNSET £reagent
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
 SET §tmp ~^MAXDURABILITY~
 REPAIR SELF ~^PLAYER_SKILL_OBJECT_KNOWLEDGE~
 if (^DURABILITY < §tmp) {
  SPEAK -p [player_weapon_repaired_partially] NOP
  ACCEPT
 }
 SPEAK -p [player_weapon_repaired_in_full] NOP
 UNSET §tmp
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
}