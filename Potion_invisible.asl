ON INVENTORYUSE {
 PLAY "drink"
  PLAY "Magic_Spell_invisibilityon"
 SPELLCAST -msfd 12000 10 INVISIBILITY PLAYER
 SETINTERACTIVITY NONE
 timerreplace -m 1 500 SETINTERACTIVITY YES REPLACEME "\\provisions\\bottle_empty\\bottle_empty"
 ACCEPT
}

ON INIT {
 SETNAME [description_potion]
 //SETIDNAME [description_white_potion]
 SET_MATERIAL GLASS
 SET_GROUP PROVISIONS
 SET_PRICE 150
 PLAYERSTACKSIZE 10
 SET_STEAL 50
 SETEQUIP identify_value 40
 SET_WEIGHT 0
 ACCEPT
}
ON EMPTY {
 REPLACEME "\\provisions\\bottle_empty\\bottle_empty"
 ACCEPT
}
ON IDENTIFY {
 SETNAME [description_white_potion]
 SET_PRICE 600
 ACCEPT
}