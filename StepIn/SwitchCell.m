//
//  SwitchCell.m
//  StepIn
//
//  Created by Mathieu ROIG on 2/5/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell
@synthesize titleLabel = titleLabel_;
@synthesize toggleSwitch = toggleSwitch_;
@synthesize delegate = delegate_;

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
  [toggleSwitch_ release];
  [super dealloc];
}

- (IBAction)didClickOnSwitch:(id)sender{
  UISwitch * theSwitch = [sender object];
  if ([(id)delegate_ respondsToSelector:@selector(didSwitchFor:withValue:)]) {
    [delegate_ didSwitchFor:self
                  withValue:[theSwitch isOn]];
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
