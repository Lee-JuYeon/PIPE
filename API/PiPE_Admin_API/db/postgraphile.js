import dotenv from 'dotenv';
dotenv.config();

// import postgraphile from 'postgraphile';

// const postgraphileDB = postgraphile(
//     {
//         database: process.env.DB_NAME,
//         user: process.env.DB_USER,
//         password: process.env.DB_PW,
//         host: process.env.DB_HOST,
//         port: process.env.DB_PORT,
//     },
//     'public',
//     {
//         watchPg: true,
//         graphiql: true,
//         enhanceGraphiql: true,
//     }
// )


const dummyDB = [
    {
        id: 1,
        role: "admin",
        email: "cavss1118@gmail.com",
        expiredDate: 20,
        purpose: "admin webpage 연결하여 langchain으로 웹페이지를 통해 데이터 입력"
    },
    {
        id: 2,
        role: "client",
        email: "benedictarthur1026@gmail.com",
        expiredDate: 20,
        purpose: "pipe ios, android 배포용 get만사용가능."
    },
    {
        id: 3,
        role: "client",
        email: "pizzalover114@naver.com",
        expiredDate: 20,
        purpose: "pie ios, android 테스트용."
    }
]

const dummyJobDB = {
    jobFairs: [
      {
        address: '서울특별시 강남구 역삼동 621-10',
        title: '2024 서울 채용박람회',
        by: '서울특별시',
        field: 'IT/SW',
        date: '2024-02-25',
        url: 'https://seoul.jobkorea.co.kr/fair/',
      },
      {
        address: '부산광역시 해운대구 우동 1453-1',
        title: '2024 부산 채용박람회',
        by: '부산광역시',
        field: '관광/레저',
        date: '2024-03-11',
        url: 'https://busan.jobkorea.co.kr/fair/',
      },
      {
        address: '대구광역시 중구 동성로 168',
        title: '2024 대구 채용박람회',
        by: '대구광역시',
        field: '제조업',
        date: '2024-04-22',
        url: 'https://daegu.jobkorea.co.kr/fair/',
      },
    ],
    jobContests: [
      {
        address: '서울특별시 강남구 역삼동 621-10',
        title: '2024 서울 코딩대회',
        by: '서울특별시',
        field: 'IT/SW',
        applyPeriod: '2024-02-25 ~ 2024-03-15',
        url: 'https://seoul.jobkorea.co.kr/contest/',
        subTitle: '서울시 주최 코딩대회',
        requirement: '고등학생 이상',
      },
      {
        address: '부산광역시 해운대구 우동 1453-1',
        title: '2024 부산 스타트업 경진대회',
        by: '부산광역시',
        field: '벤처/창업',
        applyPeriod: '2024-03-11 ~ 2024-04-20',
        url: 'https://busan.jobkorea.co.kr/contest/',
        subTitle: '부산시 주최 스타트업 경진대회',
        requirement: '창업 3년 이내 기업',
      },
      {
        address: '대구광역시 중구 동성로 168',
        title: '2024 대구 게임대회',
        by: '대구광역시',
        field: 'IT/SW',
        applyPeriod: '2024-04-22 ~ 2024-05-15',
        url: 'https://daegu.jobkorea.co.kr/contest/',
        subTitle: '대구시 주최 게임대회',
        requirement: '고등학생 이상',
      },
    ],
  };
  

export {
    // postgraphileDB,
    dummyDB,
    dummyJobDB
};
