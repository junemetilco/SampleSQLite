//
//  Survey.h
//  Survey
//
//  Created by Chito Lucero on 10/16/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Survey : NSObject {
  
  NSInteger surveyID;
  NSString *name;
  NSString *birthday;
  NSInteger age;
  
  NSInteger *updateid;
  
  BOOL isDirty;
  BOOL isDetailViewHydrated;
}

@property (nonatomic, readonly) NSInteger surveyID;
@property (nonatomic) NSInteger *updateid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic) NSInteger age;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

+ (void)getInitialDataToDisplay:(NSString *)dbPath;
+ (void)finalizeStatements;

- (id) initWithPrimaryKey:(NSInteger)pk;
- (void) addSurvey;
- (void) deleteSurvey;
- (void) saveAllData;
- (void) hydrateDetailViewData;

@end
