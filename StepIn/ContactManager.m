//
//  ContactManager.m
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "ContactManager.h"
#import "Contact_CD.h"

@interface ContactManager()
- (Contact_CD*) getNewContact;
@end

@implementation ContactManager

- (id)initWithContext:(NSManagedObjectContext*)context{
  self = [super init];
  if (self) {
    context_ = [context retain];
  }
  return self;
}

- (void)dealloc {
  [context_ release];
  [super dealloc];
}

- (Contact_CD*) getNewContact{
  NSParameterAssert(context_);
  return [NSEntityDescription insertNewObjectForEntityForName:@"Contact_CD"
                                       inManagedObjectContext:context_]; 
}

@end
