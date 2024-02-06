import {
    ApolloServer,
    gql, 
    ApolloError, 
    AuthenticationError
} from 'apollo-server';
import depthLimit from 'graphql-depth-limit';
import { customAuthorization } from './secure/authorization.js';
import { customResolver } from './queries/resolvers/customResolver.js';
import { customTypeDefs } from './queries/typeDefs/customTypeDef.js';

const formatError = err => {
    console.error("--- GraphQL Error ---");
    console.error("Path:", err.path);
    console.error("Message:", err.message);
    console.error("Code:", err.extensions.code);
    console.error("Original Error", err.originalError);
    return err;
};


const server = new ApolloServer({ 
    typeDefs: customTypeDefs,
    resolvers: customResolver,
    // context: ({ req }) => { 
    //     // context에서 모든 요청 정보를 인자(req)로 받으며, 
    //     // 모든 resolver 함수에서 공유할 수 있는 데이터를 제공하는 역
    //     if (!req.headers.authorization.refreshToken) throw new AuthenticationError("missing refreshToken");

    //     const accessToken = req.headers.authorization.split(" ")[1];
    //     if (!accessToken) {
    //         return null;
    //       }

    //     const user = users.find((user) => user.token === token); // 인증 토큰에 매칭되는 사용자가 있는지 users 배열을 검색
    //     // if(!user) throw new AuthenticationError("invalid token"); // 사용자가 없다면 인증 실패 상황이므로 AuthenticationError 에러를 던짐
        
    //     const user = AuthService.getUser(req);

    //     return { 
    //         user: user, 
    //         db: { 
    //             users, 
    //             notes 
    //         } 
    //     };
    // },
    validationRules: [depthLimit(5)], // 쿼리의 깊이다 5이상일경우 제한하여 5이상일 경우 거부.
    formatError,
    debug: false
});

server.listen().then(({ url }) => {
   console.log(`Running on ${url}`); 
});

// const { 
//     ApolloServer,
//     gql, 
//     ApolloError, 
//     AuthenticationError,
//     ApolloClient,
//     InMemoryCache 
// } = require('apollo-server');
// const depthLimit = require('graphql-depth-limit');
// const customAuthentication = require("./auth/auth");

// const userDB = require("./db/users");
// const mariaDB = require("./db/mariadb");
// const postgraphileDB = require("./db/postgraphile");

// const customResolver = require("./resolvers/customResolver");
// const customTypeDefs = require("./typeDefs/customTypeDefs");

// require("dotenv").config();

// const client = new ApolloClient({
//     link: createHttpLink({ uri: "https://countries.trevorblades.com" }),
//     cache: new InMemoryCache()
// });

// const formatError = err => {
//     console.error("--- GraphQL Error ---");
//     console.error("Path:", err.path);
//     console.error("Message:", err.message);
//     console.error("Code:", err.extensions.code);
//     console.error("Original Error", err.originalError);
//     return err;
// };

// const server = new ApolloServer({ 
//     customTypeDefs,
//     customResolver,
//     context: ({ req }) => { 
//         // context에서 모든 요청 정보를 인자(req)로 받으며, 
//         // 모든 resolver 함수에서 공유할 수 있는 데이터를 제공하는 역
//         if (!req.headers.authorization.refreshToken) throw new AuthenticationError("missing refreshToken");

//         const accessToken = req.headers.authorization.split(" ")[1];
//         if (!accessToken) {
//             return null;
//           }

//         const user = users.find((user) => user.token === token); // 인증 토큰에 매칭되는 사용자가 있는지 users 배열을 검색
//         // if(!user) throw new AuthenticationError("invalid token"); // 사용자가 없다면 인증 실패 상황이므로 AuthenticationError 에러를 던짐
        
//         const user = AuthService.getUser(req);

//         return { 
//             user: user, 
//             db: { 
//                 users, 
//                 notes 
//             } 
//         };
//     },
//     validationRules: [depthLimit(5)], // 쿼리의 깊이다 5이상일경우 제한하여 5이상일 경우 거부.
//     formatError,
//     debug: false
// });

// server.listen().then(({ url }) => {
//    console.log(`Running on ${url}`); 
// });

/*
express 식 관련 링크
 - https://escape.tech/blog/9-graphql-security-best-practices/

express version, 쿼리 깊이 제한
app.use("/api", graphqlServer({validationRules: [depthLimit(10)]}))
*/

