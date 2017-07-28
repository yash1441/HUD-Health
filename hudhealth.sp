/*
#						CODE BY SIMON						#
# 	 			 	 MADE FOR CS:GO ONLY					#
#															#
# Please do not edit and distribute	any part of this code	#
# without my permission.									#
#		CONSOLE CVARS:										#
#				sm_hud_health_version						#
#				sm_hud_health_enable -> 1					#
#				sm_hud_health_team -> 4						#
#				sm_hud_health_mode -> 1						#
#				sm_hud_health_flag -> d						#
#				sm_hud_health_ad -> 1						#
#		CLIENT COMMANDS:									#
#				!hudhealth									#
# 															#
# Thanks!													#
# Give suggestions/requests at yash1441@yahoo.com			#
#															#				
# Credits to Graffiti for his Show nickname in HUD plugin	#
#															#
#	CHANGELOG:												#
- 2015-12-25 ~ Added sm_hud_health_enable & Merry Christmas!
-
- 2015-09-25 ~ Fixed issues after the new CS:GO update v3.0
-
- 2015-08-22 ~ Minor Fixes v2.7
-
- 2015-08-21 ~ Minor Fixes v2.6
-
- 2015-08-20 ~ Added  sm_hud_health_mode, !hudhealth(sm_hudhealth), sm_hud_health_team 5 for spectators/dead & Advertisement v2.5
-
- 2015-08-18 ~ Initial Release v1.0
-
*/

#include <sourcemod>
#include <sdktools>
#include <cstrike>

#define PLUGIN_VERSION   "3.1"
#define DEFAULT_FLAGS 	FCVAR_PLUGIN|FCVAR_NOTIFY

new target_health;
new Handle:g_Cvar_Team = INVALID_HANDLE;
new Handle:g_Cvar_Flag = INVALID_HANDLE;
new Handle:g_Cvar_Ad = INVALID_HANDLE;
new Handle:g_Cvar_Mode = INVALID_HANDLE;
new Handle:g_Cvar_Default = INVALID_HANDLE;
new String:g_sCharAdminFlag[32];

public Plugin:myinfo =
{
	name = "HUD Health",
	author = "Simon",
	description = "Show health on HUD for CSGO",
	version = PLUGIN_VERSION,
	url = "yash1441@yahoo.com"
};

new bool:g_Hud_Check[MAXPLAYERS+1] = {false,...};

public OnPluginStart()
{
	LoadTranslations("common.phrases");
	CreateConVar("sm_hud_health_version", PLUGIN_VERSION, "Show health on HUD", FCVAR_PLUGIN | FCVAR_SPONLY | FCVAR_DONTRECORD | FCVAR_NOTIFY);
	g_Cvar_Default = CreateConVar("sm_hud_health_enable", "1", "Enabled by default or not. (0 = Disabled, 1 = Enabled)", DEFAULT_FLAGS, true, 0.0, true, 1.0);
	g_Cvar_Team = CreateConVar("sm_hud_health_team", "3", "Show health to players in which team. (0 = No One, 1 = Terrorists, 2 = Counter-Terrorists, 3 = Both, 4 = Admin Only, 5 = Dead/Spectators Only)", DEFAULT_FLAGS);
	g_Cvar_Mode = CreateConVar("sm_hud_health_mode", "1", "Show health of players in which team. (0 = All, 1 = Enemy, 2 = Teammate)", DEFAULT_FLAGS);
	g_Cvar_Flag = CreateConVar("sm_hud_health_flag", "d", "Admin flag(s) to use if admin only.", DEFAULT_FLAGS);
	g_Cvar_Ad = CreateConVar("sm_hud_health_ad", "1", "Enable/disable the display of the help message at the start of each round.", DEFAULT_FLAGS, true, 0.0, true, 1.0);

	CreateTimer(0.5, Timer, _, TIMER_REPEAT);
	HookEvent("round_start", Event_RoundStart);
	RegConsoleCmd("sm_hudhealth", Command_toggleHUD);
}

public OnClientConnected(client)
{
	if (GetConVarBool(g_Cvar_Default))
		g_Hud_Check[client] = true;
	else
		g_Hud_Check[client] = false;
}

stock TraceClientViewEntity(client)
{
	new Float:m_vecOrigin[3];
	new Float:m_angRotation[3];

	GetClientEyePosition(client, m_vecOrigin);
	GetClientEyeAngles(client, m_angRotation);

	new Handle:tr = TR_TraceRayFilterEx(m_vecOrigin, m_angRotation, MASK_VISIBLE, RayType_Infinite, TRDontHitSelf, client);
	new pEntity = -1;

	if (TR_DidHit(tr))
	{
		pEntity = TR_GetEntityIndex(tr);
		CloseHandle(tr);
		return pEntity;
	}

	if(tr != INVALID_HANDLE)
	{
		CloseHandle(tr);
	}
	
	return -1;
}

public Action:Timer(Handle:timer)
{
	for(new i = 1; i <= MaxClients; i++)
	{
	
		switch(g_Cvar_Team) {
			case 0:
			{
				return Plugin_Handled;
			}
			case 1: // T Team Alive -> sm_hud_health_team 1
			{
				if (IsClientInGame(i) && GetClientTeam(i) == CS_TEAM_T && IsPlayerAlive(i) && g_Hud_Check[i])
				{
					new target = TraceClientViewEntity(i);
					if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
					{
						switch(g_Cvar_Mode) {
							case 1: // enemy
							{
								if (GetClientTeam(target) == CS_TEAM_CT) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							case 2: // team-mate
							{
								if (GetClientTeam(target) == CS_TEAM_T) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							default: // both
							{
								target_health = GetClientHealth(target);
								PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
							}
						}
					}
				}
				break;
			}
			case 2: // CT Team Alive -> sm_hud_health_team 2
			{
				if (IsClientInGame(i) && GetClientTeam(i) == CS_TEAM_CT && IsPlayerAlive(i) && g_Hud_Check[i])
				{
					new target = TraceClientViewEntity(i);
					if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
					{
						switch(g_Cvar_Mode) {
							case 1: // enemy
							{
								if (GetClientTeam(target) == CS_TEAM_T) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							case 2: // team-mate
							{
								if (GetClientTeam(target) == CS_TEAM_CT) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							default: // both
							{
								target_health = GetClientHealth(target);
								PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
							}
						}
					}
				}
				break;
			}
			case 3: // Both Teams Alive -> sm_hud_health_team 3
			{
				if (IsClientInGame(i) && GetClientTeam(i) != CS_TEAM_SPECTATOR && IsPlayerAlive(i) && g_Hud_Check[i])
				{
					new target = TraceClientViewEntity(i);
					if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
					{
						switch(g_Cvar_Mode) {
							case 1: // enemy
							{
								if (GetClientTeam(i) != GetClientTeam(target)){
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							case 2: // team-mate
							{
								if (GetClientTeam(i) == GetClientTeam(target)){
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							default:
							{
								target_health = GetClientHealth(target);
								PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
							}
						}
					}
				}
				break;
			}
			case 4: // Admins -> sm_hud_health_team 4; not affected by sm_hud_health_mode
			{
				GetConVarString(g_Cvar_Flag, g_sCharAdminFlag, sizeof(g_sCharAdminFlag));
				if (IsClientInGame(i) && IsValidAdmin(i, g_sCharAdminFlag) && g_Hud_Check[i])
				{
					new target = TraceClientViewEntity(i);
					if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
					{
						target_health = GetClientHealth(target);
						PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
					}
				}
				else if (!IsValidAdmin(i, g_sCharAdminFlag)) {
					PrintToChat(i, "You do not have permission to use this.");
				}
				break;
			}
			case 5: // Both Teams Dead or Spectators -> sm_hud_health_team 5; not affected by sm_hud_health_mode
			{
				if (IsClientInGame(i) && g_Hud_Check[i])
				{
					if (!IsPlayerAlive(i)  || GetClientTeam(i) == CS_TEAM_SPECTATOR) {
						new target = TraceClientViewEntity(i);
						if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
						{
							target_health = GetClientHealth(target);
							PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
						}
					}
				}
				break;
			}
			default: // Everyone -> sm_hud_health_team x; x < 0 or x > 4
			{
				if (IsClientInGame(i) && g_Hud_Check[i])
				{
					new target = TraceClientViewEntity(i);
					if(target > 0 && target <= MaxClients && IsClientInGame(target) && IsPlayerAlive(target))
					{
						switch(g_Cvar_Mode) {
							case 1:
							{
								if (GetClientTeam(target) == CS_TEAM_T) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							case 2:
							{
								if (GetClientTeam(target) == CS_TEAM_CT) {
									target_health = GetClientHealth(target);
									PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
								}
								break;
							}
							default:
							{
								target_health = GetClientHealth(target);
								PrintHintText(i, "Name: \"%N\" \n HP: \"%i\"", target, target_health);
							}
						}
					}
				}
				break;
			}
		}
	}
	return Plugin_Continue; 
}

stock bool:IsValidAdmin(client, const String:flags[]) // Checks if admin has sm_hud_health_flag flag
{
	new ibFlags = ReadFlagString(flags);
	if ((GetUserFlagBits(client) & ibFlags) == ibFlags)
	{
		return true;
	}
	if (GetUserFlagBits(client) & ADMFLAG_ROOT)
	{
		return true;
	}
	return false;
}

public bool:TRDontHitSelf(entity, mask, any:data) // Don't ray trace ourselves -_-"
{
	return (1 <= entity <= MaxClients) && (entity != data);
}

public Action:Command_toggleHUD(client, args)
{
	if (g_Hud_Check[client]) {
		g_Hud_Check[client] = false;
		PrintToChat(client, "HUD Health is now turned OFF.");
	}
	else if (!g_Hud_Check[client]) {
		g_Hud_Check[client] = true;
		PrintToChat(client, "HUD Health is now turned ON.");
	}
}

public Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast) // Advertisement of the client command
{
	if (GetConVarInt(g_Cvar_Ad))
	{
		PrintToChatAll("Type !hudhealth to see other players' health on your HUD.");
	}
}