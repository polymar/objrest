//
//  NSResource.h
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONDriver.h"

@interface NSResource : NSObject {
	
	id			__object;
	
	NSURL*		__resource_url;
	NSString*	__resource_content_type;
	NSArray*	__resource_accepts;
	
	JSONDriver*	__driver;
	//TODO Caching policy?

}

@property(nonatomic, retain) NSString*	content_type;
@property(nonatomic, retain) NSArray*	accepts;
@property(nonatomic, retain) NSURL*		url;
@property(nonatomic, retain) id			object;

/**
 * Create an instance of resource for a specific instance at a specific uri (local or remote).
 **/
+ (NSResource*) resourceForObject:(id) object url:(NSString*) identifier;

/**
 * Provides the object representation for a specific driver.
 **/
- (NSString*) representation;

- (void) get;
- (void) create;
- (void) update;
- (void) delete;

@end
