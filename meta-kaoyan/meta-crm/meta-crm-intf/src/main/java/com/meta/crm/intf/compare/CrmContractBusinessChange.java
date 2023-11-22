package com.meta.crm.intf.compare;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class CrmContractBusinessChange {
    private Long fromBusinessId;

    private Long toBusinessId;

    public List<Long> getAllIds() {
        List<Long> result = new ArrayList<>();
        if (fromBusinessId != null) {
            result.add(fromBusinessId);
        }
        if (toBusinessId != null) {
            result.add(toBusinessId);
        }
        return result;
    }
}
