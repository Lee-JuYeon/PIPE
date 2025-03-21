import { gql } from 'apollo-server';

const customTypeDefs = gql`
    type JobFairModel {
        id : String
        address : String
        title : String
        by : String
        field : String
        date : String
        url : String
    }

    type JobContestModel {
        id : String
        address : String
        title : String
        by : String
        field : String
        applyPeriod : String
        url : String
        subTitle : String
        requirement : String
    }

    type CompanyModel {
        id : String
        postTitle : String
        companyTitle : String
        companyType : String
    }

    type WorkedCompanyModel {
        id : String
        companyTitle : String

    }

    type PortfolioModel {
        id : String
        title : String
        urls : [String]
        companyHistory : [WorkedCompanyModel]
    }

    type CertificationModel {
        id : String
        title : String
    }

    type RewardTargetModel {
        id : String
        title : String
    }

    type RewardModel {
        id : String
        title : String
    }

    type BankModel {
        id : String
        title : String
    }

    type MyHomeModel {
        id : String
        title : String
    }

    type PreSaleRightModel {
        id : String
        title : String
    }

    type SubscriptionModel {
        id : String
        title : String
    }

    type CheapOfficeModel {
        id : String
        title : String
    }

    input JobFairModelInput {
        id : String
        address : String
        title : String
        by : String
        field : String
        date : String
        url : String
    }

    input JobContestModelInput {
        id : String
        address : String
        title : String
        by : String
        field : String
        applyPeriod : String
        url : String
        subTitle : String
        requirement : String
    }

    input CompanyModelInput {
        id : String
        postTitle : String
        companyTitle : String
        companyType : String
    }

    input WorkedCompanyModelInput {
        id : String
        companyTitle : String

    }

    input PortfolioModelInput {
        id : String
        title : String
        urls : [String]
        companyHistory : [WorkedCompanyModelInput]
    }

    input CertificationModelInput {
        id : String
        title : String
    }

    input RewardTargetModelInput {
        id : String
        title : String
    }

    input RewardModelInput {
        id : String
        title : String
    }

    input BankModelInput {
        id : String
        title : String
    }

    input MyHomeModelInput {
        id : String
        title : String
    }

    input PreSaleRightModelInput {
        id : String
        title : String
    }

    input SubscriptionModelInput {
        id : String
        title : String
    }

    input CheapOfficeModelInput {
        id : String
        title : String
    }

    type Query{
        readJobFairs : [JobFairModel]
        readJobContests : [JobContestModel]
        readCertifications : [CertificationModel]
        readPortfolios : [PortfolioModel]
        readCompanies : [CompanyModel]

        readRewards : [RewardModel]
        readBanks : [BankModel]

        readMyHome : [MyHomeModel]
        readPreSaleRights : [PreSaleRightModel]
        readSubscriptions : [SubscriptionModel]
        readCheapOffices : [CheapOfficeModel]
    }

    type Mutation {
        createJobFairModel(model: JobFairModelInput): JobFairModel
        createJobContestModel(model: JobContestModelInput): JobContestModel
        createCertificationModel(model: CertificationModelInput): CertificationModel
        createPortfolioModel(model: PortfolioModelInput): PortfolioModel
        createCompanyModel(model: CompanyModelInput): CompanyModel
    
        createRewardModel(model: RewardModelInput): RewardModel
        createBankModel(model: BankModelInput): BankModel
    
        createMyHomeModel(model: MyHomeModelInput): MyHomeModel
        createPreSaleRightModel(model: PreSaleRightModelInput): PreSaleRightModel
        createSubscriptionModel(model: SubscriptionModelInput): SubscriptionModel
        createCheapOfficeModel(model: CheapOfficeModelInput): CheapOfficeModel
    
        updateJobFairModel(model: JobFairModelInput): JobFairModel
        updateJobContestModel(model: JobContestModelInput): JobContestModel
        updateCertificationModel(model: CertificationModelInput): CertificationModel
        updatePortfolioModel(model: PortfolioModelInput): PortfolioModel
        updateCompanyModel(model: CompanyModelInput): CompanyModel
    
        updateRewardModel(model: RewardModelInput): RewardModel
        updateBankModel(model: BankModelInput): BankModel
    
        updateMyHomeModel(model: MyHomeModelInput): MyHomeModel
        updatePreSaleRightModel(model: PreSaleRightModelInput): PreSaleRightModel
        updateSubscriptionModel(model: SubscriptionModelInput): SubscriptionModel
        updateCheapOfficeModel(model: CheapOfficeModelInput): CheapOfficeModel
    
        deleteJobFairModel(id: String): JobFairModel
        deleteJobContestModel(id: String): JobContestModel
        deleteCertificationModel(id: String): CertificationModel
        deletePortfolioModel(id: String): PortfolioModel
        deleteCompanyModel(id: String): CompanyModel

        deleteRewardModel(id: String): RewardModel
        deleteBankModel(id: String): BankModel

        deleteMyHomeModel(id: String): MyHomeModel
        deletePreSaleRightModel(id: String): PreSaleRightModel
        deleteSubscriptionModel(id: String): SubscriptionModel
        deleteCheapOfficeModel(id: String): CheapOfficeModel
    }
`;


export {
    customTypeDefs
}

/*

const customTypeDefs = gql`
    type JobPortfolio {
        id : ID!
        userID : String
        hasJob : Bool
        workMonth : Int
        jobSkill : [String]
        portfolioURL : [String]
        certification : [String]
        languages : [String]
        education : String
        workedCompany : [WorkedCompany]
    }

    type WorkedCompany {
        userID : ID!
        companyTitle : String
        workStart : String
        workEnd : String
        position : String
    }

    type Query{
        readJobPortfolio(userID : String!)
        readJobPortfolios : [JobPortfolio]

        ping: String
        authenticate(username: String, password: String): String
        me: User
        users: [User]
    }

    type User {
        username: String!
        email: String!
    }
`;


*/
