//
//  AccountViewController.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "InfoViewController.h"
#import "UserManager.h"
#import "User_CD.h"
#import "MyInfoViewController.h"
#import "UIView+XIBLoading.h"

@interface InfoViewController (PrivateMethods)
//UI
- (void)addEditButton;

//Datas
- (void)configureCells;
- (UITableViewCell*)configureMyInfoCell;
- (SwitchCell*)configureSwitchCellWithTitle:(NSString*)title
                                       isOn:(BOOL)isOn;
@end

@implementation InfoViewController
@synthesize tableView = tableView_;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
          userManager:(UserManager*)userManager
       myInfoProvider:(MyInfoViewControllerProvider)myInfoProvider{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    userManager_ = [userManager retain];
    myInfoProvider_ = Block_copy(myInfoProvider);
  }
  return self;
}

- (void)dealloc {
  [tableView_ release];
  [cells_ release];
  [userManager_ release];
  Block_release(myInfoProvider_);
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
  [self.navigationItem setTitle:@"Info"];
  [self configureCells];
  [self addEditButton];
}

#pragma mark UI
- (void)addEditButton{
  [self.navigationItem setRightBarButtonItem:self.editButtonItem];
}

#pragma mark Datas
- (void)configureCells{
  [cells_ release];
  //Get the user
  User_CD * currentUser = [userManager_ getCurrentUser];
  
  //My info cell
  NSMutableArray * infosCell = [NSMutableArray array];
  [infosCell addObject:[self configureMyInfoCell]];
  [infosCell addObject:[self configureSwitchCellWithTitle:@"Enable location"
                                                     isOn:[currentUser.enableLocation boolValue]]];
   
  cells_ = [[NSArray alloc] initWithObjects:infosCell, 
            nil];
}

- (UITableViewCell*)configureMyInfoCell{
  UITableViewCell * cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:nil] autorelease];
  [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  [cell.textLabel setText:@"My Info"];
  User_CD * currentUser = [userManager_ getCurrentUser];
  if ([currentUser.firstName length] > 0
      && 
      [currentUser.lastName length] > 0) {
    NSString * fullName = [NSString stringWithFormat:@"%@ %@", currentUser.firstName, currentUser.lastName];
    [cell.detailTextLabel setText:fullName];
  }
  return cell;
}

- (SwitchCell*)configureSwitchCellWithTitle:(NSString*)title
                                       isOn:(BOOL)isOn{
  SwitchCell * cell = [SwitchCell loadXIB:@"SwitchCell"
                                 forClass:[SwitchCell class]];
  [cell setDelegate:self];
  [cell.titleLabel setText:title];
  [cell.toggleSwitch setOn:isOn];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  if (section == 0) {
    return @"Personnal Info";
  }else{
    return nil;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return [cells_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSArray * sectionsCell = [cells_ objectAtIndex:section];
  return [sectionsCell count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray * sectionsCell = [cells_ objectAtIndex:indexPath.section];
  return [sectionsCell objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    //My info
    MyInfoViewController * myInfoController = myInfoProvider_();
    [myInfoController setDelegate:self];
    [self.navigationController pushViewController:myInfoController
                                         animated:YES];
  }
  [tableView_ deselectRowAtIndexPath:indexPath
                            animated:YES];
}

#pragma mark MyInfoDelegate
- (void)didSaveUserFor:(MyInfoViewController*)myInfoController{
  [self configureCells];
  [tableView_ reloadData];
}

#pragma mark SwitchDelegate
- (void)didSwitchFor:(SwitchCell*)switchCell
           withValue:(BOOL)value{
  
}
@end
