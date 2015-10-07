//
//  NSString+TblFixture.h
//  Tbl
//
//  Created by Phil Hale on 19/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblTeam.h"

@interface NSString (TblTeam)

+ (NSString*)stringWithNiceMultiLineTeamAddress:(TblTeam*)team;

@end
