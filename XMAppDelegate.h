//
//  CodexFab LicenseExample
//
// XMAppDelegate.h
//
// App delegate: substitute with your own AppDelegate or main NSDocument class.
// The important thing is to register for the XMDidChangeRegistrationNotification notification.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Based on CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.
// <http://www.machinecodex.com>


#import <Cocoa/Cocoa.h>


@interface XMAppDelegate : NSObject {

}

@end


// Licensing methods have their own Category for clarity

@interface XMAppDelegate (Licensing) 

- (void) launchCheck;
- (IBAction) showLicensingWindow:(id)sender;
- (BOOL) verifyLicense;

@end

