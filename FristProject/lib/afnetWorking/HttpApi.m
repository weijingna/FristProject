//
//  HttpApi.m
//  packApi
//
//  Created by chedao on 15/5/26.
//  Copyright (c) 2015年 chedao. All rights reserved.
//

#import "HttpApi.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIViewController+HUD.h"
#import <CommonCrypto/CommonDigest.h>
#import "LoadingViewController.h"

#ifdef DEBUG //调试阶段打印信息
#define MLLog(...)   NSLog(__VA_ARGS__)
#else   //上线之后  不让打印信息
#define MLLog(...)
#endif

@implementation HttpApi{

    MBProgressHUD * huding;

}


#pragma mark - ------------MD5 加密
//md5 加密字符串
-(NSString *) md5:(NSString *)str {
    
    if (str == nil) {//545b3dadb9e0b0e48aa3d21d
        return nil;
    }
    const char *cstr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, strlen(cstr), result);
    
    return [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1],
            result[2], result[3],
            result[4], result[5],
            result[6], result[7],
            result[8], result[9],
            result[10], result[11],
            result[12], result[13],
            result[14], result[15]];
}

-(NSString*)ascendingSort:(NSDictionary*)dic{
    
    
    NSMutableString *str0 = [[NSMutableString alloc] init];
    
    NSInteger k=0;
    for (NSString *key in dic.allKeys) {
        if (k==0) {
            NSString *tmp = [NSString stringWithFormat:@"%@=%@",key,[NSString stringWithFormat:@"%@", [dic objectForKey:key]]];
            [str0 appendString:tmp];
        }else{
            NSString *tmp = [NSString stringWithFormat:@"&%@=%@",key,[NSString stringWithFormat:@"%@",[dic objectForKey:key]]];
            [str0 appendString:tmp];
        }
        k++;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < str0.length; i++) {
        [arr addObject:[NSString stringWithFormat:@"%C",[str0 characterAtIndex:i]]];
    }
    
    for (int i = 0; i < arr.count - 1; i++) {
        for (int j = i + 1 ; j < arr.count ; j++) {
            NSString *str1 = [arr objectAtIndex:i];
            NSString *str2 = [arr objectAtIndex:j];
            if ([str1 compare: str2] == NSOrderedDescending) {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
            
        }
    }
    
    
    NSString * returnStr = [[arr componentsJoinedByString:@""] stringByAppendingString:@"545b3dadb9e0b0e48aa3d21d"];
    return returnStr;
}


+(HttpApi *)shareHttpApi{

    static HttpApi *api = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[HttpApi alloc] init];
    });
    return api;
}

-(void)httpAPi:(NSString *)RequestHeader Parameter:(id)parameter error:(NSString *)errorMessage controller:(UIViewController*)controller hudView:(UIView*)view Success:(SuccessResult)success Error:(errorResult)errorInfo{
    
    NSMutableDictionary *paramteDic = [NSMutableDictionary dictionaryWithDictionary:parameter];
    #pragma mark--------======== 如需加密操作可以直接在此设置
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
         [paramteDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
        [paramteDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forKey:@"token"];
    }
    
    [paramteDic setObject:[self md5:[self ascendingSort:paramteDic]] forKey:@"sign"];
    
    
    //数据吧数据拼接为url
    NSString *paramte = @"";
    int i = 0;
    for (NSString *key in paramteDic.allKeys) {
        if (i == 0) {
            
            paramte = [paramte stringByAppendingFormat:@"%@=%@",key,paramteDic[key]];
            
        }else{
            
            paramte = [paramte stringByAppendingFormat:@"&%@=%@",key,paramteDic[key]];
            
        }
        i++;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@?%@",RequestHeader,paramte];
    NSLog(@"This   URl === %@ ",url);

    #pragma mark-------  如果view为nil的话表示不需要 弹出旋转等待
    if (view) {
        [huding hide:YES];
        huding = [MBProgressHUD showHUDAddedTo:view animated:YES];
        }

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    //响应json数据
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //发送json数据
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    //设置超时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //请求时长30秒
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
  [manager POST:RequestHeader parameters:paramteDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
      MLLog(@"请求成功   =========== %@",responseObject);

      if (view) {
          [huding hide:YES];
      }
      
      if (self.type == 1) {
          self.type = 0;
          if (success) {
              //连接服务器 请求成功
              success(responseObject);
          }
          if ([[responseObject objectForKey:@"code"] intValue] == 999){
              
             
              LoadingViewController *loadVC = [[LoadingViewController alloc] initWithNibName:@"loadingViewController" bundle:nil];
              
                [loadVC HUDWithImgName:nil txt:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] delay:1.5 view:loadVC.view];
              [controller presentViewController:loadVC animated:YES completion:nil];
              
          }
          
      }else{
      
          if ([[responseObject objectForKey:@"code"] intValue] == 200) {
              if (success) {
                  //连接服务器 请求成功
                  success(responseObject);
              }
          }else  if ([[responseObject objectForKey:@"code"] intValue] == 999){
          
             
              LoadingViewController *loadVC = [[LoadingViewController alloc] initWithNibName:@"loadingViewController" bundle:nil];
              
              
                [loadVC HUDWithImgName:nil txt:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] delay:1.5 view:loadVC.view];
              
              [controller presentViewController:loadVC animated:YES completion:nil];
          
              
              
          }else{
              //成功连接服务器后的其他错误  如参数有误。。。。
              if (controller && view) {
                [controller HUDWithImgName:nil txt:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]] delay:1.2 view:view];

            }
          }
      }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      MLLog(@"%@   %@",errorMessage,error);
      if (self.type == 1) {
          self.type = 0;
      }
      if (errorInfo) {
          errorInfo(error);
      }
      
      if (view) {
       [huding hide:YES];
      }
      if (error.code == -1001) {
          
    
          [controller HUDWithImgName:@"wrong.png" txt:@"网络连接超时\n请检查您的网络连接!" delay:1.2 view:view];

      }else{
      
          if (errorMessage) {
            [controller HUDWithImgName:@"wrong.png" txt:errorMessage delay:1.2 view:view];
          }
      }
  }];
    
}

-(void)httpUpload:(NSString *)requestHeader Parameter:(id)paramter success:(SuccessResult)success upload:(UploadProgressHandler)uploadhander{

    NSMutableDictionary *paramteDic = [NSMutableDictionary dictionaryWithDictionary:paramter];
#pragma mark--------======== 如需加密操作可以直接在此设置
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //响应json数据
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //发送json数据
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
    //设置超时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    //请求时长30秒
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    AFHTTPRequestOperation *operation = [manager POST:requestHeader parameters:paramteDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MLLog(@"%@ ",error);
        
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        NSLog(@"%ld  %llu %llu",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
        uploadhander((int)bytesWritten,(int)totalBytesWritten,(int)totalBytesExpectedToWrite);
    }];
    
    [operation start];


}


@end
