# Which tx in block 257,343 spends the coinbase output of block 256,128?
initialHash=$(bitcoin-cli getblockhash 256128)
initialBlock=$(bitcoin-cli getblock $initialHash 2)
coinbaseTx=$(echo $initialBlock | jq -r ".tx[0].txid")

hashSpent=$(bitcoin-cli getblockhash 257343)
blockSpent=$(bitcoin-cli getblock $hashSpent 3)

findTxId=$(echo $blockSpent | jq -r '.tx[] | select(.vin[].txid=="'$coinbaseTx'") | .txid')

echo $findTxId