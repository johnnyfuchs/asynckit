//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

@import Foundation;
@import UIKit;

#import "AsyncDisplayKit/AsyncDisplayKit.h"


@interface WIEntryListView : UIView

@property (nonatomic, copy) void (^onPage)(BOOL shouldRefresh, void (^complete)());

- (void)loadEntries;

- (void)addEntries:(NSArray *)entries;

- (void)clearEntries;

@end