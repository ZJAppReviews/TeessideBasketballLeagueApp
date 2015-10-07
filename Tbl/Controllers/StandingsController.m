//
//  StandingsController.m
//  Tbl
//
//  Created by Phil Hale on 08/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "StandingsController.h"
#import "CustomSectionHeader.h"
#import "TeamInformationController.h"

@interface StandingsController()
@property (nonatomic, strong) TblArrayOfDivisionStandingsDto *divisonData;
@property (nonatomic, assign) int currentSelectedDivison;
@end

@implementation StandingsController
@synthesize divisonData = _divisonData;
@synthesize currentSelectedDivison = _currentSelectedDivison;


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
            
    [self reloadTableViewDataSource];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    self.divisonData = nil;
}

#pragma mark - Utility methods
- (void)createUISegmentedControl:(TblArrayOfDivisionStandingsDto*)divisions
{
    NSMutableArray *divisonNames = [[NSMutableArray alloc] initWithCapacity:[divisions count]];
    
    for (TblDivisionStandingsDto *div in divisions) {
        [divisonNames addObject:div.Name];
    }
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:divisonNames];
    seg.frame = CGRectMake(56, 5, 207, 30);
    seg.segmentedControlStyle = UISegmentedControlStyleBar;
    seg.tintColor = [UIColor lightGrayColor];
    seg.selectedSegmentIndex = 0;
    self.currentSelectedDivison = 0;
    [seg addTarget:self action:@selector(divisionChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
}

- (void)divisionChanged:(UISegmentedControl*)sender
{
    self.currentSelectedDivison = sender.selectedSegmentIndex;
    [self.tableView reloadData];
}

#pragma mark - Web service handler
- (void)getLatestStandingsSuccessHandler:(id)value
{
//    if(!self.view.window)
//    {
//        [self doneLoadingTableViewData];
//        return;
//    }
    
    TblLeagueStandingsDto* standings = (TblLeagueStandingsDto*)value;
    self.divisonData = (TblArrayOfDivisionStandingsDto*)standings.DivisionStandings;
    //NSLog(@"%@", standings);
    
    [self createUISegmentedControl:self.divisonData];
    [self.tableView reloadData];
    [self doneLoadingTableViewData];
}

- (void)reloadTableViewDataSource
{
    [super reloadTableViewDataSource];
    [self.tblDataService getStandingsForCurrentSeason:self successAction:@selector(getLatestStandingsSuccessHandler:)];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Mimic default section header style
    UIView *sectionView = [CustomSectionHeader mimicDefaultSectionHeaderView];
    
    UILabel *teamNameSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:0.0 width:90.0 text:@"Team"];
    [sectionView addSubview:teamNameSectionLabel];
    
    UILabel *playedSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:110.0 y:0.0 width:30.0 text:@"Pl"];
    playedSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:playedSectionLabel];
    
    UILabel *wonSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:150.0 y:0.0 width:30.0 text:@"W"];
    wonSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:wonSectionLabel];
    
    UILabel *lostSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:185.0 y:0.0 width:30.0 text:@"L"];
    lostSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:lostSectionLabel];
    
    UILabel *percentWonSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:230.0 y:0.0 width:30.0 text:@"Pct"];
    percentWonSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:percentWonSectionLabel];
    
    UILabel *pointsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:270.0 y:0.0 width:30.0 text:@"Pts"];
    pointsSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:pointsSectionLabel];
    
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [[[self.divisonData objectAtIndex:self.currentSelectedDivison] Standings] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"standingsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    TblDivisionStandingsDto *divsionStandings = [self.divisonData objectAtIndex:self.currentSelectedDivison];
    TblTeamLeagueDto *tl = [divsionStandings.Standings objectAtIndex:indexPath.row];
    
//    if(indexPath.section == 0)
//        pf = [self.matchResult.HomePlayerStats objectAtIndex:indexPath.row];
//    else
//        pf = [self.matchResult.AwayPlayerStats objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %d", pf.Player.Forename, pf.Player.Surname, pf.PointsScored];
    
    UILabel *teamName = (UILabel*)[cell viewWithTag:200];
    teamName.text = [NSString stringWithFormat:@"%@", tl.TeamName];
    
    UILabel *played = (UILabel*)[cell viewWithTag:201];
    played.text = tl.GamesPlayed;
    played.contentMode = UIViewContentModeRight;
    
    UILabel *won = (UILabel*)[cell viewWithTag:202];
    won.text = tl.GamesWon;
    won.contentMode = UIViewContentModeRight;
    
    UILabel *lost = (UILabel*)[cell viewWithTag:203];
    lost.text = tl.GamesLost;
    lost.contentMode = UIViewContentModeRight;
    
    UILabel *percentWin = (UILabel*)[cell viewWithTag:204];
    percentWin.text = tl.GamesPct;
    percentWin.contentMode = UIViewContentModeRight;
    
    UILabel *points = (UILabel*)[cell viewWithTag:205];
    points.text = tl.PointsLeague;
    points.contentMode = UIViewContentModeRight;
//    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma  mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    if([segue.identifier isEqualToString:@"standingsToTeamInformation"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        TblDivisionStandingsDto *divsionStandings = [self.divisonData objectAtIndex:self.currentSelectedDivison];
        TblTeamLeagueDto *tl = [divsionStandings.Standings objectAtIndex:indexPath.row];
        int teamId = tl.TeamId;
        
        TeamInformationController *teamInformationController = (TeamInformationController*)segue.destinationViewController;
        teamInformationController.teamId = teamId;
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];

    }
}


@end
