import crafttweaker.api.event.entity.living.MCLivingEquipmentChangeEvent;
import crafttweaker.api.event.tick.MCPlayerTickEvent;
import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.MCResourceLocation;

import mods.gamestages.events.GameStageAdded;
import mods.gamestages.StageHelper;



StageHelper.grantStageOnKill(<entitytype:minecraft:wither>, "expert_mode");
StageHelper.grantStageOnKill(<entitytype:minecraft:ender_dragon>, "master_mode");


CTEventManager.register<GameStageAdded>((event) => {
  if (event.stage == "master_mode") {
		//In case a player got the Master Mode stage before the Expert Mode one.
    event.player.addGameStage("expert_mode");
  }
});

CTEventManager.register<MCPlayerTickEvent>((event) => {

  var player = event.getPlayer();
  var well_equipped = false;
  var armor = player.getTotalArmorValue();


  if (player.hasGameStage("master_mode")) {
    well_equipped = player.hasGameStage("well_equipped_master");
    if (armor >= 80) {
      if (well_equipped == false) { player.addGameStage("well_equipped_master"); }
    } else {
      if (well_equipped) { player.removeGameStage("well_equipped_master"); }
    }
  } else if (player.hasGameStage("expert_mode")) {
    well_equipped = player.hasGameStage("well_equipped_expert");
    if (armor >= 40) {
      if (well_equipped == false) { player.addGameStage("well_equipped_expert"); }
    } else {
      if (well_equipped) { player.removeGameStage("well_equipped_expert"); }
    }
  } else {
    well_equipped = player.hasGameStage("well_equipped_normal");
    if (armor >= 20) {
    if (well_equipped == false) { player.addGameStage("well_equipped_normal"); }
    } else {
    if (well_equipped) { player.removeGameStage("well_equipped_normal"); }
  }}

});