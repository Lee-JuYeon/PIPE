package com.cavss.pipe.util.custombindingadapter

import android.graphics.Typeface
import android.text.Spannable
import android.text.SpannableStringBuilder
import android.text.style.AbsoluteSizeSpan
import android.text.style.StyleSpan
import android.widget.TextView
import androidx.databinding.BindingAdapter
import com.cavss.pipe.R
import com.cavss.pipe.api.opendata.model.job.certification.korea.date.CertificationKrDateItemDTO
import com.cavss.pipe.model.money.bank.depositProducts.FixedDepositDTO
import com.cavss.pipe.model.job.certification.CertificationModel
import com.cavss.pipe.model.job.contest.ContestModel
import com.cavss.pipe.model.job.employment.EmploymentModel
import com.cavss.pipe.model.job.jobfair.JobfairModel
import com.cavss.pipe.model.money.support.SupportModel

object CustomBindingAdapter {


    @JvmStatic
    @BindingAdapter("app:supportModel")
    fun TextView.supportModel(model : SupportModel){
        val spannableBuilder = SpannableStringBuilder()

        // 볼드체와 큰 텍스트로 설정할 부분
        val boldText = "${model.serviceTitle}\n"
        spannableBuilder.append(boldText)
        spannableBuilder.setSpan(
            StyleSpan(Typeface.BOLD),
            0,
            boldText.length,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )
        // 텍스트 크기 설정 (예시: 20sp)
        spannableBuilder.setSpan(
            AbsoluteSizeSpan(20, true),
            0,
            boldText.length,
            Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
        )

        // 나머지 텍스트 추가
        spannableBuilder.append("💰 지원금 : ${model.serviceReward}\n")
        spannableBuilder.append("📝 지원내용 : ${model.serviceContentShortly}\n")
        spannableBuilder.append("\uD83D\uDCC6 신청기간 : ${model.applyDate["start"]}~${model.applyDate["end"]}")

        setLineSpacing(16f,1f)
        text = spannableBuilder
    }

    @JvmStatic
    @BindingAdapter("app:bankProductModel")
    fun TextView.bankProductModel(model : FixedDepositDTO){
        val joinWay = model.joinWay // 가입방법
        val mtrt_int = model.mtrt_int // 만기 후 이자율
        val spcl_cnd = model.spcl_cnd // 우대조건
        val target = model.join_member // 가입대상
        val option =  model.option.map {// 이자율
            "\n ○ ${it.intr_rate_type_nm} (${it.save_trm}개월) : ${it.intr_rate}% / 우대 : ${it.intr_rate2}%"
        }.joinToString()
        setLineSpacing(16f,1f)
        text = "💁🏻 가입방법 : ${joinWay}\n" +
                "🧑 가입대상 : ${target}\n" +
                "⭐️ 우대조건 : ${spcl_cnd}\n" +
                "💰 만기 후 이자율 : ${mtrt_int}\n" +
                "${option}"
    }
    @JvmStatic
    @BindingAdapter("app:employmentModel")
    fun TextView.employmentModel(model : EmploymentModel){
        val applyPeriod = model.applyPeriod?.let {
            val start = it["start"]
            val end = it["end"]
            "${start} ~ ${end}"
        }
        setLineSpacing(16f,1f)
        text = """
            🏢 ${model.companyName} (${model.companyType})
            ⏰ ${context.getString(R.string.employment_career)} : ${model.experienceTime}
            🎓 ${context.getString(R.string.employment_education)} : ${model.education}
            💪 ${context.getString(R.string.employment_skill)} : 
                ${model.skill}
            💁🏻 ${context.getString(R.string.employment_jobreponsibility)} : 
                ${model.jobResponsibility} (${model.jobDuty})
            💰 ${context.getString(R.string.employment_money)} : ${model.employmentPay} (${model.employmentType})
            📆 ${context.getString(R.string.employment_applyperiod)} : 
                ${applyPeriod}
            📍 ${context.getString(R.string.employment_address)} : ${model.address}
        """.trimIndent()
    }

    @JvmStatic
    @BindingAdapter("app:jobfairModel")
    fun TextView.jobfairModel(model : JobfairModel){
        val date = model.period?.let {
            val startDate = it["startDate"]
            val endDate = if (it["endDate"] == "0000-00-00") "채용시까지" else it["endDate"]
            "$startDate ~ $endDate"
        }
        val address = model.address
        text = """
            
            📅 $date
            
            📍 $address
        """.trimIndent()
    }

    @JvmStatic
    @BindingAdapter("app:certificationModel")
    fun TextView.certificatiomModel(model : CertificationKrDateItemDTO){
        text = """
            
            ${model.qualgbNm}
            
         
        """.trimIndent()
    }

    @JvmStatic
    @BindingAdapter("app:contestModel")
    fun TextView.contestModel(model : ContestModel) {
        val startDate =
            if (model?.applyPeriod?.containsKey("접수시작")!!) model?.applyPeriod?.get("접수시작") else ""
        val startTime =
            if (model?.applyPeriod?.containsKey("접수시작시간")!!) model?.applyPeriod?.get("접수시작시간") else ""
        val endDate =
            if (model?.applyPeriod?.containsKey("접수마감")!!) model?.applyPeriod?.get("접수마감") else ""
        val endTime =
            if (model?.applyPeriod?.containsKey("접수마감시간")!!) model?.applyPeriod?.get("접수마감시간") else ""
        val reward = model?.reward?.map {
            "\n ${it.key}\n    ${it.value}"
        }?.joinToString()

        text =
            "\uD83D\uDCA1 ${context.getString(R.string.contest_subject)} : ${model.contestTitle}\n" +
                    "\uD83E\uDDD1\uD83C\uDFFB ${context.getString(R.string.contest_target)} : ${model.target}\n" +
                    "\uD83D\uDCC5 ${context.getString(R.string.contest_applystartdate)} : ${startDate} ${startTime}\n" +
                    "\uD83D\uDCC5 ${context.getString(R.string.contest_applyenddate)} : ${endDate} ${endTime}\n" +
                    "\uD83E\uDD47 ${context.getString(R.string.contest_reward)} : ${reward}".trimIndent()
    }
}
