//
//  XCDataManage.h
//  XCWash
//
//  Created by 吴伟庆 on 15/3/15.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLSessionManager.h"
#import "XCOrderModel.h"


@interface XCBaseDataManage : NSObject


/**
 *   基本请求方法
 */

+(void)baseStartRequestWithPath:(NSString *)path parmDic:(NSDictionary *)paramDic withBlock:(void (^)(NSString *retCode, NSString *retMessage, id responseObject , NSError *error))block;


/**
 * 上传图片
 */

+(void)baseStartUploadImageWithPath:(NSString *)path paramDic:(NSDictionary *)paramDic WithDataKey:(NSString *)dateKey imagesArray:(NSArray *)imageFile WithImageKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *retCode, NSString *retMessage, id responseObject , NSError *error))block;


/**
 * 上传音频
 */
+(void)baseStartUploadRecordFileWithPath:(NSString *)path paramDic:(NSDictionary *)paramDic WithDataKey:(NSString *)dateKey filePathArray:(NSArray *)filePathArray WithFileKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *retCode, NSString *retMessage, id responseObject , NSError *error))block;


@end




@interface XCDataManage : NSObject

@property(nonatomic,strong) AFURLSessionManager *sessionManage;

+(id)shareSIPDataManager;

-(void)downRecieveFileWithFileUrlStr:(NSString *)urlStr fileId:(NSString *)fileId withBlock:(void (^)(NSString *retCode,NSString *retMessage,NSURL *filePath,NSError *error))block;

/////////////////////////////////////
/////////////////////////////////////

/**
 *  获取验证码
 */
+(void)getValiCodeWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block userPhone:(NSString *)telPhone;


/**
 *  登录  注册
 */

+(void)loginWithBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block userPhone:(NSString *)telPhone valiCode:(NSString *)valiCode;

/**
 *  获取地址
 */
+(void)obtainAddressWithBlock:(void (^)(NSMutableArray *addressArray,NSString *retcode,NSString *retMessage,NSError *error))block addressType:(NSString *)type;

/**
 *  新增地址
 */
+(void)addNewAddressWithBlock:(void (^)(NSMutableArray *addressArray,NSString *retcode,NSString *retMessage,NSError *error))block addressType:(NSString *)type address:(NSString *)address;


/**
 *  会员消息
 */
+(void)obtainMessageWithBlock:(void (^)(NSMutableArray *messageArray,NSString *retcode,NSString *retMessage,NSError *error))block;


/**
 *  上传头像
 */


+(void)uploadImageWithImagesArray:(NSArray *)imageFile WithImageKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *fileUrlStr,NSString *retcode,NSString *retMessage,NSError *error))block;




/**
 *  更新个人资料
 */

+(void)updateUserInfoWithNickName:(NSString *)nickName headImageUrlStr:(NSString *)photoUrlStr withBlock:(void (^)(NSString *retcode,NSString *retmessage,NSError *error))block;


/**
 *  上传音频
 */

+(void)uploadRecordFileWithFilePath:(NSString *)filePath withBlock:(void (^)(NSString *fileUrlStr,NSString *retcode,NSString *retMessage,NSError *error))block;


//http://121.40.19.232:8080//xcnyWeb/goodsType/getGoodsTypeList?gt_parent_id=1
//
//响应数据：{"resultCode":"1","data":[{"gt_desc":"","gt_id":"1","gt_name":"上衣","gt_parent_id":"1","lr_ry":"1","lr_sj":"2015-03-10 21:42:38.0"},{"gt_desc":"","gt_id":"2","gt_name":"下装","gt_parent_id":"1","lr_ry":"1","lr_sj":"2015-03-10 21:43:23.0"},{"gt_desc":"","gt_id":"3","gt_name":"衬衫","gt_parent_id":"1","lr_ry":"1","lr_sj":"2015-03-10 21:43:37.0"}]}


/**
 * 获取商品分类
 */
+(void)obtainGoodsTypeWithBlock:(void (^)(NSMutableArray *messageArray,NSString *retcode,NSString *retMessage,NSError *error))block parentId:(NSString *)parentId;

/**
 * 获取商品分类列表
 */
+(void)obtainGoodsListWithBlock:(void (^)(NSMutableArray *messageArray,NSString *retcode,NSString *retMessage,NSError *error))block goodsTypeId:(NSString *)gt_id;

/**
 * 我的订单
 */
+(void)obtainMyOrderListWithBlock:(void (^)(NSMutableArray *messageArray,NSString *retcode,NSString *retMessage,NSError *error))block orderType:(NSString *)type;

/**
 * 用户下单
 */

+(void)makeOrderWithBlock:(void (^)(NSMutableArray *messageArray,NSString *retcode,NSString *retMessage,NSError *error))block  takeTime:(NSString *)takeTime takeAddress:(NSString *)takeAddress sendAddress:(NSString *)sendAddress voiceUrl:(NSString *)voiceUrl;




/**
 * 取消订单
 */
+(void)cancleOrderWithBlock:(void (^)(NSString *retcode,NSString *retMessage,NSError *error))block  orderId:(NSString *)orderId cancleReason:(NSString *)cancleReason;

/**
 * 订单详情
 */
+(void)obtainOrderDetailithBlock:(void (^)(XCOrderDetailModel*detailModel,NSString *retcode,NSString *retMessage,NSError *error))block  orderId:(NSString *)orderId;


/**
 * 评论订单
 */
+(void)addCommentToOrderWithBlock:(void (^)(NSString *retcode,NSString *retMessage,NSError *error))block  uid:(NSString *)u_id oid:(NSString *)o_id ccontent:(NSString *)c_content cclevel:(NSString *)c_c_level cwlevel:(NSString *)c_w_level;

/**
 * 广告位
 */
+(void)getAdWithBlock:(void (^)(NSMutableArray *array,NSString *retcode,NSString *retMessage,NSError *error))block;

/**
 * 删除地址
 */
+(void)deleteAddressWithBlock:(void (^)(NSString *retcode,NSString *retMessage,NSError *error))block uaid:(NSString *)ua_id;


@end
