//
//  NSString+Helper.m
//  Letter-Pop-Animation-Demo
//
//  Created by Ryan David Forsyth on 2020-09-02.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

- (NSArray<NSString *> *)charArray {
    NSMutableArray *characters = [[NSMutableArray alloc] initWithCapacity:[self length]];
    for (int i=0; i < [self length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [self characterAtIndex:i]];
        [characters addObject:ichar];
    }
    return characters;
}

@end
