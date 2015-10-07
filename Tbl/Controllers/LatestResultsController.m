//
//  TableViewController.m
//  Tbl
//
//  Created by Phil Hale on 03/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "LatestResultsController.h"
#import "MatchResultController.h"
#import "NSDate+NSString.h"
#import "EGORefreshTableHeaderView.h"

@interface LatestResultsController() //<EGORefreshTableHeaderDelegate>
@property (nonatomic, strong) TblArrayOfFixtureDto *results;

@end

@implementation LatestResultsController

@synthesize results = _results;


#pragma mark - Web service

- (void)getLatestResults
{
    [self.tblDataService getLatestMatchResults:self successAction:@selector(getLatestMatchResultsSuccessHandler:) numberOfMatchResults: 10];
}

- (void) getLatestMatchResultsSuccessHandler: (id) value 
{
//    if(!self.view.window)
//    {
//        [self doneLoadingTableViewData];
//        return;
//    }
    
    TblArrayOfFixtureDto* result = (TblArrayOfFixtureDto*)value;
	//NSLog(@"GetLatestMatchResults returned the value: %@", result);
    self.results = result;
    [self.tableView reloadData];
    [self doneLoadingTableViewData];
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self reloadTableViewDataSource];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.results = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"latestResultsToMatchResult"sender:cell];    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    if([segue.identifier isEqualToString:@"latestResultsToMatchResult"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        int fixtureId = [[self.results objectAtIndex:indexPath.row] FixtureId];
        [segue.destinationViewController setFixtureId:fixtureId];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"latestResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TblFixtureDto *fixture = [self.results objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ vs %@ %@", fixture.HomeTeamName, fixture.HomeTeamScore, fixture.AwayTeamScore, fixture.AwayTeamName];

    cell.detailTextLabel.text = [fixture.FixtureDate stringWithShortDateFormat];

    
    return cell;
}

#pragma mark - Pull down refresh
- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
    [super reloadTableViewDataSource];
    [self getLatestResults];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
