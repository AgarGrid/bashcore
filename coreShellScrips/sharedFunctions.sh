getHostStackFolderPath(){
    HOST_FOLDER="./hosts/"
    HOST_STACK_FOLDER_PATH=$HOST_FOLDER$(getHostName)
    echo $HOST_STACK_FOLDER_PATH 
}