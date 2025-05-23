package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.UserDTO;
import com.javaweb.model.request.UserSearchRequest;
import com.javaweb.model.response.UserSearchResponse;
import com.javaweb.service.user.IUserService;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import com.javaweb.util.RoleCode;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller(value = "userControllerOfAdmin")
@RequiredArgsConstructor
public class UserController {
    private final IUserService IUserService;
    private final MessageUtils messageUtil;

    @GetMapping(value = "/admin/user-list")
    public ModelAndView userList(@ModelAttribute("userSearch") UserSearchRequest userSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/user/list");

        UserSearchResponse userSearchResponse = new UserSearchResponse();

        DisplayTagUtils.of(request, userSearchResponse);
//        Sort sort = Sort.by(userSearchResponse.getSortName()).ascending();
        Sort sort = Sort.by(Sort.Direction.valueOf(userSearchResponse.getSortOrder()), userSearchResponse.getSortName());
        userSearchResponse.setListResult(IUserService.findAll(userSearchRequest, PageRequest.of(userSearchResponse.getPage() - 1, userSearchResponse.getMaxPageItems(), sort)));
        userSearchResponse.setTotalItems(IUserService.countTotalItems(userSearchRequest));

        mav.addObject("userSearchResponse", userSearchResponse);
        mav.addObject("role", RoleCode.getListCode());

        return mav;
    }

    @GetMapping(value = "/admin/user-detail-{id}")
    public ModelAndView userDetail(@ModelAttribute("userDetail") UserDTO userDTO, @PathVariable Long id) {
        ModelAndView mav = new ModelAndView("/admin/user/detail");

        UserDTO userReturn = IUserService.findOneById(id);

        if(ObjectUtils.isEmpty(userReturn)){
            return new ModelAndView("/redirect:/not-found");
        }

        mav.addObject("userDetail", userReturn);

        return mav;
    }

    @GetMapping(value = "/admin/user-add")
    public ModelAndView addUser(@ModelAttribute("userAdd") UserDTO userDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/admin/user/add");

        mav.addObject("role", RoleCode.getListCode());
        initMessageResponse(mav, request);

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
