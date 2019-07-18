//
//  MBProgressHUD+ISProgress.h
//  ISToolsDemo
//
//  Created by isaac on 15/12/21.
//  Copyright © 2015年 isaac. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ISProgress)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showLoading:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showLoading:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
