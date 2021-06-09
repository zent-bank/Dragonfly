const express = require('express')
const cors = require('cors')
const helmet = require('helmet')
const hpp = require('hpp')
const rateLimit = require('express-rate-limit')

const apiRoutes = require('./routes/api-route')

const app = express()
app.use(express.json({ parameterLimit: 100, limit: '1mb' }));
app.use(express.urlencoded({ extended: true, parameterLimit: 100, limit: '1mb' }));
app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    if (req.method === 'OPTIONS') {
        res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
        return res.status(200).json({});
    }
    next();
})

app.use(cors())
app.use(helmet())
app.use(hpp())

app.use(rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 50,
    message: "Too many accounts created from this IP, please try again after an 15 minute"
}))

app.use('/backend',apiRoutes)


var server = app.listen(process.env.PORT || 8080, function () {
    var port = server.address().port;
    //console.log("App now running on env  : ", process.env.NODE_ENV);
    console.log("########## App now running on port :",port,"##########");
});