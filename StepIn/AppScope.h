//
//  AppScope.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDef.h"

@interface AppScope : NSObject {
	SIDelegate *appDelegate_;
	UITabBarController *tabController_;
}

@property (nonatomic,retain) SIDelegate *appDelegate;
@property (nonatomic,retain) UITabBarController *tabController;

@end
