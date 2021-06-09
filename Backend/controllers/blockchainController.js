const blockchainService = require('../services/blockchainService')

module.exports.getBalance = async (req, res) => {
    try{
        const params = req.body
        // console.log(req)
        console.log(req.body)
        const response = await blockchainService.getBalance(params.address)
        res.json({balance: +response})
    }catch(err){
        res.status(500).send("Found error: "+err.message)
    }
}

module.exports.transferToken = async (req, res) => {
    try{
        const params = req.body
        // console.log(req)
        console.log(params)
        const response = await blockchainService.transferToken(params.privateKey, params.transferAmount, params.receiverAddress)
        res.json(response)
    }catch(err){
        res.status(500).send("Found error: "+err.message)
    }
}
