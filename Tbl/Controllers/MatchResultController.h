//
//  MatchResultController.h
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseViewController.h"

@interface MatchResultController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) int fixtureId;
@end
