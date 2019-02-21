ON INIT {
 SET £rune_name aam
 SET_MATERIAL STONE
 SET_GROUP PROVISIONS
 SET_PRICE 1000
 SET_STEAL 50
 SET_WEIGHT 0
 ACCEPT
}

ON INITEND {
 SETNAME [system_~£rune_name~] 
 TWEAK ICON rune_~£rune_name~[icon]
 TWEAK SKIN "item_rune_aam" item_rune_~£rune_name~
 ACCEPT
}

ON INVENTORYUSE {
 PLAY "system2"
 RUNE -a ~£rune_name~
 IF (#TUTORIAL_MAGIC < 9) INC #TUTORIAL_MAGIC 3
 IF (#TUTORIAL_MAGIC == 8) GOTO TUTO
 IF (#TUTORIAL_MAGIC == 7) GOTO TUTO
 IF (#TUTORIAL_MAGIC == 6) {
  >>TUTO
  SET #TUTORIAL_MAGIC 9
  PLAY "system"
  HEROSAY [system_tutorial_6bis]
  QUEST [system_tutorial_6bis]
  DESTROY SELF
  ACCEPT
 }
 DESTROY SELF
 ACCEPT
}

ON INVENTORYIN {
 IF (#TUTORIAL_MAGIC > 1) ACCEPT
 INC #TUTORIAL_MAGIC 1
 IF (#TUTORIAL_MAGIC == 2) {
  PLAY "system"
  HEROSAY [system_tutorial_6]
  QUEST [system_tutorial_6]
  ACCEPT
 }
 ACCEPT
}
//ON INVENTORYOUT {
// IF (#TUTORIAL_MAGIC == 1) DEC #TUTORIAL_MAGIC 1
// ACCEPT
//}