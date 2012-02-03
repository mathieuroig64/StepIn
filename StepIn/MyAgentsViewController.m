//
//  AccountViewController.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "MyAgentsViewController.h"
#import "AccountViewController.h"

@interface MyAgentsViewController (PrivateMethods)
- (void)showAccountController;
- (void)addAccountButtonToNavigationBar;
@end

@implementation MyAgentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
      accountProvider:(AccountViewControllerProvider)accountProvider
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    accountProvider_ = Block_copy(accountProvider);
  }
  return self;
}

- (void)dealloc {
  Block_release(accountProvider_);
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
  [self.navigationItem setTitle:@"My Agents"];
  [self addAccountButtonToNavigationBar];
}

#pragma mark UI
- (void)addAccountButtonToNavigationBar{
  UIBarButtonItem * accountButton = [[[UIBarButtonItem alloc] initWithTitle:@"Account"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(showAccountController)] autorelease];
  [self.navigationItem setRightBarButtonItem:accountButton];
}

- (void)showAccountController{
  AccountViewController * accountController = accountProvider_();
  UINavigationController * navigationController = [[[UINavigationController alloc] 
                                                    initWithRootViewController:accountController] autorelease];
  [self presentModalViewController:navigationController
                          animated:YES];
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

@end
