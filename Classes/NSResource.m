//
//  NSResource.m
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import "NSResource.h"

static NSString* DEFAULT_ACCEPT = @"application/json";
static NSString* DEFAULT_CONTENT_TYPE = @"application/json";

@interface NSResource ()
/*! init the resource setting the wrapped object and the uri. !*/
- (id) initWithObject:(id) obj url:(NSString*) identifier;

/*! serialize the wrapped object using the available driver. !*/
- (NSString*) serialize;

/*! extract and set properties to the wrapped object. !*/
- (int) deserialize:(NSString*) properties; 

@end


@implementation NSResource

@synthesize accepts =		__resource_accepts;
@synthesize content_type =	__resource_content_type;
@synthesize url =			__resource_url;
@synthesize object =		__object;

/**
 * Create an instance of resource for a specific instance at a specific uri (local or remote).
 **/
+ (NSResource*) resourceForObject:(id) object url:(NSString*) identifier {
	return [[[NSResource alloc] initWithObject:object url:identifier] autorelease];
}

/*! init the resource setting the wrapped object and the uri. !*/
- (id) initWithObject:(id) obj url:(NSString*) identifier {
	NSLOGFUN();
	self = [super init];
	if(self) {
		self.object = obj;
		self.url = [NSURL URLWithString:identifier];
		self.accepts = [NSArray arrayWithObject:DEFAULT_ACCEPT];
		self.content_type = DEFAULT_CONTENT_TYPE;
	}
	return self;
}

/*! serialize the wrapped object using the available driver. !*/
- (NSString*) serialize {
	NSLOGFUN();
	if(__object) {
		__driver = [[JSONDriver alloc] init];
		NSError** error = nil;
		NSString* serialized = [__driver stringWithObject:[__object properties] error:error];
		[__driver release];
		if(error) {
			NSLog(@"Error during object serialization: ", error);
			return nil;
		}
		return serialized;
	}
	return [self description];
}

/*! extract and set properties to the wrapped object. !*/
- (int) deserialize:(NSString*) properties {
	if(__object) {
		
	}
	return 0;
}

/**
 * Provides the object representation for a specific driver.
 **/
- (NSString*) representation {
	return [self serialize];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSLOGFUN();
	if([__object respondsToSelector:[anInvocation selector]]) {
		[anInvocation invokeWithTarget:__object];
	} else {
		[super forwardInvocation:anInvocation];
	}
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSLOGFUN();
	if(__object)
		return [__object methodSignatureForSelector:aSelector];
	return [super methodSignatureForSelector:aSelector];
}

/**
 * Dynamically provides an implementation for a given selector for a class method.
 **/
/*
+ (BOOL)resolveClassMethod:(SEL)name {
	NSLOGFUN();
	return NO;
}
*/

/**
* Dynamically provides an implementation for a given selector for an instance method.
**/
/*
+ (BOOL)resolveInstanceMethod:(SEL)name {
	NSLOGFUN();
	return NO;
}
*/

- (void) get {
	NSLOGFUN();
}

- (void) create {
	NSLOGFUN();
}

- (void) update {
	NSLOGFUN();
}

- (void) delete {
	NSLOGFUN();
}

- (void) dealloc {
	[__object release];
	[__resource_url release];
	[__resource_accepts release];
	[__resource_content_type release];
	[super dealloc];
}

@end
