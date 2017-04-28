//
//  BIDFourLines.m
//  kliii
//
//  Created by yzk on 14-7-24.
//  Copyright (c) 2014年 cooperLink. All rights reserved.
//

#import "BIDFourLines.h"

static NSString * const kLinesKey = @"kLinesKey";

@implementation BIDFourLines

#pragma mark - Coding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark - Copying

- (id)copyWithZone:(NSZone *)zone
{
    BIDFourLines *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}

@end

