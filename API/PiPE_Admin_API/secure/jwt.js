import jwt from 'jsonwebtoken';
import { postgraphileDB, dummyDB } from '../db/postgraphile.js';
import { encrypt, compare } from './crypto.js';

const testString = "asdf"
const hashedText = await encrypt(testString); 
console.log(`encrypt : ${hashedText}`);

const result = await compare(testString, hashedText);
console.log(`compare : ${result}`);

const configure = {
    aesKey : process.env.AES256_KEY,
    accessKey : process.env.ACCESS_SECRET, // 원하는 시크릿 ㅍ키
    refreshKey : process.env.REFRESH_SECRET, 
    options : {
        algorithm : "HS256", // 해싱 알고리즘
        expiresIn : "10m",  // 토큰 유효 기간
        issuer : "발행자" // 발행자
    }
}

// const db = postgraphileDB
const db = dummyDB

const dumpyUserInfo = {
    id: 1,
    role: "admin",
    email: "cavss1118@gmail.com",
    expiredDate: 20,
    purpose: "admin용."
}

const generateToken = async (userInfo) => {
    
    /*
    1. 최소한의 개인정보로만 json으로 담음
    2. 개인정보로 access, refresh token 만듬. 
    3. refresh token은 firebase에 저장 ( 유통기한 따로 표기 )
    4. access token만 사용.
    */

    const NewRefreshTokenExpiredDate = new Date( //6개월
        Date.now() + 3600 * 1000 * 24 * 180
    )

    const duplicatedCheck = db.filter((item) => {
        return item.email != db.email
    })[0];

    if(!duplicatedCheck){
        res.status(403).json({
            error : "Not Authorized",
            message : "중복된 이메일"
        });
    }else{
        try { 
            const payload =  {
                id : userInfo.id,
                role : userInfo.role,
                email : userInfo.email,
                expiredDate : userInfo.expiredDate,
                purpose : userInfo.purpose
            };

            // access Token 발급 
            const accessToken = jwt.sign(
                payload, 
                configure.accessKey, 
                configure.options
            );

            // refresh Token 발급
            const refreshToken = jwt.sign(
                payload, 
                configure.refreshKey, 
                configure.options
            );

            // token 전송, accessToken이란 이름으로 유저의 토큰을 헤더에 넣음.
            res.header('Authorization', `Bearer ${accessToken}`);

        
            // token 전송, refreshToken이란 이름으로 유저의 토큰을 쿠키에 넣음.
            res.cookie("refreshToken", refreshToken, {
                secure : false,
                httpOnly : true,
            })

            res.status(200).json({
                message : "JWT, signUp // access, refresh토큰 생성 완료, 쿠키에 저장",
                accessToken : accessToken,
                refreshToken : refreshToken
            });
        } catch (error) {
            res.status(500).json({
                error : error,
                message : `JWT, signUp // 에러내용 : ${error}`
            });
        }
    }
}
  
// jwt토큰생성. access, refresh 토큰생성해서 쿠키에 저장.
const initToken = (req, res, next) => {
    const { email, password, username } = req.body;
    const userInfo = db.filter((item) => { // 중복체크
        return item.email === email;
    })[0];

    console.log('req.body:', req.body); // 디버깅용 로그
    console.log('req.headers', req.headers); // 디버깅용 로그
    console.log(`eamil : ${email}, password : ${password}, username : ${username}`);


    if (!userInfo) { // 이메일 중복없다면 else로 넘어감.
        res.status(403).json({
            error : "Not Authorized",
            message : "중복된 이메일"
        });
    } else { 
        try { 
            // access Token 발급 
            const payload =  {
                id : userInfo.id,
                username : userInfo.username,
                email : userInfo.email,
            };

            const accessToken = jwt.sign(
                    payload, 
                    accessKey, 
                    options
                );

            // refresh Token 발급
            const refreshToken = jwt.sign(
                    payload, 
                    refreshKey, 
                    options
                );

            // token 전송, accessToken이란 이름으로 유저의 토큰을 헤더에 넣음.
            res.header('Authorization', `Bearer ${accessToken}`);

        
            // token 전송, refreshToken이란 이름으로 유저의 토큰을 쿠키에 넣음.
            res.cookie("refreshToken", refreshToken, {
                secure : false,
                httpOnly : true,
            })

            res.status(200).json({
                message : "access, refresh토큰 생성 완료, 쿠키에 저장",
                accessToken : accessToken,
                refreshToken : refreshToken
            });
        } catch (error) {
            res.status(500).json({
                error : error,
                message : ""
            });
        }
    }
}

// AceessToken의 유효기간이 지나게 되면 ,
// AccessToken을 기반으로 만들어진 Refresh Token을 사용해 
// 새로운 AccessToken을 발급
const refreshToken = (req, res) => {
    try {
        const token = req.cookies.refreshToken;
        if (!token) {
            throw new Error('refresh토큰이 없음.');
        }

        const data = jwt.verify(token, refreshKey, function(err, decoded){
            if (err){
                err = {
                    name: 'TokenExpiredError',
                    message: 'jwt expired',
                    expiredAt: 1408621000
                }
            }
        })
        const userData = db.filter( item => {
            return item.email === data.email;
        })[0]

        if (!userData) {
            throw new Error('User가 없음');
        }
  
        // access Token 새로 발급
        const accessToken = jwt.sign(
            {
                id : userData.id,
                username : userData.username,
                email : userData.email,
            }, 
            accessKey, 
            options
        );
    
        // token 전송, accessToken이란 이름으로 유저의 토큰을 헤더에 넣음.
        res.header('Authorization', `Bearer ${accessToken}`);

        
        res.status(200).json({
            message : "refresh토큰 기반으로 새로운 access토큰 발행 완료, 헤더에 저장.",
            refreshToken : refreshToken
        });
    } catch (error) {
        res.status(500).json(error);
    }
};

function tokensVerifyCheck(){
    try{
        const accessToken = req.headers.authorization?.split(' ')[1]; // Bearer 토큰에서 실제 토큰 부분만 추출
        if(accessToken.length > 1){
            throw new Error('accessToken 없음.');
        }
    }catch(error){
        // 토큰이 만료된 경우
        if (error.name === 'TokenExpiredError') {
            return res.status(419).json({
                code: 419,
                message: 'accessToken 토큰이 만료되었습니다.'
            });
        }else if (error.name === 'JsonWebTokenError'){
            return res.status(401).json({
                code: 401,
                message: '유효하지 않은 토큰입니다.'
            });
        }
    }

    try{
        const refreshToken = req.cookies.refreshToken;
        if(refreshToken.length > 1){
            throw new Error('refreshToken 없음.');
        }

    }catch(error){
         // 토큰이 만료된 경우
         if (error.name === 'TokenExpiredError') {
            return res.status(419).json({
                code: 419,
                message: 'accessToken 토큰이 만료되었습니다.'
            });
        }else if (error.name === 'JsonWebTokenError'){
            return res.status(401).json({
                code: 401,
                message: '유효하지 않은 토큰입니다.'
            });
        }
    }
}
const login = (req, res) => {
    try {
        // const token = req.headers.authorization?.split(' ')[1]; // Bearer 토큰에서 실제 토큰 부분만 추출
        const token = req.cookies.accessToken;
        if (!token) {
            throw new Error('refresh토큰이 없음.');
        }


        const data = jwt.verify(token, accessKey);
    
        const userData = db.filter(item=>{
          return item.email === data.email;
        })[0];
    
        res.status(200).json(userData);
    } catch (error) {
        res.status(500).json(error);
    }
};

const logout = (req, res) => {
    try {
        res.cookie('accessToken', '');
        res.status(200).json("Logout Success");
    } catch (error) {
        res.status(500).json(error);
    }
};


export {
    initToken,
    refreshToken,
    login,
    logout
}
