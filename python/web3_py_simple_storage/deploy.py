from solcx import compile_standard, install_solc
import json
from web3 import Web3
import os
from dotenv import load_dotenv

load_dotenv()

install_solc("0.8.0")

# Read Smart Contract
with open("../contracts/SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

# Compile Start Contract
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {
                    "*": ["abi", "metadata", "evm.bytecode", "evm.bytecode.sourceMap"]
                }
            }
        },
    },
    solc_version="0.8.0",
)

# Copy compiled code to JSON file
with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

# Get bytecode of Smart Contract
bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]

# Get abi of Smart Contract
abi = json.loads(
    compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["metadata"])["output"]["abi"]

# Connect to local Ganache network -> Params in Ganache GUI
# w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))  # RPC SERVER
w3 = Web3(Web3.HTTPProvider(
    "https://rinkeby.infura.io/v3/4ce2896ad2ed476d9d9a33739c7b88e0"))

chain_id = 4  # NETWORK ID
my_address = "0x25a93B2D95b9bBDAEEB1A5fB67Dd39997db50C10"  # ADDRESS
private_key = os.getenv("PRIVATE_KEY")  # PRIVATE KEY

# Create the contract in Python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

# 1. Build / Submit a transaction
# Get the latest transaction of account
nonce = w3.eth.getTransactionCount(my_address)
transaction = SimpleStorage.constructor().buildTransaction(
    {"chainId": chain_id, "from": my_address, "nonce": nonce}
)

# 2. Sign the transaction
signed_txn = w3.eth.account.sign_transaction(
    transaction, private_key=private_key)

# 3. Send it!
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

# Wait for the transaction to be mined, and get the transaction receipt
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

# Working with deployed Contracts
# For working with contract we need address and abi
simple_storage = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)

# Call -> Simulate making a call and getting a return value
# Transact -> Actually make a state change
print(simple_storage.functions.getFavNumber().call())
store_transaction = simple_storage.functions.storeFavNumber(15).buildTransaction(
    {"chainId": chain_id, "from": my_address, "nonce": nonce + 1}
)
signed_store_txn = w3.eth.account.sign_transaction(
    store_transaction, private_key=private_key
)
tx_store_hash = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_store_hash)
print(simple_storage.functions.getFavNumber().call())

'''
Working with ganache-cli (close Ganache before)
- npm install -g ganache-cli -> instalation
- ganache-cli [--deterministic]  -> start local blockchain from cmd
- update data from console (port, address, private key) 
'''
'''
Running own blockchain node instead of local network (Own blockchain node / Third party client (infura, alchemy, ...))
infura.io
- register
- create new project (Ethereum, bombi-net)
    - endpoint (rinkeby)
    - change settings: url,network id, private key, address
'''
