//
//  TextViewCell.m
//  StepIn
//
//  Created by Mathieu ROIG on 2/5/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell
@synthesize textView = textView_;

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)dealloc {
  [textView_ release];
  [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
