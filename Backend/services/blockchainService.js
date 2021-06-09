const ethers = require('ethers')
const config = require('../config/config')
const abi = [
    'function totalSupply() public view returns (uint256)',
    'function balanceOf(address account) public view returns (uint256)',
    'function transfer(address recipient, uint256 amount) public returns (bool)',
    'function allowance(address owner, address spender) public view returns (uint256)',
    'function approve(address spender, uint256 amount) public returns (bool)',
    'function transferFrom(address sender, address recipient, uint256 amount) public returns (bool)'
]

const provider = new ethers.getDefaultProvider('rinkeby')

module.exports.getBalance = async (address) => {
    let balance = 0
    try{
        const contract = new ethers.Contract(config.address.dgc_contract, abi, provider)
        balance = await contract.balanceOf(address)
        console.log(ethers.utils.formatUnits(balance,18))
        return ethers.utils.formatUnits(balance,18)
    }catch(err){
        console.error(err)
        throw err
    }
}

module.exports.transferToken = async (privateKey, transferAmount, receiverAddress) => {
    let amount = 0
    try{
        const senderWallet = new ethers.Wallet(privateKey,provider)
        const contract = new ethers.Contract(config.address.dgc_contract,abi, senderWallet)
        if(transferAmount){
            amount = ethers.utils.parseUnits(transferAmount,18)
        }
        const response = await contract.transfer(receiverAddress, amount)
        const result = await response.wait()
        console.log("result.blockHash: ", result.blockHash)
        console.log("result.transactionHash: ", result.transactionHash)
        return result.transactionHash
    }catch(err){
        console.error(err)
        throw err
    }
}
