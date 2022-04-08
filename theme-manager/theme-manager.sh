#!/bin/sh
## T-ui Theme Manager
## Author  	: Ema (with the help of Arun and ĐɆ₳ĐⱤ₳฿฿ł₮; thank u guys)
## Github  	: @M4dGun
## Telegram : @UnderTheGun1
## T-ui group: https://t.me/tuilauncher
##
## #####  #  #  #####"
##   #    #  #    #
##   #    #  #    #   
##   #    ####  #####
##
######
PROGNAME=ttm
FILENAME=theme-manager.sh

## DIRECTORY
tui=/storage/emulated/0/t-ui
sd=/storage/emulated/0
sdt=/storage/emulated/0/tui-themes_and_backup
# timestamp=$(date +%Y%m%d%H%M)

BACKUP="$sdt/tui-backup.tar"
ALIASTXT="$tui/alias.txt"
SCRIPTDIR="$TUIDIR/script"
SCRIPT="ttm"

## LINKS
REMOTEHOST="https://github.com/M4dGun/t-ui_themes/raw/main"
THEMES="https://github.com/M4dGun/t-ui_themes/raw/main/database"
THEMES_LIST=("dracula_v1.zip" "Dracula_v2.zip" "NetHunter_v1.zip" "NetHunter_v2.zip" "grid.zip" "wallx.zip" "tomboy.zip")
SCRIPT_LINK="https://raw.githubusercontent.com/M4dGun/t-ui_themes/main/theme-manager/theme-manager.sh"

## THEMES
theme_1=Dracula_v1
theme_2=Dracula_v2
theme_3=NetHunter_v1
theme_4=NetHunter_v2
theme_5=Grid
theme_6=WallX
theme_7=Tomboy_Girl
theme_8=ff


print_header () {
	echo " T-ui Theme Manager"
	printf "\n  \n"
	printf "\n #####  #####   ##   ##"
    printf "\n   #      #     # # # #"
    printf "\n   #      #     #  #  #"
    printf "\n   #      #     #     #\n"
    printf "\n  \n"
}


show_help(){

	padding=-14
	print_header
	printf "%s\n" \
	    " USAGE: $PROGNAME [-h, --help]   [-v, --version]"\
        "            [-l, --list]   [-p, --preview]"\
        "            [-u, --update] [1 or 2 or 3...]"\
        "            [-b, --backup] [-r, --restore]"
		
    printf " \n"
    printf "  %${padding}s %s\n" \
	    "1 or 2 or 3..." "Install theme n.1 (or 2 or 3 etc)" \
        "-u, --update" "Update ttm script" \
        "-l, --list" "Show available themes" \
        "-p, --preview" "Screenshots of available themes" \
        "-b, --backup" "Backup current theme (tar format)" \
        "-r, --restore" "Restore previous saved theme" \
        "-h, --help" "Print this help message" \
        "-v, --version" "Print ttm script version"
        
	printf " \n"
	printf "  %${padding}s %s\n" \
        "Note: Update ttm to get the latest list" \
        "" "      of available themes"
	exit 1
}


show_theme(){

	echo " T-ui Theme Manager"
	padding=-16
	printf " \n"
	printf "%s\n" \
	    " -------------------------------- "\
        "         THEMES AVAILABLE         "
    printf " \n"
    printf "  %${padding}s %s\n" \
	    "1.$theme_1" \
		"2.$theme_2" \
		"3.$theme_3" \
		"4.$theme_4" \
		"5.$theme_5" \
		"6.$theme_6" \
		"7.$theme_7" 

	printf "%s\n \n " \
	    " -------------------------------- "
	    
	printf "%s\n " \
		":: To download a theme type: ttm number" \
		"   Example: ttm 2 [to download Dracula_v2] "
		
    printf " \n"
	printf "%s\n " \
		" :: Type ttm -p to see previews (via GitHub) "

    exit 1
}

update_ttm(){
	echo " T-ui Theme Manager"
	printf "\n  \n"
	printf "\n :: Updating ttm script...\n \n" ; sleep 1.5

	if [[(-f /bin/curl )]]; then 
		cd $tui && curl -L $SCRIPT_LINK -o $tui/$FILENAME
    elif [[(-f /bin/wget)]]; then
		cd $tui && wget -c $SCRIPT_LINK
    else cd $tui && termux curl -L $SCRIPT_LINK -o $tui/$FILENAME
    fi

	if [ $? -ne '0' ]; then
	printf "\n \n :: Please run ttm script via Termux/TEL or another Terminal emulator: check ttm wiki for more info. \n " ; exit 1
	fi
	printf "\n \n :: Updating ttm script... \n " ; sleep 1.0

   rm $sd/$FILENAME
   cd $tui
   mv $FILENAME $sd/$FILENAME

#   if [ $? -ne '0' ]; then
#    printf ":: An error occurred...\n" \ ; exit 1
#	fi
    printf "\n :: ttm script updated! \n "
	printf "\n :: There's no need to restart t-ui! \n" ; exit 0
}
    
backup1(){
	print_header

	if [[ -d $sdt ]]; then
	echo " tui-themes_and_backup dir alredy exist " ;
	else
	mkdir $sdt &>/dev/null
	fi

	tar cf $sdt/tui-backup.tar $tui 	

	if [ $? -ne '0' ]; then 
    printf ":: An error occurred!\n" \ ; exit 1
	fi
    printf ":: Success! Backup completed.\n" ; exit 0

  
}

restore(){
	print_header

	# Restore previous theme
    if [ -f "$BACKUP" ]
    then
        echo " :: Restoring previous theme... Please wait..." ; sleep 1.0
		rm -r $tui &>/dev/null
        cd $sdt && tar -xvf tui-backup.tar #-C /opt/files
		cd $sdt/$sd && mv t-ui $sd
		rm -r $sdt/storage &>/dev/null
		printf " \n"
        echo " :: Done. Please restart t-ui."
    else
        echo " :: No previous backup found. Aborting..."
    fi
	
    exit $?
}

version(){
	echo " T-ui Theme Manager"
	printf " \n"
	echo " version 0.99 Beta"
	
	exit 1
}

  
install_theme(){
	print_header
	
	if [[ -d $sdt ]]; then
	echo " tui-themes dir alredy exist " ;
	else
	mkdir $sdt &>/dev/null
	fi

	printf "\n  \n :.: Please wait... " ; sleep 1.0


	## BACKUP CURRENT THEME
	tar cf $sdt/tui-backup.tar $tui # &>/dev/null
	printf "\n \n :.: Backup completed \n" ; sleep 1.0
	printf "\n \n :.: Downloading theme... \n \n" ; sleep 1.5
		
	if [[(-f /bin/curl )]]; then 
	cd $sdt && curl -LJO "$THEMES/$CHOSEN_THEME"
    elif [[(-f /bin/wget)]]; then
    cd $sdt && wget -c "$THEMES/$CHOSEN_THEME"
    else cd $sdt && termux curl -LJO "$THEMES/$CHOSEN_THEME"
    fi
	
	if [ $? -ne '0' ]; then
	printf "\n \n :.: Please run ttm script via Termux/TEL or another Terminal emulator: check ttm wiki for more info. \n " ; exit 1
	fi
	printf "\n \n :.: Download completed. \n" ; sleep 1.5
	
	printf "\n \n :.: Installing...\n" ; sleep 1.0

	
	CHOSEN_THEME="${CHOSEN_THEME##*/}"
	rm -rf $tui/*.ttf $tui/*.otf
	unzip -o $CHOSEN_THEME -d $tui ; cd $tui/t-ui && cp -r * $tui  ;
	rm -rf $tui/t-ui

	# Test if ttm alias already exist ##thank you @deadrabbit404
	grep "^ttm" $ALIASTXT >/dev/null 2>&1
	if [ $? -ne 0 ]
	then
		# Test if the file has no EOL, then print a blank line.
		[ -n "`tail -c 1 $ALIASTXT`" ] && echo >> $ALIASTXT 
		echo "ttm =sh $sd/$FILENAME %" >> $ALIASTXT
		echo "ttm -p=search -u https://github.com/M4dGun/t-ui_themes" >> $ALIASTXT
		printf "\n "
		printf " :.: Added ttm alias in new alias.txt \n " ; sleep 1.5
	else
		# This means the alias already exists.
		# Replace whatever value assigned to the alias with a new one that points to the ttm script.
		sed -i "s#\(^ttm =\).*\$#\1sh $sd/$FILENAME %#" $ALIASTXT
#		sed -i "s#\(^ttm -p=\).*\$#\1search -u https://github.com/M4dGun/t-ui_themes#" $ALIASTXT
		printf "\n \n :: ttm alias already exists, nothing to change \n " ; sleep 1.5
	fi
	
	printf "\n ::: THEME INSTALLED ::: \n" ; sleep 2
	
	printf "\n \n :.: NOTE: \n"
	printf "\n :.: Check tui folder to use theme's wallpaper " ; sleep 1.0
	printf "\n :.: Type ttm -r to restore your previous theme " ; sleep 2

	printf "\n \n :.: Now type restart in t-ui. Cheers \n"
	
	exit 0
}


## [123456789]|10|11|12|13)
## index=$(($1-1))   CHOSEN_THEME="{THEME_LIST[$index]}"


case "$1" in

    [1234567])
	index=$(( $1 - 1))
	CHOSEN_THEME="${THEMES_LIST[$index]}"
        ;;
    -l|--list|%)
        show_theme
        ;;
    -u|--update)
        update_ttm
        ;;        
    -v|--version)
        version
        ;;
    -b|--backup)
        backup1
        ;;    
    -r|--restore)
        restore
        ;;            
    -h|--help)
		show_help
        ;;
    *)
        printf "Invalid option. Type 'ttm -h' to show help\n"
        exit 1
        ;;
esac

install_theme ## call the install function.
