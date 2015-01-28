#!/bin/sh

SERVER=ura1
USER=tdev
TTMI_DIR=/home/$USER/Projects/
TTMI_HOME=ttmi
TAR_FILE=ttmi.tar.gz
TMP_DIR=/home/$USER/tmp
DEPLOY_HOME=~/
echo Deoloying TTMI Project from $SERVER

case $1 in
  csv)
    echo Packing CSV files
    cat << EOF > /tmp/CMD.txt
    cd $TTMI_DIR
    tar zcvf $TMP_DIR/$TAR_FILE --exclude .git* $TTMI_HOME/csv
    EOF
    ;;
  batch)
    echo Packing batch files
    ;;
  *)
    echo Packing TTMI Project
    cat << EOF > /tmp/CMD.txt
    cd $TTMI_DIR
    tar zcvf $TMP_DIR/$TAR_FILE -X $TTMI_HOME/.tarignore $TTMI_HOME
    EOF
  ;;

CMD=`cat /tmp/CMD.txt`
rm /tmp/CMD.txt
ssh $USER@$SERVER "$CMD"

echo Copy TTMI Project from $SERVER
scp $USER@$SERVER:$TMP_DIR/$TAR_FILE .

echo Delete $TAR_FILE from $SERVER
cat << EOF > /tmp/CMD.txt
rm $TMP_DIR/$TAR_FILE
EOF
CMD=`cat /tmp/CMD.txt`
rm /tmp/CMD.txt
ssh $USER@$SERVER "$CMD"

echo Unpacking
tar zxvf ./$TAR_FILE -C $DEPLOY_HOME
rm ./$TAR_FILE
