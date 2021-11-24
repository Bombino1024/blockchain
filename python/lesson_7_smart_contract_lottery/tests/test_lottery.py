from brownie import accounts, Lottery, config, network
from brownie.network.web3 import Web3


def test_get_entrance_fee():
    account = accounts[0]
    lottery = Lottery.deploy(config["networks"][network.show_active()]["eth_usd_price_feed"],
                             {"from": account},)
