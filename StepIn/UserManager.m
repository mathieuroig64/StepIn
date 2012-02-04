//
//  UserManager.m
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "UserManager.h"
#import "User_CD.h"
#import "ContactManager.h"

@interface UserManager()
- (User_CD*) getNewUser;
@end

@implementation UserManager

// Init with context
- (id)initWithContext:(NSManagedObjectContext *)context
       contactManager:(ContactManager*)contactManager{
	self = [super init];
	if (self) {
    context_ = [context retain];
    contactManager_ = [contactManager retain];
	}
	return self;
}

- (void)dealloc {
  [context_ release];
  [contactManager_ release];
  [super dealloc];
}

- (User_CD*) getNewUser{
  NSParameterAssert(context_);
  return [NSEntityDescription insertNewObjectForEntityForName:@"User_CD"
                                       inManagedObjectContext:context_]; 
}

//Insert a new member
- (User_CD*)insertNewUserWithFirstName:(NSString*)firstName
                              lastName:(NSString*)lastName
                                  info:(NSString*)info{
  User_CD * currentUser = [self getCurrentUser];
  if (currentUser) {
    [context_ deleteObject:currentUser];
    [context_ save:nil];
  }
  User_CD * newUser = [self getNewUser];
  
  [newUser setFirstName:firstName];
  [newUser setLastName:lastName];
  [newUser setInfo:info];
  
  NSError * error = nil;
  
  [context_ save:&error];
  if (error) {
    DLog(@"Error while saving member");
    return nil;
  }
  return newUser;
}




- (User_CD*)getCurrentUser{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"User_CD"
                                            inManagedObjectContext:context_];
  [fetchRequest setEntity:entity];
  
  NSError *error = nil;
  NSArray *fetchedObjects = [context_ executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects == nil) {
    //Error
    [fetchRequest release];
    return nil;
  }
  [fetchRequest release];
  if ([fetchedObjects count] > 0) {
    return [fetchedObjects objectAtIndex:0];    
  }else{
    return nil;
  }
}


@end
