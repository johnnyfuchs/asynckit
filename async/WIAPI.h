//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

@import Foundation;

#import "AFHTTPSessionManager.h"

@interface WIAPI : NSObject

+ (void)callMethod:(NSString *)method
              path:(NSString *)path
            params:(NSDictionary *)params
              done:(void (^)(NSURLSessionDataTask *, id JSON, NSError *error))done;

@end