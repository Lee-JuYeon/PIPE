package com.cavss.pipe.api.opendata.model.job.certification.korea.name

import org.simpleframework.xml.Element
import org.simpleframework.xml.Root

@Root(name = "header")
data class CertificationKrNameHeaderDTO(
    @field:Element(name = "resultCode")
    var resultCode: String? = null,

    @field:Element(name = "resultMsg")
    var resultMsg: String? = null
)