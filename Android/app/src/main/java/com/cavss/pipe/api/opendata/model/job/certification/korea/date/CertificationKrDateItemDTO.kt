package com.cavss.pipe.api.opendata.model.job.certification.korea.date

import com.google.gson.annotations.SerializedName
import org.simpleframework.xml.Element
import org.simpleframework.xml.Root

//data class CertificationKrDateItemDTO(
//    @SerializedName("implYy")
//    val implYy: String? = null, // 시행년도
//
//    @SerializedName("implSeq")
//    val implSeq: String? = null, // 시행회차
//
//    @SerializedName("qualgbCd")
//    val qualgbCd: String? = null, // 자격구분코드
//
//    @SerializedName("qualgbNm")
//    val qualgbNm: String? = null, // 자격구분명
//
//    @SerializedName("description")
//    val description	: String? = null, // 설명
//
//    @SerializedName("docRegStartDt")
//    val docRegStartDt: String? = null, // 필기시험 원서접수 시작일자
//
//    @SerializedName("docRegEndDt")
//    val docRegEndDt: String? = null, // 필기시험 원서접수 종료일자
//
//    @SerializedName("docExamStartDt")
//    val docExamStartDt: String? = null, // 필기시험 시작일자
//
//    @SerializedName("docExamEndDt")
//    val docExamEndDt: String? = null, // 필기시험 종료일자
//
//    @SerializedName("docPassDt")
//    val docPassDt: String? = null, // 필기시험 합격(예정)자 발표일자
//
//    @SerializedName("pracRegStartDt")
//    val pracRegStartDt: String? = null, // 실기(작업)/면접 시험 원서접수 시작일자
//
//    @SerializedName("pracRegEndDt")
//    val pracRegEndDt: String? = null, // 실기(작업)/면접 시험 원서접수 종료일자
//
//    @SerializedName("pracExamStartDt")
//    val pracExamStartDt: String? = null, // 실기(작업)/면접 시험 시작일자
//
//    @SerializedName("pracExamEndDt")
//    val pracExamEndDt: String? = null, // 실기(작업)/면접 시험 종료일자
//
//    @SerializedName("pracPassDt")
//    val pracPassDt: String? = null // 실기(작업)/면접 합격자 발표일자
//){}

@Root(name = "item")
data class CertificationKrDateItemDTO(
    @field:Element(name = "implYy")
    var implYy: String? = null, // 시행년도

    @field:Element(name = "implSeq")
    var implSeq: String? = null, // 시행회차

    @field:Element(name = "qualgbCd")
    var qualgbCd: String? = null, // 자격구분코드

    @field:Element(name = "qualgbNm")
    var qualgbNm: String? = null, // 자격구분명

    @field:Element(name = "description")
    var description: String? = null, // 설명

    @field:Element(name = "docRegStartDt")
    var docRegStartDt: String? = null, // 필기시험 원서접수 시작일자

    @field:Element(name = "docRegEndDt")
    var docRegEndDt: String? = null, // 필기시험 원서접수 종료일자

    @field:Element(name = "docExamStartDt")
    var docExamStartDt: String? = null, // 필기시험 시작일자

    @field:Element(name = "docExamEndDt")
    var docExamEndDt: String? = null, // 필기시험 종료일자

    @field:Element(name = "docPassDt")
    var docPassDt: String? = null, // 필기시험 합격(예정)자 발표일자

    @field:Element(name = "pracRegStartDt")
    var pracRegStartDt: String? = null, // 실기(작업)/면접 시험 원서접수 시작일자

    @field:Element(name = "pracRegEndDt")
    var pracRegEndDt: String? = null, // 실기(작업)/면접 시험 원서접수 종료일자

    @field:Element(name = "pracExamStartDt")
    var pracExamStartDt: String? = null, // 실기(작업)/면접 시험 시작일자

    @field:Element(name = "pracExamEndDt")
    var pracExamEndDt: String? = null, // 실기(작업)/면접 시험 종료일자

    @field:Element(name = "pracPassDt")
    var pracPassDt: String? = null // 실기(작업)/면접 합격자 발표일자
){}