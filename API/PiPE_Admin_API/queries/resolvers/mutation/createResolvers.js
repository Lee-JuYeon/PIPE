import { 
    postgraphileDB,
    dummyDB,
    dummyJobDB 
} from "../../../db/customPostgresQL.js";

const createJobFairModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createJobContestModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createCertificationModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createPortfolioModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createCompanyModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createRewardModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createBankModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createMyHomeModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createPreSaleRightModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createSubscriptionModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createCheapOfficeModel = async (parent, { model }, context, info) => {
    try {
        // const jobContests = await fetchJobContestsFromDatabase(); 
        const jobContests = dummyJobDB.jobContests
        return jobContests;
    } catch (error) {
        console.error('Error fetching job contests:', error);
        throw error;
    }
}

const createResolvers = {
    createJobFairModel,
    createJobContestModel,
    createCertificationModel,
    createPortfolioModel,
    createCompanyModel,
    createRewardModel,
    createBankModel,
    createMyHomeModel,
    createPreSaleRightModel,
    createSubscriptionModel,
    createCheapOfficeModel
};

export {
    createResolvers
}