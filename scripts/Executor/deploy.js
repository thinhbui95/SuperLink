const hre = require("hardhat");

async function main() {

    const Executor = await hre.ethers.getContractFactory("Executor");
    //const TokenOKC = await upgrades.deployProxy(tokenOKC);
    //var weth = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //Goreli
    const ExecutorSwap =await Executor.deploy();

    await ExecutorSwap.deployed();

    console.log("Executor deployed to:", ExecutorSwap.address);


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