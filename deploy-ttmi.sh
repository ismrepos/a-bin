#!/bin/sh

SERVER=ura1
USER=tdev
TTMI_DIR=/home/$USER/Projects/
TTMI_HOME=ttmi
TAR_FILE=hoge.tar.gz
TMP_DIR=/home/$USER/tmp
DEPLOY_HOME=~/
echo Deoloying TTMI Project from $SERVER

echo Packing TTMI Project
cat << EOF > /tmp/CMD.txt
cd $TTMI_DIR
tar zcvf $TMP_DIR/$TAR_FILE -X $TTMI_HOME/.tarignore $TTMI_HOME
EOF
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

echo Unpacking TTMI Project
tar zxvf ./$TAR_FILE -C $DEPLOY_HOME
rm ./$TAR_FILE
