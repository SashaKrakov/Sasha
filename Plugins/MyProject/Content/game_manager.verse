using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Game }
using { /Fortnite.com/Characters }

game_manager := class(creative_device):

    @editable
    GoldCounter : conditional_button_device = conditional_button_device{}
    @editable
    ItemGranter : item_granter_device = item_granter_device{}
    @editable
    TeamOneBlue : team_settings_and_inventory_device = team_settings_and_inventory_device{}
    @editable
    TeamTwoRed : team_settings_and_inventory_device = team_settings_and_inventory_device{}
    @editable
    var EliminationManager : elimination_manager_device = elimination_manager_device{}
    @editable
    var ClassSelector : []class_and_team_selector_device = array{}

    OnBegin<override>()<suspends>:void=
        #TeamOneBlue.EnemyEliminatedEvent.Subscribe(OnTeamOneScore)
        #TeamTwoRed.EnemyEliminatedEvent.Subscribe(OnTeamTwoScore)
        EliminationManager.EliminatedEvent.Subscribe(OnEnemyKilled)
        AllPlayers := GetPlayspace().GetPlayers()
        for(L_Agent : AllPlayers):
            HandleJoiningPlayer(L_Agent)
        GetPlayspace().PlayerAddedEvent().Subscribe(HandleJoiningPlayer)

        for(PlayerClass : ClassSelector):
            PlayerClass.ClassSwitchedEvent.Subscribe(HandleClassChange)

    HandleJoiningPlayer(InAgent : agent): void=
        Print("PlayerJoined")

    OnEnemyKilled(Agent : agent) : void=
        ItemGranter.GrantItem(Agent)    
        
    OnTeamOneScore(Agent : agent) : void=
        Print("TeamOne") 

    OnTeamTwoScore(Agent : agent) : void=
        Print("TeamTwo")  

    HandleClassChange(Agent : agent) : void=
        if(Agent.GetFortCharacter[]):
            Print("ClassChange")  