


workspaceExists(){
    if [ ! -z "$WORKSPACE_DIR" ]
    then
        targetDirExist=$(doesDirExists $WORKSPACE_DIR)

        echo $targetDirExist
    fi
}

