from brownie import accounts, network, config, dao


LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache"]


def get_account():
    # if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
    #     return accounts[0]
    # return accounts.add(config["wallets"]["from_key"])
    return accounts[0]


def deploy():
    account = get_account()
    daoContract = dao.deploy(
        {"from": account}, publish_source=config["networks"][network.show_active()]["verify"])
    tx = daoContract.createElection("Init", {"from": account})
    tx.wait(1)


def main():
    deploy()
