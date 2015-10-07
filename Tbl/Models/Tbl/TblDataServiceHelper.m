//
//  TblDataServiceHelper.m
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "TblDataServiceHelper.h"
#import "TblTblDataService.h"

#define TBL_WEB_SERVICE_USERNAME @"tblwebservice"
#define TBL_WEB_SERVICE_PASSWORD @"JpVw#41m"

@interface TblDataServiceHelper()
@property (nonatomic, strong) TblTblDataService *tblDataService;

// The four properties below are used to kind of "intercept" the web service calls
// Controller passes in "success" method to call. This calls the actuall web service
// method with the checkForError method which tests the returned value and calls
// the error or success selectors appropriately
// I have a small feeling that this make break if several cals are made in quick
// succession with the same instance, but I'll see how it goes
@property (nonatomic, strong) id errorTarget;
@property (nonatomic, assign) SEL errorAction;
@property (nonatomic, strong) id successTarget;
@property (nonatomic, assign) SEL successAction;
@end

// TODO Do I need to set tblDataService to nil in a deconstructor??
@implementation TblDataServiceHelper

@synthesize tblDataService = _tblDataService;
@synthesize errorTarget = _errorTarget;
@synthesize errorAction = _errorAction;
@synthesize successTarget = _successTarget;
@synthesize successAction = _successAction;

- (TblDataServiceHelper*)initWithErrorTarget:(id)errorTarget errorAction:(SEL)errorAction;
{
    TblDataServiceHelper *helper = [self init];
    helper.errorTarget = errorTarget;
    helper.errorAction = errorAction;
    return helper;
}

- (TblTblDataService*)tblDataService
{
    _tblDataService = [TblTblDataService service];        
    _tblDataService.username = TBL_WEB_SERVICE_USERNAME;
    _tblDataService.password = TBL_WEB_SERVICE_PASSWORD;
    _tblDataService.logging = NO;
    
    return _tblDataService;
}

- (BOOL)hasError:(id)value
{
    // Handle errors and faults
	if([value isKindOfClass:[NSError class]] || [value isKindOfClass:[SoapFault class]]) {
		//NSLog(@"%@", value);
		return YES;
	}
    
	return NO;
}

#pragma mark - Web service methods
// succcessTarget and errorTarget MUST be set otherwise the calls will not work at all

-(void)checkForError:(id)value
{
    if(![self hasError:value])
        [self.successTarget performSelector:self.successAction withObject:value];
    else
        [self.errorTarget performSelector:self.errorAction];
}

- (void)getLatestMatchResults:(id)successTarget successAction:(SEL)successAction numberOfMatchResults:(int)numberOfMatchResults
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetLatestMatchResults:self action:@selector(checkForError:) numberOfMatchResults: numberOfMatchResults];

}

- (void)getMatchResult: (id)successTarget successAction:(SEL)successAction fixtureId:(int)fixtureId
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetMatchResult:self action:@selector(checkForError:) fixtureId:fixtureId];
}

- (void)getStandingsForCurrentSeason:(id)successTarget successAction:(SEL)successAction
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetStandingsForCurrentSeason:self action:@selector(checkForError:)];
}

- (void)getTeamsNamesForCurrentSeason:(id)successTarget successAction:(SEL)successAction
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetTeamsNamesForCurrentSeason:self action:@selector(checkForError:)];
}

- (void)getTeam:(id)successTarget successAction:(SEL)successAction teamId:(int)teamId
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetTeam:self action:@selector(checkForError:) id:teamId];
}

- (void)getAllPlayerStats:(id)successTarget successAction:(SEL)successAction playerId:(int)playerId
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetAllPlayerStats:self action:@selector(checkForError:) id:playerId];
}

- (void)getFixturesFiltered:(id)successTarget successAction:(SEL)successAction teamId:(int)teamId isPlayed:(NSString*)isPlayed
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService GetFixturesFiltered:self action:@selector(checkForError:) teamId:teamId isPlayed:isPlayed];
}

- (void)testError:(id)successTarget successAction:(SEL)successAction
{
    self.successTarget = successTarget;
    self.successAction = successAction;
    [self.tblDataService TestError: self action:@selector(checkForError:)];
}


@end
