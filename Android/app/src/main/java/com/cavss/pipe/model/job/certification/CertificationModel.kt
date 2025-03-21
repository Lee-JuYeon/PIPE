package com.cavss.pipe.model.job.certification

data class CertificationModel(
    var certificationName : String?,         // 자격증 이름
    var implYy : String?,                   // 시행년도
    var implSeq : String?,                  // 시행회차
    var qualgbCd : String?,                 // 자격구분코드
    var qualgbNm : String?,                 // 자격구분이름
    var description : String?,              // 설명
    var docRegStartDt : String?,            // 필기시험 원서접수 시작일자
    var docRegEndDt : String?,              // 필기시험 원서접수 종료일자
    var docExamStartDt : String?,           // 필기시험 시작일자
    var docExamEndDt : String?,             // 필기시험 종료일자
    var docPassDt : String?,                // 필기시험 합격(예정)자 발표일자
    var pracRegStartDt : String?,           // 실기(작업)/면접 시험 원서접수 시작일자
    var pracRegEndDt : String?,             // 실기(작업)/면접 시험 원서접수 종료일자
    var pracExamStartDt : String?,          // 실기(작업)/면접 시험 시작일자
    var pracExamEndDt : String?,            // 실기(작업)/면접 시험 종료일자
    var pracPassDt : String?               // 실기(작업)/면접 합격자 발표일자
)