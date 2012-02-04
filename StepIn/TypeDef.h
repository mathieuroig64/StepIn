//
//  TypeDef.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//


@class AppScope;
@class SIDelegate;
@class AlertViewController;
@class InfoViewController;
@class MyInfoViewController;

#pragma mark UITabBarController
typedef UITabBarController* (^TabBarProvider)();

#pragma mark AlertViewController
typedef AlertViewController *(^AlertViewControllerProvider)();

#pragma mark InfoViewController
typedef InfoViewController *(^InfoViewControllerProvider)();

#pragma mark MyInfoViewController
typedef MyInfoViewController *(^MyInfoViewControllerProvider)();