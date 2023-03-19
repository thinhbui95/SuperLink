const hre = require("hardhat");

async function main() {

    const Coin98CurveV2 = await hre.ethers.getContractFactory("Coin98CurveV2");
    //const TokenOKC = await upgrades.deployProxy(tokenOKC);
    // var weth = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //Goreli
    var weth = "0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd" //BSC testnet
    const coin98CurveV2 =await Coin98CurveV2.deploy(weth);

    await coin98CurveV2.deployed();

    console.log("coin98CurveV2 deployed to:", coin98CurveV2.address);
    

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