from brownie import FundMe, MockV3Aggregator, network, config
from scripts.helpful_scripts import get_account, deploy_mocks, LOCAL_BLOCKCHAIN_ENVIRONMENTS


def deploy_fund_me():
    account = get_account()
    '''
        - publish_source -> if True, will verify smart contracs. If you
          have API KEY from etherscan copied in .env file, you can 
          know interact with the contract on etherscan
        - price_feed_address -> if we're not on a local development
          than get the address from .env, otherwise deploy fake (mock)
          smart contract and use that address
    '''
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        price_feed_address = config["networks"][network.show_active()][
            "eth_usd_price_feed"
        ]
    else:
        deploy_mocks()
        # use the most recent MockV3Aggregator contract deployed
        price_feed_address = MockV3Aggregator[-1].address

    fund_me = FundMe.deploy(price_feed_address, {
                            "from": account}, publish_source=config["networks"][network.show_active()].get("verify"))
    return fund_me


def main():
    deploy_fund_me()
