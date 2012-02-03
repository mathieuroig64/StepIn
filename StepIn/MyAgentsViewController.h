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
  AccountViewControllerProvider accountProvider_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
      accountProvider:(AccountViewControllerProvider)accountProvider;

@end
