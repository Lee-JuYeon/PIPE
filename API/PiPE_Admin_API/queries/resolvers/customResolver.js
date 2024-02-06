import {
    ApolloServer,
    gql, 
    ApolloError, 
    AuthenticationError
} from 'apollo-server';
import {
    // postgraphileDB,
    dummyDB,
    dummyJobDB
} from '../../db/postgraphile.js';

const customResolver = {
    Query : {
        readJobFairs: async (parent, args, context, info) => {
            try {
                // const jobFairs = await dummyJobDB.jobFairs; 
                const jobFairs = dummyJobDB.jobFairs;
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
    },
    Mutation : {
        createJobFairModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createJobContestModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createCertificationModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createPortfolioModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createCompanyModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createRewardModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createBankModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createMyHomeModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createPreSaleRightModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createSubscriptionModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },
        createCheapOfficeModel: async (parent, { model }, context, info) => {
            try {
                // const jobContests = await fetchJobContestsFromDatabase(); 
                const jobContests = dummyJobDB.jobContests
                return jobContests;
            } catch (error) {
                console.error('Error fetching job contests:', error);
                throw error;
            }
        },

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
        },

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
    }
}

export {
    customResolver
}


// if (!user) throw new AuthenticationError("not authenticated");
// if (!user.roles.includes("admin"))
//   throw new ForbiddenError("not authorized");

// const orm = require('./../postgraphile');


// const customResolver = {
//   Query : {
//       readJobPortfolio : async (_, args, { user }) => {
//           let conn;
//           try {
//             if (!user) {
//                 throw new Error('Unauthorized');
//             }
//               conn = await pool.getConnection();
//               const rows = await conn.query('SELECT * FROM users');
//               return rows;
//           } catch (err) {
//               throw err;
//           } finally {
//               if (conn) conn.end();
//           }
//       },
//       readJobPortfolios : async (_, args, { user }) => {
//           let conn;
//           try {
//             if (!user) {
//                 throw new Error('Unauthorized');
//             }
//               conn = await pool.getConnection();
//               const rows = await conn.query('SELECT * FROM users');
//               return rows;
//           } catch (err) {
//               throw err;
//           } finally {
//               if (conn) conn.end();
//           }
//       },
//       // allUsers: () => {
//       //     throw new Error("allUsers query failed");
//       //   },
//       // user: (_, { id }) => {
//       //     if (id < 0)
//       //       throw new ApolloError("id must be non-negative", "INVALID_ID", {
//       //         parameter: "id"
//       //       });
//       //     return {
//       //       id,
//       //       email: `test${id}@email.com`
//       //     };
//       // }
//       ping: () => "pong",
//       authenticate: (parent, { username, password }) => {
//           const found = users.find(
//               user => user.username === username && user.password === password
//           );
//           console.log(found);
//           return found && found.token;
//       },
//       me: (parent, args, { user }) => {
//           if (!user) throw new AuthenticationError("not authenticated");
//           return user;
//       },
//       users: (parent, args, { user }) => {
//           if (!user) throw new AuthenticationError("not authenticated");
//           if (!user.roles.includes("admin"))
//               throw new ForbiddenError("not authorized");
//           return users;
//       }
//   }
// }

// module.exports = {
//     customResolver : customResolver
// }