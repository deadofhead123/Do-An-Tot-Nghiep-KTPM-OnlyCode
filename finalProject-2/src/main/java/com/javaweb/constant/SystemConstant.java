package com.javaweb.constant;

public class SystemConstant {
    /*Spring security 4: ROLE_ADMIN, Spring security 3 not required*/
    public static final String ONE_EQUAL_ONE = " WHERE 1 = 1 ";
    public static final String STAFF_ROLE = "ROLE_STAFF";
    /*Spring security 4: ROLE_ADMIN, Spring security 3 not required*/
    public static final String USER_ROLE = "ROLE_USER";
    //    public static final String MANAGER_ROLE = "ROLE_MANAGER";
    public static final String ADMIN_ROLE = "ROLE_ADMIN";

    public static final String HOME = "/home";
    public static final String ADMIN_HOME = "/admin/home";
    public static final String MODEL = "model";
    public static final String INSERT_SUCCESS = "insert_success";
    public static final String UPDATE_SUCCESS = "update_success";
    public static final String DELETE_SUCCESS = "delete_success";
    public static final String ERROR_SYSTEM = "error_system";
    public static final String ALERT = "alert";
    public static final String MESSAGE_RESPONSE = "messageResponse";
    public static final String URL_BACK = "urlBack";
    public static final String PASSWORD_DEFAULT = "123456";
    public static final String CHANGE_PASSWORD_FAIL = "change_password_fail";

    public static final String NAME_OF_SHOP = "Vegefood";
    public static final String ADDRESS_OF_SHOP = "Số 298 đường Cầu Diễn, Phường Minh Khai, Quận Bắc Từ Liêm, Thành phố Hà Nội.";
    public static final String EMAIL_OF_SHOP = "phamminhhoa3005.shopapp@gmail.com";
    public static final String PHONENO_OF_SHOP = "0984243005";

    public static final Integer RESET_TOKEN_EXPIRED = 3; // days
    public static final Integer NEAR_OUT_OF_QUANTITY = 10; // days


    public static final String DEFAULT_ORDER_STATUS = "IN_PROGRESS";

    public static final String IMAGE_SAVE_PATH = "D://ImageRepository";

    public static final String SYSTEM_ERROR_MESSAGE = "Lỗi máy chủ! Vui lòng thử lại!";
}
