package com.cavss.pipe.api.opendata.model.job.certification.korea.date

import com.google.gson.annotations.SerializedName
import org.simpleframework.xml.Element
import org.simpleframework.xml.Root


//data class CertificationKrDateHeaderDTO(
//    @SerializedName("resultCode")
//    val resultCode: String,
//
//    @SerializedName("resultMsg")
//    val resultMsg: String
//){}

@Root(name = "header")
data class CertificationKrDateHeaderDTO(
    @field:Element(name = "resultCode")
    var resultCode: String? = null,

    @field:Element(name = "resultMsg")
    var resultMsg: String? = null
){}

