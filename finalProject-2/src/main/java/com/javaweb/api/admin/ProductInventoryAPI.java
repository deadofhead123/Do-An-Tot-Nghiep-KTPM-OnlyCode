package com.javaweb.api.admin;

import com.javaweb.constant.SessionConstant;
import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ProductDTO;
import com.javaweb.model.dto.ProductDropDTO;
import com.javaweb.model.dto.ProductInventoryDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.product.IProductService;
import com.javaweb.service.productInventory.IProductInventoryService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping(value = "/api/admin/productInventories")
@RequiredArgsConstructor
public class ProductInventoryAPI {
    private final IProductInventoryService productInventoryService;
    private final IProductService productService;
    private final ModelMapper modelMapper;

    @GetMapping(value = "/search")
    public ResponseEntity<?> getProductInventory(@RequestParam Map<String, Object> params) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            if(params.get("isExpired") != null){
                responseDTO.setData(productInventoryService.findAllExpiredNotPaging());
            }
            else if(params.get("isLocked") != null){
                responseDTO.setData(productInventoryService.findAllLockedNotPaging());
            }
            else if(params.get("ids") != null){
                String ids = params.get("ids").toString();
                List<Long> idsFinal = Arrays.stream(ids.split(",")).map(Long::parseLong).collect(Collectors.toList());

                responseDTO.setData(productInventoryService.findAllByIdNotPaging(idsFinal));
            }
            else if(params.get("id") != null){
                Long id = Long.parseLong(params.get("id").toString());
                responseDTO.setData(Arrays.asList(productInventoryService.findOneById(id)));
            }
            else{
                responseDTO.setData(productInventoryService.findAllUnusedNotPaging());
            }

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PutMapping
    public ResponseEntity<?> updateProductInventory(HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            Boolean updateResult = productInventoryService.updateProductInventory(request);

            if(!updateResult){
                responseDTO.setMessage("Có lỗi khi bỏ hàng!");
                return ResponseEntity.badRequest().body(responseDTO);
            }

            responseDTO.setMessage("Bỏ hàng thành công!");
            responseDTO.setData(SystemConstant.UPDATE_SUCCESS);

            return ResponseEntity.ok(responseDTO);
        }
        catch (Exception ex){
            responseDTO.setData(SystemConstant.ERROR_SYSTEM);
            responseDTO.setMessage(ex.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }

    @PostMapping(value = "/addToDropList/{ids}")
    public ResponseEntity<?> addProductImport(@PathVariable(name = "ids") List<Long> ids, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();
        List<ProductDropDTO> productDropList;

        List<ProductInventoryDTO> productInventoryDTOList = productInventoryService.findAllByIdNotPaging(ids);

        HttpSession session = request.getSession();

        // - Duyệt ds đã tìm thấy để thêm vào session
        //   + Nếu sản phẩm chưa tồn tại thì thêm mới vào
        //   + Nếu sản phẩm đã tồn tại thì tăng số lượng lên
        if(session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME) == null){
            productDropList = new ArrayList<>();
        }
        else{
            productDropList = (List<ProductDropDTO>) session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME);
        }

        for(ProductInventoryDTO item : productInventoryDTOList){
            ProductDropDTO productDropDTO = productDropList.stream().filter(x -> x.getId().equals(item.getId())).findFirst().orElse(null);;

            int idx = productDropDTO == null ? -1 : productDropList.indexOf(productDropDTO);

            if(idx == -1){
                productDropDTO = modelMapper.map(item, ProductDropDTO.class);
                productDropDTO.setName(item.getProductDTO().getName());
                productDropDTO.setPriceInImport(item.getPriceInImport());
                productDropDTO.setImage(item.getProductDTO().getImage());

                String note = item.getNote();
                if(note != null) productDropDTO.setNote(note);
                else{
                    if(item.getExpiredAt().isBefore(LocalDateTime.now())){
                        productDropDTO.setNote("Hết hạn");
                    }
                    else{
                        productDropDTO.setNote("Bị hỏng");
                    }
                }

                productDropList.add(productDropDTO);
            }
        }

        session.setAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME, productDropList);
        responseDTO.setMessage("Thêm sản phẩm thành công !");

        return ResponseEntity.ok(responseDTO);
    }

    @PutMapping(value = "/changeProductDrop")
    public ResponseEntity<?> changeProductDrop(@RequestBody ProductDropDTO productDropDTO, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();
        HttpSession session = request.getSession();
        List<ProductDropDTO> productDropList = (List<ProductDropDTO>) session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME);

        ProductDTO productDTO = productService.findOneById(productDropDTO.getId());

        if(ObjectUtils.isEmpty(productDTO)){
            responseDTO.setMessage("Sản phẩm này không tồn tại trong hệ thống!");
            productDropList.stream().filter(x -> x.getId().equals(productDropDTO.getId())).findFirst().ifPresent(productDropList::remove);
            return ResponseEntity.badRequest().body(responseDTO);
        }

        for(int i = 0 ; i < productDropList.size(); i++){
            if(productDropList.get(i).getId().equals(productDropDTO.getId())){
                if(productDropDTO.getNote() != null) productDropList.get(i).setNote(productDropDTO.getNote());
                break;
            }
        }

        session.setAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME, productDropList);

        return ResponseEntity.ok(responseDTO);
    }

    @DeleteMapping(value = "/deleteProductDrop/{ids}")
    public ResponseEntity<?> deleteProductDrop(@PathVariable("ids") List<Long> ids, HttpServletRequest request) {
        ResponseDTO responseDTO = new ResponseDTO();

        try{
            HttpSession session = request.getSession();
            List<ProductDropDTO> productDropList = (List<ProductDropDTO>) session.getAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME);

            for(int i = 0 ; i < ids.size() ; i++){
                Long id = ids.get(i);
                productDropList.stream().filter(x -> x.getId().equals(id)).findFirst().ifPresent(productDropList::remove);
            }

            session.setAttribute(SessionConstant.PRODUCT_DROP_LIST_SESSION_NAME, productDropList);

            responseDTO.setMessage("Xóa sản phẩm thành công !");
            return ResponseEntity.ok(responseDTO);
        }
        catch(Exception ex){
            responseDTO.setMessage("Xóa sản phẩm thất bại !");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseDTO);
        }
    }
}
