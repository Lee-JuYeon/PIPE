import { 
    postgraphileDB,
    dummyDB,
    dummyJobDB 
} from "../../../db/customPostgresQL.js";

const readResolvers = {
    readJobFairs: async (parent, args, context, info) => {
        try {
            // const jobFairs = await dummyJobDB.jobFairs; 
            const jobFairs = dummyJobDB.jobFairs;
            const jobContests = await postgraphileDB.request('query', `
                query {
                    jobContests {
                        id
                        name
                        description
                        # Fetch other relevant fields
                    }
                }
            `);
            return jobFairs;
        } catch (error) {
            console.error('Error fetching job fairs:', error);
            throw error;
        }
    },
    readJobContests: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readCertifications: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readPortfolios: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readCompanies: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readRewards: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readBanks: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readMyHome: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readPreSaleRights: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readSubscriptions: async (parent, args, context, info) => {
        try {
            // const jobContests = await fetchJobContestsFromDatabase(); 
            const jobContests = dummyJobDB.jobContests
            return jobContests;
        } catch (error) {
            console.error('Error fetching job contests:', error);
            throw error;
        }
    },
    readCheapOffices: async (parent, args, context, info) => {
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
    readResolvers
};