const router = require('express').Router()
const blockchainController = require('../controllers/blockchainController')

router.route('/getBalance').post(blockchainController.getBalance)
router.route('/transferToken').post(blockchainController.transferToken)

module.exports = router