//
//  NSString+NSDate.m
//  Tbl
//
//  Created by Phil Hale on 20/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "NSString+NSDateTests.h"
#import "NSDate+NSString.h"

@implementation NSString_NSDateTests

#pragma mark - Utility methods
// This would be a good extension method
- (NSDate*)dateWithDay:(int)day month:(int)month year:(int)year
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    return [cal dateFromComponents:comps];
}

#pragma mark - stringWithShortDateFormat

- (void)stringWithShortDateFormat_ValidDate_ReturnsExpectedFormat
{
    NSDate *testDate = [self dateWithDay:6 month:1 year:1980];
    
    STAssertEqualObjects([testDate stringWithShortDateFormat] , @"06/01/1980", @"");
}

- (void)stringWithShortDateFormat_AnotherValidDate_ReturnsExpectedFormat
{
    NSDate *testDate = [self dateWithDay:29 month:10 year:2012];
    
    STAssertEqualObjects([testDate stringWithShortDateFormat] , @"29/10/2012", @"");
}

#pragma mark - stringWithShortDateFormat

- (void)stringWithMonthName_January_ReturnsJanuary
{
    NSDate *testDate = [self dateWithDay:29 month:1 year:2012];
    
    STAssertEqualObjects([testDate stringWithMonthName] , @"January", @"");
}

- (void)stringWithMonthName_December_ReturnsDecember
{
    NSDate *testDate = [self dateWithDay:1 month:12 year:2001];
    
    STAssertEqualObjects([testDate stringWithMonthName] , @"December", @"");
}

#pragma mark - stringWithYear
- (void)stringWithYear_2003_Returns2003
{
    NSDate *testDate = [self dateWithDay:29 month:1 year:2003];
    
    STAssertEqualObjects([testDate stringWithMonthName] , @"2003", @"");
}

#pragma mark - stringWithMonthNameAndYear
- (void)stringWithYear_March2005_ReturnsMarch2005
{
    NSDate *testDate = [self dateWithDay:29 month:3 year:2005];
    
    STAssertEqualObjects([testDate stringWithMonthNameAndYear] , @"March 2005", @"");
}

@end
