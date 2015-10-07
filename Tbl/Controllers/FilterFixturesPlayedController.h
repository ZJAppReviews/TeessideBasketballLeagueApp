//
//  FilterFixturesPlayedController.h
//  Tbl
//
//  Created by Phil Hale on 11/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseTableViewController.h"

@class FilterFixturesPlayedController;

@protocol FilterFixturesPlayedControllerDelegate <NSObject>

- (void)filterFixturesPlayedViewController:(FilterFixturesPlayedController *)sender
              selectedIsPlayedFilter:(NSString*)isPlayedFilter
                        isPlayedText:(NSString*)isPlayedText;

@end

@interface FilterFixturesPlayedController : BaseTableViewController

@property (nonatomic, strong) NSString* selectedIsPlayedFilter;
@property (nonatomic, weak) id <FilterFixturesPlayedControllerDelegate> delegate;

@end
