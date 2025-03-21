package com.cavss.pipe.model.money.support

import android.content.Context
import android.content.Intent
import android.graphics.Typeface
import android.net.Uri
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.style.AbsoluteSizeSpan
import android.text.style.ClickableSpan
import android.text.style.StyleSpan
import android.view.View
import com.cavss.pipe.R
import com.cavss.pipe.model.target.TargetModel

// employment model : 경력, 학력 ,스킬, 모집 직무, 급여 ,접수기간 ,근무지
data class SupportModel(
    val postUID : String, // api uid ( "money-support-uid" )
    val serviceTitle : String, // 지원 타이틀 ( 서비스명 )
    val serviceType : String, // 지원 유형
    val serviceContent : String,  // 지원 내용 (서비스 목적)
    val serviceContentShortly : String? = null,  // 지원 내용 (서비스 목적)
    val serviceReward : String, // 지원 금액
    val applyDate : Map<String, String>, // 신청기간 start, end
    val postURL : String, // 상세 url
    val requirementFiles : List<String>, // 구비서류 리스트
    val target : TargetModel?, // 대상
    var companyTitle : String, // 기관 명
    var companyType : String, // 기관 구분
    var companyContact : Map<String, String> // 문의(전화문의, 이메일, 부서명 등등)
) {

    fun toBottomSheetMapping(context: Context) : SpannableStringBuilder {
        val spannableBuilder = SpannableStringBuilder()
        // 볼드체와 큰 텍스트로 설정할 부분
        val boldText = "${serviceTitle}\n"
        spannableBuilder.append(boldText)
        spannableBuilder.setSpan(
            StyleSpan(Typeface.BOLD),
            0,
            boldText.length,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )
        // 텍스트 크기 설정 (예시: 20sp)
        spannableBuilder.setSpan(
            AbsoluteSizeSpan(30, true),
            0,
            boldText.length,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )

        val linkText = "🔗 ${context.getString(R.string.bottom_sheet_link_title)}\n"
        spannableBuilder.append(linkText)
        spannableBuilder.setSpan(
            object : ClickableSpan() {
                override fun onClick(widget: View) {
                    // 링크를 클릭했을 때 웹페이지로 이동하는 Intent 생성
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(postURL))
                    // 웹페이지로 이동하는 Intent 실행
                    context.startActivity(intent)
                }
            },
            spannableBuilder.length - linkText.length + 3,
            spannableBuilder.length - 1,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )

        // 나머지 텍스트 추가
        spannableBuilder.append("💰 지원 금액 : ${serviceReward}\n")
        spannableBuilder.append("📝 지원 내용 : ${serviceContentShortly}\n")
        spannableBuilder.append("📋️ 지원 유형 : ${serviceType}\n")
        spannableBuilder.append("🗓️ 신청기간 : ${applyDate["start"]}~${applyDate["end"]}\n")
        spannableBuilder.append("📂 구비서류 : ${serviceType}\n")
        spannableBuilder.append("🙋 대상 : ${target?.toMapping()}\n")
        spannableBuilder.append("🏢 기관 : ${companyTitle}(${companyType})\n")
        companyContact.entries.forEach {
            spannableBuilder.append("   ${it.key} : ${it.value}\n")
        }
        return spannableBuilder
    }
}

