//
//  NSString+NSDate.h
//  Tbl
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSString)
- (NSString*)stringWithShortDateFormat;
- (NSString*)stringWithMonthName;
- (NSString*)stringWithMonthNameAndYear;
@end
