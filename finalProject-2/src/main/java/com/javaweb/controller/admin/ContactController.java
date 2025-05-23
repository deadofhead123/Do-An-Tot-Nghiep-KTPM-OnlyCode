package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.model.dto.ContactDTO;
import com.javaweb.model.request.ContactSearchRequest;
import com.javaweb.model.response.ContactSearchResponse;
import com.javaweb.service.contact.IContactService;
import com.javaweb.util.ContactStatus;
import com.javaweb.util.DisplayTagUtils;
import com.javaweb.util.MessageUtils;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang.StringUtils;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller(value = "contactControllerOfAdmin")
@RequiredArgsConstructor
public class ContactController {
    private final IContactService IContactService;
    private final MessageUtils messageUtil;

    @GetMapping(value = "/admin/contact-list")
    public ModelAndView contactList(@ModelAttribute("contactSearch") ContactSearchRequest contactSearchRequest, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/contact/list");

        ContactSearchResponse contactResponseList = new ContactSearchResponse();

        DisplayTagUtils.of(request, contactResponseList);
        contactResponseList.setListResult
                (IContactService.findAll(contactSearchRequest,
                        PageRequest.of(contactResponseList.getPage() - 1, contactResponseList.getMaxPageItems(), Sort.by(Sort.Direction.valueOf(contactResponseList.getSortOrder()), contactResponseList.getSortName()))));
        contactResponseList.setTotalItems(IContactService.countTotalItems(contactSearchRequest));

        mav.addObject("listType", ContactStatus.typeContact());
        mav.addObject("contactResponseList", contactResponseList);

        return mav;
    }

    @GetMapping(value = "/admin/contact-edit-{id}")
    public ModelAndView contactDetail(@ModelAttribute("contactDetail") ContactDTO contactDTO, HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/contact/edit");

        ContactDTO contactReturn = IContactService.findOneById(contactDTO.getId());

        if(ObjectUtils.isEmpty(contactReturn)){
            return new ModelAndView("redirect:/not-found");
        }

        mav.addObject("contactDetail", contactReturn);
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
