//
//  XCDataManage.m
//  XCWash
//
//  Created by 吴伟庆 on 15/3/15.
//  Copyright (c) 2015年 tatrena. All rights reserved.
//

#import "XCDataManage.h"
#import "DocumentUtil.h"
#import "AFHTTPRequestOperationManager.h"
#import "XCAddressModel.h"
#import "XCMessageModel.h"
#import "XCGoodsTypeModel.h"
#import "XCOrderModel.h"


@implementation XCBaseDataManage

+(void)baseStartRequestWithPath:(NSString *)path parmDic:(NSDictionary *)paramDic withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{
    
    if (![HTNetwork isNetworkAvailable])
    {
        
        if (block)
        {
            block(HTTP_NET_ERROR,STR_NET_ERROR,nil,nil);
        }
        
        return;
    }
    

    NSMutableDictionary *senderDic = [NSMutableDictionary dictionary];
    if (paramDic && [paramDic count]>0)
    {
        for (id key in paramDic.allKeys)
        {
            NSString *keyValue = [paramDic objectForKey:key];
            
            
            NSString *keyValueEncode = [keyValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [senderDic setValue:keyValueEncode forKey:key];
        }
    }
    
    
    
    
     DDLogInfo(@"send  path = %@  data = %@",path,senderDic);
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];

    [manage GET:path parameters:senderDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *retCode = [NSString stringWithFormat:@"%@",[responseObject valueForKeyPath:HTTP_CODE]];
        
        NSString *retMessage = [NSString stringWithFormat:@"%@",[responseObject valueForKeyPath:HTTP_MESSAGE]];
        
        DDLogInfo(@"recieve data =%@",responseObject);
        

        if (![retCode isEqualToString:HTTP_OK])
        {
            if ([NSString isBlankString:retMessage])
            {
                retMessage = STR_GET_DATA_FAILED;
            }

        }
        
        if (block)
        {
            block(retCode,retMessage,responseObject,nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block)
        {
            block(nil,STR_GET_DATA_FAILED,nil,error);
        }

    }];
    
//    [manage POST:path parameters:paramDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSString *retCode = [NSString stringWithFormat:@"%@",[responseObject valueForKeyPath:HTTP_CODE]];
//        
//        if (block)
//        {
//            block(retCode,nil,responseObject,nil);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (block)
//        {
//            block(nil,nil,nil,error);
//        }
//        
//    }];
}


+(void)baseStartUploadImageWithPath:(NSString *)path paramDic:(NSDictionary *)paramDic WithDataKey:(NSString *)dateKey imagesArray:(NSArray *)imageFile WithImageKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{
    

    if (![HTNetwork isNetworkAvailable])
    {
        
        if (block)
        {
            block(HTTP_NET_ERROR,STR_NET_ERROR,nil,nil);
        }
        
        return;
    }
    
    DDLogInfo(@"send request path : %@",path);
    
    DDLogInfo(@"send request data : %@",paramDic);
    
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionary];
    if (paramDic && [paramDic count]>0)
    {
        for (id key in paramDic.allKeys)
        {
            NSString *keyValue = [paramDic objectForKey:key];
            
            NSString *keyValueEncode = [keyValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [senderDic setValue:keyValueEncode forKey:key];
        }
    }
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.securityPolicy.allowInvalidCertificates = YES;
    
    
    [manage POST:path parameters:senderDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        

        for (NSInteger i = 0;i<[imageFile count];i++)
        {
            NSData *imageData = [imageFile objectAtIndex:i ];
            
            NSString *picname=[NSString stringWithFormat:@"pic%d",i];
            [formData appendPartWithFileData:imageData name:[keysArray objectAtIndex:i] fileName:[picname stringByAppendingFormat:@".jpg"] mimeType:@"image/jpeg"];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *retCode = [responseObject valueForKeyPath:HTTP_CODE];
        NSString *retmessage = [responseObject valueForKeyPath:HTTP_MESSAGE];
        
        if (![retCode isEqualToString:HTTP_OK])
        {
            if ([NSString isBlankString:retmessage])
            {
                retmessage = STR_GET_DATA_FAILED;
            }
            
        }
        
        if (block)
        {
            block(retCode,retmessage,responseObject,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block)
        {
            block(nil,STR_GET_DATA_FAILED,nil,error);
        }
        
        
    }];
    
}


+(void)baseStartUploadRecordFileWithPath:(NSString *)path paramDic:(NSDictionary *)paramDic WithDataKey:(NSString *)dateKey filePathArray:(NSArray *)filePathArray WithFileKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *, NSString *, id, NSError *))block
{
    
    
    if (![HTNetwork isNetworkAvailable])
    {
        
        if (block)
        {
            block(HTTP_NET_ERROR,STR_NET_ERROR,nil,nil);
        }
        
        return;
    }
    
    DDLogInfo(@"send request path : %@",path);
    
    DDLogInfo(@"send request data : %@",paramDic);
    
    NSMutableDictionary *senderDic = [NSMutableDictionary dictionary];
    if (paramDic && [paramDic count]>0)
    {
        for (id key in paramDic.allKeys)
        {
            NSString *keyValue = [paramDic objectForKey:key];
            
            NSString *keyValueEncode = [keyValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            
            [senderDic setValue:keyValueEncode forKey:key];
        }
    }

    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.securityPolicy.allowInvalidCertificates = YES;
    
    
    [manage POST:path parameters:senderDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        for (NSInteger i = 0;i<[filePathArray count];i++)
        {
            NSString *filePath = [filePathArray objectAtIndex:i ];
            
            NSString *picname=[NSString stringWithFormat:@"voice%d.aac",i];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:[keysArray objectAtIndex:i] fileName:picname mimeType:@"audio/3gp" error:nil];
        }
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString *retCode = [responseObject valueForKeyPath:HTTP_CODE];
        NSString *retmessage = [responseObject valueForKeyPath:HTTP_MESSAGE];
        
        if (![retCode isEqualToString:HTTP_OK])
        {
            if ([NSString isBlankString:retmessage])
            {
                retmessage = STR_GET_DATA_FAILED;
            }
            
        }
        
        if (block)
        {
            block(retCode,retmessage,responseObject,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (block)
        {
            block(nil,STR_GET_DATA_FAILED,nil,error);
        }
        
        
    }];
}





@end






@implementation XCDataManage

static XCDataManage *av;



+(id)shareSIPDataManager
{
    @synchronized(self)
    {
        if(av== nil)
        {
            av =[[XCDataManage alloc] init];
        }
    }
    return av;
}
+ (id)alloc
{
    @synchronized(self)
    {
        if (av ==nil)
        {
            av = [super alloc];
        }
    }
    return av;
}


+(id)resultOfHttpResponse:(id)responseObject
{
    NSString *jsonStr = [responseObject valueForKeyPath:HTTP_DATA] ;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err)
    {
        DDLogInfo(@"解析失败");
        
        return nil;
    }
    
    return dic;
    
}

#pragma mark - backgroundSessionManage -


- (AFURLSessionManager *)backgroundSessionManage
{
    
    NSURLSessionConfiguration *configuration;
    
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000)
    configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:BUNDLEID];
#else
    configuration = [NSURLSessionConfiguration backgroundSessionConfiguration:BUNDLEID];
#endif
    
    static AFURLSessionManager *sessionManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sessionManage = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return sessionManage;
}


-(void)downRecieveFileWithFileUrlStr:(NSString *)urlStr fileId:(NSString *)fileId  withBlock:(void (^)(NSString *, NSString *,NSURL *,NSError *))block
{
    self.sessionManage = [self backgroundSessionManage];
    
    
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",HX_FILE_DOWN_SERVER,urlStr];
    
    NSURL *downloadURL = [NSURL URLWithString:pathStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    
    
    NSURLSessionDownloadTask *downloadTask = [self.sessionManage downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        BOOL isExist = NO;
        
        NSString *recordFilePath = [DocumentUtil getRecordFileByRecordFileId:fileId isExist:&isExist];
        
        NSURL *desUrl = [[NSURL alloc]initFileURLWithPath:recordFilePath];
        
        
        return desUrl;
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error)
        {
            if (block)
            {
                block(nil,nil,filePath,error);
            }
        }
        else
        {
            NSHTTPURLResponse *httpRespone = (NSHTTPURLResponse *)response;
            NSDictionary *headDic = [httpRespone allHeaderFields];
            
            NSString *retCode = [NSString stringWithFormat:@"%d",httpRespone.statusCode];
            NSString *retmessage;
            
            if ([retCode isEqualToString:@"200"])
            {
                retmessage = @"下载成功";
            }
            else
            {
                retmessage = @"下载失败";

            }
            

            
            if (block)
            {
                block(retCode,retmessage,filePath,error);
            }

        }
        
        
        
        
        
    }];
    
    [downloadTask resume];

}


///////////////////////////////////////////////////

//////////////////////////////////////////////////

#pragma mark - + 请求接口 -

/*
 * 获取验证码
 */
+(void)getValiCodeWithBlock:(void (^)(NSString *, NSString *, NSError *))block userPhone:(NSString *)telPhone
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_SendValiCode];
    
    NSDictionary *dataDic = @{@"u_phone":telPhone};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            if (block)
            {
                block(nil,retMessage,error);
            }
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            if (block)
            {
                block(retCode,retMessage,nil);
            }

        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,nil);
            }
        }
        
        
        
        
    }];
    
}




+(void)loginWithBlock:(void (^)(NSString *, NSString *, NSError *))block userPhone:(NSString *)telPhone valiCode:(NSString *)valiCode
{
//    NSString *path = [NSString stringWithFormat:@"%@%@?u_phone=%@&valiCode=%@",HX_HTTP_SERVER,APT_Login,telPhone,valiCode];
    
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Login];
    
    NSDictionary *dataDic = @{@"u_phone":telPhone,@"valiCode":valiCode};
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            if (block)
            {
                block(nil,retMessage,error);
            }
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSDictionary *dic = [responseObject  valueForKeyPath:HTTP_DATA];
            if (dic)
            {
                [XCUserModel shareInstance].userName = [NSString stringWithoutNull:[dic objectForKey:@"u_nickname"]];
                
                [XCUserModel shareInstance].userId = [NSString stringWithoutNull:[dic objectForKey:@"u_id"]];
                
                [XCUserModel shareInstance].userPictureUrl = [NSString stringWithoutNull:[dic objectForKey:@"u_photo"]];
                
                [XCUserModel shareInstance].userTelphoneNum = [NSString stringWithoutNull:[dic objectForKey:@"u_phone"]];
                
                [XCUserModel shareInstance].u_address = [NSString stringWithoutNull:[dic objectForKey:@"u_address"]];
                
                [XCUserModel shareInstance].u_email = [NSString stringWithoutNull:[dic objectForKey:@"u_email"]];
                
                [XCUserModel shareInstance].u_get_message = [NSString stringWithoutNull:[dic objectForKey:@"u_get_message"]];
                
                [XCUserModel shareInstance].u_integral = [NSString stringWithoutNull:[dic objectForKey:@"u_integral"]];
                
                [XCUserModel shareInstance].u_qq = [NSString stringWithoutNull:[dic objectForKey:@"u_qq"]];
                
                [XCUserModel shareInstance].u_regTime = [NSString stringWithoutNull:[dic objectForKey:@"u_regTime"]];
                
            }
            
            if (block)
            {
                block(retCode,retMessage,nil);
            }
            
            
        }
        else if ([retCode isEqualToString:HTTP_ValiCode_error])
        {
            retMessage = @"验证码错误";
            if (block)
            {
                block(retCode,retMessage,nil);
            }
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,nil);
            }
            
        }

    }];
}



//获取地址
+(void)obtainAddressWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block addressType:(NSString *)type
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Obtain_address];
    
    NSDictionary *dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"type":type};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSArray *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in dataArray)
            {
                XCAddressModel *model = [[XCAddressModel alloc]init];
                model.ua_id = [NSString stringWithoutNull:[dic objectForKey:@"ua_id"]];
                
                model.ua_address = [NSString stringWithoutNull:[dic objectForKey:@"ua_address"]];
                
                model.ua_isdefault = [NSString stringWithoutNull:[dic objectForKey:@"ua_isdefault"]];
                
                model.ua_type = [NSString stringWithoutNull:[dic objectForKey:@"type"]];
                
                [mutabArray addObject:model];
            }
            
            
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }

            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
 
        }
        
        
        
    }];
}

+(void)addNewAddressWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block addressType:(NSString *)type address:(NSString *)address
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Add_address];
    
    NSDictionary *dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"type":type,@"ua_address":address};
    
    
   
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSDictionary *dic = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            XCAddressModel *model = [[XCAddressModel alloc]init];
            model.ua_id = [NSString stringWithoutNull:[dic objectForKey:@"ua_id"]];
            
            model.ua_address = [NSString stringWithoutNull:[dic objectForKey:@"ua_address"]];
            
            model.ua_isdefault = [NSString stringWithoutNull:[dic objectForKey:@"ua_isdefault"]];
            
            model.ua_type = [NSString stringWithoutNull:[dic objectForKey:@"type"]];
            
            [mutabArray addObject:model];
            
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }
        
        
        
    }];

}


+(void)obtainMessageWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Obtain_message];
    
    NSDictionary *dataDic = @{@"u_id":[XCUserModel shareInstance].userId};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSArray *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in dataArray)
            {
                
                XCMessageModel *model = [[XCMessageModel alloc]init];
                model.m_id = [NSString stringWithoutNull:[dic objectForKey:@"m_id"]];
                
                model.m_title = [NSString stringWithoutNull:[dic objectForKey:@"m_title"]];
                
                model.m_content = [NSString stringWithoutNull:[dic objectForKey:@"m_content"]];
                
                model.m_user_type = [NSString stringWithoutNull:[dic objectForKey:@"m_user_type"]];
                
                model.lr_ry = [NSString stringWithoutNull:[dic objectForKey:@"lr_ry"]];
                
                model.lr_sj = [NSString stringWithoutNull:[dic objectForKey:@"lr_sj"]];
                
                [mutabArray addObject:model];
            }
            
            
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }

    }];
}

/*
 * 上传头像
 */
+(void)uploadImageWithImagesArray:(NSArray *)imageFile WithImageKeysArray:(NSArray *)keysArray withBlock:(void (^)(NSString *,NSString *, NSString *, NSError *))block
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Upload_headImage];
    
    [XCBaseDataManage baseStartUploadImageWithPath:path paramDic:nil WithDataKey:nil imagesArray:imageFile WithImageKeysArray:keysArray withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:HTTP_OK])
        {
            NSString *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            
            if (block)
            {
                block(dataArray,retCode,retMessage,error);
            }

        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,error);
            }
        }
        
        
        
        
    }];
    
}


/*
 * 更新个人资料
 */

+(void)updateUserInfoWithNickName:(NSString *)nickName headImageUrlStr:(NSString *)photoUrlStr withBlock:(void (^)(NSString *, NSString *, NSError *))block
{
    
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Update_UserInfo];
    NSDictionary *dataDic ;
    
    if ([NSString isBlankString:photoUrlStr])
    {
        dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"u_nickname":nickName};
    }
    else
    {
        dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"u_nickname":nickName,@"u_photo":photoUrlStr};
    }
    
    
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            if (block)
            {
                block(nil,retMessage,error);
            }
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSDictionary *dic = [responseObject  valueForKeyPath:HTTP_DATA];
            if (dic)
            {
                [XCUserModel shareInstance].userName = [NSString stringWithoutNull:[dic objectForKey:@"u_nickname"]];
                
                [XCUserModel shareInstance].userId = [NSString stringWithoutNull:[dic objectForKey:@"u_id"]];
                
                [XCUserModel shareInstance].userPictureUrl = [NSString stringWithoutNull:[dic objectForKey:@"u_photo"]];
                
                [XCUserModel shareInstance].userTelphoneNum = [NSString stringWithoutNull:[dic objectForKey:@"u_phone"]];
                
                [XCUserModel shareInstance].u_address = [NSString stringWithoutNull:[dic objectForKey:@"u_address"]];
                
                [XCUserModel shareInstance].u_email = [NSString stringWithoutNull:[dic objectForKey:@"u_email"]];
                
                [XCUserModel shareInstance].u_get_message = [NSString stringWithoutNull:[dic objectForKey:@"u_get_message"]];
                
                [XCUserModel shareInstance].u_integral = [NSString stringWithoutNull:[dic objectForKey:@"u_integral"]];
                
                [XCUserModel shareInstance].u_qq = [NSString stringWithoutNull:[dic objectForKey:@"u_qq"]];
                
                [XCUserModel shareInstance].u_regTime = [NSString stringWithoutNull:[dic objectForKey:@"u_regTime"]];
                
            }
            
            if (block)
            {
                block(retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(retCode,retMessage,nil);
            }
            
        }
        
    }];
    
    
}




/*
 * 上传音频
 */

+(void)uploadRecordFileWithFilePath:(NSString *)filePath withBlock:(void (^)(NSString *, NSString *, NSString *, NSError *))block
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Upload_recordFile];

    NSArray *filePathArray = @[filePath];
    NSArray *fileKeyArray = @[@"file"];
    
    
    [XCBaseDataManage baseStartUploadRecordFileWithPath:path paramDic:nil WithDataKey:nil filePathArray:filePathArray WithFileKeysArray:fileKeyArray withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if ([retCode isEqualToString:HTTP_OK])
        {
            NSString *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            
            if (block)
            {
                block(dataArray,retCode,retMessage,error);
            }
            
        }
        
        if (block)
        {
            block(nil,retCode,retMessage,error);
        }
        
        
    }];
    
    
}

+(void)obtainGoodsTypeWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block parentId:(NSString *)parentId
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Obtain_Goods_type];
    
    NSDictionary *dataDic = @{@"gt_parent_id":parentId};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSArray *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in dataArray)
            {
                
                XCGoodsTypeModel *model = [[XCGoodsTypeModel alloc]init];
                model.gt_id = [NSString stringWithoutNull:[dic objectForKey:@"gt_id"]];
                
                model.gt_name = [NSString stringWithoutNull:[dic objectForKey:@"gt_name"]];
                
                model.gt_parent_id = [NSString stringWithoutNull:[dic objectForKey:@"gt_parent_id"]];
                
                model.gt_desc = [NSString stringWithoutNull:[dic objectForKey:@"gt_desc"]];
                
                model.lr_ry = [NSString stringWithoutNull:[dic objectForKey:@"lr_ry"]];
                
                model.lr_sj = [NSString stringWithoutNull:[dic objectForKey:@"lr_sj"]];
                
                [mutabArray addObject:model];
            }
            
            
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }
        
    }];

}

+(void)obtainGoodsListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block goodsTypeId:(NSString *)gt_id
{
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Obtain_Goods_List];
    
    NSDictionary *dataDic = @{@"gt_id":gt_id};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSArray *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in dataArray)
            {
                
                XCGoodsModel *model = [[XCGoodsModel alloc]init];
                model.g_id = [NSString stringWithoutNull:[dic objectForKey:@"g_id"]];
                
                model.g_name = [NSString stringWithoutNull:[dic objectForKey:@"g_name"]];
                
                model.g_img = [NSString stringWithoutNull:[dic objectForKey:@"g_img"]];
                
                model.gt_id = [NSString stringWithoutNull:[dic objectForKey:@"gt_id"]];
                
                model.g_price = [NSString stringWithoutNull:[dic objectForKey:@"g_price"]];
                
                model.g_sm = [NSString stringWithoutNull:[dic objectForKey:@"g_sm"]];
                
                model.g_estimate_time = [NSString stringWithoutNull:[dic objectForKey:@"g_estimate_time"]];
                
                model.g_type = [NSString stringWithoutNull:[dic objectForKey:@"g_type"]];
                
                
                [mutabArray addObject:model];
            }
            
            
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }
        
    }];
}


+(void)obtainMyOrderListWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block orderType:(NSString *)type
{
    
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Obtain_Order_List];
    
    NSDictionary *dataDic = @{@"type":type,@"u_id":[XCUserModel shareInstance].userId};
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSArray *dataArray = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            for (NSDictionary *dic in dataArray)
            {
                
                XCOrderModel*model = [[XCOrderModel alloc]init];
                model.orderId = [NSString stringWithoutNull:[dic objectForKey:@"o_id"]];
                
                model.orderNumber = [NSString stringWithoutNull:[dic objectForKey:@"o_no"]];
                
                model.orderTime = [NSString stringWithoutNull:[dic objectForKey:@"o_time"]];
                
                model.takeAddress = [NSString stringWithoutNull:[dic objectForKey:@"o_cu_et_add"]];
                
                model.sendAddress = [NSString stringWithoutNull:[dic objectForKey:@"o_cu_ets_add"]];
                
                model.listenFileUrl = [NSString stringWithoutNull:[dic objectForKey:@"o_voice_url"]];
                
                model.o_status = [NSString stringWithoutNull:[dic objectForKey:@"o_status"]];
                [mutabArray addObject:model];
            }
            
            
            if (block)
            {
                block([NSMutableArray arrayWithArray:mutabArray],retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }
        
    }];

}

+(void)makeOrderWithBlock:(void (^)(NSMutableArray *, NSString *, NSString *, NSError *))block takeTime:(NSString *)takeTime takeAddress:(NSString *)takeAddress sendAddress:(NSString *)sendAddress voiceUrl:(NSString *)voiceUrl
{
    
    NSString *path = [NSString stringWithFormat:@"%@%@",HX_HTTP_SERVER,API_Add_New_Order];
    
    NSDictionary *dataDic;
    if (![NSString isBlankString:voiceUrl])
    {
        dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"o_cu_et_time":takeTime,@"o_cu_ets_add":sendAddress,@"o_cu_et_add":takeAddress,@"o_voice_url":voiceUrl};
    }
    else
    {
        dataDic = @{@"u_id":[XCUserModel shareInstance].userId,@"o_cu_et_time":takeTime,@"o_cu_ets_add":sendAddress,@"o_cu_et_add":takeAddress,@"o_voice_url":@""};
    }
    
    [XCBaseDataManage baseStartRequestWithPath:path parmDic:dataDic withBlock:^(NSString *retCode, NSString *retMessage, id responseObject, NSError *error) {
        
        if (error)
        {
            block(nil,retMessage,nil,error);
        }
        else if ([retCode isEqualToString:HTTP_OK])
        {
            NSDictionary *dic = [responseObject  valueForKeyPath:HTTP_DATA];
            NSMutableArray *mutabArray = [NSMutableArray arrayWithCapacity:0];
            
            if (dic)
            {
                XCOrderModel*model = [[XCOrderModel alloc]init];
                model.orderId = [NSString stringWithoutNull:[dic objectForKey:@"o_id"]];
                
                model.orderNumber = [NSString stringWithoutNull:[dic objectForKey:@"o_no"]];
                
                model.orderTime = [NSString stringWithoutNull:[dic objectForKey:@"o_time"]];
                
                model.takeAddress = [NSString stringWithoutNull:[dic objectForKey:@"o_cu_et_add"]];
                
                model.sendAddress = [NSString stringWithoutNull:[dic objectForKey:@"o_cu_ets_add"]];
                
                model.listenFileUrl = [NSString stringWithoutNull:[dic objectForKey:@"o_voice_url"]];
                
                model.o_cu_et_time = [NSString stringWithoutNull:[dic objectForKey:@"o_cu_et_time"]];
                [mutabArray addObject:model];
            }
            if (block)
            {
                block(mutabArray,retCode,retMessage,nil);
            }
            
            
        }
        else
        {
            if (block)
            {
                block(nil,retCode,retMessage,nil);
            }
            
        }
        
    }];

}




@end
