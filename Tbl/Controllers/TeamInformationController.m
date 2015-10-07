//
//  TeamInformationController.m
//  Tbl
//
//  Created by Phil Hale on 18/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TeamInformationController.h"
#import "NSString+TblTeam.h"

@interface TeamInformationController()

@property (nonatomic, strong) TblTeam *team;

// Outlets
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *contactEmail;
@property (weak, nonatomic) IBOutlet UILabel *contactPhone;
@property (weak, nonatomic) IBOutlet UILabel *venueAddress;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressCell;

@end


// TODO Find nice way of setting label width
@implementation TeamInformationController

@synthesize contactName = _contactName;
@synthesize contactEmail = _contactEmail;
@synthesize contactPhone = _contactPhone;
@synthesize venueAddress = _venueAddress;
@synthesize teamName = _teamName;
@synthesize addressCell = _addressCell;

@synthesize teamId = _teamId;
@synthesize team = _team;

- (void)setTeamId:(int)teamId
{
    if(teamId != _teamId)
    {
        _teamId = teamId;
        [self.tblDataService getTeam:self successAction:@selector(getTeamSuccessHandler:) teamId:teamId];
        self.isLoading = YES;
    }
}

#pragma mark - Web service handler
- (void)getTeamSuccessHandler:(id)value
{
//    if(!self.view.window)
//    {
//        [self hideSpinner];
//        return;
//    }
    
    TblTeam *team = (TblTeam*)value;
    
    self.teamName.text = team.TeamName;
    self.contactName.text = [NSString stringWithFormat:@"%@ %@", team.TeamContact1Forename, team.TeamContact1Surname];
    self.contactEmail.text = team.TeamContact1Email;
    self.contactPhone.text = [NSString stringWithFormat:@"%@ %@", team.TeamContact1ContactNumber1, team.TeamContact1ContactNumber2];

    self.venueAddress.text = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    //NSLog(@"label width = %@ %@", team.Venue, team.AddressPostCode);
    //NSLog(@"label width = %f", self.contactName.frame.size.width);
    
    CGSize addressCellSize = self.addressCell.frame.size;
    int heightDifferenceBetweenCellAndLabel = addressCellSize.height - self.venueAddress.frame.size.height;
    
    CGSize maximumLabelSize = CGSizeMake(296,9999);
    // TODO Create some kind of frame utils for making this stuff quicker
    CGSize expectedLabelSize = [self.venueAddress.text sizeWithFont:self.venueAddress.font 
                                      constrainedToSize:maximumLabelSize 
                                          lineBreakMode:self.venueAddress.lineBreakMode]; 
    
    int labelHeightIncrease = expectedLabelSize.height - self.venueAddress.frame.size.height;
    
    // Calc cell frame size for increased label height
    CGRect newAddressCellFrame = self.addressCell.frame;
    newAddressCellFrame.size.height = expectedLabelSize.height + heightDifferenceBetweenCellAndLabel;
    self.addressCell.frame = newAddressCellFrame;
    
    //adjust the label the the new height.
    CGRect newFrame = self.venueAddress.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.venueAddress.frame = newFrame;
    
    // Increase the table view frame size
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + labelHeightIncrease);
        
    self.isLoading = NO;
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setContactName:nil];
    [self setContactEmail:nil];
    [self setContactPhone:nil];
    [self setVenueAddress:nil];
    [self setAddressCell:nil];
    [self setTeamName:nil];
    [super viewDidUnload];
    self.team = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


@end
