//
//  TeamsController.m
//  Tbl
//
//  Created by Phil Hale on 17/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TeamsController.h"
#import "TeamInformationController.h"

@interface TeamsController()
    
@property (nonatomic, strong) TblArrayOfTeamNameDto *teams;

@end

@implementation TeamsController

@synthesize teams = _teams;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.tblDataService getTeamsNamesForCurrentSeason:self successAction:@selector(getTeamsSuccessHandler:)];    
    self.isLoading = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.teams = nil;
}

#pragma mark - Web service handler
- (void) getTeamsSuccessHandler: (id) value {
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }
    
    TblArrayOfTeamNameDto* result = (TblArrayOfTeamNameDto*)value;
	//NSLog(@"Teams for curent season returned the value: %@", result);
    self.teams = result;
    [self.tableView reloadData];
    self.isLoading = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [self.teams count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teamCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    TblTeam *team = [self.teams objectAtIndex:indexPath.row];
    cell.textLabel.text = team.TeamName;
    
    return cell;
}

#pragma  mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"teamsToTeamInformation"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        int teamId = [[self.teams objectAtIndex:indexPath.row] TeamId];
        
        TeamInformationController *teamInformationController = (TeamInformationController*)segue.destinationViewController;
        teamInformationController.teamId = teamId;
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end
