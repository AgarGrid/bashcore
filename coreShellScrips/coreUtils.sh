

unmountFolder(){
    targetMountFile="$FILE_SYSTEM_MOUNT_DIR/$1"
    echo $LOCAL_ROOT_PASS | sudo -S umount -f $targetMountFile
}

mountFolder(){
    log "Mounting folder"

    targetMountFile="$FILE_SYSTEM_MOUNT_DIR/$1"
    createDirIfNotExcist $targetMountFile

    echo $LOCAL_ROOT_PASS | sudo -S mount -t cifs -o rw,user=$AGAR_PUBLIC_USER,password=$AGAR_PUBLIC_PASS,uid=$(id -u),gid=$(id -g),forceuid,forcegid, $PATH_TO_AGAR_PUBLIC$1 $targetMountFile


  ##echo Beerwoman7daa! | sudo -S  mount -t cifs -o rw,user=admin,password=AwT0W2wiKFwc,uid=$(id -u),gid=$(id -g),forceuid,forcegid, //192.168.1.26/public/media ./agarFileMount/test/
}

isPackageInstalled(){

    if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        echo "false" 
    else
        echo "true"
    fi
}

getHostProjectFolderName(){
    echo $HOST_FOLDER_PREFIX$(getHostName)
}


log(){
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    output_string="$dt $(getHostName) ${0##*/} --> $@"
    log_to_file $output_string
    echo -e "${Green}$output_string ${Color_Off}"
}

log_error(){
    dt=$(date '+%d/%m/%Y %H:%M:%S');
    output_string="$dt $(getHostName) ERROR -  ${0##*/} --> $@"
    log_to_file $output_string 
    echo -e "${Red}$output_string ${Color_Off}"
}

log_to_file(){
    echo "not implemented"
    ##echo "$@" >> $LOG_FILE_LOCATION
}

clear_log_file(){
    echo "not implemented"
    ##echo "" > $LOG_FILE_LOCATION
}

getHostName(){
    echo $(uname -n)
}

doesDirExists(){
    if [ -d $@ ] 
    then
        echo "true" 
    else
        echo "false"
    fi
}

checkSystemRequirements(){
    log "Checking file system requirements"

    for i in "${SYSTEM_DEPENDENCIES[@]}"
    do
        isOnSystem=$(isPackageInstalled $i)

        if [ "$isOnSystem" = true ] ; 
        then
            log "Package $i IS installed" 
        else
            log_error "Package $i NOT INSTALLED - Exiting"
            exit 1
        fi
    done
}

createDirIfNotExcist(){
    targetDirExist=$(doesDirExists $1)

    if [ "$targetDirExist" = false ] ; then
        log 'Creating folder '$1
        mkdir -p $1
    fi
}




# returnToMain(){
# 	./core/coreScript.sh;
# }

# restartApp(){
# 	./shellos.sh;
# }

# getIsConnectedToInternet(){
# 	if [[ $(ping -c1 google.com) ]]
# 	then 
# 	    echo "You are connected to the intertubes!"
# 	    return 0;
# 	else
# 	    echo "No interwebs!!"
# 	    return 1;
# 	fi
# }

# updateApp(){
# 	echo "Updateing from github"
# 	git pull;
# 	git checkout develop
# }

# updateInstanceFiles(){	
# 	rm -rf ./$INSTANCE_FOLDER_NAME
# 	git clone $INSTACE_REPO ./$INSTANCE_FOLDER_NAME
# 	cd $INSTANCE_FOLDER_NAME
# 	git checkout $INSTANCE_BRANCH
# 	cd ..
# }

# figOut(){
# 	figlet ${@}
# }

# getDateString(){
# 	echo $(date +"%H : %M : %S")
# }

# getSeconds(){
# 	echo $(date +"%S")
# }

# getMinutes(){
# 	echo $(date +"%M")
# }

# getHours(){
# 	echo $(date +"%H")
# }

# playGif(){
# 	playMedia $1 $2
# }

# playYouTube(){
# 	VIDEO_CODE=$1

# 	if isPreCached $VIDEO_CODE; then 
# 		echo "precashed"
# 	else
# 		echo "not precached"

# 		preCacheYouTube $VIDEO_CODE
# 	fi
# 	sendToMplayer ./precache/$1
# }

# playMedia(){

# 	##precache
# 	FULL_URL=$1
# 	FILE_NAME=${FULL_URL##*/}
# 	NO_PRECACHE=$2

# 	if $NO_PRECACHE; then
# 		sendToMplayer $FULL_URL
# 	else
# 		if isPreCached $FILE_NAME; then 
# 			echo "precashed"
# 		else
# 			preCacheFile $FILE_NAME $FULL_URL
# 		fi
		
# 		sendToMplayer ./precache/$FILE_NAME
# 	fi
# }

# sendToMplayer(){

# 	mplayer $1 -fs -zoom
# }

# isPreCached(){

# 	PRE_CACHE_FILE="./precache/"$1

# 	if [ -f "$PRE_CACHE_FILE" ]; then
# 	    echo "File already on system"
# 	    return 0;
# 	else
# 	    echo "Not Precached"
# 	    return 1;
# 	fi
# }

# preCacheFile(){
# 	## do we have a precachefolder
# 	if [ ! -d "./precache" ]; then
# 		mkdir precache;   
# 	fi

# 	echo "PreCaching "$1" from "$2

# 	wget -O ./precache/$1 $2;
# }

# preCacheYouTube(){
# 	echo "preCacheYouTube-->http://www.youtube.com/watch?v="$1
# 	## do we have a precachefolder
# 	if [ ! -d "./precache" ]; then
# 		mkdir precache;   
# 	fi

	

# 	echo "PreCaching YouTube "$1
# 	##youtube-dl -f worst -o ./precache/$1 "http://www.youtube.com/watch?v="$1
# 	youtube-dl -f 17 -o ./precache/$1 "http://www.youtube.com/watch?v="$1
# }



# dictionaryUtil_getRandomWordFromFile(){
# 	SOURCE_FILE=$1
#  	echo $(awk NR==$((${RANDOM} % `wc -l < $SOURCE_FILE` + 1)) $SOURCE_FILE)
# }

# ###### you tube stuff
# youtubeUtil_youtubeVideoSearchResultsToFile(){
# 	SEARCH_TERM=$1
# 	FILE_PATH="./precache/youtubeSearchList.txt"

# 	##clear old output
# 	rm $FILE_PATH

# 	YOUTUBE_SEARCH_RESULT=$(youtubeUtil_returnRawYoutubeSearch $SEARCH_TERM)

# 	IFS=\"
# 	set -- $YOUTUBE_SEARCH_RESULT
# 	for i; do youtubeUtil_filterForValidResultsAndOutPut $i ; done
# }

# youtubeUtil_filterForValidResultsAndOutPut(){

# 	##echo $UNFILTERED_LINE	

# 	UNFILTERED_LINE=$1


# 	MATCH_STRING="watch?v="

# 	REMOVE_PREFIX="href=\"\/watch?v=";
# 	REMOVE_SUFFIX="\"";


# 	if [[ $UNFILTERED_LINE == *$MATCH_STRING* ]]
# 	then
# 		if [[ ${#UNFILTERED_LINE} == 20 ]]
# 		then
# 		##	echo $UNFILTERED_LINE

# 			##echo $UNFILTERED_LINE | sed -r 's/^.{5}//' >> "./precache/youtubeSearchList.txt"
# 			echo ${UNFILTERED_LINE:9} >> "./precache/youtubeSearchList.txt"

# 		fi
# 	fi
# }

# youtubeUtil_returnRawYoutubeSearch(){

	
# 	##RAND_PAGE=getRandomNumber 1 10
	
	
# 	##RESULT="`wget -qO- http://www.youtube.com/results?search_query=$1&page=$RAND_PAGE`"
	
# 	RESULT="`wget -qO- http://www.youtube.com/results?search_query=$1`"
# 	echo $RESULT
# }

# clearPrecacheFile(){
# 	rm -rf ./precache/
# }

##getRandomNumber(){
##	MIN=$1;
##	MAX=$2;
##	
##	echo $(( ( RANDOM % $MAX )  + $MIN ));
##}

