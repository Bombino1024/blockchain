# BROWNIE

## Installation

```
python -m pip install --user pipx
python -m pipx ensurepath
pipx install eth-brownie
```

## Contracts

```
brownie init
brownie compile
brownie run scripts/deploy
```

By default brownie will run a local ganache network with bunch of fake accounts

## Acounts

```
brownie accounts new bombi-account
# Add private key from Metamask
# Enter password (test)
```

This is a safe way how to store private key

```
brownie accounts list
brownie accounts delete <account name>
```

You can however still use .env file to store private key, but it's little less secure

## Testing

Full python documentation

```
brownie test
brownie test -k test_updating_storage # only one method
brownie test --pdb # will catch a breakpoint on assertion error
brownie test -s # mote statistics
```

## Network

```
brownie networks list
brownie run scripts/deploy.py --network rinkeby
```

--network network_name will select network to interact with, all other scripts than has to be run with --network network_name

Example:
brownie run scripts/deploy.py --network rinkeby
export WEB3_INFURA_PROJECT_ID=4ce2896ad2ed476d9d9a33739c7b88e0
