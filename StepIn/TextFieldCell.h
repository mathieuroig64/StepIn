//
//  TextFieldCell.h
//  StepIn
//
//  Created by Mathieu ROIG on 30/01/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell {
  UITextField * textField_;
}

@property (nonatomic, retain) IBOutlet UITextField * textField;

@end
