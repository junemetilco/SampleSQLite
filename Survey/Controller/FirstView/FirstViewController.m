//
//  FirstViewController.m
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#import "BirthdayController.h"
#import "AgeViewController.h"

#import "Survey.h"

#import "UICheckbox.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface FirstViewController () { }

@property (nonatomic, retain) BirthdayController *bdayController;
@property (nonatomic, retain) AgeViewController *ageController;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation FirstViewController

@synthesize dropdownbutton;

@synthesize bdayController;
@synthesize ageController;

@synthesize birthdayBtn;
@synthesize ageBtn;

@synthesize name;
@synthesize age;
@synthesize birthday;

@synthesize maleCheckbox = _maleCheckbox;
@synthesize femaleCheckbox = _femaleCheckbox;
@synthesize SSSCheckbox = _SSSCheckbox;
@synthesize GSISCheckbox = _GSISCheckbox;
@synthesize PRCCheckbox = _PRCCheckbox;
@synthesize COMELECCheckbox = _COMELECCheckbox;
@synthesize singleCheckbox = _singleCheckbox;
@synthesize marriedCheckbox = _marriedCheckbox;
@synthesize separatedCheckbox = _separatedCheckbox;
@synthesize widowedCheckbox = _widowedCheckbox;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      self.title = NSLocalizedString(@"Survey Questions", @"Survey Questions");
      self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];

  [name setReturnKeyType:UIReturnKeyDone];
  
//  self.maleCheckbox.checked = TRUE;
//  self.maleCheckbox.disabled = FALSE;
  
  self.maleCheckbox.text = @"Male";
  self.femaleCheckbox.text = @"Female";
  self.SSSCheckbox.text = @"SSS";
  self.GSISCheckbox.text = @"GSIS";
  self.PRCCheckbox.text = @"PRC";
  self.COMELECCheckbox.text = @"COMELEC";
  self.singleCheckbox.text = @"Single";
  self.marriedCheckbox.text = @"Married";
  self.separatedCheckbox.text = @"Separated";
  self.widowedCheckbox.text = @"Widowed";

  // Set DropDown
  arrayData = [[NSArray alloc] initWithArray:[Globals regions]];  
	dropDownView = [[DropDownView alloc] initWithArrayData:arrayData 
                                              cellHeight:30 
                                         heightTableView:115
                                              paddingTop:-8 
                                             paddingLeft:-5 
                                            paddingRight:-10 
                                                 refView:dropdownbutton 
                                               animation:BLENDIN 
                                   openAnimationDuration:0.5 
                                  closeAnimationDuration:0.5];
  
  dropDownView.delegate = self;
  [self.view addSubview:dropDownView.view];
  [dropdownbutton setTitle:[arrayData objectAtIndex:0] forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
  [super viewDidUnload];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
//  AddViewController *addCon = [[[AddViewController alloc] initWithNibName:@"AddViewController" bundle:[NSBundle mainBundle]] autorelease];
//  self.view = addCon.view;                             
  
  name.text = @"";
  birthday.text = @"";
  age.text = @"";
  
  //get the values from another viewController to firstViewController
  self.birthday.text = bdayController.bLabel.text;
  self.age.text = ageController.pLabel.text;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) textFieldShouldReturn:(UITextField *)theTextField
{
  [name resignFirstResponder];
  return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Age and Birthday Controller Action
////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)birthdaybtn_tapped:(id)sender
{
  [name resignFirstResponder];
  
  bdayController = [[[BirthdayController alloc] init] autorelease];
  
  if(!bdayNavController)
    bdayNavController = [[UINavigationController alloc] initWithRootViewController:bdayController];
  
  bdayController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  
  [self presentModalViewController:bdayNavController animated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)agebtn_tapped:(id)sender
{
  [name resignFirstResponder];
  
  ageController = [[[AgeViewController alloc] init] autorelease];
  
  if(!ageNavController)
    ageNavController = [[UINavigationController alloc] initWithRootViewController:ageController];
  
  ageController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
  
  [self presentModalViewController:ageNavController animated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Checkbox Actions
////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) maleCheckBox:(id)sender
{
  [name resignFirstResponder];
  
  NSLog(@"checkbox.checked = %@", (self.maleCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.maleCheckbox.disabled) ? @"YES" : @"NO");
  
  if (self.maleCheckbox.checked) 
    self.femaleCheckbox.disabled = TRUE;
  else
    self.femaleCheckbox.disabled = FALSE;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) femaleCheckBox:(id)sender
{
  [name resignFirstResponder];
  
  NSLog(@"checkbox.checked = %@", (self.femaleCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.femaleCheckbox.disabled) ? @"YES" : @"NO");
  
  if(self.femaleCheckbox.checked == TRUE)
    self.maleCheckbox.disabled = TRUE;
  else
    self.maleCheckbox.disabled = FALSE;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) SSSCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.SSSCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.SSSCheckbox.disabled) ? @"YES" : @"NO");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) GSISCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.GSISCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.GSISCheckbox.disabled) ? @"YES" : @"NO");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) PRCCheckBox:(id)sender 
{
  NSLog(@"checkbox.checked = %@", (self.PRCCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.PRCCheckbox.disabled) ? @"YES" : @"NO");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) COMELECCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.COMELECCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.COMELECCheckbox.disabled) ? @"YES" : @"NO");
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) singleCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.singleCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.singleCheckbox.disabled) ? @"YES" : @"NO");
  
  if(self.singleCheckbox.checked == TRUE) {
    self.marriedCheckbox.disabled = TRUE;
    self.separatedCheckbox.disabled = TRUE;
    self.widowedCheckbox.disabled = TRUE;
  } else {
    self.marriedCheckbox.disabled = FALSE;
    self.separatedCheckbox.disabled = FALSE;
    self.widowedCheckbox.disabled = FALSE;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) marriedCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.marriedCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.marriedCheckbox.disabled) ? @"YES" : @"NO");
  
  if(self.marriedCheckbox.checked == TRUE) {
    self.singleCheckbox.disabled = TRUE;
    self.separatedCheckbox.disabled = TRUE;
    self.widowedCheckbox.disabled = TRUE;
  } else {
    self.singleCheckbox.disabled = FALSE;
    self.separatedCheckbox.disabled = FALSE;
    self.widowedCheckbox.disabled = FALSE;
  }
  
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) separatedCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.separatedCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.separatedCheckbox.disabled) ? @"YES" : @"NO");
  
  if(self.separatedCheckbox.checked == TRUE) {
    self.singleCheckbox.disabled = TRUE;
    self.marriedCheckbox.disabled = TRUE;
    self.widowedCheckbox.disabled = TRUE;
  } else {
    self.singleCheckbox.disabled = FALSE;
    self.marriedCheckbox.disabled = FALSE;
    self.widowedCheckbox.disabled = FALSE;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) widowedCheckBox:(id)sender
{
  NSLog(@"checkbox.checked = %@", (self.widowedCheckbox.checked) ? @"YES" : @"NO");
  NSLog(@"checkbox.disabled = %@", (self.widowedCheckbox.disabled) ? @"YES" : @"NO");
  
  if(self.widowedCheckbox.checked == TRUE) {
    self.singleCheckbox.disabled = TRUE;
    self.marriedCheckbox.disabled = TRUE;
    self.separatedCheckbox.disabled = TRUE;
  } else {
    self.singleCheckbox.disabled = FALSE;
    self.marriedCheckbox.disabled = FALSE;
    self.separatedCheckbox.disabled = FALSE;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [name release];
  [birthday release];
  [age release];
  
  [dropdownbutton release];
  
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) hideKeyboard:(id)sender
{
  [sender resignFirstResponder];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Survey Action
////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) saveSurveyToDB:(id)sender
{  
  AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
  
  Survey *surveyObj = [[Survey alloc] initWithPrimaryKey:0];
  
  surveyObj.name = name.text;
  surveyObj.birthday = birthday.text;
  
  NSString *ageString = [NSString stringWithFormat:@"%d", surveyObj.age];
  ageString = age.text;
  
  surveyObj.isDirty = NO;
  surveyObj.isDetailViewHydrated = YES;
  
  [appDelegate addSurvey:surveyObj];
  
//  UIAlertView* alert;
//  alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Survey Question Saved! as Array" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//  [alert show];
//  [alert release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark DropDown
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dropDownCellSelected:(NSInteger)returnIndex
{
  [dropdownbutton setTitle:[arrayData objectAtIndex:returnIndex] forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) dropdownbutton_tapped
{
  [dropDownView openAnimation];
}


@end
