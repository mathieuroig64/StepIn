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
@synthesize context = context_;

- (id)initWithContext:(NSManagedObjectContext*)context{
  self = [super init];
  if (self) {
    context_ = [context retain];
  }
  return self;
}

-(void)dealloc{
	[tabController_ release];
	[appDelegate_ release];
  [context_ release];
  [super dealloc];
}
@end
