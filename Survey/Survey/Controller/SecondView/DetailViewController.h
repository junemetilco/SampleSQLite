//
//  DetailViewController.h
//  Survey
//
//  Created by Chito Lucero on 10/18/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Survey, EditViewController;

@interface DetailViewController : UIViewController {
  
  IBOutlet UITableView *detailTableView;
  Survey *surveyObj;
  NSIndexPath *selectedIndexPath;
  
  EditViewController *editViewController;
}

@property (nonatomic, retain) Survey *surveyObj;

//- (IBAction) backToSecondView:(id)sender;

@end
