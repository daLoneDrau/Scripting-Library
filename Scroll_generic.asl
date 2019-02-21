ON INIT {
 SET §transmuted 0
 SET £spellname "none"
 SET_MATERIAL CLOTH
 SET_GROUP PROVISIONS
 SET §circle 1 // correspond au cercle de magie
 SET_STEAL 50
 SET_WEIGHT 0
 ACCEPT
}

ON INITEND {
 IF (£spellname == "none") ACCEPT
>>TRANSMUTE
 SET §transmuted 1
 IF (£spellname == "magic_missile") {
  SETNAME [system_spell_name_magic_projectile]
  GOTO SUITE
 }
 IF (£spellname == "dispell_illusion") {
  SETNAME [system_spell_name_reveal]
  GOTO SUITE
 }
 IF (£spellname == "bless") {
  SETNAME [system_spell_name_sanctify]
  GOTO SUITE
 }
 IF (£spellname == "rune_of_guarding") {
  SETNAME [system_spell_name_rune_guarding]
  GOTO SUITE
 }
 IF (£spellname == "poison_projectile") {
  SETNAME [system_spell_name_poison_projection]
  GOTO SUITE
 }
 IF (£spellname == "control") {
  SETNAME [system_spell_name_control_target]
  GOTO SUITE
 }
 SETNAME [system_spell_name_~£spellname~]
>>SUITE
 SET #TMP 200
 MUL #TMP §circle
 SET_PRICE #TMP
 IF (§circle == 1) ACCEPT
 TWEAK ICON Scroll_generic[Icon]~§circle~
ACCEPT
}

ON INVENTORYUSE {
 IF (#TUTORIAL_SCROLL < 2) {
  SET #TUTORIAL_SCROLL 2
  SENDEVENT TADA PLAYER ""
  HEROSAY [system_tutorial_15]
  QUEST [system_tutorial_15]
 }
 PRECAST -f §circle ~£spellname~
 PLAY "activate_scroll"
 DESTROY SELF
 ACCEPT
}

ON TRANSMUTE {
 IF (§transmuted == 1) ACCEPT
 SET §circle ^$PARAM1
 SET £spellname ^$PARAM2
 GOTO TRANSMUTE
 ACCEPT
}