//
//  FilterFixturesTeamsController.m
//  Tbl
//
//  Created by Phil Hale on 10/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "FilterFixturesTeamsController.h"

#define ALL_TEAMS @"All"

@interface FilterFixturesTeamsController()
@property (weak, nonatomic) IBOutlet UITableView *teamsFilterTableView;
@property (nonatomic, strong) TblArrayOfTeamNameDto *teams;
@end

@implementation FilterFixturesTeamsController

@synthesize teamsFilterTableView;
@synthesize teams = _teams;
@synthesize selectedTeamId = _selectedTeamId;
@synthesize delegate = _delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tblDataService getTeamsNamesForCurrentSeason:self successAction:@selector(getTeamsForSeasonSuccessHandler:)];
    self.isLoading = YES;
}

- (void)viewDidUnload
{
    [self setTeamsFilterTableView:nil];
    self.teams = nil;
    self.delegate = nil;
    [super viewDidUnload];
}

- (void)getTeamsForSeasonSuccessHandler:(id)value
{
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }
    
    self.teams = (TblArrayOfTeamNameDto*)value;
    //NSLog(@"%@", self.teams);
    [self.teamsFilterTableView reloadData];
    self.isLoading = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [self.teams count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teamFixtureFilterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    TblTeamNameDto *team = nil;
    
    if(indexPath.row > 0)
        team = [self.teams objectAtIndex:indexPath.row-1];
    
    if(team)
    {
        cell.textLabel.text = team.TeamName;
    }
    else 
    {
        cell.textLabel.text = ALL_TEAMS;
    }
    
    if((!team && self.selectedTeamId == 0)
       || (team && self.selectedTeamId == team.TeamId))
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [self.teamsFilterTableView cellForRowAtIndexPath:indexPath];
    TblTeamNameDto *team = nil;
    
    if(indexPath.row > 0)
        team = [self.teams objectAtIndex:indexPath.row - 1];
    
    self.selectedTeamId = team ? team.TeamId : 0;
    
    [self.delegate filterFixturesTeamsViewController:self selectedTeamId: self.selectedTeamId selectedTeamName:(team ? team.TeamName : ALL_TEAMS)];
    [self.teamsFilterTableView reloadData];
}

@end
