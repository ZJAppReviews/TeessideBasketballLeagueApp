//
//  TblArrayOfFixture+NSArray.m
//  Tbl
//
//  Created by Phil Hale on 14/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "NSOrderedSet+TblArrayOfFixture.h"
#import "TblFixtureDto.h"
#import "NSDate+NSString.h"

@implementation NSOrderedSet (TblArrayOfFixtureDto)
+ (NSOrderedSet*)monthsInFixtures:(TblArrayOfFixtureDto*)fixtures
{
    NSMutableOrderedSet *months = [[NSMutableOrderedSet alloc] init];
    NSString *lastMonth = nil;
    
    for (TblFixtureDto *fixture in fixtures) {        
        if(!lastMonth || ![[fixture.FixtureDate stringWithMonthNameAndYear] isEqualToString:lastMonth])
        {
            lastMonth = [fixture.FixtureDate stringWithMonthNameAndYear];
            [months addObject:lastMonth];
        }
    }
    
    //NSLog(@"monthsInFixtures = %@", months);
    
    return months;
}
@end
