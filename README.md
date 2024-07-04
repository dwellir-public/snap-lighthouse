# Lighthouse snap

WIP

Here is how to run a node: https://lighthouse-book.sigmaprime.io/run_a_node.html

## Example start

### Install reth as a L1 client
1. sudo snap install reth --channel edge
2. sudo snap start reth

3. copy the jwt.hex from reth -> lighthouse #todo move the jwt.hex to a place where upgrades doesn't reset it.

  sudo cp /root/snap/reth/current/.local/share/reth/mainnet/jwt.hex /root/snap/lighthouse/common/


```

Monitor logs:
  sudo snap logs reth -f

### Install lighthouse as a L2 client
4. sudo snap install lighthouse --channel edge
5. copy the jwt.hex from reth -> lighthouse #todo move the jwt.hex to a place where upgrades doesn't reset it.

  sudo cp /root/snap/reth/current/.local/share/reth/mainnet/jwt.hex /root/snap/lighthouse/common/


6. sudo snap set lighthouse service-args="beacon_node --network mainnet --execution-endpoint http://localhost:8551 --execution-jwt ./jwt.hex --checkpoint-sync-url https://mainnet.checkpoint.sigp.io --disable-deposit-contract-sync"

Monitor logs:
  sudo snap logs lighthouse -f

