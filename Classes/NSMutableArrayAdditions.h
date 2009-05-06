//
//  NSMutableArrayAdditions.h
//  SRD
//
//  Created by Roberto Gamboni on 4/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (UtilityAdditions)
/*! In-place reverse of an array. !*/
- (void) reverse;
@end

@interface NSMutableArray (StackAdditions)
/*! Push an object. !*/
- (void) push: (id) anObject;
/*! Pop and return an object. !*/
- (id) pop;
@end

@interface NSMutableArray (QueueAdditions)
/*! Pull and return an object. !*/
- (id) pull;
@end
