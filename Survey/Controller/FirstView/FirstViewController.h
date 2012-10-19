//
//  FirstViewController.h
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "DropDownView.h"

@class BirthdayController, AgeViewController, UICheckbox, Survey, SecondViewController;

@interface FirstViewController : UIViewController <DropDownViewDelegate>{
  
  AgeViewController *ageController;
  UINavigationController *ageNavController;
  
  BirthdayController *bdayController;
  UINavigationController *bdayNavController;
  
  SecondViewController *secondController;
  UINavigationController *secondNavController;
  
  UIButton *dropdownbutton;
  NSArray *arrayData;
  DropDownView *dropDownView;
}

@property (nonatomic, retain) IBOutlet UIButton *dropdownbutton;

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *age;
@property (nonatomic, retain) IBOutlet UITextField *birthday;

@property (nonatomic, retain) IBOutlet UIButton *birthdayBtn;
@property (nonatomic, retain) IBOutlet UIButton *ageBtn;

@property (nonatomic, strong) IBOutlet UICheckbox *maleCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *femaleCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *SSSCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *GSISCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *PRCCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *COMELECCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *singleCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *marriedCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *separatedCheckbox;
@property (nonatomic, strong) IBOutlet UICheckbox *widowedCheckbox;

- (IBAction) maleCheckBox:(id)sender;
- (IBAction) femaleCheckBox:(id)sender;
- (IBAction) SSSCheckBox:(id)sender;
- (IBAction) GSISCheckBox:(id)sender;
- (IBAction) PRCCheckBox:(id)sender;
- (IBAction) COMELECCheckBox:(id)sender;
- (IBAction) singleCheckBox:(id)sender;
- (IBAction) marriedCheckBox:(id)sender;
- (IBAction) separatedCheckBox:(id)sender;
- (IBAction) widowedCheckBox:(id)sender;

- (IBAction) hideKeyboard:(id)sender;

- (IBAction) saveSurveyToDB:(id)sender;

- (IBAction) dropdownbutton_tapped;

@end
