//
//  AgeViewController.h
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
  
  IBOutlet UILabel *pLabel;
  NSArray *arrayNo;
  IBOutlet UIPickerView *agePickerView;
}

@property (nonatomic, retain) UILabel *pLabel;

@end
