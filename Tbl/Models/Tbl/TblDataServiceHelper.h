//
//  TblDataServiceHelper.h
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblObjectImports.h"

@interface TblDataServiceHelper : NSObject
- (TblDataServiceHelper*)initWithErrorTarget:(id)errorTarget errorAction:(SEL)errorAction;

- (BOOL)hasError:(id)value;

- (void)getLatestMatchResults:(id)successTarget successAction:(SEL)successAction numberOfMatchResults:(int)numberOfMatchResults;
- (void)getMatchResult:(id)successTarget successAction:(SEL)successAction fixtureId:(int)fixtureId;
- (void)getStandingsForCurrentSeason:(id)successTarget successAction:(SEL)successAction;
- (void)getTeamsNamesForCurrentSeason:(id)successTarget successAction:(SEL)successAction;
- (void)getTeam:(id)successTarget successAction:(SEL)successAction teamId:(int)teamId;
- (void)getAllPlayerStats:(id)successTarget successAction:(SEL)successAction playerId:(int)playerId;
- (void)getFixturesFiltered:(id)successTarget successAction:(SEL)successAction teamId:(int)teamId isPlayed:(NSString*)isPlayed;
- (void)testError:(id)successTarget successAction:(SEL)successAction;
@end
