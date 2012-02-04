//
//  SIInjector.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDef.h"

//Manager
@class UserManager;
@class ContactManager;

@interface SIInjector : NSObject


#pragma mark AppDelegate
+(SIDelegate*)injectDelegate;

#pragma mark Appscope
+(AppScope*)injectAppScope;

#pragma mark TabBar
+(TabBarProvider)injectTabBarProvider:(AppScope*)appScope;
+(UITabBarController *)tabBarController:(AppScope*)appScope;
+(NSArray*)injectTabBarControllers:(AppScope*)appScope;

#pragma mark AlertViewControllerProvider
+(AlertViewControllerProvider)injectAlertViewControllerProvider:(AppScope*)appScope;

#pragma mark InfoViewControllerProvider
+(InfoViewControllerProvider)injectInfoViewControllerProvider:(AppScope*)appScope;

#pragma mark MyInfoViewControllerProvider
+(MyInfoViewControllerProvider)injectMyInfoViewControllerProvider:(AppScope*)appScope;

#pragma mark -
#pragma mark CoreData
+ (NSManagedObjectContext*)injectContext;

#pragma mark UserManager
+ (UserManager*)injectUserManager:(AppScope*)appScope;

#pragma mark ContactManager
+ (ContactManager*)injectContactManager:(AppScope*)appScope;
@end
