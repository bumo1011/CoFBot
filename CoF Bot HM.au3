#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include "GWA².au3"
#include <ComboConstants.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>

Global $DiessaChalice = 24353
Global $GoldenRinRelic = 24354
Global $CharrCarving = 27052
Global $RenderingEnabled = True
Global $firstRun = 0
Global $boolrun = False
Global $Deads = 0
Global $fails = 0
Global $success = 0
Global $diessa = 0
Global $rin = 0
Global $char = 0
Global $Timer = 0
Global $TimerDiff = 0
Global $TimerMin = 0
Global $TimerMax = 0
Global $TimerAvg = 0
Global $TimerSum = 0
Global $starttime
Global $starttimecalc
Global $successhour = 0
Global $failshour = 0
Global $diessahour = 0
Global $rinhour = 0
Global $charhour = 0
Global $hourcounter = 0

$aCharName = ""

If $aCharName= "" Then
	If Not Initialize(WinGetProcess("Guild Wars"), True, True, False) Then
		MsgBox(0, "Error", "Guild Wars it not running.")
		Exit
	EndIf
Else
	If Not Initialize($aCharName, True, True, False) Then
		MsgBox(0, "Error", "Can't find a Guild Wars client with that character name.")
		Exit
	EndIf
EndIf

$GuiH = 400
$GuiW = 400
$WinX = (@desktopWidth/2) - ($GuiW/2)
$WinY = (@DesktopHeight/2) - ($GuiH/2)

$Form1 = GUICreate("Cathedral Of Flame - Hardmode", $GuiW, $GuiH, $WinX, $WinY)
$bRun = GUICtrlCreateButton("Start", 40, 45, 169, 25)
$Label2 = GUICtrlCreateLabel("Pause", 50, 18, 152, 25, $SS_CENTER)
$Checkbox = GUICtrlCreateCheckbox("Disable Rendering", 8, 98, 129, 17)
	GUICtrlSetState(-1, 0)
	GUICtrlSetOnEvent(-1, "ToggleRendering")
GUICtrlCreateLabel("Starttime:", 180,98, 129, 17)
Global Const $StartTimeLabel = GUICtrlCreateLabel($starttime, 252, 98, 129, 17)
GUICtrlCreateLabel("SuccRuns:", 8,130, 80, 17)
Global Const $RunsLabel = GUICtrlCreateLabel($success, 80, 130, 50, 17)
GUICtrlCreateLabel("/hour:", 180,130, 129, 17)
Global Const $RunsPerHourLabel = GUICtrlCreateLabel($successhour, 252, 130, 129, 17)
GUICtrlCreateLabel("Fails:", 8,150, 80, 17)
Global Const $FailsLabel = GUICtrlCreateLabel($fails, 80, 150, 50, 17)
GUICtrlCreateLabel("/hour:", 180,150, 129, 17)
Global Const $FailsPerHourLabel = GUICtrlCreateLabel($failshour, 252, 150, 129, 17)
GUICtrlCreateLabel("Diessa:", 8,170, 80, 17)
Global Const $DiessaLabel = GUICtrlCreateLabel($diessa, 80, 170, 50, 17)
GUICtrlCreateLabel("/hour:", 180,170, 129, 17)
Global Const $DiessaPerHourLabel = GUICtrlCreateLabel($diessahour, 252, 170, 129, 17)
GUICtrlCreateLabel("Rin:", 8,190, 80, 17)
Global Const $RinLabel = GUICtrlCreateLabel($rin, 80, 190, 50, 17)
GUICtrlCreateLabel("/hour:", 180,190, 129, 17)
Global Const $RinPerHourLabel = GUICtrlCreateLabel($rinhour, 252, 190, 129, 17)
GUICtrlCreateLabel("Char:", 8,210, 80, 17)
Global Const $CharLabel = GUICtrlCreateLabel($char, 80, 210, 50, 17)
GUICtrlCreateLabel("/hour:", 180,210, 129, 17)
Global Const $CharPerHourLabel = GUICtrlCreateLabel($charhour, 252, 210, 129, 17)
GUICtrlCreateLabel("LastTime:", 8,230,80,17)
Global Const $TimerLabel = GUICtrlCreateLabel($Timer, 80, 230, 50, 17)
GUICtrlCreateLabel("TimeMin:", 8,250,80,17)
Global Const $TimerMinLabel = GUICtrlCreateLabel($TimerMin, 80, 250, 50, 17)
GUICtrlCreateLabel("TimeMax:", 8,270,80,17)
Global Const $TimerMaxLabel = GUICtrlCreateLabel($TimerMax, 80, 270, 50, 17)
GUICtrlCreateLabel("TimeAvg:", 8,290,80,17)
Global Const $TimerAvgLabel = GUICtrlCreateLabel($TimerAvg, 80, 290, 50, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Opt("GUIOnEventMode", 1)

GUISetOnEvent($GUI_EVENT_CLOSE, "Events")
GUICtrlSetOnEvent($bRun,"Events")

GUISetState(@SW_SHOW)


Func Events()
Switch (@GUI_CtrlId)
	Case $bRun
		$boolRun = Not $boolRun
		If $boolRun Then
			$starttime = _Now()
			$starttimecalc = _NowCalc()
			GUICtrlSetData($StartTimeLabel, $starttime)
			GUICtrlSetData($bRun, "Stop")
		EndIf
	Case $GUI_EVENT_CLOSE
		Exit
EndSwitch
EndFunc


While 1
Sleep(GetPing() + 100)
If $boolrun Then
   main()
EndIf
WEnd

Func main()

SwitchMode(1) ; 1 for HM and 0 for NM
If Not $RenderingEnabled Then ClearMemory()
If $firstRun = 0 Then
Disp("Travel To Doomlore Shrine")
RndTravel(648)
EndIf
$firstRUn = 1
GoNearestNPCToCoords(-19086,17999)
Dialog(0x00832105)
Sleep(300)
Dialog(0x00000088)
Disp("Loading CoF")
WaitMapLoading()
$Timer = TimerInit()
Sleep(GetPing())
GoNearestNPCToCoords(-18250,-8649)
Dialog(0x00000084)
Farm()
RndTravel(648)
EndFunc


Func Farm()
Disp("Farming Group 1")
MoveTo(-15992,-8390)
Sleep(2000)
MoveTo(-16113, -8199)
Kill()
Disp("Farming Group 2")
MoveTo(-13918,-8650)
Kill()
Disp("Farming Group 3")
MoveTo(-11048,-8604)
Sleep(1000)
Kill()
Disp("Farming Group 4")
MoveTo(-11176,-5339)
Kill()
;~ Disp("Farming Group 4 - 2")
MoveTo(-11726,-4007)
Kill()
Disp("Farming Group 5")
MoveTo(-13022,-2448)
Kill()
Disp("Farming Group 6")
MoveTo(-14665,-3696)
Kill()
MoveTo(-13022,-2448)
MoveTo(-12344,-1556)
Kill()
Disp("Farming Group 7")
MoveTo(-10866,8)
Kill()
;~ Disp("Farming Group 7 - 2")
MoveTo(-10147,694)
Kill()
MoveTo(-11239,1901)
Disp("Farming Boss group")
MoveTo(-12723,3069)
Sleep(1000)
Kill()
Sleep(1000)
$success += 1
UpdateTimer()
UpdatePerHour()
GUICtrlSetData($RunsLabel, $success)
EndFunc


Func UpdateTimer()
   $TimerDiff = Round((TimerDiff($Timer))/1000) ;Time in seconds
   $TimerSum = $TimerSum + $TimerDiff
   GUICtrlSetData($TimerLabel, $TimerDiff)
If $success=1 and $fails = 0 Then
	  $TimerMin = $TimerDiff
	  GUICtrlSetData($TimerMinLabel, $TimerMin)
	  $TimerMax = $TimerDiff
	  GUICtrlSetData($TimerMaxLabel, $TimerMax)
	  $TimerAvg = $TimerDiff
	  GUICtrlSetData($TimerAvgLabel, $TimerAvg)
Else
	  If ($TimerDiff<$TimerMin) Then
		 $TimerMin = $TimerDiff
		 GUICtrlSetData($TimerMinLabel, $TimerMin)
	  EndIf
	  If ($TimerDiff > $TimerMax) Then
		 $TimerMax = $TimerDiff
		 GUICtrlSetData($TimerMaxLabel, $TimerMax)
	  EndIf
   $TimerAvg = Round(($TimerSum/$success)) ; Average in seconds
   GUICtrlSetData($TimerAvgLabel, $TimerAvg)
EndIf
EndFunc


Func UpdatePerHour()
   Local $currenttime = _NowCalc()
   Local $minutesdiff = _DateDiff('n', $starttimecalc, $currenttime)
   If ($minutesdiff-(60*$hourcounter)) >= 60 Then
	  $hourcounter += 1
   EndIf
   If $hourcounter <> 0 Then
	  $successhour = $success/$hourcounter
	  $failshour = $fails/$hourcounter
	  $diessahour = $diessa/$hourcounter
	  $rinhour = $rin/$hourcounter
	  $charhour = $char/$hourcounter
	  GUICtrlSetData($RunsPerHourLabel, Round($successhour, 3))
	  GUICtrlSetData($FailsPerHourLabel, Round($failshour, 3))
	  GUICtrlSetData($DiessaPerHourLabel, Round($diessahour, 3))
	  GUICtrlSetData($RinPerHourLabel, Round($rinhour, 3))
	  GUICtrlSetData($CharPerHourLabel, Round($charhour, 3)
   Else
	  $successhour = $success
	  $failshour = $fails
	  $diessahour = $diessa
	  $rinhour = $rin
	  $charhour = $char
	  GUICtrlSetData($RunsPerHourLabel, $successhour)
	  GUICtrlSetData($FailsPerHourLabel, $failshour)
	  GUICtrlSetData($DiessaPerHourLabel, $diessahour)
	  GUICtrlSetData($RinPerHourLabel, $rinhour)
	  GUICtrlSetData($CharPerHourLabel, $charhour)
   EndIf
EndFunc

Func Kill()
$stuck = 0
Do
   $stuck = $stuck + 1
   CheckPartyDead()
   $target = GetNearestEnemyToAgent()
   $distance = GetDistance($target)
   ChangeTarget($target)
   UseSkills()
Until DllStructGetData($target, 'HP') = 0 Or GetDistance($target, -2) > 1250 or $Stuck == 10
PickUpLoot()
EndFunc


Func UseSkills()

For $i = 1 to 8
	$target = GetNearestEnemyToAgent()
	$targetHP = DllStructGetData(GetCurrentTarget(),'HP')
	$targetDistance = GetDistance($target)
 	 If GetSkillBarSkillRecharge($i) = 0 Then
	 	 If $targetDistance > 1250 then ExitLoop
	 	 UseSkill($i, $target)
	  	CallTarget($target)
	  	Sleep(1600)
 	 EndIf
Next
EndFunc


Func PickUpLoot()
	Local $lMe
	Local $lBlockedTimer
	Local $lBlockedCount = 0
	Local $lItemExists = True
	Local $Distance

	For $i = 1 To GetMaxAgents()
		If GetIsDead(-2) Then Return False
		$lAgent = GetAgentByID($i)
		If Not GetIsMovable($lAgent) Then ContinueLoop
	    $lDistance = GetDistance($lAgent)
	    If $lDistance > 2000 Then ContinueLoop
		$lItem = GetItemByAgentID($i)
		If CanPickup($lItem) Then
		   Disp("Picking Up Loot")
			Do
				If GetDistance($lAgent) > 150 Then Move(DllStructGetData($lAgent, 'X'), DllStructGetData($lAgent, 'Y'), 100)
				PickUpItem($lItem)
				Sleep(GetPing())
				Do
					Sleep(100)
					$lMe = GetAgentByID(-2)
				Until DllStructGetData($lMe, 'MoveX') == 0 And DllStructGetData($lMe, 'MoveY') == 0
				$lBlockedTimer = TimerInit()
				Do
					Sleep(3)
					$lItemExists = IsDllStruct(GetAgentByID($i))
				Until Not $lItemExists Or TimerDiff($lBlockedTimer) > Random(500, 1000, 1)
				If $lItemExists Then $lBlockedCount += 1
			Until Not $lItemExists Or $lBlockedCount > 5
		EndIf
	Next
EndFunc


Func CanPickUp($item)
	$id = DllStructGetData($item, 'ModelID')
	$r = GetRarity($item)
	$t = DllStructGetData($item, 'Type')
	$e = DllStructGetData($item, 'ExtraID')
	If $t = 20 Then ;Gold
		Return True
	ElseIf $id = 146 Then ;Dye
		If $e = 10 Or $e = 12 Then ;Black & White
			Return True
		EndIf
	ElseIf $id = 22751 Then ;Lockpick
		Return True
	ElseIf $id = 24353 Then
		$diessa += 1
		GUICtrlSetData($DiessaLabel, $diessa)
		Return True
        ElseIf $id = 24354 Then
		$rin += 1
		GUICtrlSetData($RinLabel, $rin)
                Return True
	ElseIf $id = 27052 Then
		$char += 1
		GUICtrlSetData($CharLabel, $char)
		Return True
	ElseIf $id = 929 Then ;glitzer
		Return True
	ElseIf $id = 921 Then ;Knochen
		Return True
    ElseIf $r = 2624 Then ; golden items
		Return True
	EndIf
	Return False
EndFunc


Func CheckPartyDead()
  $Deads = 0
  For $i =1 to GetHeroCount()
	   Sleep(100)
		 If GetIsDead(GetHeroID($i)) = True Then
			RndSleep(40)
			$Deads +=1
			RndSleep(450)
		 EndIf
  Next
  If $Deads > 4 Then
     $fails +=1
     GUICtrlSetData($FailsLabel, $fails)
     $firstRun = 0
     Main()
  EndIf
EndFunc


Func GoNearestNPCToCoords($x, $y)
	Local $guy, $Me
	Do
		RndSleep(250)
		$guy = GetNearestNPCToCoords($x, $y)
	Until DllStructGetData($guy, 'Id') <> 0
	ChangeTarget($guy)
	RndSleep(250)
	GoNPC($guy)
	RndSleep(250)
	Do
		RndSleep(500)
		MoveEx(DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y'), 40)
		RndSleep(500)
		GoNPC($guy)
		RndSleep(250)
		$Me = GetAgentByID(-2)
	Until ComputeDistance(DllStructGetData($Me, 'X'), DllStructGetData($Me, 'Y'), DllStructGetData($guy, 'X'), DllStructGetData($guy, 'Y')) < 250
	RndSleep(1000)
 EndFunc


 Func MoveEx($x, $y, $random = 150)
	Move($x, $y, $random)
 EndFunc


Func RndTravel($aMapID)
	Local $UseDistricts = 7 ; 7=eu-only, 8=eu+us, 9=eu+us+int, 12=all(incl. asia)
	; Region/Language order: eu-en, eu-fr, eu-ge, eu-it, eu-sp, eu-po, eu-ru, us-en, int, asia-ko, asia-ch, asia-ja
	Local $Region[11] = [2, 2, 2, 2, 0, -2, 1, 3, 4]
	Local $Language[11] = [4, 5, 9, 10, 0, 0, 0, 0, 0]
	Local $Random = Random(0, $UseDistricts - 1, 1)
	MoveMap($aMapID, $Region[$Random], 0, $Language[$Random])
	WaitMapLoading($aMapID, 30000)
	Sleep(3000)
 EndFunc

 Func Disp($msg)
	GuiCtrlSetData($Label2,$msg)
EndFunc

Func ToggleRendering()
	$RenderingEnabled = Not $RenderingEnabled
	If $RenderingEnabled Then
		EnableRendering()
		WinSetState(GetWindowHandle(), "", @SW_SHOW)
	Else
		DisableRendering()
		WinSetState(GetWindowHandle(), "", @SW_HIDE)
		ClearMemory()
	EndIf
EndFunc   ;==>ToggleRendering