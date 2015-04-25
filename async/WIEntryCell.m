//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import "WIEntryCell.h"
#import "WIEntry.h"
#import "ASImageNode.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLResponseSerialization.h"
#import "WIUtil.h"


@interface WIEntryCell ()
@property(nonatomic, strong) ASImageNode *imageNode;
@end

@implementation WIEntryCell

- (id)init {
    self = [super init];
    if (self) {
        ASCellNode *node = [[ASCellNode alloc] init];

        self.imageNode = [[ASImageNode alloc] init];
        self.imageNode.layerBacked = YES;

        [node addSubnode:self.imageNode];
        node.backgroundColor = [UIColor lightGrayColor];
    }

    return self;
}


- (void)setEntry:(WIEntry *)entry {
    _entry = entry;
    WILoadImage(entry.thumbnailURL, ^(UIImage *image, NSError *error){
        self.imageNode.image = image;
        NSLog(@"image: %@", image);
    });

}


- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    return CGSizeMake(160, 160);
}


@end