const hre = require("hardhat");

async function main() {

    const DemoAdapter1 = await hre.ethers.getContractFactory("DemoAdapter1");
    //const TokenOKC = await upgrades.deployProxy(tokenOKC);
    // var weth = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //Goreli
    var weth = "0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd"; //BSCS Testnet

    const Demo1 =await DemoAdapter1.deploy(weth);

    await Demo1.deployed();

    console.log("DemoAdapter deployed to:", Demo1.address);
    //console.log("DemoAdapter proxy deployed to:", demoAdapter.address);

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