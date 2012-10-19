//
//  SecondViewController.h
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@class Survey, DetailViewController;

@interface SecondViewController : UIViewController {
  
  AppDelegate *appDelegate;
  
  NSIndexPath *selectedIndexPath;
  
  NSMutableArray *surveyResult;
  IBOutlet UITableView *surveyResultTable;
  
  DetailViewController *detailController;
  UINavigationController *detailNavController;
}

@property (nonatomic, retain) NSMutableArray *surveyResult;
@property (nonatomic, retain) IBOutlet UITableView *surveyResultTable;


@end
