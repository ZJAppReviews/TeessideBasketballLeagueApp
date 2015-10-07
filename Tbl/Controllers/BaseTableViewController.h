//
//  BaseController.h
//  Tbl
//
//  Created by Phil Hale on 03/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TblDataServiceHelper.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseTableViewController : UITableViewController
@property (nonatomic, readonly, strong) TblDataServiceHelper *tblDataService;
@property (nonatomic, assign) BOOL isLoading; // Controls spinner

- (void)showWebServiceError;
@end
