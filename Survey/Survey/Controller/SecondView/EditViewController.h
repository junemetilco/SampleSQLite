//
//  EditViewController.h
//  Survey
//
//  Created by Chito Lucero on 10/19/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController {
  
  IBOutlet UITextField *editTextField;
  NSString *keyOfTheFieldToEdit;
  NSString *editValue;
  id objectToEdit;
}

@property (nonatomic, retain) NSString *keyOfTheFieldToEdit;
@property (nonatomic, retain) NSString *editValue;
@property (nonatomic, retain) id objectToEdit;

- (IBAction) save_tapped:(id)sender;
- (IBAction) cancel_tapped:(id)sender;
@end
