//
//  CodexFab
//
// XMAppDelegate+Licensing.m
//
//  App delegate extension for licensing methods.
//  Pay attention to the TODO: comments below.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Designed to work with CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.


#import "XMAppDelegate.h"
#import "XMLicensingWindowController.h"
#import "XMArgumentKeys.h"
#import "CFobLicVerifier.h"


@implementation XMAppDelegate (Licensing)


- (XMLicensingWindowController *)sharedLicensingWindowController {
	
	return [XMLicensingWindowController sharedLicensingWindowController];
}

- (IBAction)showLicensingWindow:(id)sender {
		
	[[[self sharedLicensingWindowController] window] makeKeyAndOrderFront:self];
}

- (void) launchCheck {
	
	if ([self verifyLicense]) {
		
		NSLog(@"Application is registered.");
		[self sharedLicensingWindowController].isLicensed= YES;
	}
	else {
		
		NSLog(@"Application not registered.");
		[self sharedLicensingWindowController].isLicensed= NO;

		// Perform trial timeout check
	}
}

- (BOOL) verifyLicense {
		
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString * regCode = [defaults valueForKey:kXMRegCode];
	NSString * name = [defaults valueForKey:kXMRegName];
	
	// Here we match CocoaFob's licensekey.rb "productname,username" format
	NSString * regName = [NSString stringWithFormat:@"%@,%@", kXMProductCode, name];
	
	// TODO: Obfuscated public key inspired by AquaticPrime: break up your pubkey.pem and insert it below.
	// Do not use this actual key in your app: it was generated specifically for LicenseExample.app.
	// Don't insert the header or footer text, just the key itself. 
	// Add a "\n" token to represent each pubkey.pem newline.
	NSMutableString *pubKeyBase64 = [NSMutableString string];
	[pubKeyBase64 appendString:@"MIHxMIGoBgcqhkjOOAQBMIGcAkEAlkH"];
	[pubKeyBase64 appendString:@"hqwIttlbDZEK6mOY7s7EBjI/GFhhT/F7m\n"];
	[pubKeyBase64 appendString:@"4eA4vVefuIsdTmA5gBplebQ02"];
	[pubKeyBase64 appendString:@"k8JMPWaP0mV8hCDzcdIHMqrSwIVAPdSrKvB8U59\n"];
	[pubKeyBase64 appendString:@"+7I0X0wfm74v0WTzAkBwKLW3thX3IO"];
	[pubKeyBase64 appendString:@"Po4vjghDX/nHtJG3VXSmCTC7mFpv2nhXuz\n"];
	[pubKeyBase64 appendString:@"blSbboRAlMa/j0kl4vURsuVXlg"];
	[pubKeyBase64 appendString:@"vvWpCpgA0SSf0TA0QAAkEAh5RNl7/OdeCse"];
	[pubKeyBase64 appendString:@"UUY\n"];
	[pubKeyBase64 appendString:@"hnWI5rVfc7g8ZjVydDTnznSaOXB"];
	[pubKeyBase64 appendString:@"FelXJJFERjEK71bA3bzgbUHnS5P4KYBhzJO5G\n"];
	[pubKeyBase64 appendString:@"+wwciQ==\n"];
		
	NSString *publicKey = [CFobLicVerifier completePublicKeyPEM:pubKeyBase64];

	CFobLicVerifier * verifier = [CFobLicVerifier verifierWithPublicKey:publicKey];

	verifier.regName = regName;
	verifier.regCode = regCode;
	NSLog(@"publicKey %@ \n regCode: %@ regName: %@", publicKey, verifier.regCode, verifier.regName);
	 
	if ([verifier verify]) {

		NSLog(@"Yes %@", verifier);
		return YES;
	}
		 
	NSLog(@"No %@", verifier);
	return NO;
}
	 
- (void) registrationChanged:(NSNotification *)notification {
		
	XMLicensingWindowController * licenseWindowController = [self sharedLicensingWindowController];
	[self showLicensingWindow:self];
	
	BOOL isValidLicense = [self verifyLicense];
	
	[licenseWindowController showLicensedStatus:isValidLicense];
}

@end
