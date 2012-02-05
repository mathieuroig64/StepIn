//
//  SwitchCell.h
//  StepIn
//
//  Created by Mathieu ROIG on 2/5/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwitchDelegate;

@interface SwitchCell : UITableViewCell {
  UILabel * titleLabel_;
  UISwitch * toggleSwitch_;
  id<SwitchDelegate> delegate_;
}

@property (nonatomic, retain) IBOutlet UILabel * titleLabel;
@property (nonatomic, retain) IBOutlet UISwitch * toggleSwitch;
@property (nonatomic, assign) id<SwitchDelegate> delegate;

- (IBAction)didClickOnSwitch:(id)sender;

@end

@protocol SwitchDelegate <NSObject>
- (void)didSwitchFor:(SwitchCell*)switchCell
           withValue:(BOOL)value;
@end