package com.meta.crm.intf.compare;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CrmBusinessContactChange {
    private String type;
    private Long fromContactId;
    private Long toContactId;
}
