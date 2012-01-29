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
@class MyAgentsViewController;
@class LoginViewController;

#pragma mark UITabBarController
typedef UITabBarController* (^TabBarProvider)();

#pragma mark AlertViewController
typedef AlertViewController *(^AlertViewControllerProvider)();

#pragma mark AccountViewController
typedef MyAgentsViewController *(^MyAgentsViewControllerProvider)();

#pragma mark LoginViewController
typedef LoginViewController *(^LoginViewControllerProvider)();