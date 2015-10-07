//
//  RefreshTableViewControllerViewController.m
//  Tbl
//
//  Created by Phil Hale on 07/05/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "RefreshTableViewControllerViewController.h"

@interface RefreshTableViewControllerViewController ()
@property (nonatomic, assign) BOOL reloading;
@end

@implementation RefreshTableViewControllerViewController

@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize reloading = _reloading;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.refreshHeaderView = nil;
}

- (void)showWebServiceError
{
    [self doneLoadingTableViewData];
    [super showWebServiceError];
}

#pragma mark - Pull down refresh
- (EGORefreshTableHeaderView*)refreshHeaderView
{
    if(!_refreshHeaderView)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
    }
    return _refreshHeaderView;
}

- (void)reloadTableViewDataSource
{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	self.reloading = YES;
    self.isLoading = YES;
	// MUST BE OVERRIDEN IN SUB CLASS
}

- (void)doneLoadingTableViewData
{
	
	//  model should call this when its done loading
	self.reloading = NO;
    self.isLoading = NO;
	[self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return self.reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
}


@end
