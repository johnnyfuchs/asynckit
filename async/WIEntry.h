//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WIEntry : NSObject

@property (nonatomic) NSInteger uid;
@property (nonatomic, copy) NSURL *thumbnailURL;

+ (void)trendingEntries:(NSURL *)nextPageOrNil done:(void(^)(NSArray *entries, NSURL *nextPage, NSError *error))done;

@end