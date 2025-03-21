package com.cavss.pipe.repository

import com.cavss.pipe.dummy.Dummy
import com.cavss.pipe.model.job.jobfair.JobfairModel
import com.cavss.pipe.model.job.certification.CertificationModel
import com.cavss.pipe.model.job.contest.ContestModel
import com.cavss.pipe.model.job.employment.EmploymentModel
import com.cavss.pipe.model.money.support.SupportModel

class PipeRepository() {
    suspend fun getSupportModelList() : List<SupportModel>{
        return Dummy.dummy_supportlist()
    }

    suspend fun getJobFairModelList() : List<JobfairModel>{
        val jobfairList = mutableListOf<JobfairModel>(
            JobfairModel(
                mapOf("startDate" to "2023-05-01", "endDate" to "0000-00-00"),
                "10:00 ~ 17:00",
                "Seoul, South Korea",
                "ABC Company - Software Engineer",
                mapOf("email" to "abc@example.com", "phone" to "123-456-7890"),
                "https://example.com/jobfair1",
                listOf("Free snacks and drinks", "Career counseling available"),
                "https://news.nateimg.co.kr/orgImg/at/2021/02/07/2021020701000697900043321.jpg"
            ),
            JobfairModel(
                mapOf("startDate" to "2023-06-01", "endDate" to "2023-06-03"),
                "10:00 ~ 17:00",
                "Busan, South Korea",
                "XYZ Corporation - Marketing Specialist",
                mapOf("email" to "xyz@example.com", "phone" to "987-654-3210"),
                "https://example.com/jobfair2",
                listOf("Free swags for participants"),
                "https://img3.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202302/20/hairfit/20230220100158147qunc.jpg"
            ),
            JobfairModel(
                mapOf("startDate" to "2023-07-01", "endDate" to "2023-07-03"),
                "10:00 ~ 17:00",
                "New York, USA",
                "EFG Inc. - Data Analyst",
                mapOf("email" to "efg@example.com", "phone" to "555-555-5555"),
                "https://example.com/jobfair3",
                listOf("Free resume check-up service"),
                "https://www.kmaeil.com/news/photo/202212/378931_204597_5814.jpg"
            ),
            JobfairModel(
                mapOf("startDate" to "2023-08-01", "endDate" to "2023-08-03"),
                "10:00 ~ 17:00",
                "Tokyo, Japan",
                "HIJ Ltd. - Sales Representative",
                mapOf("email" to "hij@example.com", "phone" to "111-222-3333"),
                "https://example.com/jobfair4",
                listOf("Networking opportunities with industry professionals"),
                "https://img1.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202204/15/sportskhan/20220415164341712rfla.jpg"
            ),
            JobfairModel(
                mapOf("startDate" to "2023-09-01", "endDate" to "2023-09-03"),
                "10:00 ~ 17:00",
                "Paris, France",
                "KLM SARL - Financial Analyst",
                mapOf("email" to "klm@example.com", "phone" to "444-555-6666"),
                "https://example.com/jobfair5",
                listOf("Free LinkedIn profile photo shooting"),
                "https://cdn.spotvnews.co.kr/news/photo/202301/582469_809168_930.jpg"
            )
        )
        return jobfairList
    }
    suspend fun getJobEmploymentModelList() : List<EmploymentModel>{
        var list = mutableListOf<EmploymentModel>(
            EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            ),
            EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            ),
            EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            ),
            EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            ),EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            ),
            EmploymentModel(
                employmentTitle = "Software Engineer",
                businessSector = "IT",
                workerCount = 100,
                companyType = "Corporation",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Dental Insurance, Retirement Plan",
                experienceTime = "3 years",
                education = "Bachelor's degree",
                skill = "Java, Kotlin, Spring Framework",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Send your resume to hr@example.com",
                applyResult = "Interview scheduled on June 5th",
                jobPosition = "Software Engineer",
                jobResponsibility = "Developing and maintaining software systems",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Design and develop software applications",
                hireCount = 5,
                address = "123 Example St., Suite 100, Anytown, USA",
                applyRequirements = "3+ years of experience in software development",
                preferredQualification = "Experience with Spring Boot",
                processDetail = mapOf("document screening" to "May 15th", "interview" to "June 5th"),
                caution = "Please do not contact us regarding this position",
                major = "Computer Science"
            ),
            EmploymentModel(
                employmentTitle = "Marketing Manager",
                businessSector = "Advertising",
                workerCount = 50,
                companyType = "Start-up",
                companyHomepage = "www.example.com",
                walfare = "Health Insurance, Flexible work hours",
                experienceTime = "5 years",
                education = "Bachelor's degree",
                skill = "Marketing strategy, Communication",
                applyPeriod = mapOf("start" to "2023-05-01", "end" to "2023-05-31"),
                howToApply = "Submit your resume and cover letter on our website",
                applyResult = "Interview scheduled on June 7th",
                jobPosition = "Marketing Manager",
                jobResponsibility = "Planning and executing marketing campaigns",
                companyName = "Example Corp.",
                employmentType = "Full-time",
                employmentPay = "Negotiable",
                jobDuty = "Develop and implement marketing strategies",
                hireCount = 1,
                address = "456 Example St., Suite 200, Anytown, USA",
                applyRequirements = "5+ years of experience in marketing",
                preferredQualification = "Experience in digital marketing",
                processDetail = mapOf("document screening" to "May 25th", "interview" to "June 7th"),
                caution = "Only shortlisted candidates will be contacted",
                major = "Marketing"
            )
        )
        return list
    }
    suspend fun getJobContestModelList() : List<ContestModel>{
        var list = mutableListOf<ContestModel>(
            ContestModel(
                "제 1회 코딩 대회",
                "알고리즘 문제 해결",
                "초/중/고등학생",
                "100명",
                "코딩 대회입니다.",
                mapOf("1위" to "100만원 상금", "2위" to "50만원 상금"),
                mapOf("접수 시작일" to "2023-05-01", "접수 종료일" to "2023-05-15"),
                mapOf("문의 전화번호" to "010-1234-5678", "이메일" to "codingcontest@gmail.com"),
                "코딩 커뮤니티",
                "초/중/고등학생 누구나 참가 가능",
                "온라인으로 접수하세요",
                "서울시 종로구",
                "http://codingcontest.com",
                "성적 우수자 제외"
            ),
            ContestModel(
                "우리동네 나눔책방 공모전",
                "지역사회 공헌",
                "전국",
                "50개",
                "우리동네 나눔책방 설치사업",
                mapOf("1위" to "500만원 상금", "2위" to "300만원 상금", "3위" to "100만원 상금"),
                mapOf("접수 시작일" to "2023-06-01", "접수 종료일" to "2023-07-31"),
                mapOf("문의 전화번호" to "02-1234-5678", "이메일" to "bookshare@gmail.com"),
                "한국나눔재단",
                "개인 또는 단체로 참가 가능",
                "우리동네 나눔책방 설치 계획서 제출",
                "대한민국 전역",
                "http://bookshare.kr",
                null
            ),
            ContestModel(
                contestTitle = "제1회 그림이 전하는 지역의 멋과 사랑",
                contestSubject = "우리 동네를 그리다",
                target = "일반인",
                size = "지역주민 100명",
                mainContent = "우리 동네의 풍경, 문화재, 사람들을 그림으로 표현해주세요.",
                reward = mapOf(
                    "대상" to "100만원",
                    "최우수상" to "50만원",
                    "우수상" to "20만원"
                ),
                applyPeriod = mapOf(
                    "접수기간" to "2023.05.01 ~ 2023.06.30",
                    "심사기간" to "2023.07.01 ~ 2023.07.31",
                    "결과발표" to "2023.08.10"
                ),
                serviceCall = mapOf(
                    "문의처" to "010-1234-5678",
                    "이메일" to "contest@example.com"
                ),
                companyTitle = "OO동네 화랑",
                applyRequirement = "만 14세 이상 일반인",
                howToApply = "인터넷 접수",
                address = "서울특별시 OO구 OO동",
                contestHomePage = "https://contest.example.com",
                exceptionTarget = "전문작가, 대학생, 중·고등학생"
            ),
            ContestModel(
                contestTitle = "2023년 서울시 공원 아이디어 공모전",
                contestSubject = "서울시 공원을 더욱 즐겁게",
                target = "일반인",
                size = "상금총액 500만원",
                mainContent = "서울시 공원의 편리하고 즐거운 이용을 위한 아이디어를 제안해주세요.",
                reward = mapOf(
                    "대상" to "200만원",
                    "최우수상" to "100만원",
                    "우수상" to "50만원",
                    "장려상" to "20만원"
                ),
                applyPeriod = mapOf(
                    "접수기간" to "2023.04.01 ~ 2023.05.31",
                    "심사기간" to "2023.06.01 ~ 2023.06.30",
                    "결과발표" to "2023.07.10"
                ),
                serviceCall = mapOf(
                    "문의처" to "02-1234-5678",
                    "이메일" to "parkcontest@example.com"
                ),
                companyTitle = "서울시",
                applyRequirement = "만 14세 이상 일반인",
                howToApply = "인터넷 접수",
                address = "서울특별시 중구 태평로1가 31 서울시청",
                contestHomePage = "https://contest.example.com",
                exceptionTarget = "전문작가, 대학생, 중·고등학생"
            )
        )
        return list
    }
    suspend fun getJobCertificationModelList() : List<CertificationModel> {
        var list = mutableListOf<CertificationModel>(
            CertificationModel("국가전문자격 자격증", "2022", "2", "A01", "국가전문자격", "영어 실력 검증을 위한 자격증", "2022-07-01", "2022-07-30", "2022-08-15", "2022-08-20", "2022-09-01", "2022-10-01", "2022-10-30", "2022-11-15", "2022-11-20", "2022-12-01"),
            CertificationModel("일학습병행자격 자격증", "2022", "1", "B01", "일학습병행자격", "금융 전문가 자격증", "2022-08-01", "2022-08-31", "2022-09-15", "2022-09-20", "2022-10-01", "2022-11-01", "2022-11-30", "2022-12-15", "2022-12-20", "2023-01-01"),
            CertificationModel("과정평가형자격 자격증", "2022", "2", "C01", "과정평가형자격", "프로젝트 관리자 자격증", "2022-06-01", "2022-06-30", "2022-07-15", "2022-07-20", "2022-08-01", "2022-09-01", "2022-09-30", "2022-10-15", "2022-10-20", "2022-11-01"),
            CertificationModel("국가기술자격 자격증", "2022", "1", "D01", "국가기술자격", "회계사 자격증", "2022-09-01", "2022-09-30", "2022-10-15", "2022-10-20", "2022-11-01", "2022-12-01", "2022-12-31", "2023-01-15", "2023-01-20", "2023-02-01"),
            CertificationModel("기타 자격증", "2022", "기타", "E01", "기타", "AWS 클라우드 전문가 자격증", "2022-07-01", "2022-07-31", "2022-08-15", "2022-08-20", "2022-09-01", "2022-10-01", "2022-10-31", "2022-11-15", "2022-11-20", "2022-12-01")
        )
        return list
    }

//    suspend fun getSavingFixedDepositLst() : List<FixedDepositDTO>{
//        // 은행
//        val apiService1 = RetrofitManager.getBankClient().getBankDepositProductList(
//            BuildConfig.api_get_bank,
//            "020000",
//            1
//        )
//        // 여신전문
//        val apiService2 = RetrofitManager.getBankClient().getBankDepositProductList(
//            BuildConfig.api_get_bank,
//            "030200",
//            1
//        )
//        // 저축은행
//        val apiService3 = RetrofitManager.getBankClient().getBankDepositProductList(
//            BuildConfig.api_get_bank,
//            "030300",
//            1
//        )
//        // 보험
//        val apiService4 = RetrofitManager.getBankClient().getBankDepositProductList(
//            BuildConfig.api_get_bank,
//            "050000",
//            1
//        )
//        // 금융투자
//        val apiService5 = RetrofitManager.getBankClient().getBankDepositProductList(
//            BuildConfig.api_get_bank,
//            "060000",
//            1
//        )
//        val emptyList = mutableListOf<FixedDepositDTO>()
//        val apiServiceList = listOf(apiService1, apiService2, apiService3, apiService4, apiService5)
//        apiServiceList.map {
//            if (it.isSuccessful){
//                val baseList = it.body()?.result?.baseList!!
//                val optionList = it.body()?.result?.optionList!!
//                for (i in baseList.indices){
//                    var model = FixedDepositDTO(
//                        dcls_month = baseList[i].dcls_month,
//                        bankName = baseList[i].kor_co_nm,
//                        productName = baseList[i].fin_prdt_nm,
//                        joinWay = baseList[i].join_way,
//                        mtrt_int = baseList[i].mtrt_int,
//                        spcl_cnd = baseList[i].spcl_cnd,
//                        join_deny = baseList[i].join_deny,
//                        join_member = baseList[i].join_member,
//                        etc_note = baseList[i].etc_note,
//                        max_limit = baseList[i].max_limit,
//                        dcls_strt_day = baseList[i].dcls_strt_day,
//                        dcls_end_day = baseList[i].dcls_end_day,
//                        fin_co_subm_day = baseList[i].fin_co_subm_day,
//                        option = arrayListOf()
//                    )
//                    for (j in optionList.indices){
//                        if (baseList[i].fin_co_no == optionList[j].fin_co_no &&
//                            baseList[i].fin_prdt_cd == optionList[j].fin_prdt_cd){
//                            model.option.add(optionList[j])
//                        }
//                    }
//                    emptyList.add(model)
//                }
//            }
//        }
//        return emptyList
//    }
//    suspend fun getSavingDepositList() : List<SavingsDTO>{
//        // 은행
//        val apiService1 = RetrofitManager.getBankClient().getBankSavingProductList(
//            BuildConfig.api_get_bank,
//            "020000",
//            1
//        )
//        // 여신전문
//        val apiService2 = RetrofitManager.getBankClient().getBankSavingProductList(
//            BuildConfig.api_get_bank,
//            "030200",
//            1
//        )
//        // 저축은행
//        val apiService3 = RetrofitManager.getBankClient().getBankSavingProductList(
//            BuildConfig.api_get_bank,
//            "030300",
//            1
//        )
//        // 보험
//        val apiService4 = RetrofitManager.getBankClient().getBankSavingProductList(
//            BuildConfig.api_get_bank,
//            "050000",
//            1
//        )
//        // 금융 투자
//        val apiService5 = RetrofitManager.getBankClient().getBankSavingProductList(
//            BuildConfig.api_get_bank,
//            "060000",
//            1
//        )
//        val apiServiceList = listOf(apiService1, apiService2, apiService3, apiService4, apiService5)
//        val emptyList = mutableListOf<SavingsDTO>()
//        apiServiceList.map {
//            if (it.isSuccessful){
//                val baseList = it.body()?.result?.baseList!!
//                val optionList = it.body()?.result?.optionList!!
//                for (i in baseList.indices){
//                    var model = SavingsDTO(
//                        dcls_month = baseList[i].dcls_month,
//                        bankName = baseList[i].kor_co_nm,
//                        productName = baseList[i].fin_prdt_nm,
//                        joinWay = baseList[i].join_way,
//                        mtrt_int = baseList[i].mtrt_int,
//                        spcl_cnd = baseList[i].spcl_cnd,
//                        join_deny = baseList[i].join_deny,
//                        join_member = baseList[i].join_member,
//                        etc_note = baseList[i].etc_note,
//                        max_limit = baseList[i].max_limit,
//                        dcls_strt_day = baseList[i].dcls_strt_day,
//                        dcls_end_day = baseList[i].dcls_end_day,
//                        fin_co_subm_day = baseList[i].fin_co_subm_day,
//                        option = arrayListOf()
//                    )
//                    for (j in optionList.indices){
//                        if (baseList[i].fin_co_no == optionList[j].fin_co_no &&
//                            baseList[i].fin_prdt_cd == optionList[j].fin_prdt_cd){
//                            model.option.add(optionList[j])
//                        }
//                    }
//                    emptyList.add(model)
//                }
//            }
//        }
//        return emptyList
//    }
//    suspend fun getSavingPensionList() : List<PensionSavingsDTO>{
//        // 은행
//        val apiService1 = RetrofitManager.getBankClient().getBankAnnuitySavingProductList(
//            BuildConfig.api_get_bank,
//            "020000",
//            "1"
//        )
//        // 여신전문
//        val apiService2 = RetrofitManager.getBankClient().getBankAnnuitySavingProductList(
//            BuildConfig.api_get_bank,
//            "030200",
//            "1"
//        )
//
//        // 저축은행
//        val apiService3 = RetrofitManager.getBankClient().getBankAnnuitySavingProductList(
//            BuildConfig.api_get_bank,
//            "030300",
//            "1"
//        )
//
//        // 보험
//        val apiService4 = RetrofitManager.getBankClient().getBankAnnuitySavingProductList(
//            BuildConfig.api_get_bank,
//            "050000",
//            "1"
//        )
//        // 금융투자
//        val apiService5 = RetrofitManager.getBankClient().getBankAnnuitySavingProductList(
//            BuildConfig.api_get_bank,
//            "060000",
//            "1"
//        )
//        val apiServiceList = listOf(apiService1, apiService2, apiService3, apiService4, apiService5)
//        val emptyList = mutableListOf<PensionSavingsDTO>()
//        apiServiceList.map {
//            if (it.isSuccessful){
//                val baseList = it.body()?.result?.baseList!!
//                val optionList = it.body()?.result?.optionList!!
//                for (i in baseList.indices){
//                    var model = PensionSavingsDTO(
//                        dcls_month = baseList[i].dcls_month,
//                        bankName = baseList[i].kor_co_nm,
//                        productName = baseList[i].fin_prdt_nm,
//                        join_way = baseList[i].join_way,
//                        pnsn_kind = baseList[i].pnsn_kind,
//                        pnsn_kind_nm = baseList[i].pnsn_kind_nm,
//                        sale_strt_day = baseList[i].sale_strt_day,
//                        mntn_cnt = baseList[i].mntn_cnt,
//                        prdt_type = baseList[i].prdt_type,
//                        prdt_type_nm = baseList[i].prdt_type_nm,
//                        avg_prft_rate = baseList[i].avg_prft_rate,
//                        dcls_rate = baseList[i].dcls_rate,
//                        guar_rate = baseList[i].guar_rate,
//                        btrm_prft_rate_1 = baseList[i].btrm_prft_rate_1,
//                        btrm_prft_rate_2 = baseList[i].btrm_prft_rate_2,
//                        btrm_prft_rate_3 = baseList[i].btrm_prft_rate_3,
//                        etc = baseList[i].etc,
//                        sale_co = baseList[i].sale_co,
//                        dcls_strt_day = baseList[i].dcls_strt_day,
//                        dcls_end_day = baseList[i].dcls_end_day,
//                        fin_co_subm_day = baseList[i].fin_co_subm_day,
//                        option = arrayListOf()
//                    )
//                    for (j in optionList.indices){
//                        if (baseList[i].fin_co_no == optionList[j].fin_co_no &&
//                            baseList[i].fin_prdt_cd == optionList[j].fin_prdt_cd){
//                            model.option.add(optionList[j])
//                        }
//                    }
//                    emptyList.add(model)
//                }
//            }
//        }
//        return emptyList
//    }
//
//    suspend fun getLoanMortgageList() : List<MortgageLoanDTO>{
//        // 은행
//        val apiService1 = RetrofitManager.getBankClient().getLoanMortgageList(
//            BuildConfig.api_get_bank,
//            "020000",
//            "1"
//        )
//        // 여신전문
//        val apiService2 = RetrofitManager.getBankClient().getLoanMortgageList(
//            BuildConfig.api_get_bank,
//            "030200",
//            "1"
//        )
//        // 저축은행
//        val apiService3 = RetrofitManager.getBankClient().getLoanMortgageList(
//            BuildConfig.api_get_bank,
//            "030300",
//            "1"
//        )
//        // 보험
//        val apiService4 = RetrofitManager.getBankClient().getLoanMortgageList(
//            BuildConfig.api_get_bank,
//            "050000",
//            "1"
//        )
//        // 금융투자
//        val apiService5 = RetrofitManager.getBankClient().getLoanMortgageList(
//            BuildConfig.api_get_bank,
//            "060000",
//            "1"
//        )
//        val apiServiceList = listOf(apiService1, apiService2, apiService3, apiService4, apiService5)
//        val emptyList = mutableListOf<MortgageLoanDTO>()
//        apiServiceList.map {
//            if (it.isSuccessful){
//                val baseList = it.body()?.result?.baseList!!
//                val optionList = it.body()?.result?.optionList!!
//                for (i in baseList.indices){
//                    var model = MortgageLoanDTO(
//                        dcls_month = baseList[i].dcls_month,
//                        kor_co_nm = baseList[i].kor_co_nm,
//                        fin_prdt_nm = baseList[i].fin_prdt_nm,
//                        join_way = baseList[i].join_way,
//                        loan_inci_expn = baseList[i].loan_inci_expn,
//                        erly_rpay_fee = baseList[i].erly_rpay_fee,
//                        dly_rate = baseList[i].dly_rate,
//                        loan_lmt = baseList[i].loan_lmt,
//                        dcls_strt_day = baseList[i].dcls_strt_day,
//                        dcls_end_day = baseList[i].dcls_end_day,
//                        fin_co_subm_day = baseList[i].fin_co_subm_day,
//                        optionList = arrayListOf()
//                    )
//                    for (j in optionList.indices){
//                        if (baseList[i].fin_co_no == optionList[j].fin_co_no &&
//                            baseList[i].fin_prdt_cd == optionList[j].fin_prdt_cd){
//                            model.optionList.add(optionList[j])
//                        }
//                    }
//                    emptyList.add(model)
//                }
//            }
//        }
//        return emptyList
//    }
//    suspend fun getLoanRentHouselist() : List<RentHouseLoanDTO>{
//        // 은행
//        val apiService1 = RetrofitManager.getBankClient().getLoanRentHouseList(
//            BuildConfig.api_get_bank,
//            "020000",
//            "1"
//        )
//        // 여신전문
//        val apiService2 = RetrofitManager.getBankClient().getLoanRentHouseList(
//            BuildConfig.api_get_bank,
//            "030200",
//            "1"
//        )
//        // 저축은행
//        val apiService3 = RetrofitManager.getBankClient().getLoanRentHouseList(
//            BuildConfig.api_get_bank,
//            "030300",
//            "1"
//        )
//        // 보험
//        val apiService4 = RetrofitManager.getBankClient().getLoanRentHouseList(
//            BuildConfig.api_get_bank,
//            "050000",
//            "1"
//        )
//        // 금융투자
//        val apiService5 = RetrofitManager.getBankClient().getLoanRentHouseList(
//            BuildConfig.api_get_bank,
//            "060000",
//            "1"
//        )
//        val apiServiceList = listOf(apiService1, apiService2, apiService3, apiService4, apiService5)
//        val emptyList = mutableListOf<RentHouseLoanDTO>()
//        apiServiceList.map {
//            if (it.isSuccessful){
//                val baseList = it.body()?.result?.baseList!!
//                val optionList = it.body()?.result?.optionList!!
//                for (i in baseList.indices){
//                    var model = RentHouseLoanDTO(
//                        dcls_month = baseList[i].dcls_month,
//                        fin_co_no = baseList[i].fin_co_no,
//                        fin_prdt_cd = baseList[i].fin_prdt_cd,
//                        kor_co_nm = baseList[i].kor_co_nm,
//                        fin_prdt_nm = baseList[i].fin_prdt_nm,
//                        join_way = baseList[i].join_way,
//                        loan_inci_expn = baseList[i].loan_inci_expn,
//                        erly_rpay_fee = baseList[i].erly_rpay_fee,
//                        dly_rate = baseList[i].dly_rate,
//                        loan_lmt = baseList[i].loan_lmt,
//                        dcls_strt_day = baseList[i].dcls_strt_day,
//                        dcls_end_day = baseList[i].dcls_end_day,
//                        fin_co_subm_day = baseList[i].fin_co_subm_day,
//                        optionList = arrayListOf()
//                    )
//                    for (j in optionList.indices){
//                        if (baseList[i].fin_co_no == optionList[j].fin_co_no &&
//                            baseList[i].fin_prdt_cd == optionList[j].fin_prdt_cd){
//                            model.optionList.add(optionList[j])
//                        }
//                    }
//                    emptyList.add(model)
//                }
//            }
//        }
//        return emptyList
//    }


//    suspend fun getContestList() : List<ContestModel>? {
//        var resultList : MutableList<ContestModel> = mutableListOf()
//        try {
//            val apiService = RetrofitManager.getContestClient().getContestList(
//                BuildConfig.api_key_data_government,
//                "1", "1000","20150101","20251225","Y"
//            )
//            apiService.enqueue(object : Callback<ContestResponse>{
//                override fun onResponse(call: Call<ContestResponse>, response: Response<ContestResponse>) {
//                val body = response.body()?.body?.items?.item
//                    val body = response.body()
//                    Log.e("mException", "응답된 데이터 : ${body}")
//                if (body != null){
//                    body.map {
//                        resultList.add(
//                            ContestModel(
//                                postsn = it.postsn,
//                                biztitle = it.biztitle
//                            )
//                        )
//                    }
//                }
//
//                }
//
//                override fun onFailure(call: Call<ContestResponse>, t: Throwable) {
//                    TODO("Not yet implemented")
//                    Log.e("mException", "PipeRepository, getContestList // Throwable : ${t.localizedMessage}")
//                }
//            })
//            return resultList
//        }catch (e:Exception){
//            Log.e("mException", "PipeRepository, getContestList // Exception : ${e.localizedMessage}")
//            return resultList
//        }
//    }
//
//    suspend fun getMyHomeSeoulMZ(perPage : Int, page : Int) : MyHomeSeoulMZResponse {
//        val result = RetrofitManager.getMyHomeSeoulMZClient().getMyHomeSeoulMZ(
//            BuildConfig.api_key_data_government,
//            perPage, page
//        )
//        return result
//    }
//
//    suspend fun getCertificationDate(numOfRows: Int, pageNo: Int, dataFormat: String, implYy: Int, qualgbCd: String?, jmCd: String?): CertificationDateResponse {
//        val result = RetrofitManager.getCertificationDateClient().getCertificationDate(
//            BuildConfig.api_key_data_government,
//            numOfRows, pageNo, dataFormat, implYy, qualgbCd, jmCd
//        )
//        return result
//    }
//
//    suspend fun getCertificationName() : CertificationNameResponse {
//        val result = RetrofitManager.getCertificationNameClient().getCertificationName(
//            BuildConfig.api_key_data_government
//        )
//        return result
//    }
}
