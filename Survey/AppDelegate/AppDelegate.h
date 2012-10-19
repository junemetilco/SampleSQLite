//
//  AppDelegate.h
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
  
  NSMutableArray *surveyArray;
  NSInteger surveyID;
  NSString *name;
  NSString *birthday;
  NSInteger age;
  
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) NSMutableArray *surveyArray;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;

-(void)addSurvey:(Survey *)surveyObj;
-(void)removeSurvey:(Survey *)surveyObj;
-(void)updateSurvey:(Survey *)surveyObj;

@end
