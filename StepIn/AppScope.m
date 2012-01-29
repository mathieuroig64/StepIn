//
//  AppScope.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "AppScope.h"

@implementation AppScope
@synthesize appDelegate = appDelegate_;
@synthesize tabController = tabController_;

-(void)dealloc{
	[tabController_ release];
	[appDelegate_ release];
  [super dealloc];
}
@end
