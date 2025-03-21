package com.cavss.pipe.api.opendata.model.job.certification.korea.date

import com.cavss.pipe.api.opendata.model.job.certification.korea.date.CertificationKrDateItemDTO
import org.simpleframework.xml.ElementList
import org.simpleframework.xml.Root

@Root(name = "items")
data class CertificationKrDateItemsDTO (
    @field:ElementList(inline = true, entry = "item")
    var items: List<CertificationKrDateItemDTO>? = null
)