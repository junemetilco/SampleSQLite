//
//  AgeViewController.m
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "AgeViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AgeViewController

@synthesize pLabel;

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
    // Do any additional setup after loading the view from its nib.
  
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] 
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                           target:self action:@selector(cancel_tapped:)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                            target:self action:@selector(done_tapped:)];
  
//  arrayNo = [[NSMutableArray alloc] init];
  
  arrayNo = [[NSArray alloc] initWithArray:[Globals ages]];
  
//  [arrayNo addObject:@"20"];
//  [arrayNo addObject:@"21"];
//  [arrayNo addObject:@"22"];
//  [arrayNo addObject:@"23"];
//  [arrayNo addObject:@"24"];
//  [arrayNo addObject:@"25"];
//  [arrayNo addObject:@"26"];
//  [arrayNo addObject:@"27"];
//  [arrayNo addObject:@"28"];
//  [arrayNo addObject:@"29"];
//  [arrayNo addObject:@"30"];

  
  [agePickerView selectRow:1 inComponent:0 animated:NO];
  
  pLabel.text = [arrayNo objectAtIndex:[agePickerView selectedRowInComponent:0] ];

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
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  pLabel.text = [arrayNo objectAtIndex:row];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
  return [arrayNo count];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
  return [arrayNo objectAtIndex:row];
}


@end
