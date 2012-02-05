//
//  ContactManager.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Contact_CD;

@interface ContactManager : NSObject {
  NSManagedObjectContext * context_;
}

- (id)initWithContext:(NSManagedObjectContext*)context;

- (Contact_CD*)insertContactWithFirstName:(NSString*)firstName
                                 lastName:(NSString*)lastName
                                    phone:(NSString*)phone
                                    email:(NSString*)email
                           isEmailEnabled:(BOOL)isEmailEnabled
                             isSMSEnabled:(BOOL)isSMSEnabled
                       isEmergencyContact:(BOOL)isEmergencyContact;

- (Contact_CD*)updateContactWithFirstName:(NSString*)firstName
                                 lastName:(NSString*)lastName
                                    phone:(NSString*)phone
                                    email:(NSString*)email
                           isEmailEnabled:(BOOL)isEmailEnabled
                             isSMSEnabled:(BOOL)isSMSEnabled
                       isEmergencyContact:(BOOL)isEmergencyContact
                               forContact:(Contact_CD*)contact;

- (Contact_CD*)getContactWithFirstName:(NSString*)firstName
                              lastName:(NSString*)lastName;

@end
