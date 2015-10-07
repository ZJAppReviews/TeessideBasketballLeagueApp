//
//  BaseController.h
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TblDataServiceHelper.h"

@interface BaseViewController : UIViewController
@property (nonatomic, readonly, strong) TblDataServiceHelper *tblDataService;
@property (nonatomic, assign) BOOL isLoading; // Controls spinner
@end
