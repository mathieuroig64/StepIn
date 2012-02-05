//
//  MyInfoViewController.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserManager;
@class User_CD;

@protocol MyInfoDelegate;

@interface MyInfoViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource,
UITextFieldDelegate, UITextViewDelegate>{
  @private
  UserManager * userManager_;
  NSArray * cells_;
  User_CD * currentUser_;
  
  @public
  UITableView * tableView_;
  id<MyInfoDelegate> delegate_;
}

@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, assign) id<MyInfoDelegate> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
          userManager:(UserManager*)userManager;

@end

@protocol MyInfoDelegate <NSObject>
- (void)didSaveUserFor:(MyInfoViewController*)myInfoController;
@end