//
//  UserManager.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User_CD;
@class ContactManager;

@interface UserManager : NSObject {
  NSManagedObjectContext * context_;
  ContactManager * contactManager_;
}

//Init method
- (id)initWithContext:(NSManagedObjectContext *)context
       contactManager:(ContactManager*)contactManager;

- (User_CD*)insertNewUserWithFirstName:(NSString*)firstName
                              lastName:(NSString*)lastName
                                  info:(NSString*)info;

- (User_CD*)getCurrentUser;

@end
