//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const Executor = await hre.ethers.getContractFactory("Executor");
    const executor = await Executor.attach("0xc97B3BC075a1CC41264Ed8B94227C8595ae11274");//BSC Testnet
    var _contract = "0xDaFB8EbBA2255f4516b793e2802EB94694a1e3A6";
    await executor.addAdapters(_contract);
    // await executor.addAdapters();
    var a1 = await executor.owner();
    console.log(a1);
    
   

    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet