//
//  MyInfoViewController.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserManager;

@interface MyInfoViewController : UIViewController {
  @private
  UserManager * userManager_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
          userManager:(UserManager*)userManager;

@end
