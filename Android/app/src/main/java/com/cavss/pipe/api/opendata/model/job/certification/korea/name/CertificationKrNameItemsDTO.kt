package com.cavss.pipe.api.opendata.model.job.certification.korea.name

import org.simpleframework.xml.ElementList
import org.simpleframework.xml.Root

@Root(name = "items")
data class CertificationKrNameItemsDTO(
    @field:ElementList(inline = true, name = "item")
    var itemList: List<CertificationKrNameItemDTO>? = null
)