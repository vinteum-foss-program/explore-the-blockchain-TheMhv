# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
rawTransaction=$(bitcoin-cli getrawtransaction "e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163")
transaction=$(bitcoin-cli decoderawtransaction "$rawTransaction" true)

witnessScript=$(echo $transaction | jq -r '.vin[].txinwitness[-1]')
witnessScriptDecoded=$(bitcoin-cli decodescript $witnessScript | jq .)

echo $witnessScriptDecoded | jq -r '.asm | scan("OP_IF (.*) OP_ELSE")| .[0]'