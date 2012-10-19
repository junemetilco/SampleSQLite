//
//  EditViewController.m
//  Survey
//
//  Created by Chito Lucero on 10/19/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "EditViewController.h"

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
@implementation EditViewController

@synthesize keyOfTheFieldToEdit;
@synthesize editValue;
@synthesize objectToEdit;

//////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
  self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
  
  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                            target:self action:@selector(save_tapped:)] autorelease];

}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.title = [self.keyOfTheFieldToEdit capitalizedString];
  editTextField.placeholder = [self.keyOfTheFieldToEdit capitalizedString];
  
  editTextField.text = self.editValue;
  
  [editTextField becomeFirstResponder];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
  [editTextField release];
  [keyOfTheFieldToEdit release];
  [editValue release];
  [objectToEdit release];
  [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark tapped action
//////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) save_tapped:(id)sender
{
  [objectToEdit setValue:editTextField.text forKey:self.keyOfTheFieldToEdit];
  
  [self.navigationController popViewControllerAnimated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (IBAction) cancel_tapped:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
