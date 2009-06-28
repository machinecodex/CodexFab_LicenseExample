CodexFab LicenseExample
=======================

Description:
------------

CodexFab aims to make it simple for you to add automatic Potion Store licensing support to your Cocoa app.

This LicenseExample project demonstrates the code necessary to validate a CocoaFob license code string against an app's private key. It also demonstrates the implementation of one click licensing from a custom URL scheme. All this is wrapped in a customisable, animating Licensing window.

CodexFab is based on CocoaFob, an open source project by Gleb Dolgich that implements secure assymetric DSA key generation and validation in Cocoa and Ruby. CodexFab simply adds a few classes necessary to support CocoaFob in your app. 

CocoaFob and CodexFab are both designed to work with the Potion Store.
<http://github.com/potionfactory/potionstore/tree/master>

Usage:
------

This example application implements a complete solution to licensing a Cocoa app using CocoaFob and Potion Store.

To intgrate CodexFab into your Cocoa app, you will need to follow a these steps.

1. Go and grab the latest build of CocoaFob from <http://github.com/gbd/cocoafob/tree/master> and add the CocoaFob/objc directory to your project.

2. Add the XMLicensing group classes to your app's source and copy it to your Xcode project. (You can do this via drag and drop between Xcode windows.) 

3. Add the code in XMAppDelegate to your app's principal class. Your app delegate or document class needs to register for the XMDidChangeRegistrationNotification and perform a launch check.

4. Make XMAppDelegate+Licensing.m into a category on your app's principal class. This class provides the methods which respond to the XMDidChangeRegistrationNotification, open the licensing window, and verify the license against your public key. By putting it in a category, we can keep these methods logically separate but still globally accessible.

5. Generate DSA keys for your application. This can be easily done using the companion CodexFab application, or by following the manual key generation method outlined in the CocoaFob ReadMe. These keys can be stored anywhere, but it can be handy to keep them in the project folder as we have done here.

6. Include an obfuscated version of your public key in the source code of your app. Edit the - (void) verifyLicense method in  XMAppDelegate+Licensing.m, which uses the AquaticPrime-inspired technique of splitting the public key string into random length sections. Other possibilities here might involve splitting this string across multiple classes.

7. Link to libcrypto as an external framework. In your project, right click on the Frameworks group and select Add > Existing Framework. Type /usr/bin/ to navigate to that folder. Choose "libcrypto 0.9.7.dylib" and click Add. You don't need to copy the dylib to the project folder as it is present on all Macs running OS X 10.2+.

8. Edit global Argument Keys to integrate your app and Potion Store setup. Edit the file XMArgumentKeys.h, paying attention to the TODO comments.

9. Support one-click registration from your Potion Store. Edit your app's Info.plist file to add a CFBundleURLTypes array, substituting your own CFBundleURLScheme to match the one you have set up for your app on Potion Store, as below:

	<key>NSAppleScriptEnabled</key>
	<string>YES</string>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<!-->TODO: update this string to match your potionstore license url scheme<-->
				<string>com.mycompany.example.lic</string>
			</array>
		</dict>
	</array>

10. Copy the MyApp.scriptsuite and MyApp.scriptTerminology files to the resources group of your project. Then open each one and change the "LicenseExample" keys to your app's name.

11. Copy Licensing.xib to your project's resources group and edit in Interface Builder.

12. Test your CodexFab implementation with CodexFab.app and your Potion Store ordering.

See the ReadMe.txt in the CocoaFob group folder for more information on setting up your PotionStore for use with CocoaFob.

DSA Key Notes:
--------------

The included DSA keys are application specific. You will need to generate your own keys, either using the technique discussed in the CocoaFob ReadMe, or by using the CodexFab application.

Important:
----------

Never distribute your dsaparam.pem or privkey.pem file, and always obfuscate your pubkey.pem in your code (See XMAppDelegate+Licensing.m for an example).

Credits:
--------

This project includes code from the following open source projects:

[1] CocoaFob Copyright 2009 by Gleb Dolgich <http://github.com/gbd/cocoafob/tree/master>

[2] MSZLinkedView by Marcus Zarra <http://www.cimgf.com/2008/03/03/core-animation-tutorial-wizard-dialog-with-transitions/>

License:
--------

CodexFab LicenseExample is Copyright © 2009 MachineCodex Software.
CodexFab LicenseExample is released under a Creative Commons Attribution 3.0 License.
<http://creativecommons.org/licenses/by/3.0/>
