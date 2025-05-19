package com.javaweb.api.admin;

import com.javaweb.constant.SessionConstant;
import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.SupplierDTO;
import com.javaweb.model.dto.ProductImport;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.product.IProductService;
import com.javaweb.service.productImport.IProductImportService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/admin/imports")
@RequiredArgsConstructor
public class ProductImportAPI_Admin {
    private final IProductService productService;
    private final IProductImportService productImportService;
    private final ModelMapper modelMapper;

    @PostMapping
    public ResponseEntity<?> createImport(@Valid @RequestBody SupplierDTO supplierDTO, BindingResult bindingResult, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(bindingResult.hasErrors()){
                List<String> errors = bindingResult.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .collect(Collectors.toList());
                responseDTO.setMessage("Lỗi nhập dữ liệu:");
                responseDTO.setDetails(errors);
                return ResponseEntity.badRequest().body(responseDTO);
            }

            SupplierDTO supplierDTOResult = productImportService.createImport(supplierDTO, request);

            if(supplierDTOResult.getId() != null){
                responseDTO.setMessage("Nhập hàng thành công!");
                responseDTO.setData(SystemConstant.INSERT_SUCCESS);
            }
            else{
                responseDTO.setMessage("Nhập hàng thất bại!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PostMapping(value = "/addToImportList/{ids}")
    public ResponseEntity<?> addProductImport(@PathVariable(name = "ids") List<Long> ids, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();
        List<ProductImport> productImportList;

        List<ProductDTO> productDTOList = productService.findAllbyId(ids);

        HttpSession session = request.getSession();

        // - Duyệt ds đã tìm thấy để thêm vào session
        //   + Nếu sản phẩm chưa tồn tại thì thêm mới vào
        //   + Nếu sản phẩm đã tồn tại thì tăng số lượng lên
        if(session.getAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME) == null){
            productImportList = new ArrayList<>();
        }
        else{
            productImportList = (List<ProductImport>) session.getAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME);
        }

        for(ProductDTO item : productDTOList){
            ProductImport productImport = productImportList.stream().filter(x -> x.getId().equals(item.getId())).findFirst().orElse(null);;

            int idx = productImport == null ? -1 : productImportList.indexOf(productImport);

            if(idx == -1){
                productImport = modelMapper.map(item, ProductImport.class);
                productImport.setPriceInPurchase(item.getPrice());
                productImport.setQuantity(1L);
                productImportList.add(productImport);
            }
            else{
                productImportList.get(idx).setQuantity(productImport.getQuantity() + 1L);
            }
        }

        session.setAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME, productImportList);
        responseDTO.setMessage("Thêm sản phẩm thành công !");

        return ResponseEntity.ok(responseDTO);
    }

    @PutMapping(value = "/changeProductImport")
    public ResponseEntity<?> changeProductImport(@RequestBody ProductImport productImport, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();
        HttpSession session = request.getSession();
        List<ProductImport> productImportList = (List<ProductImport>) session.getAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME);

        ProductDTO productDTO = productService.findOneById(productImport.getId());

        if(ObjectUtils.isEmpty(productDTO)){
            responseDTO.setMessage("Sản phẩm này không tồn tại trong hệ thống!");
            ProductImport productImportRemove = productImportList.stream().filter(x -> x.getId() == productImport.getId()).findFirst().orElse(null);
            productImportList.remove(productImportRemove);
            return ResponseEntity.badRequest().body(responseDTO);
        }

        for(int i = 0 ; i < productImportList.size(); i++){
            if(productImportList.get(i).getId().equals(productImport.getId())){
                if(productImport.getQuantity() != null) productImportList.get(i).setQuantity(productImport.getQuantity());
                if(productImport.getPrice() != null) productImportList.get(i).setPrice(productImport.getPrice());
                break;
            }
        }

        session.setAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME, productImportList);

        return ResponseEntity.ok(responseDTO);
    }

    @DeleteMapping(value = "/deleteProductImport/{ids}")
    public ResponseEntity<?> deleteProductImport(@PathVariable("ids") List<Long> ids, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            HttpSession session = request.getSession();
            List<ProductImport> productImportList = (List<ProductImport>) session.getAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME);

            for(int i = 0 ; i < ids.size() ; i++){
                Long id = ids.get(i);
                ProductImport productImport = productImportList.stream().filter(x -> x.getId().equals(id)).collect(Collectors.toList()).get(0);
                productImportList.remove(productImport);
            }

            session.setAttribute(SessionConstant.PRODUCT_IMPORT_LIST_SESSION_NAME, productImportList);

            responseDTO.setMessage("Xóa sản phẩm thành công !");
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Xóa sản phẩm thất bại !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
