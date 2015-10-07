//
//  TblDataStore.m
//  Tbl
//
//  Created by Phil Hale on 11/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TblDataStore.h"

#define FIXTURE_FILTER_TEAM_ID_KEY @"fixtureFilterTeamId"
#define FIXTURE_FILTER_TEAM_NAME_KEY @"fixtureFilterTeamName"
#define FIXTURE_FILTER_IS_PLAYED_KEY @"fixtureFilterIsPlayed"
#define FIXTURE_FILTER_IS_PLAYED_TEXT_KEY @"fixtureFilterIsPlayedText"

@implementation TblDataStore

+ (NSUserDefaults*)getNSUserDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - Set
+ (void)saveFixtureFiltersTeamId:(int)teamId teamName:(NSString*)teamName isPlayed:(NSString*)isPlayed isPlayedText:(NSString*)isPlayedText
{
    NSUserDefaults *defaults = [self getNSUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:teamId] forKey:FIXTURE_FILTER_TEAM_ID_KEY];
    [defaults setObject:teamName forKey:FIXTURE_FILTER_TEAM_NAME_KEY];
    [defaults setObject:isPlayed forKey:FIXTURE_FILTER_IS_PLAYED_KEY];
    [defaults setObject:isPlayedText forKey:FIXTURE_FILTER_IS_PLAYED_TEXT_KEY];
    [defaults synchronize];
}

#pragma mark - Get
+ (int)getFixtureFilterTeamId
{
    NSUserDefaults *defaults = [self getNSUserDefaults];
    NSNumber *teamId  = (NSNumber*)[defaults objectForKey:FIXTURE_FILTER_TEAM_ID_KEY];
    return [teamId intValue];
}

+ (NSString*)getFixtureFilterTeamName
{
    NSUserDefaults *defaults = [self getNSUserDefaults];
    NSString *teamName = (NSString*)[defaults objectForKey:FIXTURE_FILTER_TEAM_NAME_KEY];
    
    if(teamName)
        return teamName;
    else
        return @"All"; // Really really really don't like this as it totally breaks encapsulation but can't think of a better way
}

+ (NSString*)getFixtureFilterIsPlayed
{
    NSUserDefaults *defaults = [self getNSUserDefaults];
    NSString *isPlayed = (NSString*)[defaults objectForKey:FIXTURE_FILTER_IS_PLAYED_KEY];
    
    if(isPlayed)
        return isPlayed;
    else
        return @"N";
}

+ (NSString*)getFixtureFilterIsPlayedText
{
    NSUserDefaults *defaults = [self getNSUserDefaults];
    NSString *isPlayedText = (NSString*)[defaults objectForKey:FIXTURE_FILTER_IS_PLAYED_TEXT_KEY];
    
    if(isPlayedText)
        return isPlayedText;
    else
        return @"Unplayed"; // Again this burns my eyes
}

@end
