//
//  SIInjector.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

//Main
#import "SIInjector.h"
#import "SIDelegate.h"
#import "AppScope.h"

//Classes
#import "AlertViewController.h"
#import "MyAgentsViewController.h"
#import "AccountViewController.h"

@implementation SIInjector

#pragma mark AppDelegate
+(SIDelegate*)injectDelegate{	
  
  UIWindow* window = 
  [[[UIWindow alloc] initWithFrame:CGRectMake(0, 
                                              0, 
                                              [UIScreen mainScreen].bounds.size.width, 
                                              [UIScreen mainScreen].bounds.size.height)] 
   autorelease];
  
	AppScope* appScope = [self injectAppScope];
  TabBarProvider tabBarProvider = [self injectTabBarProvider:appScope];	
  
  SIDelegate* appDelegate =  [[SIDelegate alloc] initWithWindow:window 
                                                 tabBarProvider:tabBarProvider];
  [appScope setAppDelegate:appDelegate];
  return [appDelegate autorelease];
}

#pragma mark Appscope
+(AppScope*)injectAppScope{
  
  NSManagedObjectContext * context = [self injectContext];
  
  AppScope* appScope = [[[AppScope alloc] initWithContext:context] autorelease];
	return appScope;
}

#pragma mark TabBar
+(TabBarProvider)injectTabBarProvider:(AppScope*)appScope{
	TabBarProvider provider = ^(){
		UITabBarController *tab = [self tabBarController:appScope];
		[appScope setTabController:tab];
		return tab;
	};
	return [[provider copy] autorelease];	
}


+(UITabBarController *)tabBarController:(AppScope*)appScope{
  
	UITabBarController* tabBarController =
	[[[UITabBarController alloc] init] autorelease];
	
	NSMutableArray *tabControllers = [NSMutableArray array];
	
  UIImage *imgAlert = [UIImage imageNamed:@"alert.png"];
  UIImage * imgAgents = [UIImage imageNamed:@"agents.png"];
	
	
	NSArray *images = [NSArray arrayWithObjects:
                     imgAlert, 
                     imgAgents,
                     nil];
	
	NSArray *titles = [NSArray arrayWithObjects:
                     @"Alert",
                     @"My Agents",
                     nil];
	
	NSArray *controllers = 
	[self injectTabBarControllers:appScope];
	
	for (int i =0; i < [controllers count]; i++) {
		UIViewController *viewcontroller = [controllers objectAtIndex:i];
		UITabBarItem* theItem = 
		[[[UITabBarItem alloc] initWithTitle:[titles objectAtIndex:i]
                                   image:[images objectAtIndex:i]
                                     tag:i] autorelease];
		UINavigationController *navcontroller = 
		[[[UINavigationController alloc] initWithRootViewController:viewcontroller] 
		 autorelease];
   	viewcontroller.tabBarItem = theItem;
		navcontroller.tabBarItem = theItem;
		[tabControllers addObject:navcontroller];
	}
	tabBarController.viewControllers = tabControllers;
	[tabBarController setDelegate:appScope.appDelegate];	
	return tabBarController;
}

+(NSArray*)injectTabBarControllers:(AppScope*)appScope{
	
  AlertViewControllerProvider alertProvider = 
  [self injectAlertViewControllerProvider:appScope];
  
  AlertViewController * alertController = alertProvider(); 
  
  MyAgentsViewControllerProvider myAgentsProvider = 
  [self injectMyAgentsViewControllerProvider:appScope];
  
  MyAgentsViewController * agentsController = myAgentsProvider();
  
  NSArray *viewControllers = [NSArray arrayWithObjects:
                              alertController,
                              agentsController,
                              nil];
  
  return viewControllers;
}

#pragma mark AlertViewControllerProvider
+(AlertViewControllerProvider)injectAlertViewControllerProvider:(AppScope*)appScope{
 	AlertViewControllerProvider provider = ^(){
    
		AlertViewController * controller = 
    [[[AlertViewController alloc] initWithNibName:@"AlertViewController" 
                                           bundle:nil] autorelease];
		return controller;
	};
	return [[provider copy] autorelease]; 
}

#pragma mark MyAgentsViewControllerProvider
+(MyAgentsViewControllerProvider)injectMyAgentsViewControllerProvider:(AppScope*)appScope{
 	MyAgentsViewControllerProvider provider = ^(){
    
    AccountViewControllerProvider accountProvider = [self injectAccountViewControllerProvider:appScope];
    
		MyAgentsViewController * controller = 
    [[[MyAgentsViewController alloc] initWithNibName:@"MyAgentsViewController" 
                                              bundle:nil
                                     accountProvider:accountProvider] autorelease];
		return controller;
	};
	return [[provider copy] autorelease];  
}

#pragma mark AccountViewControllerProvider
+(AccountViewControllerProvider)injectAccountViewControllerProvider:(AppScope*)appScope{
  AccountViewControllerProvider provider = ^(){
    
		AccountViewController * controller = 
    [[[AccountViewController alloc] initWithNibName:@"AccountViewController" 
                                             bundle:nil] autorelease];
		return controller;
	};
	return [[provider copy] autorelease];  
}

#pragma mark -
#pragma mark CoreData
+ (NSManagedObjectContext*)injectContext{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  NSString *strFilePath = 
  [basePath stringByAppendingPathComponent:@"/StepIn.sqlite"];
  DLog(@"%@",strFilePath);
  NSManagedObjectModel * managedObjectModel = 
  [NSManagedObjectModel mergedModelFromBundles:nil] ; 
  NSError *error;
  NSPersistentStoreCoordinator * persistentStoreCoordinator = 
  [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel] 
   autorelease];
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                configuration:nil 
                                                          URL:[NSURL fileURLWithPath:strFilePath]
                                                      options:nil 
                                                        error:&error]) {
    NSLog(@"Unable to addPersistentStoreWithType");
    exit(-1);
  } 
  NSManagedObjectContext *managedObjectContext = 
  [[[NSManagedObjectContext alloc] init] autorelease];
  [managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
  return managedObjectContext;
}


@end
