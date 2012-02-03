//
//  LoginViewController.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "AccountViewController.h"
#import "UIDevice+IdentifierAddition.h"
#import "TextFieldCell.h"
#import "UIView+XIBLoading.h"

@interface AccountViewController (PrivateMethods)
//UI
- (void)addCancelButtonToNavBar;
- (void)addSaveButtonToNavBar;

//Datas
- (void)configureCells;
- (UITableViewCell*) configureCellWithTitle:(NSString*)title
                                      value:(NSString*)value
                                 isSubtitle:(BOOL)isSubtitle;

- (TextFieldCell*)configureTextFieldCellWithTitle:(NSString*)title
                                            value:(NSString*)value;
//Database
- (void)saveProfile;
@end

@implementation AccountViewController
@synthesize tableView = tableView_;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)dealloc {
  [tableView_ release];
  [cells_ release];
  [firstName_ release];
  [lastName_ release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self configureCells];
  [self.navigationItem setTitle:@"Account"];
  [self addCancelButtonToNavBar];
  [self addSaveButtonToNavBar];
}

#pragma mark UI
- (void)addCancelButtonToNavBar{
  UIBarButtonItem * cancelButton = [[[UIBarButtonItem alloc] 
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                     target:self
                                     action:@selector(dismissModalViewControllerAnimated:)] autorelease];
  [self.navigationItem setLeftBarButtonItem:cancelButton];
}
- (void)addSaveButtonToNavBar{
  UIBarButtonItem * saveButton = [[[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self
                                   action:@selector(saveProfile)] autorelease];
  [self.navigationItem setRightBarButtonItem:saveButton];
}

#pragma mark Datas
- (void)configureCells{
  cells_ = [[NSArray arrayWithObjects:
             [self configureTextFieldCellWithTitle:@"First Name" 
                                             value:@""],
             [self configureTextFieldCellWithTitle:@"Last Name" 
                                             value:@""],
             [self configureCellWithTitle:@"Identifier" 
                                    value:[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]
                               isSubtitle:YES], nil] retain];
}

- (TextFieldCell*)configureTextFieldCellWithTitle:(NSString*)title
                                            value:(NSString*)value{
  TextFieldCell * cell = [TextFieldCell loadXIB:@"TextFieldCell"
                                       forClass:[TextFieldCell class]];
  [cell.titleLabel setText:title];
  [cell.textField setText:value];
  [cell.textField setDelegate:self];
  return cell;
}

- (UITableViewCell*) configureCellWithTitle:(NSString*)title
                                      value:(NSString*)value
                                 isSubtitle:(BOOL)isSubtitle{
  UITableViewCell * cell = nil;
  
  if (!isSubtitle) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:nil] autorelease];
    
  }else{
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                   reuseIdentifier:nil] autorelease];
    
  }
  
  [cell.textLabel setText:title];
  [cell.detailTextLabel setText:value];
  return cell;
}

#pragma mark Database
- (void)saveProfile{
  
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  [textField resignFirstResponder];
  return YES;
}


- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [cells_ count];;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return @"My Info";
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
  if (section == 0) {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(10, 10, 200, 40)];
    [button setTitle:@"Send my info" 
            forState:UIControlStateNormal];
   return button;    
  }else{
    return nil;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  return 50.0;
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [cells_ objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView_ deselectRowAtIndexPath:indexPath
                            animated:YES];
}
@end
