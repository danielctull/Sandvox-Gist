//
//  GistPlugIn.m
//  Gist
//
//  Created by Daniel Tull on 11.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "GistPlugIn.h"


@implementation GistPlugIn

@synthesize gistID;

- (void)dealloc {
	[gistID release], gistID = nil;
	[super dealloc];
}

@end
