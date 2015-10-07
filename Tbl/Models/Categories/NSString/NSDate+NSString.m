//
//  NSString+NSDate.m
//  Tbl
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "NSDate+NSString.h"

@implementation NSDate (NSString)
- (NSString*)stringWithShortDateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    return [formatter stringFromDate:self];
}

- (NSString*)stringWithMonthName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    return [formatter stringFromDate:self];
}

- (NSString*)stringWithYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY"];
    return [formatter stringFromDate:self];
}

- (NSString*)stringWithMonthNameAndYear
{
    return [NSString stringWithFormat:@"%@ %@", [self stringWithMonthName], [self stringWithYear]];
}
@end
