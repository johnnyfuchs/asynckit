//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WSELF __weak typeof(self) wself = self
#define SSELF __strong typeof(self) sself = wself

@interface WIUtil : NSObject
@end