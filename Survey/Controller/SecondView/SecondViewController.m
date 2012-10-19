//
//  SecondViewController.m
//  Survey
//
//  Created by Chito Lucero on 10/9/12.
//  Copyright (c) 2012 HP Outsourcing. All rights reserved.
//

#import "SecondViewController.h"

#import "Survey.h"

#import "DetailViewController.h"

NSString *name;
NSMutableArray *surveys;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SecondViewController

@synthesize surveyResult;
@synthesize surveyResultTable;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Survey Lists", @"Survey Lists");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
  [super setEditing:editing animated:animated];
  [self.navigationItem setHidesBackButton:editing animated:animated];
  
  [surveyResultTable reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - View lifecycle
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
}         

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
  [super viewDidUnload];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [surveyResultTable reloadData];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated
{
	[surveyResultTable deselectRowAtIndexPath:selectedIndexPath animated:YES];
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
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [surveyResultTable release];
  [selectedIndexPath release];
  
  [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view methods
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
  return 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{  
  appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  return [appDelegate.surveyArray count];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [surveyResultTable dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  
  Survey *surveyObj = [appDelegate.surveyArray objectAtIndex:indexPath.row];
  
  cell.textLabel.text = surveyObj.name;
  
//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  selectedIndexPath = indexPath;
  
  if (!detailController)
    detailController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
  
  if(!detailNavController)
    detailNavController = [[UINavigationController alloc] initWithRootViewController:detailController];
  
  Survey *surveyObj = [appDelegate.surveyArray objectAtIndex:indexPath.row];
  
  [surveyObj hydrateDetailViewData];
  detailController.surveyObj = surveyObj;
  
  [self presentModalViewController:detailNavController animated:YES];
  
//  [detailController release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
//{
//  selectedIndexPath = indexPath;
//  
//  if (editingStyle == UITableViewCellEditingStyleDelete) 
//  {
//    Survey *surveyObj = [appDelegate.surveyArray objectAtIndex:indexPath.row];
//    [appDelegate removeSurvey:surveyObj];
//    
//    [surveyResultTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//  }
//}

////////////////////////////////////////////////////////////////////////////////////////////////////
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath 
//{
//  return UITableViewCellAccessoryDetailDisclosureButton;
////  return (self.editing) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
//}

////////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  // Only allow selection if editing.
//  return (self.editing) ? indexPath : nil;
//}

@end
