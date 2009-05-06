//
//  Multipart.h
//  objectiverest
//
//  Created by Roberto Gamboni on 5/5/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Multipart : NSObject {
	
	NSMutableDictionary*	__formFields;
	NSMutableDictionary*	__fileFields;
	
	NSString*				__boundary;

}

@property(nonatomic, retain) NSString* boundary;

- (void)addString:(NSString *)stringData withFieldName:(NSString *)fieldName;
- (void)addFile:(NSString *)fileName withFieldName:(NSString *)fieldName;

- (NSString*) buildRequestBodyString;
- (NSData*)	  buildRequestBody;

@end
