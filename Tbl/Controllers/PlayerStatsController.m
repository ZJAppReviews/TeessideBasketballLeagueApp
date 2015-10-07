//
//  PlayerStatsController.m
//  Tbl
//
//  Created by Phil Hale on 21/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "PlayerStatsController.h"
#import "TblPlayer+NSString.h"
#import "CustomSectionHeader.h"

@interface PlayerStatsController ()

@property (nonatomic, strong) TblPlayerStatsDto *playerStats;

@property (weak, nonatomic) IBOutlet UILabel *playerName;

@end

@implementation PlayerStatsController

@synthesize playerId = _playerId;
@synthesize playerStats = _playerStats;
@synthesize playerName = _playerName;

- (void)setPlayerId:(int)playerId
{
    if(_playerId != playerId)
    {
        _playerId = playerId;
        [self.tblDataService getAllPlayerStats:self successAction:@selector(getAllPlayerStatsSuccessHandler:) playerId:playerId];
        self.isLoading = YES;
    }
}

#pragma mark - View lifecyle
- (void)viewDidUnload
{
    [self setPlayerName:nil];
    [super viewDidUnload];
    self.playerStats = nil;
}

#pragma mark - Web service
- (void) getAllPlayerStatsSuccessHandler: (id) value {
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }
    
    self.playerStats = (TblPlayerStatsDto*)value;
    
    self.playerName.text = [self.playerStats.Player fullName];
    
    [self.tableView reloadData];
    self.isLoading = NO;
}

#pragma mark - Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    // http://stackoverflow.com/questions/791628/multi-column-header-for-a-uitableview-with-multiple-columns
//    if(section == 0)
//        return @"Home Stats";
//    else
//        return @"Away Stats";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        // Double height section header
        UIView *currentSeasonSectionHeaderView = [CustomSectionHeader mimicDefaultSectionHeaderViewWithDoubleHeight];
        
        // Top
        UILabel *currentSeasonSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:0.0 width:200.0 text:@"Season Stats"];
        [currentSeasonSectionHeaderView addSubview:currentSeasonSectionLabel];
        
        // Bottom
        UILabel *opponentSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:22.0 width:150.0 text:@"Vs"];
        [currentSeasonSectionHeaderView addSubview:opponentSectionLabel];
        
        UILabel *mvpSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:170.0 y:22.0 width:40.0 text:@"MVP"];
        [currentSeasonSectionHeaderView addSubview:mvpSectionLabel];
        
        UILabel *foulsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:240.0 y:22.0 width:30.0 text:@"F"];
        foulsSectionLabel.contentMode = UIViewContentModeRight;
        [currentSeasonSectionHeaderView addSubview:foulsSectionLabel];
        
        UILabel *pointsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:280.0 y:22.0 width:30.0 text:@"Pts"];
        pointsSectionLabel.contentMode = UIViewContentModeRight;
        [currentSeasonSectionHeaderView addSubview:pointsSectionLabel];

        
        return currentSeasonSectionHeaderView;
        
    }
    else {
        // Double height section header
        UIView *careerSectionHeaderView = [CustomSectionHeader mimicDefaultSectionHeaderViewWithDoubleHeight];
        
        // Top
        UILabel *careerSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:0.0 width:170.0 text:@"Career Stats"];
        [careerSectionHeaderView addSubview:careerSectionLabel];
        
        // Bottom
        UILabel *yearSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:22.0 width:60 text:@"Year"];
        [careerSectionHeaderView addSubview:yearSectionLabel];
        
        UILabel *gamesSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:93.0 y:22.0 width:30.0 text:@"G"];
        gamesSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:gamesSectionLabel];
        
        UILabel *mvpSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:120.0 y:22.0 width:40.0 text:@"MVP"];
        mvpSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:mvpSectionLabel];
        
        UILabel *foulsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:170.0 y:22.0 width:30.0 text:@"F"];
        foulsSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:foulsSectionLabel];
        
        UILabel *foulsPerGameSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:198.0 y:22.0 width:40.0 text:@"FPG"];
        foulsPerGameSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:foulsPerGameSectionLabel];
        
        UILabel *pointsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:240.0 y:22.0 width:30.0 text:@"Pts"];
        pointsSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:pointsSectionLabel];
        
        UILabel *pointsPerGameSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:275.0 y:22.0 width:40.0 text:@"PPG"];
        pointsPerGameSectionLabel.contentMode = UIViewContentModeRight;
        [careerSectionHeaderView addSubview:pointsPerGameSectionLabel];
        
        
        return careerSectionHeaderView;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    if(section == 0)
        return [self.playerStats.CurrentSeasonFixtureStats count];
    else
        return [self.playerStats.CareerStats count]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    if(indexPath.section == 0)
        CellIdentifier = @"playerSeasonStatCell";
    else 
        CellIdentifier = @"playerCareerStatCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.section == 0) {
        TblPlayerSeasonFixtureStatsDto *stats = [self.playerStats.CurrentSeasonFixtureStats objectAtIndex:indexPath.row];
        
        UILabel *opponent = (UILabel*)[cell viewWithTag:400];
        opponent.text = stats.OpponentName;

        UILabel *mvp = (UILabel*)[cell viewWithTag:401];
        mvp.text = [NSString stringWithFormat:@"%@", stats.IsMvp ? @"Y" : @"N"];
        mvp.contentMode = UIViewContentModeRight;
        
        UILabel *fouls = (UILabel*)[cell viewWithTag:402];
        fouls.text = stats.Fouls;
        fouls.contentMode = UIViewContentModeRight;
        
        UILabel *points = (UILabel*)[cell viewWithTag:403];
        points.text = stats.Points;
        points.contentMode = UIViewContentModeRight;
    }
    else {
        TblPlayerCareerStatsDto *stats = [self.playerStats.CareerStats objectAtIndex:indexPath.row];

        UILabel *year = (UILabel*)[cell viewWithTag:500];
        year.text = stats.Year;
        
        UILabel *games = (UILabel*)[cell viewWithTag:501];
        games.text = stats.Games;
        games.contentMode = UIViewContentModeRight;
        
        UILabel *mvp = (UILabel*)[cell viewWithTag:502];
        mvp.text = stats.MvpAwards;
        mvp.contentMode = UIViewContentModeRight;
        
        UILabel *fouls = (UILabel*)[cell viewWithTag:503];
        fouls.text = stats.Fouls;
        fouls.contentMode = UIViewContentModeRight;
        
        UILabel *foulsPerGame = (UILabel*)[cell viewWithTag:504];
        foulsPerGame.text = stats.FoulsPerGame;
        foulsPerGame.contentMode = UIViewContentModeRight;
        
        UILabel *points = (UILabel*)[cell viewWithTag:505];
        points.text = stats.Points;
        points.contentMode = UIViewContentModeRight;
        
        UILabel *pointsPerGame = (UILabel*)[cell viewWithTag:506];
        pointsPerGame.text = stats.PointsPerGame;
        pointsPerGame.contentMode = UIViewContentModeRight;
    }

    cell.userInteractionEnabled = NO;
    
    return cell;
}

@end
