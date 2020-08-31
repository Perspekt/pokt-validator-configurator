#!/usr/bin/bash
 
# ========================================
function loadExternalValidators {
     eVALS=(
        "b42d316cd32dea7b4c302b92a92a082ea8940999,01,node1"
        "cd7afcb827179d9d295d92252e091f979461440c,02,node2"
        "5307ae841ce3002505a61cfa57470f3806597d3b,03,node4"
        "56870cf8331229c762a9e9c40fe7e22c34574d71,04,node5"
        "f227b7c293e3af6bef18e9dbdcbc94f501c7cf14,05,node6"
        "b80417427c269a36696334ee14ca24f8a56fecfb,06,node7"
        "c391832c9a74acf0ac8b83003e4bd4b30c980628,07,node8"
)
}
# =========================================
function setColorConstants {
      GRN='\033[1;32m'
      RED='\033[0;31m'
      CYA='\033[1;36m'
      NC='\033[0m' # No Color
      BLI='\033[5m' # Blink

}
# =========================================
function setDrawingConstants {
      BON='\033(0'
      BOF='\033(B'
       DASH="qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
       DASH3="qqqqqqqqqqqqqqqqqqqqqqqqqqqqqwqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqwqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
       SPACE="                                                                                                       "
      THIRDS="                             x                                      x                                   "
}
# =========================================
function setCursorConstants {
      CCD='\033[2J'   # Cursor Clear Down
      CCR='\033[0K'   # Cursor clear Right
      CGH='\033[1;1H' # Cursor Go Home
      CGT='\033['     # Cursor Go TO  x,H
}

# =========================================
function initWindow {
	$(resize -s 40 100 >/dev/null )  # dev/null to supress error if x-term not installed
       echo -e ${CGH}${CCD}          # send the cursor home and clear the screen
#      echo -e "\033[?3l" #set 80 cols?  no apparent effect.
}
# ===========================================
function setGlobalVars {
LastHeight="0"
lscreen=(
	"STA,C,4,3,20,1,CurSTA,Status: "
	"VAL,C,7,3,63,1,CurVAL,Validator address: "
        "BAL,N,8,3,37,1,CurBAL,Validator ballance: "	
	"RUN,N,4,25,20,1,CurRUN,(PID): "
	"DOM,C,3,3,41,1,CurDOM,Domain: "
	"HEI,N,4,69,20,1,CurHEI,Height: "
	"FIR,C,3,65,24,1,CurFIR,UFW Status: "
	"NGI,C,3,42,23,1,CurNGI,Nginx Status: "
	"NET,C,4,47,20,1,CurNET,ChainID: "
	"NOD,B,7,65,20,1,CurNOD,Jailed: "
	"CLA,AD,12,71,6,16,CurCLA,"
	"CLB,AD,12,77,11,16,CurCLB,- "
	"STK,C,8,65,20,1,CurSTK,Staked: "
	"24B,N,8,38,24,1,Cur24B,24h Chg: "
	"VVV,AS,12,2,25,16,eVALS,"
	"NUM,N,5,43,20,1,CurNUM,Staked Vals: "
	"NUM,N,5,64,20,1,CurAPP,Staked Apps: "
	"TIM,TS,5,3,30,1,CurTIM,Next Block in: "
	"CHJ,AD,12,31,7,16,CurCHJ,"
	"CHU,AD,12,37,27,16,CurCHU,= "
        )
lscreentext=(
	"0,1,ROKT v0.7.b - Ben@BenVan.com 2020/08/29 - Free and Open Source... enjoy!"
	"10,4,External Validators "
	"10,40,chains.json "
	"11,31,Chain =  URL"
	"10,73,Pending Claims "
	"11,72,Chain-   Proofs "
	'11,3,"EEE" to activate'
        )

}
# ========================================
function drawlmenuframe {
echo -e "${BON}l${DASH:1:90}k${BOF}"
echo -e "\x1b(0x${SPACE:1:90}x\x1b(B"
echo -e "\x1b(0x${SPACE:1:90}x\x1b(B"
echo -e "\x1b(0x${SPACE:1:90}x\x1b(B"
echo -e "\x1b(0t${DASH:1:90}u\x1b(B"
for i in {1..3}
do
echo -e "\x1b(0x${SPACE:1:90}x\x1b(B"
done
echo -e "\x1b(0t${DASH3:1:90}u\x1b(B"
echo -e "\x1b(0x${THIRDS:1:90}x\x1b(B"
for i in {1..25}
do
echo -e "\x1b(0x${THIRDS:1:90}x\x1b(B"
done
echo -e "\x1b(0m${DASH:1:90}j\x1b(B"

}
function drawlmenutext {
  for item in "${lscreentext[@]}"
  do
     readarray -td, a <<<"$item,"; unset 'a[-1]';
     posR="${a[0]}";
     posC="${a[1]}";
     disc="${a[2]}";
     line="${CGT}${posR};${posC}H $disc"
     echo -e "$line"
  done

}
# ==========================================
function createMenuStrings {
    tmenu="static"
    Nmenu=" aint got this menu yet"
    Lmenu=""
    Fmenu=" \e[7m  ================ Ben Van's Node Manager (BVM v0.3) 2020-08-21 ==================== \e[0m
  DIS - show ${CYA}dis${NC}k space                   \e[7m \e[0m    FRE - show ${CYA}fre${NC}e memory 
  RUN - Is Pocket ${CYA}run${NC}ning?                \e[7m \e[0m    STA - ${CYA}sta${NC}rt Pocket 
  SIM - start Pocket with ${CYA}sim${NC}ulateRelay   \e[7m \e[0m    AUT - start Pocket with ${CYA}aut${NC}o Restart
  STO - ${CYA}Sto${NC}p Pocket                       \e[7m \e[0m    CHA - edit ${CYA}cha${NC}ins.json
  HEI - Pocket qery ${CYA}hei${NC}ght                \e[7m \e[0m    CON - edit ${CYA}con${NC}fig.json
  SEE - show ${CYA}see${NC}ds in use                 \e[7m \e[0m    VAL - show ${CYA}val${NC}idator address
  LIS - show ${CYA}lis${NC}t of accounts             \e[7m \e[0m    NOD - show ${CYA}nod${NC}e status
  FIR - show ${CYA}fir${NC}ewall status              \e[7m \e[0m    NGI - show ${CYA}ngi${NC}nx status
  001 -${RED}[to do]${NC} direct test chain (0${CYA}001${NC})   \e[7m \e[0m    DOM - Show ${CYA}dom${NC}ain 
  002 -${RED}[to do]${NC} direct test chain (0${CYA}021${NC})   \e[7m \e[0m    111,222 - change ${CYA}men${NC}us
  TEC -${RED}[to do]${NC} make ${CYA}tec${NC}h support file     \e[7m \e[0m    CLA - show pending ${CYA}cla${NC}ims
  SAU -${RED}[to do]${NC} Better Call ${CYA}Sau${NC}l           \e[7m \e[0m    BAL - ${CYA}bal${NC}ance @Val address
                                          \e[7m \e[0m    NUM - ${CYA}num${NC}ber of Validators on net
                                          \e[7m \e[0m
   X  - e${CYA}x${NC}it program                      \e[7m \e[0m"
   Cmenu=$Fmenu # set inital current menu to full menu
}
# ========================================================================
function showTime  {
    num=$1
    min=0
    hour=0
    day=0
    if ((num>59));then
        ((sec=num%60))
        ((num=num/60))
        if ((num>59));then
            ((min=num%60))
            ((num=num/60))
            if ((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi
    if ((sec<10));then
        sec="0$sec"
    fi
    timeOut="${min}:${sec}"
}
# ========================================================================
# ==    All the case calls are being turned into functions and put here ==
#=========================================================================
function fRun {
	CurRUN=$(ps -C pocket | grep "pocket")
  	CurRUN="${CurRUN:0:7}"
  	if [ "$CurRUN" != "" ]
  	then 
		CurSTA="${GRN}Running"
  	else 
		CurSTA="${RED}Not Running"
  	fi
        if [ "$localVAL" == "external" ]; 
	then
        	CurRUN="        "
		CurSTA="        "
        fi
}
function fSta {
  	$(pocket start >/dev/null &)
  	fRun
  	CurSTA="Launched into Background"
        if [ "$localVAL" == "external" ]; 
	then
           CurSTA="        "
        fi

}
function fVal {
    	if [ "$localVAL" != "external" ]
    	then	    
    		CurVAL=$(pocket accounts get-validator | grep 'Validator')
    		CurVAL=${CurVAL:18:999}
    	fi
}
function fDom {
         CurDOM=$(pocket query node $CurVAL | grep "service_url")
	 CurDOM=${CurDOM:28:-2}
}
function fHei { 
	CurHEI=$(pocket query height | grep 'height"')
	CurHEI=${CurHEI:14}
}
function fBal {
	  CurBAL=$(pocket query balance $CurVAL | grep 'balance"')
  	CurBAL="${CurBAL:14}"
  	if [ $CurHEI>96 ]
  	then
  		Cur24B="$(($CurHEI - 96))"
  		Cur24B=$(pocket query balance $CurVAL $Cur24B | grep 'balance"')
  		Cur24B="${Cur24B:14}"
  		let "Cur24B = $CurBAL - $Cur24B"
  	fi
}
function fFir {
	if [[ $EUID = 0 ]] 
	then
		CurFIR=$(sudo ufw status | grep 'Status:')
		CurFIR=${CurFIR:8} 
        else
		CurFIR="Need SUDO"
	fi
        if [ "$localVAL" == "external" ]; 
	then
           	CurFIR="        "
        fi

}
function fNgi {
	CurNGI=$(service nginx status | grep "Active:")
	CurNGI=${CurNGI:13:7}
        if [ "$localVAL" == "external" ]; 
	then
           CurNGI="        "
        fi


}
function fNet {
	whatNET=$(cat .pocket/config/config.json | grep "Seeds")
	whatNET=${whatNET:22:5}
	case "$whatNET" in
		03b74 )	 CurNET="mainnet";;
		b3d86 )  CurNET="testnet";;
		* ) CurNET="Unknown"
	esac
        if [ "$localVAL" == "external" ]; 
	then
           CurNET="        "
        fi


}
function fNod {
        CurNOD=$(pocket query node $CurVAL | grep "jailed")
	CurNOD=${CurNOD:14:5}
	if [ "${CurNOD:0:4}" == "true" ]
	then
		CurNOD="${RED}$CurNOD"
	else
		CurNOD="${GRN}$CurNOD"
	fi
}
function fCla {
	CurCLAc=($(pocket query node-claims $CurVAL | grep -Po '((?<=chain":.)|(?<=chain":."))([^",\r\n]+)(?=[",\r\n]*)'))
	CurCLAp=($(pocket query node-claims $CurVAL | grep -Po '((?<=total_proofs":.)|(?<=total_proofs":."))([^",\r\n]+)(?=[",\r\n]*)'))
        if [ "$CurCLAc[0]" == "" ]
	then
	     	CurCLA="none"
	     	CurCLB="none"
	else
		CurCLA=("${CurCLAc[@]}")
		CurCLB=("${CurCLAp[@]}")	       	
	fi	
}
function fStk {
	CurSTK=$(pocket query node $CurVAL | grep "status")
        CurSTK=${CurSTK:14:-1}
	case $CurSTK in
		1 ) CurSTK="Unstaking";;
	        2 ) CurSTK="${GRN}true";;
	        * ) CurSTK="${RED}false";;
	esac 

}
function fVvv {
	CurVVV=$eVALS
}
function fNum {
	CurNUM=$(pocket query nodes --staking-status=2 | grep -Poc "false")
}
function fApp {
	CurAPP=$(pocket query apps --staking-status=2 | grep -Poc "false")
}
function fTim { 
	CurTIM=$(( 903 - $SECONDS ))
}
function fChj {
        CurCHJ=($(cat .pocket/config/chains.json | grep -Po '((?<=id":.)|(?<=id":."))([^",\r\n]+)(?=[",\r\n]*)')) 
        CurCHU=($(cat .pocket/config/chains.json | grep -Po '((?<=url":.)|(?<=url":."))([^",\r\n]+)(?=[",\r\n]*)'))
	if [ "$locaVAL" == "external" ]; then
		unset CurCHJ
		unset CurCHU
	fi
}
function fEee {
    	valChoice=""
	#    #draw the current menu
    	echo -e -n "${CGT}11;3H${GRN}(##) Choose:        ${NC}${CGT}11;14H "
    	read -n2 valChoice  
    	valChoice=${valChoice^^}
    	valChoice=${valChoice:0:2}
    	localVAL="local"
    	for item in "${eVALS[@]}"
    	do
      		readarray -td, a <<<"$item,"; unset 'a[-1]';
      		if [ "$valChoice" == "${a[1]}" ]
      		then
	     		CurVAL="${a[0]}"
             		localVAL="external"
      		fi
    	done
    	echo -e -n "${CGT}11;3H  [EEE] to activate       "
}

# ========================================================================
function loadStatusValues {

    fHei
    fVal
    fBal
    fDom
    fFir
    fNgi
    fNet
    fNod
    fCla
    fStk
    fVvv
    fNum
    fApp
    fTim
    fChj
    fRun
}
# ======================================
function setTheBlockTime {
     #  1598718275
     checkpointtime=1598718275
     currenttime=$(date +%s)
     secondsremaining=$(( $currenttime - $checkpointtime ))
     remainingtime=$(( $secondsremaining % 903))
     SECONDS=$remainingtime
}
# =======================================================================
function showlmenu {
  b=$1; c=$2; d=$3;
  for item in "${lscreen[@]}"
  do
     readarray -td, a <<<"$item,"; unset 'a[-1]';
#    declare -p a;
     name="${a[0]}";
     vtype="${a[1]}";
     posR="${a[2]}";
     posC="${a[3]}";
     size="${a[4]}";
     depth="${a[5]}";
     Cur="${a[6]}";
     disc="${a[7]}";
     line="${CGT}${posR};${posC}H $disc"
     if [ "$b" == "$name" ] || [ "$c" == "all" ]
     then
        case "$vtype" in
	AS ) # ====== ===== ===== array sublist ==== ===== ==== ====== ==== === ====
		
	  j="$posR"
          k='{'"$Cur"'[@]}'
          eval y='$'$k
	  for i in $y
          do
	    line="${CGT}${j};${posC}H $disc"	  
            readarray -td, v <<<"$i,"; unset 'a[-1]';
	    eVadd="${v[0]}";
            eVnic="${v[1]}";
            eVnod="${v[2]}";
	    line+="$eVnic $eVnod - ${eVadd:0:6}...]";
	    echo -e "$line"
	    j=$((j+1))
          done
	  

	;;
        AD ) # ====== ===== ===== Array Down ==== ===== ==== ====== ==== === ====
          j="$posR"
	  m=$((j+depth)) 
          k='{'"$Cur"'[@]}'
          eval y='$'$k
          for i in $y
          do
               line="${CGT}${j};${posC}H $disc"
               line+=" $i"
               filler=$(($size - ( ${#disc} + ${#i} ) ))
               while [ $filler -gt 0 ]
               do
                 line+=" "
                 filler=$[$filler-1]
               done
               echo -e "$line"
               j=$((j+1))
          done
          line="${CGT}${j};${posC}H${BON}${DASH:1:$size}${BOF}"
          echo -e $line
	  j=$((j+1))
	  while [ $j -lt $m ]
	  do
		  line="${CGT}${j};${posC}H${BON}${SPACE:1:$size}${BOF}"
#                  line="${CGT}${j};${posC}H - - -"

		  echo -e "$line"
		  j=$((j+1))
	  done
#	  line="${CGT}${j};${posC}H${BON}${DASH:1:$size}${BOF}"
#	  echo -e $line
	;;
  	TS ) # ===== ===== ===== ===== Time in Seconds ==== ====
          tCur=${!Cur}
     	  showTime $tCur
          line+="${CYA}$timeOut${NC}"
          filler=$(($size - ( ${#disc} + ${#timeOut} ) ))
          while [ $filler -gt 0 ] 
          do
                line+=" "
                filler=$[$filler-1]
          done
          echo -e "$line"
        ;;
	* )  # ====== ===== ===== all other types==== ===== ==== ====== ==== === ====
          line+="${CYA}${!Cur}${NC}"
	  tCur=${!Cur}
	  filler=$(($size - ( ${#disc} + ${#tCur} ) ))
          while [ $filler -gt 0 ] 
	  do 
		line+=" " 
	        filler=$[$filler-1]
	  done	
	  echo -e "$line"
	  ;;
        esac
     fi
  done
}

# ========================================================================
function main {
   selection=
until [ "$selection" == "X" ]; do
    echo -e "${CGH}$Cmenu"    #draw the current menu
    echo -e -n "${CGT}23;3H${GRN}(111=menu) $CurDOM selection:${NC} "   #draw the prompt
    read -n3 -t10 selection                                            #get the choice
    selection=${selection^^}    #uppercase the choice
    selection=${selection:0:3}
#    echo $selection
    if [ "$tmenu" == "static" ]
    then
    echo -e "${CCD}"                                          #remove previous results
    fi
    case $selection in
	APP ) echo -e "${CYA}$CurAPP${NC}"
              showlmenu APP one
	;;
        DIS ) df
	;;
        FRE ) free 
	;;
        RUN ) fRun ; echo -e "${CYA}$CurRUN${NC}"
	;;
        STA ) fSta ; echo -e "${CYA}$CurSTA${NC}"
	;;
	SIM ) $(pocket start --simulateRelay >/dev/null &)
	        echo -e "${CYA}pocket simuateRelay started in background${NC}"
	;;
	AUT ) until $(pocket start >/dev/null &); do
		outcode = $?
		if [$outcode != 0]
		then
		    echo "process crashed with exit code: $outcode.  Respawning.." >&2
		    outcode = 0
		else
		    echo "else clause executed code: $outcode."
		    outcode = 0
		    break
		fi
		done
        ;;
	STO ) pkill "pocket"  # should find a safer way to kill this!!
	;;
	HEI ) fHei
		echo -e "${CYA}$CurHEI${NC}"
		showlmenu HEI one
	;;
	SEE ) CMD=${CYA}$(cat .pocket/config/config.json | grep "Seeds")${NC}
		 echo -e "$CMD"
	;;
	CHA )   vi .pocket/config/chains.json
	;;
        CON )   vi .pocket/config/config.json
	;;
        VAL ) fVal
		 echo -e ${CYA}$CurVAL${NC}
		 showlmenu VAL one
	;;
        LIS ) CMD=${CYA}$(pocket accounts list)${NC}
		 echo -e "$CMD"
	;;
        BAL ) fBal
		 echo -e ${CYA}$CurBAL${NC}
		 showlmenu BAL one
	;;
        CLA ) fCla
                 echo -e "$CurCLA"
		 showlmenu CLA one
		 showlmenu CLB one
        ;;
        FIR )  fFir 
		  echo -e "${CYA}$CurFIR${NC}"
		  showlmenu FIR one
	;;
	STK )  fStk
       		  echo -e "${CYA}$CurSTK${NC}"
		  showlmenu STK one
	;;
        NGI )  fNgi
		  echo -e "${CYA}$CurNGI${NC}"
		  showlmenu NGI one
	;;
        111 )     Cmenu=$Fmenu;tmenu="static"
        ;;
	222 )     Cmenu="";    tmenu="live"; echo -e ${CGH}${CCD};
	          drawlmenuframe
		  drawlmenutext
	          showlmenu nothing all
	;;
	NOD )  fNod
	          echo -e "${CYA}$CurNOD${NC}"
	          showlmenu NOD one
	;;
	NUM )  fNum
		  echo -e "${CYA}$CurNUM${NC}"
		  showlmenu NOD one
	;;
	DOM )  fVal
	       fDom
		   echo -e ${CYA}$CurDOM${NC}
		   showlmenu DOM one
	;;
        NET )  fNet
		   echo -e ${CYA}$CurNET${NC}
                   showlmenu NET one
	;;
        EEE )  fEee
		   loadStatusValues
		   showlmenu nothing all
	;;
	LLL )      localVAL="local"
		   echo -e -n "${CGT}11;3H  [XVA] to activate       "
		   loadStatusValues
		   showlmenu nothing all
	;;
        X )   exit 
	;;
        * )   # echo "selected: $selection:"
	      # echo "tmenu: $tmenu:"
	      if [ "$selection" == "" ] && [ "$tmenu" == "live" ]
	      then
		   fHei;
		   fTim;
		   showlmenu TIM one
                   #echo "CurHEI: $CurHEI:"
		   #echo "LastHieght: $LastHeight"
		   if [ "$CurHEI" != "$LastHeight" ]
		   then
			if [ $LastHeight = 0 ]
			then
			    LastHeight="$CurHEI"
                            SECONDS=$remainingtime
		        else
                            SECONDS=0
			fi
			LastHeight="$CurHEI"
			loadStatusValues
	                showlmenu nothing all  
		   fi
	      else
		   echo "Unrecognized Menu Choice"
	      fi
	;;
    esac
done
}
    setColorConstants
    setDrawingConstants
    setCursorConstants
    setGlobalVars
    setTheBlockTime
    loadExternalValidators
    loadStatusValues
    createMenuStrings
    initWindow
    if [ "$CurSTA" == "Not Running" ]
    then 
	echo "============== Warning: Pocket is not currently running ========"
	echo ""
        echo "That is OK...     UNLESS...  you have a custom data directory"
        echo ""
	echo "If your set-up uses a custom data directory..."
	echo ""
	echo " STOP THIS PROCESS NOW   < CONTROL > C "
	echo ""
	echo " and start Pocket from the command line with the --DataDirectory option"
	echo ""
	echo " and DO NOT USE the start, start-simulated or auto-restart features of this script!!"
	echo ""
        echo ""
        echo "Continue (y/N):"	
        read -n1 yn
        yn=${yn^^}
        if [ "$yn" != "Y" ]	
	then
		exit
	fi
    fi
    main
