//
//  FilterFixturesPlayedController.m
//  Tbl
//
//  Created by Phil Hale on 11/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "FilterFixturesPlayedController.h"

#define ALL_ROW 0
#define UNPLAYED_ROW 1
#define PLAYED_ROW 2

@interface FilterFixturesPlayedController()
@property (nonatomic, strong) NSArray *isPlayedOptions;
@end

@implementation FilterFixturesPlayedController

@synthesize selectedIsPlayedFilter = _selectedIsPlayedFilter;
@synthesize isPlayedOptions = _isPlayedOptions;
@synthesize delegate = _delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    // Must match up with the rows defined at the top
    self.isPlayedOptions = [NSArray arrayWithObjects:@"All", @"Unplayed", @"Played", nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.selectedIsPlayedFilter = nil;
    self.isPlayedOptions = nil;
    self.delegate = nil;
}

#pragma mark - Mapping methods
// Should this be elsewhere?
- (NSString*)mapRowNumberToIsPlayedFilter:(int)rowNumber
{
    switch (rowNumber) {
        case UNPLAYED_ROW: return @"N";    
        case PLAYED_ROW: return @"Y";
        default: return @"";
    }
}

- (int)mapIsPlayedFilterToRowNumber:(NSString*)isPlayed
{
    if ([isPlayed isEqualToString:@"N"]) {
        return UNPLAYED_ROW;
    } 
    else if([isPlayed isEqualToString:@"Y"]) {
        return PLAYED_ROW;
    }
    else {
        return ALL_ROW;
    }
}


#pragma mark - Table view stuff
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    self.selectedIsPlayedFilter = [self mapRowNumberToIsPlayedFilter:indexPath.row];
    //NSLog(@"Row %d selected which translates to %@ is played", indexPath.row, self.selectedIsPlayedFilter);
    
    [self.delegate filterFixturesPlayedViewController:self selectedIsPlayedFilter:self.selectedIsPlayedFilter isPlayedText:[self.isPlayedOptions objectAtIndex:indexPath.row]];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return [self.isPlayedOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"isPlayedFixtureFilterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.isPlayedOptions objectAtIndex:indexPath.row];
    //NSLog(@"SelectedIsPlayedFilter = %@", self.selectedIsPlayedFilter);
    if([[self mapRowNumberToIsPlayedFilter:indexPath.row] isEqualToString:self.selectedIsPlayedFilter])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else 
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
