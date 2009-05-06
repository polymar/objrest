//
//  NSMutableArrayAdditions.m
//  SRD
//
//  Created by Roberto Gamboni on 4/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import "NSMutableArrayAdditions.h"

@implementation NSMutableArray (UtilityAdditions)
- (void)reverse
{
	for (int i=0; i<(floor([self count]/2.0)); i++)
		[self exchangeObjectAtIndex:i withObjectAtIndex:([self count]-(i+1))];
}
@end


@implementation NSMutableArray (StackAdditions)
- (id)pop
{
    id lastObject = [[[self lastObject] retain] autorelease];
    [self removeLastObject];
    return lastObject;
}

- (void)push:(id)object
{
    [self addObject:object];
}
@end

@implementation NSMutableArray (QueueAdditions)
- (id) pull
{
	id firstObject = [[[self objectAtIndex:0] retain] autorelease];
	[self removeObjectAtIndex:0];
	return firstObject;
}
@end
