package com.cavss.pipe.api.opendata.model.job.certification.korea.name

import org.simpleframework.xml.Element
import org.simpleframework.xml.Root

@Root(name = "body")
data class CertificationKrNameBodyDTO (

    @field:Element(name = "items")
    var items: CertificationKrNameItemsDTO? = null
)