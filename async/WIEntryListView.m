//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import "WIEntryListView.h"
#import "WIEntry.h"
#import "AFHTTPRequestOperation.h"
#import "WIEntryCell.h"

@interface WIEntryListView () <ASCollectionViewDelegate, ASCollectionViewDataSource>
@property (nonatomic, strong) ASCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *entries;
@property(nonatomic) BOOL loading;
@end

@implementation WIEntryListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat diameter = CGRectGetWidth(frame) / 2;
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.itemSize = CGSizeMake(diameter, diameter);

        self.collectionView = [[ASCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        self.collectionView.asyncDataSource = self;
        self.collectionView.asyncDelegate = self;
        [self addSubview:self.collectionView];
        [self clearEntries];
    }

    return self;
}

- (void)loadEntries
{
    if(self.onPage && !self.loading){
        self.loading = YES;
        self.onPage(NO, ^{
            self.loading = NO;
        });
    }
}

- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WIEntry *entry = self.entries[indexPath.row];
    WIEntryCell *node = [[WIEntryCell alloc] init];
    node.entry = entry;
    return node;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.entries.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayNodeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}


- (void)collectionViewLockDataSource:(ASCollectionView *)collectionView
{
    // lock the data source
    // The data source should not be change until it is unlocked.
}

- (void)collectionViewUnlockDataSource:(ASCollectionView *)collectionView
{
    // unlock the data source to enable data source updating.
}

- (void)addEntries:(NSArray *)entries {
    [self.entries addObjectsFromArray:entries];
    [self.collectionView reloadData];
}

- (void)clearEntries {
    self.entries = [NSMutableArray new];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f", self.collectionView.contentSize.height);
//    NSLog(@"%f", self.collectionView.contentOffset.y);
    if(self.isAtBottom){
        [self loadEntries];
    }
}

- (BOOL) isAtBottom
{
    return self.collectionView.contentSize.height * 0.8 < self.collectionView.contentOffset.y;
}

@end