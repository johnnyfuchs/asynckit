//
//  ViewController.m
//  async
//
//  Created by Johnny Sparks on 4/22/15.
//  Copyright (c) 2015 We Heart It. All rights reserved.
//


#import "ViewController.h"
#import "WIEntryListView.h"
#import "WIEntry.h"
#import "WIUtil.h"


@interface ViewController ()
@property(nonatomic, strong) WIEntryListView *listView;
@property(nonatomic, strong) NSURL *nextPageURL;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.listView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.listView.frame = self.view.bounds;
}

- (WIEntryListView *)listView {
    if(!_listView){
        WSELF;
        _listView = [[WIEntryListView alloc] initWithFrame:self.view.bounds];
        _listView.onPage = ^(BOOL shouldRefresh, void (^complete)()){

            [WIEntry trendingEntries:wself.nextPageURL done:^(NSArray *entries, NSURL *nextPage, NSError *error) {
                [wself.listView addEntries:entries];
                wself.nextPageURL = nextPage;
                complete();
            }];
        };
        [_listView loadEntries];
    }
    return _listView;
}


@end