//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import "NSArray+WIAdditions.h"


@implementation NSArray (WIAdditions)

- (NSArray *)map:(id (^)(id in))block
{
    NSMutableArray *temp = [NSMutableArray new];
    for(id item in self){
        [temp addObject:block(item)];
    }
    return temp;
}

@end