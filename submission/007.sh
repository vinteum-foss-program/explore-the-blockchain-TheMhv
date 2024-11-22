# Only one single output remains unspent from block 123,321. What address was it sent to?
hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash 2)

txAndLenghts=$(echo "$block" | jq -c "[.tx[] | {id: .txid, vouts: (.vout | length)}]")

echo "$txAndLenghts" | jq -c '.[]' | while read tx; do
    id=$(echo "$tx" | jq -r '.id')
    vouts=$(echo "$tx" | jq -r '.vouts')

    for n in $(seq 1 $vouts); do
        getTxOut=$(bitcoin-cli gettxout "$id" $(($n-1)))
        
        if test -z "$getTxOut"; then
            continue
        else
            echo "$getTxOut" | jq -r ".scriptPubKey.address"
            break 2
        fi
    done
done