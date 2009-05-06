//
//  Story.h
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObjectRuntimeAdditions.h"

@interface Story : NSObject {
	
	NSMutableString* summary;
	NSMutableString* content;
	NSString*		 author;
	NSDate*			 published;
	NSArray*		 tags;
	
}

@property(nonatomic, retain) NSMutableString* summary;
@property(nonatomic, retain) NSMutableString* content;
@property(nonatomic, retain) NSString*		  author;
@property(nonatomic, retain) NSDate*		  published;
@property(nonatomic, retain) NSArray*		  tags;

@end
