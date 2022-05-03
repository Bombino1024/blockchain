from brownie import accounts


def check_accounts():
    for i in range(len(accounts)):
        print(accounts[i])


def main():
    check_accounts()
