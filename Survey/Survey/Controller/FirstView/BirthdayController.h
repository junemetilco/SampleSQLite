//
//  BirthdayController.h
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstViewController;

@interface BirthdayController : UIViewController {
  
  FirstViewController *firstView;
  
  IBOutlet UILabel *bLabel;
//  IBOutlet UIPickerView *bdayPickerView;
  
  IBOutlet UIDatePicker *bdayPickerView;
  
}

@property (nonatomic, retain) UILabel *bLabel;

- (IBAction)getSelectedDate:(id)sender;


@end
