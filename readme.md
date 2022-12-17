Instal Geth:
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum

Install Nettool
sudo apt install net-tools

Check Open Port
-- Using Nettool
sudo netstat -l (All)
sudo netstat -lt (TCP Only)
netstat -tlpen | grep 8080

-- Firewall
sudo ufw status
sudo ufw enable
sudo ufw allow 8545/tcp
sudo ufw disable

-- lsof
sudo lsof -i tcp
sudo lsof -nP | grep LISTEN

-- File Operation Ubuntu
Delete Dir - rmdir node1
Remove all file- rm -r node1
remove - rm 4649-harmony.json
rename - mv 4649.json genesis.json

Create Node and Account manully:
mkdir GethPrivateBlockchain
cd GethPrivateBlockchain
mkdir node1 node2 node3 bnode

geth --datadir ./node1/data account new 
geth --datadir ./node1/data account new
geth --datadir ./node1/data account new
geth --datadir ./node1/data account new
geth --datadir ./node1/data account new
geth --datadir ./node1/data account new

geth --datadir ./node2/data account new
geth --datadir ./node2/data account new

geth --datadir ./node3/data account new
geth --datadir ./node3/data account new
geth --datadir ./node3/data account new

Save Account Details:
echo '0x8ccbCfDc030fa09Fb6Fdc20924B3cec35b08d8AC' >> accounts.txt
echo '0x7Bb542DEd40d0E6Bd01a1bAe39ec5E9984f36E48' >> accounts.txt

Save Password Details:
echo 'abc@123' >> node1/password_1.txt
echo 'abc@123' >> node1/password_2.txt
echo 'abc@123' >> node1/password_3.txt
echo 'abc@123' >> node1/password_4.txt
echo 'abc@123' >> node1/password_5.txt
echo 'abc@123' >> node1/password_6.txt

echo 'abc@123' >> node2/password_1.txt
echo 'abc@123' >> node2/password_2.txt
echo 'abc@123' >> node3/password_3.txt

echo 'abc@123' >> node3/password_1.txt
echo 'abc@123' >> node3/password_2.txt
echo 'abc@123' >> node3/password_3.txt

Create Bootnode:
cd ..
cd bnode
bootnode -genkey boot.key


Creete Genesis json:
cd 
puppeth
network name - genesis
Network ID - 15353
--ctrl+D

initalize node:
geth --datadir ./node1/data init ./genesis.json
geth --datadir ./node2/data init ./genesis.json
geth --datadir ./node3/data init ./genesis.json

Bootnode to get enode Address: 
cd bnode
bootnode -nodekey ./boot.key -verbosity 7 -addr 127.0.0.1:30301
stop for now: ctrl+C
-- Copy encode address

Create bash file:
touch node1/node1.sh 
touch node2/node2.sh 
touch node3/node3.sh 

vim node1/node1.sh
# Node 1
nohup geth \
--datadir ./node1/data \
--networkid 15353 \
--syncmode 'full' \
--ipcdisable \
--bootnodes $1 \
--port 30303 \
--http \
--http.corsdomain “*” \
--http.port 8545 \
--http.addr $2 \
--http.vhosts '*' \
--http.api admin,eth,miner,net,txpool,personal,web3,debug \
--authrpc.port 8551 \ 
--unlock '$3' \ 
--allow-insecure-unlock \
--password password_1.txt \ 
--mine console &

echo "Node 1 Start"

:wq

vim node2/node2.sh
# Node 2
nohup geth \
--datadir ./node2/data \
--networkid 15353 \
--syncmode 'full' \
--ipcdisable \
--bootnodes $1 \
--port 30305 \
--http \
--http.corsdomain “*” \
--http.port 8546 \
--http.addr $2 \
--http.vhosts '*' \
--http.api admin,eth,miner,net,txpool,personal,web3 \
--authrpc.port 8552 \ 
--unlock '$3' \ 
--allow-insecure-unlock \
--password password_1.txt \ 
console &
echo "Node 2 Start"
:wq

vim node3/node3.sh
# Node 3
nohup geth \
--datadir ./node3/data \
--networkid 15353 \
--syncmode 'full' \
--ipcdisable \
--bootnodes $1 \
--port 30307 \
--http \
--http.corsdomain “*” \
--http.port 8547 \
--http.addr $2 \
--http.vhosts '*' \
--http.api admin,eth,miner,net,txpool,personal,web3 \
--authrpc.port 8553 \ 
--unlock '$3' \ 
--allow-insecure-unlock \
--password password_1.txt \ 
console &
echo "Node 2 Start"
:wq


Start Nodes
Bootnode : 
bootnode -nodekey ./bnode/boot.key -verbosity 7 -addr <Private IP>:30301

Open new ternimal
cd GethPrivateBlockchain
sh node1/node1.sh <enode addr> <Private IP> <Account>

Open new ternimal
cd GethPrivateBlockchain
sh node2/node2.sh <enode addr> <Private IP> <Account>

Open new ternimal
cd GethPrivateBlockchain
sh node3/node3.sh <enode addr> <Private IP> <Account>

--Open new ternimal for General operation

Curl Operation:
Node1 Account:
curl -X POST http://127.0.0.1:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0x7B3413D90564F5E9A9Fe4206Cc2383c2eAB386c3","latest"], "id":1}'

Node2 Account:
curl -X POST http://127.0.0.1:8546 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0x7B3413D90564F5E9A9Fe4206Cc2383c2eAB386c3","latest"], "id":1}'

Node1 Account from local:
curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0x7B3413D90564F5E9A9Fe4206Cc2383c2eAB386c3","latest"], "id":1}'

Node2 Account from local:
curl -X POST http://<Public IP>:8546 -H "Content-Type: application/json" --data '{"jsonrpc":"2.0", "method":"eth_getBalance", "params":["0x7B3413D90564F5E9A9Fe4206Cc2383c2eAB386c3","latest"], "id":1}'


curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 1,"method": "admin_peers","params": []}'
curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 2,"method": "eth_blockNumber","params": []}'
curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 3,"method": "eth_accounts","params": []}'
curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 4,"method": "eth_getBalance","params":["0x08d1f47128f5c04d7a4aee69e90642645059acd6","latest"]}'
curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 5,"method": "personal_newAccount","params":["abc@123"]}'

curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 6,"method": "eth_sendTransaction","params":[{"from":"0x08d1f47128f5c04d7a4aee69e90642645059acd6","to": "0x2bc05c71899ecff51c80952ba8ed444796499118","value": "0xf4240"}]}'

curl -X POST http://<Public IP>:8545 -H "Content-Type: application/json" --data '{"jsonrpc": "2.0","id": 5,"method": "eth_getTransactionByHash","params":["0xa96de080dfcb9c5f908528b92d3df55a0e230cf4e48ae178bb220862c2a544c7"]}'

Links:
Private Network
https://geth.ethereum.org/docs/getting-started/dev-mode
https://hackernoon.com/how-to-set-up-a-private-ethereum-blockchain-proof-of-authority-with-go-ethereum-part-1
https://medium.com/scb-digital/running-a-private-ethereum-blockchain-using-docker-589c8e6a4fe8
https://medium.com/@andrenit/buildind-an-ethereum-playground-with-docker-part-1-introduction-80be173aaa7a#.o1ifv82wn

Contracts:
https://www.tutorialspoint.com/solidity/index.htm
https://medium.com/robhitchens/solidity-crud-part-1-824ffa69509a
https://bitbucket.org/rhitchens2/soliditycrud/src/master/contracts/SolidityCRUD-part2.sol
https://www.youtube.com/watch?v=CgXQC4dbGUE
https://www.youtube.com/watch?v=nvw27RCTaEw
https://github.com/smallbatch-apps/fairline-contract

