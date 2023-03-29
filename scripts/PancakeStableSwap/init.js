//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const PancakeStableSwap = await hre.ethers.getContractFactory("PancakeStableSwap");
    const pancakeStableSwap = await PancakeStableSwap.attach("0x02B2E6916263Fd20a5c9287C9a6B83e16224D59E");//Goerli Testnet
    var USDC = "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF"
    var USDT = "0x05a4e4F59B4779fC3FB4959a3CFC4FA8d248Edc2"
    var _coins = [USDC,USDT]
    var _A = 1000;
    var _fee = 15000000
    var _admin_fee = 5000000000
    var _owner = "0x10505818AFDB5fA60862e1D771a84E8164Dd9D49"
    await pancakeStableSwap.initialize(_coins,_A,_fee,_admin_fee,_owner)
    

    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet