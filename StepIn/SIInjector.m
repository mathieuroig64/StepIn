//
//  SIInjector.m
//  StepIn
//
//  Created by Mathieu ROIG on 1/29/12.
//  Copyright (c) 2012 Kadrige. All rights reserved.
//

#import "SIInjector.h"
#import "SIDelegate.h"
#import "AppScope.h"

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
  
  AppScope* appScope = [[[AppScope alloc] init] autorelease];
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
	
  UIImage *imgPlanning = [UIImage imageNamed:@"icon_tabBar_planning.png"];
	UIImage *imgEpisodes = [UIImage imageNamed:@"icon_tabBar_episodes.png"];
	UIImage *imgSeries = [UIImage imageNamed:@"icon_tabBar_series.png"];
	UIImage *imgAccount = [UIImage imageNamed:@"icon_tabBar_compte.png"];
	
	
	NSArray *images = [NSArray arrayWithObjects:
                     imgPlanning, 
                     imgEpisodes, 
                     imgSeries,
                     imgAccount,
                     nil];
	
	NSArray *titles = [NSArray arrayWithObjects:
                     NSLocalizedString(@"TAB_MY_PLANNING", nil),
                     NSLocalizedString(@"TAB_MY_EPISODES", nil),
                     NSLocalizedString(@"TAB_MY_SERIES", nil),
                     NSLocalizedString(@"TAB_MY_ACCOUNT", nil),
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
	/*
   MyPlanningController * planningController = 
   [STInjector injectMyPlanningController:appScope];
   
   MyEpisodesController * episodesController =
   [STInjector injectMyEpisodesController:appScope];
   
   MySeriesController * seriesController =
   [STInjector injectMySeriesController:appScope];
   
   MyAccountController * accountController =
   [STInjector injectMyAccountController:appScope];
   
   NSArray *viewControllers = [NSArray arrayWithObjects:
   planningController,
   episodesController,
   seriesController, 
   accountController,
   nil];
   
   return viewControllers;
   */
  return nil;
}

@end
