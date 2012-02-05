//
//  MyInfoViewController.m
//  StepIn
//
//  Created by Mathieu ROIG on 2/4/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "MyInfoViewController.h"
#import "User_CD.h"
#import "UserManager.h"
#import "UIView+XIBLoading.h"
#import "TextViewCell.h"
#import "TextFieldCell.h"

@interface MyInfoViewController (PrivateMethods)
//UI
- (void)addSaveButtonToNavBar;

//Datas
- (void)configureCells;
- (void)getCurrentUser;
- (TextFieldCell*)configureTextFieldWithPlaceholder:(NSString*)placeholder
                                        isFirstName:(BOOL)isFirstName;
- (TextViewCell*)configureTextViewWithPlaceholder:(NSString*)placeholder;

//Action
- (void)saveInfo;
@end

@implementation MyInfoViewController
@synthesize tableView = tableView_;
@synthesize delegate = delegate_;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
          userManager:(UserManager*)userManager
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    userManager_ = [userManager retain];
  }
  return self;
}

- (void)dealloc {
  [userManager_ release];
  [tableView_ release];
  [cells_ release];
  [currentUser_ release];
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
  [self.navigationItem setTitle:@"My Infos"];
  [self getCurrentUser];
  [self configureCells];
  [self addSaveButtonToNavBar];
}

#pragma mark UI
- (void)addSaveButtonToNavBar{
  UIBarButtonItem * saveButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                               target:self
                                                                                action:@selector(saveInfo)] autorelease];
  [self.navigationItem setRightBarButtonItem:saveButton];
}


#pragma mark Datas
- (void)getCurrentUser{
  currentUser_ = [[userManager_ getCurrentUser] retain];
}

- (void)configureCells{
 NSArray * nameCells = [NSArray arrayWithObjects:
                        [self configureTextFieldWithPlaceholder:@"First Name"
                                                    isFirstName:YES],
                        [self configureTextFieldWithPlaceholder:@"Last Name"
                                                    isFirstName:NO], 
                        nil];
  
  NSArray * infoCell = [NSArray arrayWithObject:[self configureTextViewWithPlaceholder:@"My infos"]];
  
  cells_ = [[NSArray alloc] initWithObjects:nameCells, infoCell, nil];
}

- (TextFieldCell*)configureTextFieldWithPlaceholder:(NSString*)placeholder
                                        isFirstName:(BOOL)isFirstName{
  TextFieldCell * cell = [TextFieldCell loadXIB:@"TextFieldCell"
                                       forClass:[TextFieldCell class]];
  [cell.textField setPlaceholder:placeholder];
  [cell.textField setDelegate:self];
  [cell.textField setReturnKeyType:UIReturnKeyNext];
  if (isFirstName) {
    if ([currentUser_.firstName length] > 0) {
      [cell.textField setText:currentUser_.firstName];
    }    
  }else{
    if ([currentUser_.lastName length] > 0) {
      [cell.textField setText:currentUser_.lastName];
    } 
  }
  return cell;
}

- (TextViewCell*)configureTextViewWithPlaceholder:(NSString*)placeholder{
  TextViewCell * cell = [TextViewCell loadXIB:@"TextViewCell"
                                     forClass:[TextViewCell class]];
  [cell.textView setDelegate:self];
  if ([currentUser_.info length] > 0) {
    [cell.textView setText:currentUser_.info];    
  }
  return cell;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return [cells_ count];;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  if (section == 0) {
    return @"Personnal Info";
  }else{
    return @"Additional info";
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if (indexPath.section == 0) {
    return 44.0;
  }else{
    return 150.0;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSArray * sectionCells = [cells_ objectAtIndex:section];
  return [sectionCells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray * sectionCells = [cells_ objectAtIndex:indexPath.section];
  return [sectionCells objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
  NSArray * sectionCells = [cells_ objectAtIndex:0];
  
  TextFieldCell * firstNameCell = [sectionCells objectAtIndex:0];
  TextFieldCell * lastNameCell = [sectionCells objectAtIndex:1];
  if (firstNameCell.textField == textField) {
    [tableView_ setContentOffset:CGPointMake(0, 10)
                        animated:YES];
  }else if(lastNameCell.textField == textField){
    [tableView_ setContentOffset:CGPointMake(0, 30)
                        animated:YES];    
  }
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  NSArray * sectionCells = [cells_ objectAtIndex:0];
  NSArray * sectionCells2 = [cells_ objectAtIndex:1];
  TextFieldCell * firstNameCell = [sectionCells objectAtIndex:0];
  TextFieldCell * lastNameCell = [sectionCells objectAtIndex:1];
  
  TextViewCell * infoCell = [sectionCells2 objectAtIndex:0];
  if (firstNameCell.textField == textField) {
    [firstNameCell.textField resignFirstResponder];
    [lastNameCell.textField becomeFirstResponder];
  }else if(lastNameCell.textField == textField){
    [lastNameCell.textField resignFirstResponder];
    [infoCell.textView becomeFirstResponder];
  }
  return YES;
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
  NSArray * sectionCells2 = [cells_ objectAtIndex:1];
  
  TextViewCell * infoCell = [sectionCells2 objectAtIndex:0];
  
  if (infoCell.textView == textView) {
    [tableView_ setContentOffset:CGPointMake(0, 130)
                        animated:YES];
  }
  return YES;
}

#pragma mark Action
- (void)saveInfo{
  NSArray * sectionCells = [cells_ objectAtIndex:0];
  NSArray * sectionCells2 = [cells_ objectAtIndex:1];
  TextFieldCell * firstNameCell = [sectionCells objectAtIndex:0];
  TextFieldCell * lastNameCell = [sectionCells objectAtIndex:1];
  
  TextViewCell * infoCell = [sectionCells2 objectAtIndex:0];
  [userManager_ insertNewUserWithFirstName:firstNameCell.textField.text
                                  lastName:lastNameCell.textField.text
                                      info:infoCell.textView.text];
  if ([(id)delegate_ respondsToSelector:@selector(didSaveUserFor:)]) {
    [delegate_ didSaveUserFor:self];
  }
  [self.navigationController popViewControllerAnimated:YES];
}

@end
