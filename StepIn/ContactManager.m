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

- (Contact_CD*)insertContactWithFirstName:(NSString*)firstName
                                 lastName:(NSString*)lastName
                                    phone:(NSString*)phone
                                    email:(NSString*)email
                           isEmailEnabled:(BOOL)isEmailEnabled
                             isSMSEnabled:(BOOL)isSMSEnabled
                       isEmergencyContact:(BOOL)isEmergencyContact{
  Contact_CD * contact = [self getContactWithFirstName:firstName
                                              lastName:lastName];
  if (contact == nil) {
    //Insert the contact
    [contact setFirstName:firstName];
    [contact setLastName:lastName];
    [contact setPhone:phone];
    [contact setEmail:email];
    [contact setIsMailEnabled:[NSNumber numberWithBool:isEmailEnabled]];
    [contact setIsSMSEnabled:[NSNumber numberWithBool:isSMSEnabled]];
    [contact setIsEmergencyContact:[NSNumber numberWithBool:isEmergencyContact]];
    
  }else{
    //Update the contact
    contact = [self updateContactWithFirstName:firstName
                                      lastName:lastName
                                         phone:phone
                                         email:email
                                isEmailEnabled:isEmailEnabled
                                  isSMSEnabled:isSMSEnabled
                            isEmergencyContact:isEmergencyContact
                                    forContact:contact];
  }
  
  NSError ** error = nil;
  
  [context_ save:error];
  if (error) {
    DLog(@"Error while saving contact");
    return nil;
  }else{
    return contact;
  }
}

- (Contact_CD*)updateContactWithFirstName:(NSString*)firstName
                                 lastName:(NSString*)lastName
                                    phone:(NSString*)phone
                                    email:(NSString*)email
                           isEmailEnabled:(BOOL)isEmailEnabled
                             isSMSEnabled:(BOOL)isSMSEnabled
                       isEmergencyContact:(BOOL)isEmergencyContact
                               forContact:(Contact_CD*)contact{
  [contact setFirstName:firstName];
  [contact setLastName:lastName];
  [contact setPhone:phone];
  [contact setEmail:email];
  [contact setIsMailEnabled:[NSNumber numberWithBool:isEmailEnabled]];
  [contact setIsSMSEnabled:[NSNumber numberWithBool:isSMSEnabled]];
  [contact setIsEmergencyContact:[NSNumber numberWithBool:isEmergencyContact]];
  return contact;
}

- (Contact_CD*)getContactWithFirstName:(NSString*)firstName
                              lastName:(NSString*)lastName{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact_CD"
                                            inManagedObjectContext:context_];
  [fetchRequest setEntity:entity];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName == %@ AND lastName == %@",
                            firstName, lastName];
  [fetchRequest setPredicate:predicate];
  
  NSError *error = nil;
  NSArray *fetchedObjects = [context_ executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects == nil) {
    //Error
  }
  [fetchRequest release];
  if ([fetchedObjects count] > 0) {
    return [fetchedObjects objectAtIndex:0];
  }else{
    return nil;
  }
}

@end
