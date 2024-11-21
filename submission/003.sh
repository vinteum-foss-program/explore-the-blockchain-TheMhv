# How many new outputs were created by block 123,456?
hash=$(bitcoin-cli getblockhash 123456)
block=$(bitcoin-cli getblock $hash 2)

echo $block | jq "[.tx[].vout | length] | add"