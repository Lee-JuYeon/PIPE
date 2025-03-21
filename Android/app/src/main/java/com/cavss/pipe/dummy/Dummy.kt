package com.cavss.pipe.dummy

import com.cavss.pipe.model.money.support.SupportModel
import com.cavss.pipe.model.target.BirthState
import com.cavss.pipe.model.target.EducationLevel
import com.cavss.pipe.model.target.FamilyOption
import com.cavss.pipe.model.target.Gender
import com.cavss.pipe.model.target.IncomeState
import com.cavss.pipe.model.target.JobCategory
import com.cavss.pipe.model.target.PlusOption
import com.cavss.pipe.model.target.StartUpState
import com.cavss.pipe.model.target.TargetModel
import com.cavss.pipe.model.target.WorkingState

object Dummy {
    fun dummy_supportlist() : List<SupportModel>{
        return mutableListOf<SupportModel>(
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "주부 창업지원장려금",
                serviceType = "창업지원",
                serviceContent = "창업을 하려는 주부들에게 정부에서 지원금을 주어 독려",
                serviceReward = "8천만원",
                applyDate = mapOf("start" to "2024-01-01", "end" to "2024-01-31"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신1동",
                    Gender.FEMALE,
                    "0012",
                    EducationLevel.College,
                    FamilyOption.ExtendedFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "창업진흥원",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "여성 취업지원금",
                serviceType = "취업지원",
                serviceContent = "취업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "3백만원",
                applyDate = mapOf("start" to "2024-10-01", "end" to "2024-10-31"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 동대문구 장흥동",
                    Gender.FEMALE,
                    "0099",
                    EducationLevel.GraduateSchool,
                    FamilyOption.ExtendedFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "취업진흥원",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "군장병 취업지원금",
                serviceType = "취업지원",
                serviceContent = "취업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "3백만원",
                applyDate = mapOf("start" to "2024-05-30", "end" to "2024-06-12"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 동대문구 장흥동",
                    Gender.MALE,
                    "1212",
                    EducationLevel.HighSchool,
                    FamilyOption.ExtendedFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "취업진흥원",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "1인가정지원금",
                serviceType = "지원금",
                serviceContent = "창업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "8천만원",
                applyDate = mapOf("start" to "2024-08-08", "end" to "2024-09-20"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신1동",
                    Gender.BOTH,
                    "3456",
                    EducationLevel.MiddleSchool,
                    FamilyOption.ExtendedFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "경제부",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "신혼부부가정 지원금",
                serviceType = "지원금",
                serviceContent = "창업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "1억",
                applyDate = mapOf("start" to "2024-10-22", "end" to "2024-11-11"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신1동",
                    Gender.BOTH,
                    "6789",
                    EducationLevel.University,
                    FamilyOption.NA,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.EXPECTING_MOTHER,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "보건복지부",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "자립청년 지원금",
                serviceType = "지원금",
                serviceContent = "창업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "5백만원",
                applyDate = mapOf("start" to "2024-06-08", "end" to "2024-07-22"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신1동",
                    Gender.BOTH,
                    "0549",
                    EducationLevel.College,
                    FamilyOption.ExtendedFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "보건복지부",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "한부모가정지원금",
                serviceType = "지원금",
                serviceContent = "창업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "천만원",
                applyDate = mapOf("start" to "2024-03-01", "end" to "2024-03-22"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신1동",
                    Gender.BOTH,
                    "0011",
                    EducationLevel.University,
                    FamilyOption.OnePersonFamily,
                    WorkingState.WORKER,
                    IncomeState.FIFTY_SEVENTYFIVE,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "보건복지부",
                companyType = "정부",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
            SupportModel(
                postUID = "postUID-123123",
                serviceTitle = "삼성 20만원 지원카드",
                serviceType = "지원금",
                serviceContent = "창업을 하려는 청년들에게 정부에서 지원금을 주어 독려",
                serviceReward = "20만원",
                applyDate = mapOf("start" to "2024-04-05", "end" to "2024-04-23"),
                postURL = "https://www.youtube.com/watch?v=PNEbzcsR_PY",
                requirementFiles = listOf("가족등록등본", "이력서"),
                target = TargetModel(
                    "서울시 종로구 창신2동",
                    Gender.BOTH,
                    "1111",
                    EducationLevel.University,
                    FamilyOption.NA,
                    WorkingState.NOWORKER,
                    IncomeState.ZERO_FIFTY,
                    BirthState.BIRTH,
                    JobCategory.ETC,
                    PlusOption.PersonWithDisablity,
                    StartUpState.PreStartUp
                ),
                companyTitle = "삼성",
                companyType = "민간",
                companyContact = mapOf("phone" to "123-456-7890", "email" to "company@example.com")
            ),
        )
    }
}