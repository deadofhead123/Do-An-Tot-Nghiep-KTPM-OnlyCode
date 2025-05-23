package com.javaweb.util;

import com.javaweb.model.dto.AbstractDTO;
import org.apache.commons.lang.StringUtils;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;

import javax.servlet.http.HttpServletRequest;

public class DisplayTagUtils {

    //private static final Logger log = Logger.getLogger(DisplayTagUtils.class);

    public static void of(HttpServletRequest request, AbstractDTO dto) {
        if (dto != null) {
            String sPage = request.getParameter(new ParamEncoder(dto.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_PAGE));
            Integer page = 1;
            if (StringUtils.isNotBlank(sPage)) {
                try {
                    page = Integer.valueOf(sPage);
                } catch (Exception e) {
                    //log.error(e.getMessage());
                }
            }
            dto.setPage(page);

            // Sort follow name of head column
            String sortName = request.getParameter(new ParamEncoder(dto.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_SORT));
            if(StringUtils.isNotBlank(sortName)){
                dto.setSortName(sortName);
            }

            String sortOrder = request.getParameter(new ParamEncoder(dto.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_ORDER));
            if(StringUtils.isNotBlank(sortOrder)){
                if(sortOrder.equals("1")){
                    sortOrder = "ASC";
                }
                else{
                    sortOrder = "DESC";
                }
                dto.setSortOrder(sortOrder);
            }
        }
    }
}
