import { 
    postgraphileDB,
    dummyDB,
    dummyJobDB 
} from "../../../db/customPostgresQL.js";

const updateResolvers = {
    updateJobFairModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateJobContestModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateCertificationModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updatePortfolioModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateCompanyModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateRewardModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateBankModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateMyHomeModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updatePreSaleRightModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateSubscriptionModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    updateCheapOfficeModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    }
};

export {
    updateResolvers
}