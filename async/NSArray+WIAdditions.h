//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WIAdditions)

- (NSArray *)map:(id (^)(id in))block;

@end