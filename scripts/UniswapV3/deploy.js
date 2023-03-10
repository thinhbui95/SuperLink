const hre = require("hardhat");

async function main() {

    const Coin98UniswapV3 = await hre.ethers.getContractFactory("Coin98UniswapV3");
    //const TokenOKC = await upgrades.deployProxy(tokenOKC);
    var weth = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //Goreli
    const coin98UniswapV3 =await Coin98UniswapV3.deploy(weth);

    await coin98UniswapV3.deployed();

    console.log("Coin98Uniswap deployed to:", coin98UniswapV3.address);


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