//
//  NSString_TblTeamTests.m
//  Tbl
//
//  Created by Phil Hale on 19/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "NSString_TblTeamTests.h"
#import "NSString+TblTeam.h"

@implementation NSString_TblTeamTests

TblTeam* team;

- (void)setUp
{
    [super setUp];
    
    team = [[TblTeam alloc] init];
}

- (void)test_stringWithNiceMultiLineTeamAddress_VenueNil_ReturnsEmptySTring
{
    team.Venue = nil;
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    STAssertEqualObjects(result, @"", @"");
}

- (void)test_stringWithNiceMultiLineTeamAddress_VenueEmptyString_ReturnsEmptySTring
{
    team.Venue = @"";
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    STAssertEqualObjects(result, @"", @"");
}

- (void)test_stringWithNiceMultiLineTeamAddress_VenueOnly_ReturnsVenue
{
    team.Venue = @"Gym";
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
        
    STAssertEqualObjects(result, @"Gym", @"");
}

- (void)test_stringWithNiceMultiLineTeamAddress_VenueAndLine1_ReturnsCorrectString
{
    team.Venue = @"Gym";
    team.AddressLine1 = @"1 Willow Road";
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    STAssertEqualObjects(result, @"Gym\n1 Willow Road", @"");
}

- (void)test_stringWithNiceMultiLineTeamAddress_Line1AndTown_ReturnsCorectString
{
    team.AddressLine1 = @"1 Willow Road";
    team.AddressTown = @"Kidderminster";
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    NSLog(@"resut = %@", result);
    
    STAssertEqualObjects(result, @"1 Willow Road\nKidderminster", @"");
}

- (void)test_stringWithNiceMultiLineTeamAddress_AllFields_ReturnsCorrectString
{
    team.Venue = @"Place";
    team.AddressLine1 = @"1 Willow Road";
    team.AddressLine2 = @"2";
    team.AddressLine3 = @"3";
    team.AddressTown = @"Kidderminster";
    team.AddressCounty = @"Durham";
    team.AddressPostCode = @"DH1 4HH";
    
    NSString *result = [NSString stringWithNiceMultiLineTeamAddress:team];
    
    NSLog(@"resut = %@", result);
    
    STAssertEqualObjects(result, @"Place\n1 Willow Road\n2\n3\nKidderminster\nDurham\nDH1 4HH", @"");
}

@end
