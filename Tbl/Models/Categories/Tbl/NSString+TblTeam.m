//
//  NSString+TblFixture.m
//  Tbl
//
//  Created by Phil Hale on 19/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "NSString+TblTeam.h"

@implementation NSString (TblTeam)

+ (NSString*)stringWithNiceMultiLineTeamAddress:(TblTeam*)team
{
    NSMutableArray *addressParts = [[NSMutableArray alloc] init];
    // Can't use addWithObjects because one of the passed objects may be nil
    if(team.Venue) [addressParts addObject:team.Venue];
    if(team.AddressLine1) [addressParts addObject:team.AddressLine1];
    if(team.AddressLine2) [addressParts addObject:team.AddressLine2];
    if(team.AddressLine3) [addressParts addObject:team.AddressLine3];
    if(team.AddressTown) [addressParts addObject:team.AddressTown];
    if(team.AddressCounty) [addressParts addObject:team.AddressCounty];
    if(team.AddressPostCode) [addressParts addObject:team.AddressPostCode];    
    
    //NSLog(@"Array size = %d", [addressParts count]);
    NSMutableString *multiLineAddress = [[NSMutableString alloc] init];
    for (NSString *addressPart in addressParts) {
        
        NSString *addressPartTrimmed = [addressPart stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if(addressPartTrimmed && [addressPartTrimmed length] > 0)
        {
            if([multiLineAddress length] > 0) [multiLineAddress appendString:@"\n"];
            
            [multiLineAddress appendString:addressPartTrimmed];
        }
    }
    
    return multiLineAddress;
}

@end
