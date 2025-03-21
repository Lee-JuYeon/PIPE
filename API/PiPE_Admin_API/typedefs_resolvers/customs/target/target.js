import {
    ApolloServer,
    gql, 
    ApolloError, 
    AuthenticationError
} from 'apollo-server';

const typeDefs = gql`
    enum BirthState {
        PARENTS_TO_BE
        INFERTILITY
        EXPECTING_MOTHER
        BIRTH
        ADOPTION
        NA
    }
    enum EducationLevel {
        PrimarySchool
        MiddleSchool
        HighSchool
        College
        University
        GraduateSchool
    }
    enum FamilyOption {
        MultiChildFamily
        HomelessHouseHold
        Newcomer
        ExtendedFamily
        MulticulturalFamily
        NothKoreanDefector
        SingleParentFamily
        GrandparentFamily
        OnePersonFamily
        NA
    } 
    enum Gender {
        MALE
        FEMALE
        BOTH
    }
    enum IncomeState {
        ZERO_FIFTY
        FIFTY_SEVENTYFIVE
        SEVENTYSIX_HUNDRED
        HUNDREDONE_TWOHUNDRED
        TWOHUNDRED_OVER
    }
    enum JobCategory {
        Agriculture
        Fishing
        ETC
    }
    enum PlusOption {
        PersonWithDisablity
        Veterans
        PersonWithIllnesses
        NA
    }
    enum StartUpState {
        PreStartUp
        InBusiness
        StrugglingFinancially
        ClosingDownSoon
        NA
    }
    enum WorkingState {
        WORKER
        NOWORKER
    }

    type TargetModel {
        address : String?
        gender : Gender
        age : Int
        educationLevel : EducationLevel
        familyOption : FamilyOption
        workingState : WorkingState
        incomeState : IncomeState
        birthState : BirthState
        jobCategory : JobCategory
        plusOption : PlusOption
        startUpState : StartUpState
    }

    input TargetInput {
        address : String?
        gender : Gender
        age : Int
        educationLevel : EducationLevel
        familyOption : FamilyOption
        workingState : WorkingState
        incomeState : IncomeState
        birthState : BirthState
        jobCategory : JobCategory
        plusOption : PlusOption
        startUpState : StartUpState
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