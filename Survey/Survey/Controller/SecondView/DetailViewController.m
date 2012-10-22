//
//  DetailViewController.m
//  Survey
//
//  Created by Chito Lucero on 10/18/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "DetailViewController.h"
#import "Survey.h"
#import "EditViewController.h"
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DetailViewController

@synthesize surveyObj;

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
  [super setEditing:editing animated:animated];
  [self.navigationItem setHidesBackButton:editing animated:animated];
  
  [detailTableView reloadData];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor blackColor];
  
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                            target:self action:@selector(cancel_Clicked:)] autorelease];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
  [super viewDidUnload];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  self.title = surveyObj.name;
  [detailTableView reloadData];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewWillDisappear:(BOOL)animated
{
  [detailTableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
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

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [selectedIndexPath release];
  [detailTableView release];
  [surveyObj release];
  
  [super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView 
{
  return 5;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section 
{
  return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [detailTableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
	
  NSString *stringAge = [NSString stringWithFormat:@"%d", surveyObj.age];
  
	switch(indexPath.section) 
  {
		case 0:
			cell.textLabel.text = surveyObj.name;
			break;
		case 1:
			cell.textLabel.text = surveyObj.birthday;
			break;
    case 2:
      cell.textLabel.text = stringAge;
      break;
    case 3:
      cell.textLabel.text = surveyObj.gender;
      break;
    case 4:
      cell.textLabel. text = surveyObj.civilStatus;
      break;
	}
	
	return cell;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath 
{
  // Show the disclosure indicator if editing.
  return (self.editing) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
  // Only allow selection if editing.
  return (self.editing) ? indexPath : nil;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  selectedIndexPath = indexPath;
  
  if(!editViewController)
    editViewController = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
  
  NSString *stringAge = [NSString stringWithFormat:@"%d", surveyObj.age];
  
  switch (indexPath.section) {
    case 0:
      editViewController.keyOfTheFieldToEdit = @"name";
      editViewController.editValue = surveyObj.name;
      break;
    case 1:
      editViewController.keyOfTheFieldToEdit = @"birthday";
      editViewController.editValue = surveyObj.birthday;
      break;
    case 2:
      editViewController.keyOfTheFieldToEdit = @"age";
      editViewController.editValue = stringAge;
      break;
    case 3:
      editViewController.keyOfTheFieldToEdit = @"gender";
      editViewController.editValue = surveyObj.gender;
      break;
    case 4:
      editViewController.keyOfTheFieldToEdit = @"civilStatus";
      editViewController.editValue = surveyObj.civilStatus;
      break;
  }
  
  editViewController.objectToEdit = surveyObj;
  
  [self.navigationController pushViewController:editViewController animated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void) cancel_Clicked:(id)sender 
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
