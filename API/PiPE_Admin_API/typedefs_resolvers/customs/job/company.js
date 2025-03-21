import {
    ApolloServer,
    gql, 
    ApolloError, 
    AuthenticationError
} from 'apollo-server';

const typeDefs = gql`
    type CompanyModel {
        postUID : String
        serviceTitle : String
        serviceType : String
        serviceContent : String
        serviceReward : String
        applyDate : Map<String, String>
        postURL : String
        requirementFiles : List<String>
        target : TargetModel?
        companyTitle : String
        companyType : String
        companyContent : Map<String, String>
    }

    input CompanyInput {
        postUID : String
        serviceTitle : String
        serviceType : String
        serviceContent : String
        serviceReward : String
        applyDate : Map<String, String>
        postURL : String
        requirementFiles : List<String>
        target : TargetModel?
        companyTitle : String
        companyType : String
        companyContent : Map<String, String>
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