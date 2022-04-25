```
1. Register to etherscan
2. MyProfile -> API-KEYs -> Add Key
3. Copy key and set it as env variable (as ETHERSCAN_TOKEN)
```

If you run

```
brownie run scripts/deploy.py
```

and you already have local ganache started at port 8545,
brownie will automatically attach to that blockchain

This is how you add any chain to brownie

```
brownie networks add Ethereum ganache-local host=HTTP://127.0.0.1:8545 chainid=5777
```

```
brownie netrworks list -> copy ID
brownie networks delete ganache-local
```

## Forking ethereum mainnet

```
1. go to https://www.alchemy.com/
2. sign in with google
3. select Ethereum ecosystem
4. create app
    - TEAM NAME = Fund Me Demo
    - APP NAME = Fund Me Demo
    - NETWORK = Mainnet
5. view key -> copy http (https://eth-mainnet.alchemyapi.io/v2/dyNb9_ugG3VNlvteJcF_T3vzauYbm20s)
6. brownie networks add development mainnet-fork-dev cmd=ganache-cli host=http://127.0.0.1 fork=https://eth-mainnet.alchemyapi.io/v2/dyNb9_ugG3VNlvteJcF_T3vzauYbm20s accounts=10 mnemonic=brownie port=8545
```
