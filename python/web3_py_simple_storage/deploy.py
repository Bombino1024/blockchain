from solcx import compile_standard, install_solc
import json
from web3 import Web3

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
w3 = Web3(Web3.HTTPProvider("HTTP://127.0.0.1:7545"))  # RPC SERVER
chain_id = 1337  # NETWORK ID
my_address = "0xe6E509140846a788569CF64A07b1be692D684a81"  # ADDRESS
private_key = "0xd7c6e51bfc7ce443096566c07c6bd4c956c6705250fa116f3ee5a5ce5433b65f"  # PRIVATE KEY

# Create the contract in Python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)


# 1. Build a transaction
# Get the latest transaction of account
nonce = w3.eth.getTransactionCount(my_address)
transaction = SimpleStorage.constructor().buildTransaction(
    {"chainId": chain_id, "from": my_address, "nonce": nonce}
)
print(transaction)
