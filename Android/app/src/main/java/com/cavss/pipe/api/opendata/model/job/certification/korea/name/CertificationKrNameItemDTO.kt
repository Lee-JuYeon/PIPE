package com.cavss.pipe.api.opendata.model.job.certification.korea.name

import org.simpleframework.xml.Element
import org.simpleframework.xml.Root

@Root(name = "item")
data class CertificationKrNameItemDTO(
    @field:Element(name = "jmcd")
    var jmcd: String? = null,

    @field:Element(name = "jmfldnm")
    var jmfldnm: String? = null,

    @field:Element(name = "mdobligfldcd")
    var mdobligfldcd: String? = null,

    @field:Element(name = "mdobligfldnm")
    var mdobligfldnm: String? = null,

    @field:Element(name = "obligfldcd")
    var obligfldcd: String? = null,

    @field:Element(name = "obligfldnm")
    var obligfldnm: String? = null,

    @field:Element(name = "qualgbcd")
    var qualgbcd: String? = null,

    @field:Element(name = "qualgbnm")
    var qualgbnm: String? = null,

    @field:Element(name = "seriescd")
    var seriescd: String? = null,

    @field:Element(name = "seriesnm")
    var seriesnm: String? = null
) {
}