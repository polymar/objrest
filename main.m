//
//  main.m
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Additions.h"
#import "Story.h"
#import "NSResource.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	/*************--Creating a fake story--*************************/
	Story* s = [[Story alloc] init];
	s.summary = @"this is the summary";
	s.content = @"content... way longer than this.";
	s.published = [NSDate date];
	s.author = @"Polymar";
	s.tags = [NSArray arrayWithObjects:@"openovo", @"pages", @"waves", nil];
	
	/*************--Inspecting the object--*************************/
	NSDictionary* prop = [Story propertyNamesAndTypes];
	NSLog(@"%@", prop);
	NSLog(@"******************");
	NSDictionary* values = [s properties];
	NSLog(@"%@", values);
	NSLog(@"%@", [s className]);
	
	/*************--Creating a resource object--*************************/
	NSResource* resource = [NSResource resourceForObject:s url:@"/story"];
	[resource get];
	//...manipulate
	[resource update];
	NSLog(@"%@", [resource representation]);
	
	int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
