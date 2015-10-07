//
//  FilterFixturesController.h
//  Tbl
//
//  Created by Phil Hale on 09/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseTableViewController.h"

@class FilterFixturesController;

@protocol FilterFixturesControllerDelegate <NSObject>

- (void)saveFiltersFilterFixturesController:(FilterFixturesController *)sender
                    selectedTeamIdFilter:(int)teamIdFilter
                              selectedIsPlayedFilter:(NSString*)isPlayedFilter;

@end

@interface FilterFixturesController : BaseTableViewController

@property (nonatomic, strong) id <FilterFixturesControllerDelegate> delegate;

@end
