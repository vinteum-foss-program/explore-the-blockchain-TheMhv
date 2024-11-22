# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
rawTransaction=$(bitcoin-cli getrawtransaction "37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517")
transaction=$(bitcoin-cli decoderawtransaction "$rawTransaction")

addresses=$(echo "$transaction" | jq -r '[.vin[].txinwitness[1]]')
multisigAddress=$(bitcoin-cli createmultisig 1 "$addresses")

echo "$multisigAddress" | jq -r ".address"