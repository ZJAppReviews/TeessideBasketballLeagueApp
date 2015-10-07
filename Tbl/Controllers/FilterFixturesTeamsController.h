//
//  FilterFixturesTeamsController.h
//  Tbl
//
//  Created by Phil Hale on 10/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseViewController.h"

@class FilterFixturesTeamsController;

@protocol FilterFixturesTeamsControllerDelegate <NSObject>

- (void)filterFixturesTeamsViewController:(FilterFixturesTeamsController *)sender
             selectedTeamId:(int)teamId
               selectedTeamName:(NSString *)teamName;
@end

@interface FilterFixturesTeamsController : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int selectedTeamId;
@property (nonatomic, weak) id <FilterFixturesTeamsControllerDelegate> delegate;

@end
