//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import "WIEntry.h"
#import "WIAPI.h"
#import "NSArray+WIAdditions.h"


@implementation WIEntry

+ (instancetype)entryFromDict:(NSDictionary *)dict
{
    WIEntry *entry = [WIEntry new];
    entry.thumbnailURL = [NSURL URLWithString:dict[@"media"][2][@"url"]];
    entry.uid = [dict[@"id"] integerValue];
    return entry;
}

+ (void)trendingEntries:(NSURL *)nextPageOrNil done:(void (^)(NSArray *entries, NSURL *nextPage, NSError *error))done
{
    [WIAPI callMethod:@"GET"
                 path:@"api/v2/entries"
               params:nil
                 done:^(NSURLSessionDataTask *task, id JSON, NSError *error) {
                     if(error){
                         done(nil, nil, error);
                         return;
                     }

                     NSURL *next = [NSURL URLWithString:JSON[@"meta"][@"next_page_url"]];

                     NSArray *entries = [JSON[@"entries"] map:^id(id entryDict) {
                         return [self entryFromDict:entryDict];
                     }];

                     done(entries, next, nil);
                 }];
}

@end