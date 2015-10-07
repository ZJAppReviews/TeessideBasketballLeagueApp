//
//  TblPlayer+NSString.m
//  Tbl
//
//  Created by Phil Hale on 21/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TblPlayer+NSString.h"

@implementation TblPlayer (NSString)

- (NSString*)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.Forename, self.Surname];
}

@end
