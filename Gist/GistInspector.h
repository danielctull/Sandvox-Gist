//
//  GistInspector.h
//  Gist
//
//  Created by Abizer Nasir on 21/04/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <Sandvox.h>


@interface GistInspector : SVInspectorViewController {
@private
    NSTextField *gistIdField;
}
@property (assign) IBOutlet NSTextField *gistIdField;

@end
