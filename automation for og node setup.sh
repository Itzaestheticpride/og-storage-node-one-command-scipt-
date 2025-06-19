#!/bin/bash

echo "LETS DELETE YOUR OLD NODE FILES "
sudo rm -rf 0g-storage-node
if [[ $EUID -ne 0 ]]; then 
    echo 'please be a root user. Run "sudo -i" to be a root user '
    exit 1
else 
    echo "downloding dependencies"
    sudo apt install curl iptables build-essential git wget lz4 jq make cmake gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev screen ufw -y 

fi

echo "installing rustup"
curl https://sh.rustup.rs -sSf | sh && \
echo "exporting to the shell" && \
source $HOME/.cargo/env 
echo "verifying the rustup installtion "
rust_version=$(rustc --version 2>/dev/null)
    if [[ $rust_version == *"rustc"*  ]]; then
    echo "success"
else 
    echo "installation failed"
fi
echo "installing Go"

wget https://go.dev/dl/go1.24.3.linux-amd64.tar.gz && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf go1.24.3.linux-amd64.tar.gz && \
rm go1.24.3.linux-amd64.tar.gz && \
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && \
source ~/.bashrc 

echo "verifiying installation "
go_version=$(go version)

if [[ $go_version == *"go version"* ]]; then 
echo "success"
else 
    echo "failed"
fi

echo "cloning repo"
git clone https://github.com/0glabs/0g-storage-node.git && \

cd 0g-storage-node && git checkout v1.0.0 && git submodule update --init 

echo "building the files"
cargo build --release 
echo " setting configurations"
rm -rf $HOME/0g-storage-node/run/config.toml && \
curl -o $HOME/0g-storage-node/run/config.toml https://raw.githubusercontent.com/Mayankgg01/0G-Storage-Node-Guide/main/config.toml 
read -p "Enter your private key: " user_key
sed -i "s|miner_key = \"Your_Wallet_Private_key_Without_0x\"|miner_key = \"$user_key\"|" "$HOME/0g-storage-node/run/config.toml"
echo "do you want to change the rpc to the latest? (y/n)"
read rpc 
if [[ $rpc == "y" ]]; then 
    echo "paste your rpc here "
read -p "enter your rpc which is currently active... to check the rpc status follow the link ... choose the one with less ping i.e with less ms" user_rpc
sed -i "s|blockchain_rpc_endpoint = \"https://evmrpc-testnet.0g.ai\"|blockchain_rpc_endpoint = \"$user_rpc\"|" "$HOME/0g-storage-node/run/config.toml"
    echo "rpc updated successfully"
else 
    echo 'using defult rpc i.e "https://evmrpc-testnet.0g.ai":'
fi 
echo "creating systemd service file"
sudo tee /etc/systemd/system/zgs.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/0g-storage-node/run
ExecStart=$HOME/0g-storage-node/target/release/zgs_node --config $HOME/0g-storage-node/run/config.toml
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

echo " setting up the node "
sudo systemctl daemon-reload && \
sudo systemctl enable zgs && \
sudo systemctl start zgs 

echo "verifiying status "
node_status=$(sudo systemctl status zgs)
if [[ $node_status == *"active"* ]]; then 
    echo "node running " 
else 
    echo "something went wrong" 
fi
echo "do you want to check your logs of the node? (y/n)"
read logs

if {{ $logs == "y" }}; then 
echo ' run the following command in another terminal "tail -f ~/0g-storage-node/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)\" :'
echo "Thanks for using the scipt happy farming "




