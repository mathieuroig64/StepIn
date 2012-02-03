//
//  TextFieldCell.m
//  StepIn
//
//  Created by Mathieu ROIG on 30/01/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell
@synthesize titleLabel = titleLabel_;
@synthesize textField = textField_;

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
  [titleLabel_ release];
  [textField_ release];
  [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
