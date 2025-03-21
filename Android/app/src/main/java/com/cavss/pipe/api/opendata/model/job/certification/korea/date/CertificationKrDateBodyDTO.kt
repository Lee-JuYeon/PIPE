package com.cavss.pipe.api.opendata.model.job.certification.korea.date

import com.google.gson.annotations.SerializedName
import org.simpleframework.xml.Element
import org.simpleframework.xml.ElementList
import org.simpleframework.xml.ElementListUnion
import org.simpleframework.xml.Root


//data class CertificationKrDateBodyDTO(
//    @SerializedName("items")
//    val items: List<CertificationKrDateItemDTO>,
//
//    @SerializedName("numOfRows")
//    val numOfRows: Int,
//
//    @SerializedName("pageNo")
//    val pageNo: Int,
//
//    @SerializedName("totalCount")
//    val totalCount: Int
//){}

@Root(name = "body")
data class CertificationKrDateBodyDTO(
    @field:ElementList(name = "items", inline = false)
    var items: List<CertificationKrDateItemDTO>? = null,

    @field:Element(name = "numOfRows")
    var numOfRows: String = "50",

    @field:Element(name = "pageNo")
    var pageNo: String = "0",

    @field:Element(name = "totalCount")
    var totalCount: String = "0"
){}