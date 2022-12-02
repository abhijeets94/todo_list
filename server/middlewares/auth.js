const jwt = require("jsonwebtoken");

const auth = async(req, res, next) => {
    try {
        const token = req.header('auth-token');
        // console.log(`token is ${token} from middleware auth.js`);
        if(!token)
            return res.status(401).json({msg: 'No auth token, no entry here!'});
        
        const verified = jwt.verify(token, 'passwordKey');
        // console.log(`verified is ${verified} from middleware auth.js`);

        if(!verified)
            return res.status(401).json({msg: 'Token verification failed, authorization failed! '});
        req.user = verified.id;
        req.token = token;
        next();     
    } catch (err) {
        res.status(500).json({error: err.message});
    }
}

module.exports = auth;