const hre = require("hardhat");

async function main() {

    const Coin98BalancerV2 = await hre.ethers.getContractFactory("Coin98BalancerV2");
    //const TokenOKC = await upgrades.deployProxy(tokenOKC);
    // var weth = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //Goreli
    var weth = "0x2DD4Aa80b9197FdfFF4F15b6a1a35633437cd398" //BSC testnet
    const coin98BalancerV2 =await Coin98BalancerV2.deploy();

    await coin98BalancerV2.deployed();

    console.log("coin98BalancerV2 deployed to:", coin98BalancerV2.address);
    

    // try {
    //     const contractAddress = await getImplementationAddress(
    //         DemoAdapter.provider,
    //         DemoAdapter.address
    //     );
    //     await hre.run("verify:verify", { address: contractAddress  });
    //     console.log("Contract verified to:", contractAddresss );
    // } catch (e) {

    // }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/Demo/deploy.js --network ETH_Goerly