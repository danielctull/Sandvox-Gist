//
//  GistPlugIn.h
//  Gist
//
//  Created by Daniel Tull on 11.03.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <Sandvox.h>

@interface GistPlugIn : SVPlugIn {

@private
	NSString *gistID;

}

@property (nonatomic, copy) NSString *gistID;

@end
