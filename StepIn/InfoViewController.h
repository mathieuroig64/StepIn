//
//  AccountViewController.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDef.h"
#import "MyInfoViewController.h"
#import "SwitchCell.h"

@class UserManager;

@interface InfoViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource,
MyInfoDelegate, SwitchDelegate>{
@public
  UITableView * tableView_;
@private
  NSArray * cells_;
  UserManager* userManager_;
  MyInfoViewControllerProvider myInfoProvider_;
}

@property (nonatomic, retain) IBOutlet UITableView * tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
          userManager:(UserManager*)userManager
       myInfoProvider:(MyInfoViewControllerProvider)myInfoProvider;

@end
