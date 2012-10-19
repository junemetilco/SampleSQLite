//
//  AppDelegate.m
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "Survey.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

@synthesize surveyArray;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
  UIViewController *viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
  UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
  
  self.tabBarController = [[[UITabBarController alloc] init] autorelease];
  self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
  
  self.window.rootViewController = self.tabBarController;
  
  // DATABASE
  [self copyDatabaseIfNeeded];
  
  NSMutableArray *tempArray = [[NSMutableArray alloc] init];
  self.surveyArray = tempArray;
  [tempArray release];
  
  [Survey getInitialDataToDisplay:[self getDBPath]];
  
  [self.window makeKeyAndVisible];
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. 
     This can occur for certain types of temporary interruptions 
     (such as an incoming phone call or SMS message) or when the user quits the application and 
     it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. 
     Games should use this method to pause the game.
     */
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, 
     and store enough application state information to restore your application to its 
     current state in case it is terminated later. 
     If your application supports background execution, 
     this method is called instead of applicationWillTerminate: when the user quits.
     */
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; 
     here you can undo many of the changes made on entering the background.
     */
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. 
     If the application was previously in the background, optionally refresh the user interface.
     */
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationWillTerminate:(UIApplication *)application
{
  [self.surveyArray makeObjectsPerformSelector:@selector(saveAllData)];
  [Survey finalizeStatements];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
  [self.surveyArray makeObjectsPerformSelector:@selector(saveAllData)];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) copyDatabaseIfNeeded
{
  NSLog(@"Creating editable copy of database");
  
	//Using NSFileManager we can perform many file system operations.
	BOOL success;
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSError *error;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"survey.sqlite"];
  success = [fileManager fileExistsAtPath:writableDBPath];
  
  if (success) return;
  // The writable database does not exist, so copy the default to the appropriate location.
  NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"survey.sqlite"];
  success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
  if (!success) {
    NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) getDBPath 
{
	sqlite3 *newDBconnection;
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *path = [documentsDirectory stringByAppendingPathComponent:@"survey.sqlite"];
  
  // Open the database. The database was prepared outside the application.
  if (sqlite3_open([path UTF8String], &newDBconnection) == SQLITE_OK) {
    NSLog(@"Database Successfully Opened :)");
  }
  else {
    NSLog(@"Error in opening database :(");
  }
  return [documentsDirectory stringByAppendingPathComponent:@"survey.sqlite"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addSurvey:(Survey *)surveyObj
{
	//Add it to the database.
	[surveyObj addSurvey];
	
	//Add it to the coffee array.
	[surveyArray addObject:surveyObj];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)removeSurvey:(Survey *)surveyObj
{
	//Delete it from the database.
	[surveyObj deleteSurvey];
	
	//Remove it from the array.
	[surveyArray removeObject:surveyObj];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)updateSurvey:(Survey *)surveyObj
{
	//Update it from the database.
	[surveyObj saveAllData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc
{
  [surveyArray release];
  [_window release];
  [_tabBarController release];
  [super dealloc];
}

@end
