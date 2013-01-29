//
//  NSTextField+ZFEnabled.m
//  ZenfolioDownloader
//
//  Created by patrickm on 24-11-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "NSTextField+ZFEnabled.h"


@implementation NSTextField (ZFEnabled)

- (void)setEnabled:(BOOL)enable
{
	[super setEnabled:enable];
	[self setTextColor:enable ? [NSColor blackColor] : [NSColor grayColor]];
}

@end
