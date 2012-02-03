//
//  LoginViewController.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController
<UITabBarDelegate, UITableViewDataSource,
UITextFieldDelegate>{
  @public
  UITableView * tableView_;
  
  @private
  NSArray * cells_;
  NSString * firstName_;
  NSString * lastName_;
}

@property (nonatomic, retain) IBOutlet UITableView * tableView;

@end
