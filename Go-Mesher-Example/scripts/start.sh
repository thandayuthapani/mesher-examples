#!/usr/bin/env bash

run_client(){
if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/asifdxtreme/mesher-examples/Go-Mesher-Example/client

cp -r bin/client $1/Go-Mesher-Example/client/

cd $1/Go-Mesher-Example/client/


./client > client.log 2>&1 &

}

run_server(){
if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/asifdxtreme/mesher-examples/Go-Mesher-Example/server

cp -r bin/server $1/Go-Mesher-Example/server/

cd $1/Go-Mesher-Example/server/

./server > server.log 2>&1 &

}

run_mesher_consumer(){

if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi
if [ $2 == "" ]; then
    echo "SERVICE_CENTER_ADDR variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get -v github.com/go-chassis/mesher

cp -r bin/mesher $1/Go-Mesher-Example/mesher/mesher-consumer/

cd $1/Go-Mesher-Example/mesher/mesher-consumer/

export CSE_REGISTRY_ADDR=$2

./mesher > mesher-consumer.log 2>&1 &

}

run_mesher_provider(){


if [ $1 == "" ]; then
    echo "WORKSPACE variable in not passed.....aborting....."
    exit 1
fi
if [ $2 == "" ]; then
    echo "SERVICE_CENTER_ADDR variable in not passed.....aborting....."
    exit 1
fi

if [ $3 == "" ]; then
    echo "SERVICE_NAME variable in not passed.....aborting....."
    exit 1
fi

cd $1
mkdir -p tmp
cd tmp
export GOPATH=$1/tmp

go get github.com/go-chassis/mesher

cp -r bin/mesher $1/Go-Mesher-Example/mesher/mesher-provider/

cd $1/Go-Mesher-Example/mesher/mesher-provider/

export CSE_REGISTRY_ADDR=$2
export SERVICE_NAME=$3

./mesher > mesher-provider.log 2>&1 &

}

#COMPONENT
echo $1
echo $2
echo $3
# Get the Command
case $1 in
    client )
        run_client $2 ;;

    server )
        run_server $2;;

    mesher-consumer )
        run_mesher_consumer $2 $3;;

    mesher-provider )
        run_mesher_provider $2 $3 $4;;

esac
