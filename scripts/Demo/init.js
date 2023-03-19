//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")


async function main() {

    const DemoAdapter = await hre.ethers.getContractFactory("DemoAdapter");
    const demoAdapter = await DemoAdapter.attach("0x7154cfe28A44dd3DCd79fd1fD50CC39a5c8e3517");//Goerli
    


    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet