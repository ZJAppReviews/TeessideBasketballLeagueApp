//
//  TblDataStore.h
//  Tbl
//
//  Created by Phil Hale on 11/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TblDataStore : NSObject
+ (void)saveFixtureFiltersTeamId:(int)teamId teamName:(NSString*)teamName isPlayed:(NSString*)isPlayed isPlayedText:(NSString*)isPlayedText
;
+ (int)getFixtureFilterTeamId;
+ (NSString*)getFixtureFilterTeamName;
+ (NSString*)getFixtureFilterIsPlayed;
+ (NSString*)getFixtureFilterIsPlayedText;
@end
