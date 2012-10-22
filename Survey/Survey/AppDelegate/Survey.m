//
//  Survey.m
//  Survey
//
//  Created by Chito Lucero on 10/16/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "Survey.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *updateStmt = nil;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation Survey

@synthesize surveyID;
@synthesize name;
@synthesize birthday;
@synthesize age;
@synthesize gender;
@synthesize civilStatus;

@synthesize updateid;

@synthesize isDirty;
@synthesize isDetailViewHydrated;

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void) getInitialDataToDisplay:(NSString *)dbPath
{
  AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
  
  if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select * from survey";
		sqlite3_stmt *selectstmt;
    
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
        
				Survey *surveyObj = [[Survey alloc]initWithPrimaryKey:primaryKey];
        
				surveyObj.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
        
        surveyObj.isDirty = NO;
        
				[appDelegate.surveyArray addObject:surveyObj];
        
				[surveyObj release];
			}
		}
	} else
    sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (void) finalizeStatements
{
  if (database) sqlite3_close(database);
	if (deleteStmt) sqlite3_finalize(deleteStmt);
	if (addStmt) sqlite3_finalize(addStmt);
  if (detailStmt) sqlite3_finalize(detailStmt);
  if (updateStmt) sqlite3_finalize(updateStmt);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithPrimaryKey:(NSInteger)pk
{
  [super init];
	surveyID = pk;
	
	isDetailViewHydrated = NO;
	return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addSurvey
{
  if(addStmt == nil) {
		const char *sql_query = "insert into survey (name, birthday, age, gender, civilStatus) Values (?, ?, ?, ?, ?)";
    
		if(sqlite3_prepare_v2(database, sql_query, -1, &addStmt, nil) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_text(addStmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [birthday UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_int(addStmt, 3, age);
  sqlite3_bind_text(addStmt, 4, [gender UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_text(addStmt, 5, [civilStatus UTF8String], -1, SQLITE_TRANSIENT);
  
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else {
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		surveyID = sqlite3_last_insert_rowid(database);
    NSLog(@"Inserted!");
	}
  
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) deleteSurvey
{
  if(deleteStmt == nil) {
		const char *sql = "delete from survey where surveyID = ?";
    
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, surveyID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt))
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);

}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) hydrateDetailViewData
{
  //If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select * from survey Where surveyID = ?";
    
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    NSLog(@"%s", sql);
	}
	
	sqlite3_bind_int(detailStmt, 1, surveyID);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		//NSInteger primaryKey = sqlite3_column_int(detailStmt, 0);
    
    NSString *nameS = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 1)];
    NSString *birthdayS = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 2)];
    NSInteger ageS = sqlite3_column_int(detailStmt, 3);
    NSString *genderS = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 4)];
    NSString *civilStatusS = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 5)];
    
		//Assign the name. The name value will be copied, since the property is declared with "copy" attribute.
    self.name = nameS;
    self.birthday = birthdayS;
    self.age = ageS;
    self.gender = genderS;
    self.civilStatus = civilStatusS;
    
	} else
    NSAssert1(0, @"Error while getting the name of person. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) saveAllData
{
  NSLog(@"%@\n%@\n%d", name, birthday, age);
  
  if(updateStmt == nil) {
    const char *sql = "update survey Set name = ?, birthday = ?, age = ?";
    
    if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
      NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
  }
  
  sqlite3_bind_text(updateStmt, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_text(updateStmt, 2, [birthday UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_int(updateStmt, 3, age);
  sqlite3_bind_text(updateStmt, 4, [gender UTF8String], -1, SQLITE_TRANSIENT);
  sqlite3_bind_text(updateStmt, 5, [civilStatus UTF8String], -1, SQLITE_TRANSIENT);
  
  if(SQLITE_DONE != sqlite3_step(updateStmt))
    NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
  
  sqlite3_reset(updateStmt);
  
  isDirty = NO;
	
  //Reclaim all memory here.
  [name release];
  name = nil;
  [birthday release];
  birthday = nil;
  
  isDetailViewHydrated = NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [name release];
  [birthday release];
  
  [gender release];
  [civilStatus release];
  
  [super dealloc];
}

@end
