//
//  MatchResultController.m
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "MatchResultController.h"
#import "NSDate+NSString.h"
#import "CustomSectionHeader.h"
#import "PlayerStatsController.h"

@interface MatchResultController()
@property (weak, nonatomic) IBOutlet UIScrollView *resultScrollView;
@property (weak, nonatomic) IBOutlet UITableView *statsTableView;
@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *fixtureDate;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UILabel *matchReport;
@property (strong, nonatomic) TblMatchResultDto *matchResult;
@end

@implementation MatchResultController

@synthesize fixtureId = _fixtureId;
@synthesize resultScrollView = _resultScrollView;
@synthesize statsTableView = _statsTableView;
@synthesize resultView = _resultView;
@synthesize fixtureDate = _fixtureDate;
@synthesize result = _result;
@synthesize matchReport = _matchReport;
@synthesize matchResult = _matchResult;

- (void)setFixtureId:(int)fixtureId
{
    if(_fixtureId != fixtureId)
    {
        self.isLoading = YES;
        [self.tblDataService getMatchResult:self successAction:@selector(GetMatchResultSuccessHandler:) fixtureId: fixtureId];
     

        _fixtureId = fixtureId;
    }
}


- (void) GetMatchResultSuccessHandler: (id) value {
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }

    TblMatchResultDto* dto = (TblMatchResultDto*)value;
	//NSLog(@"GetMatchResult returned the value: %@", result);
    self.result.text = [NSString stringWithFormat:@"%@ %@ - %@ %@", dto.Fixture.HomeTeamName, dto.Fixture.HomeTeamScore, dto.Fixture.AwayTeamScore, dto.Fixture.AwayTeamName];
    
    self.fixtureDate.text = [dto.Fixture.FixtureDate stringWithShortDateFormat];
    
    if(dto.Fixture.Report && [[dto.Fixture.Report stringByTrimmingCharactersInSet:                             [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] > 0)
    {
        self.matchReport.text = dto.Fixture.Report;
    }
    else {
        self.matchReport.text = @"No match report submitted";
    }

    // TODO Encapsulate this within a UILabel subclass
    CGSize maximumLabelSize = CGSizeMake(300,9999);

    CGSize expectedReportLabelSize = [self.matchReport.text sizeWithFont:self.matchReport.font 
                                                  constrainedToSize:maximumLabelSize 
                                                      lineBreakMode:self.matchReport.lineBreakMode]; 
    //NSLog(@"%f - %f", expectedReportLabelSize.height, self.matchReport.frame.size.height);
    int reportLabelHeightDifference = expectedReportLabelSize.height - self.matchReport.frame.size.height;
    
    //adjust the label the the new height.
    CGRect newMatchReportFrame = self.matchReport.frame;
    newMatchReportFrame.size.height = expectedReportLabelSize.height;
    self.matchReport.frame = newMatchReportFrame;
    
    CGRect newResultViewFrame = self.resultView.frame;
    // I have NO IDEA why this calculation is 200 out but it seems to work
    newResultViewFrame.size.height = newResultViewFrame.size.height + reportLabelHeightDifference - 200;
    self.resultView.frame = newResultViewFrame;
    self.resultScrollView.contentSize = self.resultView.bounds.size;
    

    self.matchResult = dto;
    [self.statsTableView reloadData];
    self.isLoading = NO;
}

#pragma mark - Segmented control

- (IBAction)changeView:(UISegmentedControl*)sender {
    NSInteger selectedSegment = sender.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        self.resultView.hidden = NO;
        self.statsTableView.hidden = YES;
    }
    else {
        self.resultView.hidden = YES;
        self.statsTableView.hidden = NO;
    }}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // http://stackoverflow.com/questions/791628/multi-column-header-for-a-uitableview-with-multiple-columns
    if(section == 0)
        return @"Home Stats";
    else
        return @"Away Stats";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Mimic default section header style
    UIView *sectionView = [CustomSectionHeader mimicDefaultSectionHeaderView];
    
    UILabel *playerNameSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:0.0 width:170.0 text:[self tableView:tableView titleForHeaderInSection:section]];
    [sectionView addSubview:playerNameSectionLabel];
      
    UILabel *foulsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:180.0 y:0.0 width:50.0 text:@"F"];
    foulsSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:foulsSectionLabel];
    
    UILabel *pointsSectionLabel = [CustomSectionHeader mimicDefaultSectionHeaderLabel:230.0 y:0.0 width:50.0 text:@"Pts"];
    pointsSectionLabel.textAlignment = UITextAlignmentRight;
    [sectionView addSubview:pointsSectionLabel];
    
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    if(section == 0)
        return [self.matchResult.HomePlayerStats count];
    else
        return [self.matchResult.AwayPlayerStats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"matchResultPlayerStatCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    TblPlayerFixtureDto *pf;
    
    if(indexPath.section == 0)
        pf = [self.matchResult.HomePlayerStats objectAtIndex:indexPath.row];
    else
        pf = [self.matchResult.AwayPlayerStats objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %d", pf.Player.Forename, pf.Player.Surname, pf.PointsScored];
    
    UILabel *playerName = (UILabel*)[cell viewWithTag:100];
    playerName.text = [NSString stringWithFormat:@"%@ %@", pf.Forename, pf.Surname];
    if(pf.IsMvp)
        playerName.text = [playerName.text stringByAppendingString:@" (MVP)"];
    
    // TODO Short name?
    //playerName.font = [UIFont systemFontOfSize:14];
    //NSLog(@"%d", playerName.lineBreakMode);
    
    UILabel *fouls = (UILabel*)[cell viewWithTag:101];
    fouls.text = [NSString stringWithFormat:@"%d", pf.Fouls];
    fouls.contentMode = UIViewContentModeRight;
    
    UILabel *points = (UILabel*)[cell viewWithTag:102];
    points.text = [NSString stringWithFormat:@"%d", pf.Points];
    points.contentMode = UIViewContentModeRight;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statsTableView.delegate = self;
    self.statsTableView.dataSource = self;
}


- (void)viewDidUnload
{
    [self setResult:nil];
    [self setFixtureDate:nil];
    [self setStatsTableView:nil];
    self.matchResult = nil;
    [self setResultView:nil];
    [self setMatchReport:nil];
    [self setResultScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    if([segue.identifier isEqualToString:@"matchResultToPlayerStats"])
    {
        NSIndexPath *indexPath = [self.statsTableView indexPathForCell:sender];

        TblPlayerFixtureDto *pf;
        
        if(indexPath.section == 0)
            pf = [self.matchResult.HomePlayerStats objectAtIndex:indexPath.row];
        else
            pf = [self.matchResult.AwayPlayerStats objectAtIndex:indexPath.row];
        
        PlayerStatsController *destinationController = (PlayerStatsController*)segue.destinationViewController;
        destinationController.playerId = pf.PlayerId;
        [self.statsTableView deselectRowAtIndexPath:indexPath animated:NO];

    }
}


@end
