import {
    ApolloServer,
    gql, 
    ApolloError, 
    AuthenticationError
} from 'apollo-server';

const typeDefs = gql`
    type OfficeModel {
        postUID : String
        postURL : String
        officeName : String
        officeAddress : String
        roomName : String
        roomPrice : String
        roomType : String
        applyHow : String
        applyTarget : String
        contactNumber : String
        contactEmail : String
        contactFax : String
    }

    input OfficeInput {
        postUID : String
        postURL : String
        officeName : String
        officeAddress : String
        roomName : String
        roomPrice : String
        roomType : String
        applyHow : String
        applyTarget : String
        contactNumber : String
        contactEmail : String
        contactFax : String
    }
`

const resolvers = {
    Query : {

    },
    Mutation : {

    }
}

export {
    typeDefs,
    resolvers
}