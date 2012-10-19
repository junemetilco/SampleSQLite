//
//  BirthdayController.m
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "BirthdayController.h"
#import "FirstViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BirthdayController

@synthesize bLabel;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
    [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] 
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                           target:self action:@selector(cancel_tapped:)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                            target:self action:@selector(done_tapped:)];
    // Do any additional setup after loading the view from its nib.
  

//  NSDate *pickedDate = [bdayPickerView date];
//  
//  NSString *selectedDate = [[NSString alloc] initWithFormat:@"%@", pickedDate];
//                                                        
//  
//  bLabel.text = selectedDate;
//  
//  [selectedDate release];
  

  
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) cancel_tapped:(id)sender
{
  [self.navigationController dismissModalViewControllerAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) done_tapped:(id)sender
{
  [self.navigationController dismissModalViewControllerAnimated:YES];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)getSelectedDate:(id)sender
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  
  NSDate *date = [bdayPickerView date];
   
  NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
  [dateFormatter setLocale:usLocale];
  
//  bLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
  bLabel.text = [dateFormatter stringFromDate:date];
  
  [dateFormatter release];

}

@end
