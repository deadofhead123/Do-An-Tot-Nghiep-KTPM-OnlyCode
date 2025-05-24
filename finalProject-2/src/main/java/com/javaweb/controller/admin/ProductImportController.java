package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.SupplierDTO;
import com.javaweb.model.dto.SupplyDetailsDTO;
import com.javaweb.model.request.SupplierSearchRequest;
import com.javaweb.model.response.SupplierSearchResponse;
import com.javaweb.service.product.IProductService;
import com.javaweb.service.productImport.IProductImportService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller(value = "importControllerOfAdmin")
@RequiredArgsConstructor
public class ProductImportController {
    private final MessageUtils messageUtil;
    private final IProductImportService productImportService;
    private final IProductService productService;

    @GetMapping(value = "/admin/import-list")
    public ModelAndView importList(@ModelAttribute("importSearch") SupplierSearchRequest supplierSearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/product-import/list");

        SupplierSearchResponse supplierSearchResponse = new SupplierSearchResponse();

        DisplayTagUtils.of(request, supplierSearchResponse);
        supplierSearchResponse.setListResult
                (productImportService.findAll(supplierSearchRequest,
                                                PageRequest.of(supplierSearchResponse.getPage() - 1, supplierSearchResponse.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(supplierSearchResponse.getSortOrder()), supplierSearchResponse.getSortName()))));
        supplierSearchResponse.setTotalItems(productImportService.countTotalItems(supplierSearchRequest));

        mav.addObject("supplierSearchResponse", supplierSearchResponse);
        mav.addObject("tableId", new ParamEncoder(supplierSearchResponse.getTableId()).encodeParameterName(TableTagParameters.PARAMETER_PAGE));

        return mav;
    }

    @GetMapping(value = "/admin/import-create")
    public ModelAndView createImport(@ModelAttribute("supplierEdit") SupplierDTO supplierDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/product-import/create");

        supplierDTO.setName(SystemConstant.NAME_OF_SHOP);
        supplierDTO.setAddress(SystemConstant.ADDRESS_OF_SHOP);
        supplierDTO.setEmail(SystemConstant.EMAIL_OF_SHOP);
        supplierDTO.setPhoneNumber(SystemConstant.PHONENO_OF_SHOP);

        mav.addObject("productAvailableList", productService.findAllActiveWithoutPaging());
        mav.addObject("supplierEdit", supplierDTO);
        initMessageResponse(mav, request);

        return mav;
    }

    @GetMapping(value = "/admin/import-detail-{id}")
    public ModelAndView importDetail(@ModelAttribute("supplierEdit") SupplierDTO supplierDTO, @PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("/admin/product-import/detail");

        SupplierDTO supplierResult = productImportService.findOneById(id);

        if(ObjectUtils.isEmpty(supplierResult)){
            return new ModelAndView("redirect:/not-found");
        }

        List<SupplyDetailsDTO> supplyDetailsResult = productImportService.findBySupplierId(supplierResult.getId());

        mav.addObject("supplierEdit", supplierResult);
        mav.addObject("supplyDetailsResult", supplyDetailsResult);

        return mav;
    }

    private void initMessageResponse(ModelAndView mav, HttpServletRequest request) {
        String message = request.getParameter("message");

        if (message != null && StringUtils.isNotEmpty(message)) {
            Map<String, String> messageMap = messageUtil.getMessage(message);
            mav.addObject(SystemConstant.ALERT, messageMap.get(SystemConstant.ALERT));
            mav.addObject(SystemConstant.MESSAGE_RESPONSE, messageMap.get("message"));
        }
    }
}
