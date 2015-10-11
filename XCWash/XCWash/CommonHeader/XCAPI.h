//
//  XCAPI.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/13.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//


//#define XC_TEST   //测试数据




#define BUNDLEID            @"com.yibaomd.YiBaomdPatientDevTest"



/*
 *  接口相关
 
    com.xcwash.xcwash    测试使用的企业打包证书
 *
 */



#define HB_SEVERCE_DEBUG//调试时打开这个宏，发版本时关闭这个宏

#ifdef HB_SEVERCE_DEBUG

#define HX_HTTP_SERVER     @"http://121.40.19.232:8080//xcnyWeb/"

#define HX_FILE_DOWN_SERVER     @"http://121.40.19.232:8080/xcnyImg/"



#else

#define HX_HTTP_SERVER     @"http://zhoujian2964.oicp.net:9191//xcnyWeb/"

#define HX_FILE_DOWN_SERVER     @"http://121.40.19.232:8080/xcnyImg/"


#endif



#define API_UserImageUrl     HX_FILE_DOWN_SERVER

#define API_Download_goods_img     HX_FILE_DOWN_SERVER



#define API_uploadVoiceUrl     [NSString stringWithFormat:@"%@voice/",HX_FILE_DOWN_SERVER]




/*
 * 接口返回
 *
 */

#define HTTP_CODE     @"resultCode"

#define HTTP_MESSAGE  @"resultMessage"


#define HTTP_DATA     @"data"

#define HTTP_OK     @"1"

#define HTTP_ValiCode_error     @"2"

#define HTTP_NET_ERROR     @"009988"


/*
 * 接口api
 *
 */

#define API_SendValiCode       @"wUser/sendValiCode"


#define API_Login              @"wUser/login"

#define API_Obtain_address     @"wUser/getAddressList"

#define API_Add_address        @"wUser/addAddress"

#define API_Obtain_message      @"wUser/getUserMessage"

#define API_Upload_headImage    @"file/uploadFile?fileType=headPhoto"

#define API_Upload_recordFile    @"file/uploadFile?fileType=voice"



#define API_Update_UserInfo     @"wUser/updateWUser"

#define API_Obtain_Goods_type     @"goodsType/getGoodsTypeList"

#define API_Obtain_Goods_List     @"goods/getGoodsListByGT"

#define API_Obtain_Order_List     @"wOrder/getWUserOrderListByType"

#define API_Add_New_Order     @"wOrder/addWOrder"

#define API_Cancle_Order     @"wOrder/cancelWOrder"

#define API_Get_Order_detail     @"wOrder/getOrderDetail"


#define API_Comment_Order     @"wOrder/addWComment"


#define API_Get_advlist     @"common/getAdvList"

#define API_Delete_address     @"wUser/deleteAddress"




#define AccountLoginResult          @"AccountLoginResult"

#define LOGIN_SUCCESS_USER_ID          @"LOGIN_SUCCESS_USER_ID"

#define LOGIN_SUCCESS_USER_NAME          @"LOGIN_SUCCESS_USER_NAME"

#define LOGIN_SUCCESS_USER_URL          @"LOGIN_SUCCESS_USER_URL"

