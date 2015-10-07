//
//  TblObjectImports.h
//  
//  This header exists purely so TblTblDataService isn't exposed
//  to the controllers. They should only use TblDataServiceHelper.
//  This file will need to be updated when new objects are added
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TblDayOfWeek.h"
#import "TblArrayOfTeam.h"
#import "TblArrayOfNews.h"
#import "TblEntity.h"
#import "TblArrayOfPlayerSeasonFixtureStatsDto.h"
#import "TblArrayOfPlayerCareerStatsDto.h"
#import "TblArrayOfTeamLeagueDto.h"
#import "TblArrayOfDivisionStandingsDto.h"
#import "TblLeagueStandingsDto.h"
#import "TblArrayOfTeamNameDto.h"
#import "TblArrayOfPlayerFixtureDto.h"
#import "TblArrayOfFixtureDto.h"
#import "TblFixtureDto.h"
#import "TblTeam.h"
#import "TblDivisionStandingsDto.h"
#import "TblTeamNameDto.h"
#import "TblNews.h"
#import "TblPlayerStatsDto.h"
#import "TblMatchResultDto.h"
#import "TblPlayerSeasonFixtureStatsDto.h"
#import "TblPlayer.h"
#import "TblPlayerCareerStatsDto.h"
#import "TblTeamLeagueDto.h"
#import "TblPlayerFixtureDto.h"

@interface TblObjectImports : NSObject

@end
