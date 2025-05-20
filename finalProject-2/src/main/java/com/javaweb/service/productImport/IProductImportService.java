package com.javaweb.service.productImport;

import com.javaweb.model.dto.SupplierDTO;
import com.javaweb.model.dto.SupplyDetailsDTO;
import com.javaweb.model.request.SupplierSearchRequest;
import com.javaweb.model.response.SupplierSearchResponse;
import org.springframework.data.domain.Pageable;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IProductImportService {
    List<SupplierSearchResponse> findAll(SupplierSearchRequest request, Pageable pageable);
    SupplierDTO findOneById(Long id);
    List<SupplyDetailsDTO> findBySupplierId(Long supplierId);
    Long findImportTotalByDate(String date);

    SupplierDTO createImport(SupplierDTO supplierDTO, HttpServletRequest request);
    int countTotalItems(SupplierSearchRequest request);
}
