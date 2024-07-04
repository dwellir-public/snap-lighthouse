# Lighthouse snap

WIP

Here is how to run a node: https://lighthouse-book.sigmaprime.io/run_a_node.html

## Example start


```
/snap/lighthouse/current/bin/lighthouse beacon_node --network mainnet \
                                                    --execution-endpoint http://localhost:8551 \
                                                    --execution-jwt /tmp/jwt.hex \
                                                    --checkpoint-sync-url https://mainnet.checkpoint.sigp.io \
                                                    --disable-deposit-contract-syncd
```
