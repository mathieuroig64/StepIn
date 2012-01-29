//
//  AccountViewController.h
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeDef.h"

@interface MyAgentsViewController : UIViewController{
  @private
  LoginViewControllerProvider loginProvider_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
        loginProvider:(LoginViewControllerProvider)loginProvider;

@end
