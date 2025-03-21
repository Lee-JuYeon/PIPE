package com.cavss.pipe.model.job.employment

data class EmploymentModel(
    var employmentTitle : String?,              // 채용제목
    var businessSector : String?,               // 기업 산업(업종)
    var workerCount : Int,                      // 기업 사원수
    var companyType : String?,                  // 기업 형태
    var companyHomepage : String?,              // 기업 홈페이지
    var walfare : String?,                      // 복리후생
    var experienceTime : String?,               // 경력
    var education : String?,                    // 학력
    var skill : String?,                        // 스킬
    var applyPeriod : Map<String, String>?,     // 접수기간
    var howToApply : String?,                   // 접수방법
    var applyResult : String?,                  // 결과확인
    var jobPosition : String?,                  // 모집 직군
    var jobResponsibility : String?,            // 모집 직무
    var companyName : String?,                  // 회사 이름
    var employmentType : String?,               // 고용 형태
    var employmentPay : String?,                // 고용 급여
    var jobDuty : String?,                      // 담당업무
    var hireCount : Int,                        // 채용인원
    var address : String?,                      // 근무지
    var applyRequirements : String?,            // 지원자격
    var preferredQualification : String?,        // 우대사항
    var processDetail : Map<String, String>?,   // 전형별 세부사항
    var caution : String?,                      // 유의사항
    var major : String?                         // 관련 전공
)