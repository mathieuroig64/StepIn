//
//  User_CD.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact_CD;

@interface User_CD : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *contacts;
@end

@interface User_CD (CoreDataGeneratedAccessors)

- (void)addContactsObject:(Contact_CD *)value;
- (void)removeContactsObject:(Contact_CD *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

@end
