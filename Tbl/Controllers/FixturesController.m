//
//  FixturesController.m
//  Tbl
//
//  Created by Phil Hale on 09/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "FixturesController.h"
#import "NSDate+NSString.h"
#import "TblDataStore.h"
#import "FilterFixturesController.h"
#import "NSOrderedSet+TblArrayOfFixture.h"
#import "MatchResultController.h"
#import "CustomSectionHeader.h"

@interface FixturesController() <FilterFixturesControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *headerTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerShowGamesLabel;

@property (weak, nonatomic) IBOutlet UITableView *fixtureTableView;
@property (strong, nonatomic) TblArrayOfFixtureDto *fixtures;

// Required to display month sections
@property (strong, nonatomic) NSOrderedSet *monthNames;
@property (strong, nonatomic) NSArray *numberOfRowsInSection;
@property (strong, nonatomic) NSArray *firstIndexInSection;
@end

// TODO Make month handling better
@implementation FixturesController

@synthesize headerTeamLabel = _headerTeamLabel;
@synthesize headerShowGamesLabel = _headerShowGamesLabel;
@synthesize fixtureTableView;
@synthesize fixtures = _fixtures;
@synthesize monthNames = _monthNames;
@synthesize numberOfRowsInSection = _numberOfRowsInSection;
@synthesize firstIndexInSection = _firstIndexInSection;


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.tblDataService getFixturesFiltered:self successAction:@selector(getFixturesSucessHandler:) teamId:[TblDataStore getFixtureFilterTeamId] isPlayed:[TblDataStore getFixtureFilterIsPlayed]];
    self.isLoading = YES;
}

- (void)viewDidUnload
{
    [self setFixtureTableView:nil];
    self.fixtures = nil;
    self.monthNames = nil;
    self.numberOfRowsInSection = nil;
    self.firstIndexInSection = nil;
    [self setHeaderTeamLabel:nil];
    [self setHeaderShowGamesLabel:nil];
    [super viewDidUnload];
}

- (void)getFixturesSucessHandler:(id)value
{
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }
    
    self.fixtures = (TblArrayOfFixtureDto*)value;
    //NSLog(@"%@", self.fixtures);
    //NSLog(@"number of fixtures = %d", [self.fixtures count]);

    self.monthNames = [NSOrderedSet monthsInFixtures:self.fixtures];
    NSMutableArray *numberOfRowsInSection = [[NSMutableArray alloc] initWithCapacity:[self.monthNames count]];
    NSMutableArray *firstIndexInSection = [[NSMutableArray alloc] initWithCapacity:[self.monthNames count]];
    for (NSString *month in self.monthNames) {
        int monthCount = 0;
        //NSLog(@"Searching for month %@", month);
        int firstIndex = -1;
        for (int i = 0; i < [self.fixtures count]; i++) {
            TblFixtureDto *fixture = [self.fixtures objectAtIndex:i];
            
            //NSLog(@"Checking fixture %@ v %@ on %@ at index %d", fixture.HomeTeamName, fixture.AwayTeamName, [NSString stringWithShortDateFormat:fixture.FixtureDate], i);
            
            if([[fixture.FixtureDate stringWithMonthNameAndYear] isEqualToString:month]) {
                monthCount++;
                if(firstIndex == -1) firstIndex = i;
            }
        }
        
        [firstIndexInSection addObject:[NSNumber numberWithInt:firstIndex]];
        [numberOfRowsInSection addObject:[NSNumber numberWithInt: monthCount]]; 
    }
    
    self.numberOfRowsInSection = [[NSArray alloc] initWithArray:numberOfRowsInSection];
    self.firstIndexInSection = [[NSArray alloc] initWithArray:firstIndexInSection];
    //NSLog(@"numberOfRowsInSection = %@", self.numberOfRowsInSection); 
    //NSLog(@"firstIndexInSection = %@", self.firstIndexInSection); 
    
    self.headerTeamLabel.text = [TblDataStore getFixtureFilterTeamName];
    self.headerShowGamesLabel.text = [TblDataStore getFixtureFilterIsPlayedText];
    
    [self.fixtureTableView reloadData];
    self.isLoading = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.numberOfRowsInSection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    //NSLog(@"current section = %d", section);
    //NSLog(@"number of rows in section = %@", [self.numberOfRowsInSection objectAtIndex:section]);

    return  [[self.numberOfRowsInSection objectAtIndex:section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"fixturesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        
    int fixtureRow = [[self.firstIndexInSection objectAtIndex:indexPath.section] intValue] + indexPath.row;
    
    //NSLog(@"Returning fixture row %d", fixtureRow);
    TblFixtureDto *fixture = [self.fixtures objectAtIndex:fixtureRow];
    
    
    if(fixture.IsPlayed)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ vs %@ %@", fixture.HomeTeamName, fixture.HomeTeamScore, fixture.AwayTeamScore, fixture.AwayTeamName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
    }
    else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@", fixture.HomeTeamName, fixture.AwayTeamName];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.userInteractionEnabled = NO; 
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [fixture.FixtureDate stringWithShortDateFormat], fixture.TipOffTime];
    
    if(fixture.IsCancelled) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - CANCELLED", cell.detailTextLabel.text];
    }     
    
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [self.monthNames objectAtIndex:section];
//}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *sectionView = [CustomSectionHeader mimicDefaultSectionHeaderView];
    
    UILabel *monthName = [CustomSectionHeader mimicDefaultSectionHeaderLabel:10.0 y:0.0 width:200.0 text:[self.monthNames objectAtIndex:section]];
    [sectionView addSubview:monthName];
    
    return sectionView;
}



#pragma mark - Delegate methods
- (void)saveFiltersFilterFixturesController:(FilterFixturesController *)sender
                       selectedTeamIdFilter:(int)teamIdFilter
                     selectedIsPlayedFilter:(NSString*)isPlayedFilter
{
    [sender dismissModalViewControllerAnimated:true];
        
    [self.tblDataService getFixturesFiltered:self successAction:@selector(getFixturesSucessHandler:) teamId:teamIdFilter isPlayed:isPlayedFilter];
    self.isLoading = YES;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fixturesToFilterBy"])
    {
        UINavigationController *destinationNavController = (UINavigationController*)segue.destinationViewController;
        FilterFixturesController *destinationController = (FilterFixturesController*)destinationNavController.topViewController;
        destinationController.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"fixtureToMatchResult"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        int actualFixtureIndex = [[self.firstIndexInSection objectAtIndex:indexPath.section] intValue] + indexPath.row;
        
        int fixtureId = [[self.fixtures objectAtIndex:actualFixtureIndex] FixtureId];
        [segue.destinationViewController setFixtureId:fixtureId];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
@end
