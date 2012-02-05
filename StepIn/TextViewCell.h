//
//  TextViewCell.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/5/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewCell : UITableViewCell {
  UITextView * textView_;
}

@property (nonatomic, retain) IBOutlet UITextView * textView;

@end
