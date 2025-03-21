package com.cavss.pipe.api.opendata.model.job.certification.korea.date

import org.simpleframework.xml.Element
import org.simpleframework.xml.ElementList
import org.simpleframework.xml.Root

@Root(name = "response")
data class CertificationKrDateResponseDTO(
    @field:Element(name = "header")
    val header: CertificationKrDateHeaderDTO? = null,

    @field:Element(name = "body")
    var body: CertificationKrDateBodyDTO? = null
){}