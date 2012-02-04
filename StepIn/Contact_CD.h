//
//  Contact_CD.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User_CD;

@interface Contact_CD : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * isMailEnabled;
@property (nonatomic, retain) NSNumber * isSMSEnabled;
@property (nonatomic, retain) NSNumber * isEmergencyContact;
@property (nonatomic, retain) User_CD *forUser;

@end
