package com.cavss.pipe.api.opendata.model.job.certification.korea.name

import org.simpleframework.xml.Element
import org.simpleframework.xml.Root

// DTO 클래스 정의
@Root(name = "response")
data class CertificationKrNameResponseDTO(
    @field:Element(name = "header")
    var header: CertificationKrNameHeaderDTO? = null,

    @field:Element(name = "body")
    var body: CertificationKrNameBodyDTO? = null
)