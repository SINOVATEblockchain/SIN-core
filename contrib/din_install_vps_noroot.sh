#!/bin/bash
TMP_FOLDER=$(mktemp -d)
CONFIG_FILE='sin.conf'
#read user
echo -e "Enter the username of the D.I.N. user (default: sinovate)"
read NODEUSER
if [ -z "$NODEUSER" ]; then
  NODEUSER="sinovate"
fi
## Change where files are located
CONFIGFOLDER="/home/$NODEUSER/.sin"
COIN_DAEMON="/home/$NODEUSER/sind"
COIN_CLI="/home/$NODEUSER/sin-cli"
##
COIN_REPO='https://github.com/SINOVATEblockchain/SIN-core/releases/latest/download/daemon.tar.gz'
COIN_NAME='sinovate'
COIN_PORT=20970
#RPC_PORT=18332


NODEIP=$(curl -s ifconfig.me)


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

function create_user() {
  if [ $(grep -c "^$NODEUSER:" /etc/passwd) == 0 ]; then
    echo -e "$GREEN User $NODEUSER doesn't exist, creating new user"
    useradd $NODEUSER
    passwd $NODEUSER
    mkhomedir_helper $NODEUSER
	adduser $NODEUSER sudo
	sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config
  fi
  clear
}

function create_swap() {
  #if there are less than 2GB of memory and no swap add 4gb of swap
  if (( $(free -m | awk '/^Mem:/{print $2}')<2000 )); then
    if [[ ! $(swapon --show) ]]; then
       fallocate -l 4G /swapfile
	   dd if=/dev/zero of=/swapfile bs=1M count=4096
       chmod 600 /swapfile
       mkswap /swapfile
       swapon /swapfile
       #create a backup of fstab just in case
       cp /etc/fstab /etc/fstab.sinbackup
       echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
    fi
  fi
}


function compile_node() {
  echo -e "Preparing to download $COIN_NAME"
  cd $TMP_FOLDER
  wget -q $COIN_REPO
  compile_error
  COIN_ZIP=$(echo $COIN_REPO | awk -F'/' '{print $NF}')
  tar xvzf $COIN_ZIP >/dev/null 2>&1
  compile_error
  cp sin* /home/$NODEUSER
  compile_error
  strip $COIN_DAEMON $COIN_CLI
  cd - >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  chown $NODEUSER:$NODEUSER $COIN_CLI
  chown $NODEUSER:$NODEUSER $COIN_DAEMON
  clear
}

function configure_systemd() {
  cat << EOF > /etc/systemd/system/$COIN_NAME.service
[Unit]
Description=$COIN_NAME service
After=network.target
[Service]
User=$NODEUSER
Group=$NODEUSER

Type=forking
#PIDFile=$CONFIGFOLDER/$COIN_NAME.pid

ExecStart=$COIN_DAEMON -daemon -conf=$CONFIGFOLDER/$CONFIG_FILE -datadir=$CONFIGFOLDER
ExecStop=-$COIN_CLI -conf=$CONFIGFOLDER/$CONFIG_FILE -datadir=$CONFIGFOLDER stop

Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  sleep 3
  systemctl start $COIN_NAME.service
  sleep 20
  runuser -l $NODEUSER -c "/home/$NODEUSER/sin-cli importprivkey $COINKEY"
  systemctl enable $COIN_NAME.service >/dev/null 2>&1

  if [[ -z "$(ps axo cmd:100 | egrep $COIN_DAEMON)" ]]; then
    echo -e "${RED}$COIN_NAME is not running${NC}, please investigate. You should start by running the following commands as root:"
    echo -e "${GREEN}systemctl start $COIN_NAME.service"
    echo -e "systemctl status $COIN_NAME.service"
    echo -e "less /var/log/syslog${NC}"
    exit 1
  fi
}


function create_config() {
  mkdir $CONFIGFOLDER >/dev/null 2>&1
  chown -R $NODEUSER:$NODEUSER $CONFIGFOLDER
  RPCUSER=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w10 | head -n1)
  RPCPASSWORD=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w22 | head -n1)
  cat << EOF > $CONFIGFOLDER/$CONFIG_FILE
debug=0
rpcuser=$RPCUSER
rpcpassword=$RPCPASSWORD
rpcallowip=127.0.0.1
listen=1
server=1
daemon=1
port=$COIN_PORT
logintimestamps=1
maxconnections=256
EOF
}

function create_key() {
  echo -e "${RED}$COIN_NAME DAEMON IS RUNNING FOR THE FIRST TIME. PLEASE WAIT !!!${NC}"
  $COIN_DAEMON -daemon
  sleep 30
  if [ -z "$(ps axo cmd:100 | grep $COIN_DAEMON)" ]; then
   echo -e "${RED}$COIN_NAME server couldn not start. Check /var/log/syslog for errors.{$NC}"
   exit 1
  fi
  KEYPAIR=$($COIN_CLI infinitynode keypair)
  PUBLICKEY=$(echo $KEYPAIR|grep PublicKey|cut -c 87-130)
  COINKEY=$(echo $KEYPAIR|grep PrivateKey|cut -c 18-69)
  DECODEPKEY=$(echo $KEYPAIR|grep DecodePublicKey|cut -c 154-193)
  ADDRESS=$(echo $KEYPAIR|grep Address|cut -c 209-242)
  if [ "$?" -gt "0" ];
    then
    echo -e "${RED}Wallet not fully loaded. Let us wait and try again to generate the Private Key${NC}"
    sleep 30
  KEYPAIR=$($COIN_CLI infinitynode keypair)
  PUBLICKEY=$(echo $KEYPAIR|grep PublicKey|cut -c 87-130)
  COINKEY=$(echo $KEYPAIR|grep PrivateKey|cut -c 18-69)
  DECODEPKEY=$(echo $KEYPAIR|grep DecodePublicKey|cut -c 154-193)
  ADDRESS=$(echo $KEYPAIR|grep Address|cut -c 209-242)
  fi

  $COIN_CLI stop
clear
}

function update_config() {
  sed -i 's/daemon=0/daemon=1/' $CONFIGFOLDER/$CONFIG_FILE
  cat << EOF >> $CONFIGFOLDER/$CONFIG_FILE
infinitynodeprivkey=$COINKEY
externalip=$NODEIP:$COIN_PORT
infinitynode=1
masternode=0
turnoffmasternode=0
EOF
}


function enable_firewall() {
  echo -e "Installing and setting up firewall to allow ingress on port ${GREEN}$COIN_PORT${NC}"
  ufw allow $COIN_PORT/tcp comment "$COIN_NAME MN port" >/dev/null
  ufw allow ssh comment "SSH" >/dev/null 2>&1
  ufw limit ssh/tcp >/dev/null 2>&1
  ufw default allow outgoing >/dev/null 2>&1
  echo "y" | ufw enable >/dev/null 2>&1
}



function get_ip() {
  declare -a NODE_IPS
  for ips in $(netstat -i | awk '!/Kernel|Iface|lo/ {print $1," "}')
  do
    NODE_IPS+=($(curl --interface $ips --connect-timeout 2 -s4 icanhazip.com))
  done

  if [ ${#NODE_IPS[@]} -gt 1 ]
    then
      echo -e "${GREEN}More than one IP. Please type 0 to use the first IP, 1 for the second and so on...${NC}"
      INDEX=0
      for ip in "${NODE_IPS[@]}"
      do
        echo ${INDEX} $ip
        let INDEX=${INDEX}+1
      done
      read -e choose_ip
      NODEIP=${NODE_IPS[$choose_ip]}
  else
    NODEIP=${NODE_IPS[0]}
  fi
}


function compile_error() {
if [ "$?" -gt "0" ];
 then
  echo -e "${RED}Failed to compile $COIN_NAME. Please investigate.${NC}"
  exit 1
fi
}


function checks() {
if [[ $(lsb_release -d) < *16.04* ]]; then
  echo -e "${RED}You are not running Ubuntu 18.04 or later. Installation is cancelled.${NC}"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi

if [ -n "$(pidof $COIN_DAEMON)" ] || [ -e "$COIN_DAEMON" ] ; then
  echo -e "${RED}$COIN_NAME is already installed.${NC}"
  exit 1
fi
}

function prepare_system() {
echo -e "Prepare the system to install ${GREEN}$COIN_NAME${NC} D.I.N. node."
apt-get update >/dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get update > /dev/null 2>&1
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y -qq upgrade >/dev/null 2>&1
apt install -y software-properties-common >/dev/null 2>&1
echo -e "${GREEN}Adding bitcoin PPA repository"
apt-add-repository -y ppa:bitcoin/bitcoin >/dev/null 2>&1
echo -e "Installing required packages, it may take some time to finish.${NC}"
apt-get update >/dev/null 2>&1
apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" make software-properties-common \
build-essential libtool autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev \
libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git wget curl libdb4.8-dev bsdmainutils libdb4.8++-dev \
libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev libzmq5 libdb5.3++ >/dev/null 2>&1
if [ "$?" -gt "0" ];
  then
    echo -e "${RED}Not all required packages were installed properly. Try to install them manually by running the following commands:${NC}\n"
    echo "apt-get update"
    echo "apt -y install software-properties-common"
    echo "apt-add-repository -y ppa:bitcoin/bitcoin"
    echo "apt-get update"
    echo "apt install -y openssh-server build-essential git automake autoconf pkg-config libssl-dev libboost-all-dev libprotobuf-dev libdb5.3-dev libdb5.3++-dev protobuf-compiler \
  cmake curl g++-multilib libtool binutils-gold bsdmainutils pkg-config python3 libevent-dev screen libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools \
  libqrencode-dev libprotobuf-dev protobuf-compiler"
 exit 1
fi

clear
}


function important_information() {
 echo
 echo -e "${GREEN}!!! PLEASE SAVE THIS INFORMATION !!!${NC}"
 echo -e "================================================================================================================================"
 echo -e "$COIN_NAME D.I.N. is up and running listening on port ${RED}$COIN_PORT${NC}."
 echo -e "Configuration file is: ${RED}$CONFIGFOLDER/$CONFIG_FILE${NC}"
 echo -e "Start: ${RED}systemctl start $COIN_NAME.service${NC}"
 echo -e "Stop: ${RED}systemctl stop $COIN_NAME.service${NC}"
 echo -e "VPS_IP:PORT ${RED}$NODEIP:$COIN_PORT${NC}"
 echo -e "D.I.N. NODE PRIVATEKEY is: ${RED}$COINKEY${NC}"
 echo -e "D.I.N. NODE PUBLICKEY is: ${RED}$PUBLICKEY${NC}"
 echo -e "D.I.N. NODE DECODEPUBLICKEY is: ${RED}$DECODEPKEY${NC}"
 echo -e "D.I.N. NODE ADDRESS is: ${RED}$ADDRESS${NC}"
 echo -e "Please check ${RED}$COIN_NAME${NC} is running with the following command: ${GREEN}systemctl status $COIN_NAME.service${NC}"
 echo -e "================================================================================================================================"
 echo -e "${GREEN}!!! PLEASE SAVE THIS INFORMATION !!!${NC}"
 echo
}

function setup_node() {
  get_ip
  create_config
  create_key
  update_config
  enable_firewall
  important_information
  configure_systemd
}


##### Main #####
clear

checks
create_user
create_swap
prepare_system
compile_node
setup_node