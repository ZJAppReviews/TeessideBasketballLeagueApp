//
//  RefreshTableViewControllerViewController.h
//  Tbl
//
//  Created by Phil Hale on 07/05/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseTableViewController.h"

@interface RefreshTableViewControllerViewController : BaseTableViewController <EGORefreshTableHeaderDelegate>
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;

- (void)reloadTableViewDataSource; // Must be implemented and called for subview to implement refresh
- (void)doneLoadingTableViewData; // Must be called for subview to implement refresh
@end
