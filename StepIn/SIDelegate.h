//
//  SIDelegate.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDef.h"

@interface SIDelegate : UIResponder 
<UIApplicationDelegate, UITabBarControllerDelegate>{
@public
  UIWindow * window_;
  
@private
	UITabBarController *tabBarController_;
	TabBarProvider tabBarProvider_;
}

@property (retain, nonatomic) UIWindow *window;

-(id)initWithWindow:(UIWindow*)mainWindow
     tabBarProvider:(TabBarProvider)tabBarProvider;
@end
