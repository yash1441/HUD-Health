# HUD-Health
This is a simple plugin which shows health of player that you aim at in the hint text box of CS:GO.

# Features
- You can change who all can see health and whose health they can see through cvars.
- You can see the name of the player besides their Health, added in v3.0
- You can change the admin access needed if the above is set to admins only.
- You can turn on/off the ad for !hudhealth at every round start.

# CVARs
- ```sm_hud_health_version``` - returns the plugin version
- ```sm_hud_health_enable``` - Enabled by default or not. (0 = Disabled, 1 = Enabled**[DEFAULT]**)
- ```sm_hud_health_team``` - Show health to players in which team. (0 = No One, 1 = Terrorists, 2 = Counter-Terrorists, 3 = Both**[DEFAULT]**, 4 = Admins Only, 5 = Dead/Spectators Only)
- ```sm_hud_health_mode``` - Show health of players in which team. (0 = All, 1 = Enemy**[DEFAULT]**, 2 = Teammate)
- ```sm_hud_health_flag``` - Admin flag(s) to use if admins only. (**DEFAULT** is d)
- ```sm_hud_health_ad``` - Enable/disable the display of the help message at the start of each round. (0 = Disabled, 1 = Enabled**[DEFAULT]**)
- ```sm_hudhealth``` or ```!hudhealth``` - Toggle the HUD Health Box On/Off

# Changelog
- 2015-12-25 (v3.1) [Minor]
 > Added sm_hud_health_enable
 
 > Merry Christmas!

- 2015-09-25 (v3.0) [Major]
 > Fixed issues after the new CS:GO update
 > Added name of the player besides their HP in the HUD

- 2015-08-22 (v2.7) [Minor]
 > Fixed bugs

- 2015-08-21 (v2.6) [Minor]
 >* Fixed errors and warnings

- 2015-08-20 (v2.5) [Major]
 > Added sm_hud_health_mode 
 
 > Added !hudhealth(sm_hudhealth)
 
 > Added sm_hud_health_team 5 for spectators/dead
 
 > Added advertisement - sm_hud_health_ad
 
 > Added name of the player besides the health
 

- 2015-08-18 (v1.0)
 > Initial release.
