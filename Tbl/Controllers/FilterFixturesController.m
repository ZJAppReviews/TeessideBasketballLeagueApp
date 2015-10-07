//
//  FilterFixturesController.m
//  Tbl
//
//  Created by Phil Hale on 09/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "FilterFixturesController.h"
#import "FilterFixturesTeamsController.h"
#import "FilterFixturesPlayedController.h"
#import "TblDataStore.h"


@interface FilterFixturesController() <FilterFixturesTeamsControllerDelegate, FilterFixturesPlayedControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *showGamesDetail;
@property (weak, nonatomic) IBOutlet UILabel *teamDetail;

@property (nonatomic, assign) int selectedTeamIdFilter;
@property (nonatomic, strong) NSString *selectedIsPlayedFilter;

@end

@implementation FilterFixturesController

@synthesize showGamesDetail;
@synthesize teamDetail;
@synthesize selectedTeamIdFilter = selectedTeamIdFilter;
@synthesize selectedIsPlayedFilter = _selectedIsPlayedFilter;
@synthesize delegate = _delegate;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"getFixtureFilterTeamName = %@", [TblDataStore getFixtureFilterTeamName]);
    //NSLog(@"getFixtureFilterIsPlayedText = %@", [TblDataStore getFixtureFilterIsPlayedText]);
    self.selectedTeamIdFilter = [TblDataStore getFixtureFilterTeamId];
    self.selectedIsPlayedFilter = [TblDataStore getFixtureFilterIsPlayed];
    self.teamDetail.text = [TblDataStore getFixtureFilterTeamName];
    self.showGamesDetail.text = [TblDataStore getFixtureFilterIsPlayedText];
    
    //if(self.delegate) NSLog(@"Delegate is not nil");
    //if(!self.delegate) NSLog(@"Delegate is nil");
}

- (void)viewDidUnload
{
    [self setTeamDetail:nil];
    [self setShowGamesDetail:nil];
    self.selectedIsPlayedFilter = nil;
    self.delegate = nil;
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"filterFixturesToTeamFilter"])
    {
        FilterFixturesTeamsController *destinationController = (FilterFixturesTeamsController*)segue.destinationViewController;
        destinationController.delegate = self;
        destinationController.selectedTeamId = self.selectedTeamIdFilter;
    }
    else if([segue.identifier isEqualToString:@"filterFixturesToIsPlayedFilter"])
    {
        FilterFixturesPlayedController *destinationController = (FilterFixturesPlayedController*)segue.destinationViewController;
        destinationController.delegate = self;
        destinationController.selectedIsPlayedFilter = self.selectedIsPlayedFilter;
    }
}

#pragma mark - Actions
- (IBAction)dismissModalView:(id)sender {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];

}

- (IBAction)saveFilters:(id)sender {
    [TblDataStore saveFixtureFiltersTeamId:self.selectedTeamIdFilter teamName:self.teamDetail.text isPlayed:self.selectedIsPlayedFilter isPlayedText:self.showGamesDetail.text];
    
    [self.delegate saveFiltersFilterFixturesController:self selectedTeamIdFilter:self.selectedTeamIdFilter selectedIsPlayedFilter:self.selectedIsPlayedFilter];
}

#pragma mark - Delegate stuff
- (void)filterFixturesTeamsViewController:(FilterFixturesTeamsController *)sender
                      selectedTeamId:(int)teamId
                    selectedTeamName:(NSString *)teamName
{
    self.teamDetail.text = teamName;
    self.selectedTeamIdFilter = teamId;
}

- (void)filterFixturesPlayedViewController:(FilterFixturesPlayedController *)sender
                    selectedIsPlayedFilter:(NSString*)isPlayedFilter
                              isPlayedText:(NSString*)isPlayedText
{
    self.selectedIsPlayedFilter = isPlayedFilter;
    self.showGamesDetail.text = isPlayedText;
}



@end
