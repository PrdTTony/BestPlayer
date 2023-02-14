#include <sourcemod>
#include <cstrike>

public Plugin myinfo = 
{
	name = "[CSGO] BestPlayer", 
	author = "TTony", 
	description = "Best Player per round", 
	version = "1.0", 
	url = "http://steamcommunity.com/id/OneT0uch/"
};


public OnPluginStart()
{
	HookEvent("round_end", OnRoundEnd, EventHookMode_PostNoCopy);
}

void OnRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
    int bestScore = -1;
    int bestPlayer = -1;

    for (int client = 1; client <= MaxClients; client++) 
    {
      if (!IsClientInGame(client))
        continue;

      int score = CS_GetClientContributionScore(client);

      if (score > bestScore) 
      {
          bestScore = score;
          bestPlayer = client;
      }
    }

    if (bestPlayer != -1)
    {

      int frags = GetClientFrags(bestPlayer);
      int deaths = GetClientDeaths(bestPlayer);
      PrintHintTextToAll("<font color='#6CFF00'>%N</font><font color='#00FFFB'> is the best player with:</font><font color='#6CFF00'> %d score (%d kills / %d deaths</font>", bestPlayer, bestScore, frags, deaths);
    }
}

