
#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)HUDWithStr:(NSString *)str delay:(NSTimeInterval)delay view:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = str;
    [view addSubview:HUD];
//    HUD.mode = MBProgressHUDModeDeterminate;
    [HUD show:YES];
    [self setHUD:HUD];
    [HUD hide:YES afterDelay:delay];
}

- (void)HUDWithImgName:(NSString *)imgName txt:(NSString *)txt delay:(NSTimeInterval)delay view:(UIView *)view
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = txt;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    [HUD show:YES];
    [self setHUD:HUD];
    [HUD hide:YES afterDelay:delay];
}

- (void)hideHud
{
    [[self HUD] hide:YES];
}

@end
