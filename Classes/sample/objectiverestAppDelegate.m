//
//  objectiverestAppDelegate.m
//  objectiverest
//
//  Created by Roberto Gamboni on 3/6/09.
//  Copyright Roberto Gamboni 2009. All rights reserved.
//

#import "objectiverestAppDelegate.h"

@implementation objectiverestAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
