#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

//图文菊花
- (void)HUDWithImgName:(NSString *)imgName txt:(NSString *)txt delay:(NSTimeInterval)delay view:(UIView *)view;

//文字菊花
- (void)HUDWithStr:(NSString *)str delay:(NSTimeInterval)delay view:(UIView *)view;

//隐藏菊花
- (void)hideHud;


@end
