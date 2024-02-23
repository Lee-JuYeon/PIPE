import { 
    postgraphileDB,
    dummyDB,
    dummyJobDB 
} from "../../../db/customPostgresQL.js";

const deleteResolvers = {
    deleteJobFairModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteJobContestModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteCertificationModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deletePortfolioModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteCompanyModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteRewardModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteBankModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteMyHomeModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deletePreSaleRightModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteSubscriptionModel: async (parent, { model }, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    deleteCheapOfficeModel: async (parent, { model }, context, info) => {
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
    deleteResolvers
}