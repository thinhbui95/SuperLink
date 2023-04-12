const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');

async function main() {
    const KyberSwapStatic = await hre.ethers.getContractFactory("Coin98KyberClassicStatic");

    const kyberSwapStatic = await KyberSwapStatic.attach("0xEfE7B43187e8FF1661BC3C2151F16610E63AC0c5");
    console.log("Hello");
    const kyberSwapClassicStaticData = Web3EthAbi.encodeParameter({
        KyberSwapClassicStaticData :{
            to: "address",
            data: "bytes",
        }
    },{
        to: "0x5C845F19EB923eEE213b620c12cc6D1d4E6E3506",
        data: "0x",
    });

    const swapParam = Web3EthAbi.encodeParameter({
        SwapParam:{
            fromToken:"address",
            toToken:"address",
            targetExchange: "address",
            payload: "bytes",
        },
    },{
        fromToken:"0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC
        toToken: "0xA84C91E100a8B5AB94f6825adb0e767596A66b9E", //TOKEN A
        targetExchange: "0x757644fF8A9bB5358Ab7A156B4BC4204ae187C0A", //Pair A/USDC
        payload: kyberSwapClassicStaticData,
    });

    console.log("swapParam", swapParam);

    let amountIn = Web3.utils.toWei('9', 'ether');
    console.log("amountIn", amountIn);
    let amountOut = Web3.utils.toWei('0.001', 'ether');
    console.log("amountOut", amountOut);
    try {
        await kyberSwapStatic.swap(amountIn, amountOut, swapParam);
    } catch(error) {
        console.log(error);
    }

    console.log("Bye");
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet