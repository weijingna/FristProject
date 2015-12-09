//
//  HttpApi.h
//  packApi
//
//  Created by chedao on 15/5/26.
//  Copyright (c) 2015年 chedao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//typedef void (^RequestParameter)(NSMutableDictionary *dicParmes);
typedef void (^SuccessResult)(id dicResult);
typedef void (^errorResult)(id errorResult);
//byteWritten  当前下载的大小     alreadyWrittenBytes  已经下载的大小    totalBytes  下载总量的大小
typedef void (^UploadProgressHandler)(int byteWritten,int alreadyWrittenBytes,int totalBytes);

@interface HttpApi : NSObject

+(HttpApi*)shareHttpApi;

/*! type == 1 是 请求返回的所有信息全部回调回去  其他的只回调成功的接口*/
@property(nonatomic,assign)int type;

//数据请求
// requestHeader :请求头   paramerter:请求体  一般是字典类型   errorMessager :请求失败候提示的信息 如果不需要提示的话 写nil   controller:请求的类 如果不需要弹出框的话为nil  view：请求等待是的旋转  如果不需要的话 写nil   success:请求成功之后返回来的数据类型   
-(void)httpAPi:(NSString *)RequestHeader Parameter:(id)parameter error:(NSString*)errorMessage controller:(UIViewController*)controller hudView:(UIView*)view Success:(SuccessResult)success Error:(errorResult)errorInfo;


//获取下载进度 或者上传进度的 方法
-(void)httpUpload:(NSString*)requestHeader Parameter:(id)paramter success:(SuccessResult)success upload:(UploadProgressHandler)uploadhander;

@end
