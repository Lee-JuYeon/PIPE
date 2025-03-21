package com.cavss.pipe.model.target

import android.util.Log


data class TargetModel(
    val address : String?,  // 지역
    val gender : Gender?, // 성별
    val age : String?, // 만 14세 이상 == 1499, 모두 == 9900, 만 13세 이상 18세 이하 == 1318
    val educationLevel : EducationLevel?, // 최종학력
    val familyOption : FamilyOption?, // 가구상태
    val workingState : WorkingState?, // 취업상태
    val incomeState : IncomeState?, // 중위소득
    val birthState : BirthState?, // 출산상태
    val jobCategory : JobCategory?, // 종사 업종 고르기
    val plusOption : PlusOption?, //우대사항
    val startUpState : StartUpState? // 창업상태
){
    fun toMapping() : String {
        val address = this.address ?: "전국"
        val gender = this.gender?.rawValue ?: Gender.BOTH.rawValue
        val age = "만 ${this.age?.substring(0, 2)}세부터 만 ${this.age?.substring(2, 4)}세까지"
        val education = this.educationLevel?.rawValue ?: "제한사항없음"
        val family = this.familyOption?.rawValue ?: "제한사항없음"
        val working = this.workingState?.rawValue ?: "제한사항없음"
        val income = this.incomeState?.rawValue ?: "제한사항없음"
        val birth = this.birthState?.rawValue ?: "제한사항없음"
        val job = this.jobCategory?.rawValue ?: "제한사항없음"
        val plus = this.plusOption?.rawValue ?: "제한사항없음"
        val startup = this.startUpState?.rawValue ?: "제한사항없음"

        return "\n" +
                "  지역 : ${address}\n" +
                "  성별 : ${gender}\n" +
                "  나이 : ${age}\n" +
                "  최종학력 : ${education}\n" +
                "  가정형태 : ${family}\n" +
                "  취업상태 : ${working}\n" +
                "  중위소득 : ${income}\n" +
                "  출산형태 : ${birth}\n" +
                "  업종 : ${job}\n" +
                "  우대사항 : ${plus}\n" +
                "  창업상황 : ${startup}\n"
    }
}
