geth --datadir ./node1/data --networkid 15353 --syncmode 'full' --ipcdisable --bootnodes $1 --port 30303 --http --http.corsdomain "*" --http.port 8545 --http.addr $2 --http.vhosts '*' --http.api admin,eth,miner,net,txpool,personal,web3,debug --authrpc.port 8551 --unlock $3 --allow-insecure-unlock  --password password.txt --mine console

# geth --datadir ./node1/data --networkid 15353 --syncmode 'full' --bootnodes enode://4f9457aa78c1f33a4dbb399eb49c30f8bdd7e3cabe5fd91973dd37d5ca28d6876bdeca9dd65c7dfe2808599c54048044259a1d4dd75c3a0a86065ed138380ff8@172.31.83.214:0?discport=30301 --port 30303 --http --http.corsdomain "*" --http.port 8545 --http.addr 172.31.83.214 --http.vhosts '*' --http.api admin,eth,miner,net,txpool,personal,web3,debug --authrpc.port 8551 --unlock '0x1b382Be3076C99205979F1A98D40987643D87769' --allow-insecure-unlock  --password password.txt --mine console