//
//  BaseControllerUtils.h
//  Tbl
//
//  Created by Phil Hale on 06/05/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblDataServiceHelper.h"

// A fairly horrible way of encapsulating the common features of
// BaseViewController and BaseTableViewController
@interface BaseControllerCommon : NSObject

- (void)showError;

- (void)showSpinner;
- (void)hideSpinner;
- (void)toggleSpinner:(BOOL)isLoading;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
