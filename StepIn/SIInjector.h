//
//  SIInjector.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDef.h"

@interface SIInjector : NSObject


#pragma mark AppDelegate
+(SIDelegate*)injectDelegate;

#pragma mark Appscope
+(AppScope*)injectAppScope;

#pragma mark TabBar
+(TabBarProvider)injectTabBarProvider:(AppScope*)appScope;
+(UITabBarController *)tabBarController:(AppScope*)appScope;
+(NSArray*)injectTabBarControllers:(AppScope*)appScope;

@end