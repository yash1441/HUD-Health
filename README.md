# HUD-Health
This is a simple plugin which shows health of player that you aim at in the hint text box of CS:GO.

# Features
- You can customize the HUD text location, colors, alpha, duration, effects, effects duration, fade in and fade out.
- You can change who all can see health and whose health they can see through cvars.
- You can see the name of the player besides their Health, added in v3.0
- You can change the admin access needed if the above is set to admins only.
- You can turn on/off the ad for !hudhealth at every round start.

# CVARs
- ```sm_hh_version``` - returns the plugin version
- ```sm_hh_enable``` - Enabled by default or not. (0 = Disabled, 1 = Enabled[DEFAULT])
- ```sm_hh_team``` - Show health to players in which team. (0 = No One, 1 = Terrorists, 2 = Counter-Terrorists, 3 = Both[DEFAULT], 4 = Admins Only, 5 = Dead/Spectators Only)
- ```sm_hh_mode``` - Show health of players in which team. (0 = All, 1 = Enemy[DEFAULT], 2 = Teammate)
- ```sm_hh_flag``` - Admin flag(s) to use if admins only. (DEFAULT is d)
- ```sm_hh_ad``` - Enable/disable the display of the help message at the start of each round. (0 = Disabled, 1 = Enabled[DEFAULT])
- ```sm_hudhealth``` or ```!hudhealth``` or ```sm_hh``` or ```!hh``` - Toggle the HUD Health Box On/Off
- ```sm_hh_x``` - X coordinate of HUD, 0 to 1. -1.0 is center. (DEFAULT is -1.0)
- ```sm_hh_y``` - Y coordinate of HUD, 0 to 1. -1.0 is center (DEFAULT is 0.7)
- ```sm_hh_duration``` - Number of seconds to hold the text. (DEFAULT is 0.5)
- ```sm_hh_r``` - Red color value. (DEFAULT is 255)
- ```sm_hh_g``` - Green color value. (DEFAULT is 150)
- ```sm_hh_b``` - Blue color value. (DEFAULT is 0)
- ```sm_hh_a``` - Alpha transparency value. (DEFAULT is 50)
- ```sm_hh_effect``` - 0/1 causes the text to fade in and out. 2 causes the text to flash[?]. (DEFAULT is 0)
- ```sm_hh_effect_duration``` - Duration of chosen effect (May not apply to all effects). (DEFAULT is 0)
- ```sm_hh_fadein_duration``` - Number of seconds to spend in fading in. (DEFAULT is 0)
- ```sm_hh_fadeout_duration``` - Number of seconds to spend in fading out. (DEFAULT is 0)

# Changelog
- 2017-08-24 (v3.3) [Major]
 > Added MultiColors support
 
 > Simplified and added more ConVars
 
 >Added a chat prefix

- 2017-08-14 (v3.2) [Major]
 > Updated with new syntax
 
 > Added clientprefs support
 
 > Replace HintBox with the new HUDText
 
- 2015-12-25 (v3.1) [Minor]
 > Added sm_hud_health_enable
 
 > Merry Christmas!

- 2015-09-25 (v3.0) [Major]
 > Fixed issues after the new CS:GO update
 
 > Added name of the player besides their HP in the HUD

- 2015-08-22 (v2.7) [Minor]
 > Fixed bugs

- 2015-08-21 (v2.6) [Minor]
 > Fixed errors and warnings

- 2015-08-20 (v2.5) [Major]
 > Added sm_hud_health_mode 
 
 > Added !hudhealth(sm_hudhealth)
 
 > Added sm_hud_health_team 5 for spectators/dead
 
 > Added advertisement - sm_hud_health_ad
 
 > Added name of the player besides the health
 

- 2015-08-18 (v1.0)
 > Initial release.


# Requirements
- [Multi Colors](https://forums.alliedmods.net/showthread.php?t=247770)

# Screenshot
[alt text](https://steamuserimages-a.akamaihd.net/ugc/853850382734488912/54DF235A0D9557D2648699995685138936C2EEF2/ "Lol")
