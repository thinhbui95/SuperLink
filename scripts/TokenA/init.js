//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const TokenA = await hre.ethers.getContractFactory("TokenA");
    const tokenA = await TokenA.attach("0xA84C91E100a8B5AB94f6825adb0e767596A66b9E");//Goerli Testnet
    var spender = "0x4414F2b5D37F62D650ee50e9f57bC2C1f3ffc39e"
    var owner = "0x10505818AFDB5fA60862e1D771a84E8164Dd9D49";
    var amount = Web3.utils.toWei('10000', 'ether');
    await tokenA.approve(spender,amount)
    

    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet