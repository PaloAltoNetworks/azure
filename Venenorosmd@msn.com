Skip to content
 
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 @therealcurlsport
Sign out
Your account has been flagged.
Because of that, your profile is hidden from the public. If you believe this is a mistake, contact support to have your account status reviewed.
0
0 1 therealcurlsport/AzurWay-ios
forked from Pixelium/AzurWay-ios
 Code  Pull requests 0  Projects 0  Wiki  Insights  Settings
AzurWay driver app SDK http://www.azurwaymobility.fr/
 7 commits
 2 branches
 0 releases
 0 contributors
 Pull request   Compare This branch is even with Pixelium:master.
Pierre Moulonguet | MBP
Pierre Moulonguet | MBP 1.0.5
Latest commit 7329a39  on Jan 24, 2017
Type	Name	Latest commit message	Commit time
Specs/AzurWaySdk	1.0.5	2 years ago
README.md	1.0.4	2 years ago
 README.md
#AzurWay SDK

##How to install

Add this line to you Podfile

pod 'AzurWaySdk'

then, juste type : $ pod install

You can find a demo app here : https://github.com/Pixelium/AzurWay-ios-demo

##How to configure

First, set the SDK public and secret key in the - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions function

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [[AzurWaySdk sharedInstance] setTokken:@"YOUR_TOKEN" andDepartureLocation:(CLLocation *) departurePosition]];

  return YES;
}
Display the booking interface
First set the SDK Options, then, use this function to launch the SDK in the selected ViewController
- (void) launchBooking {
  AzurWaySdkOptions *options = [[AzurWaySdkOptions alloc] init];
  
  
   
  [options setType : (AWTypeEnum)(Booking | Activity | Airport)];,
  [options setNow : (Bool)];
  [options setPayment : (Bool)]; // Redirect to payment if necessary
  [options setArrivalDate : (NSDate *)]; // Mandatory if now == false
  [options setDestination : (CLLocation *)]; // Mandatory if activity or airport
  [options setLanguageCode : (NSString *)]; // "fr", "en", etc...
  [options setHotelName : (NSString *)];
  [options setHotelPhone : (NSString *)];

  // For Airport or activity destination, pass the destination GPS coordinates 
  [options setDestinationLocation:(CLLocation *)destinationCoord];
  

  [[AzurWaySdk sharedInstance] launchBookingFrom:(ViewController *)containerVC withOptions:(AzurWaySdkOptions *)options]];

}
Display the My Order screen
First set the SDK Options, then, use this function to launch the SDK in the selected ViewController
- (void) launchBooking {
  AzurWaySdkOptions *options = [[AzurWaySdkOptions alloc] init];
  
  [[AzurWaySdk sharedInstance] launchMyOrderFrom:(ViewController *)containerVC withOptions:(AzurWaySdkOptions *)options]];
}
AzurWaySDKOptions parameters lists
Function	Type	Description
setType	AWTypeEnum	Order type (Booking / Activity / Airport)
setNow	BOOL	Boolean if booking now
setPayment	BOOL	if you need redirection to the payment screen
setArrivalDate	NSDate	needed arrival date
setDestination	CLLocation	destination coordinates
setPaymentViewController	UIViewController	PaymentViewController
setLanguageCode	NSString	"fr", "en", etc...
setHotelName	NSString	hotel name
setHotelPhone	NSString	hotel phone number
---	---	---
AzurWaySDKOptions language list
Since the version 1.0.2, you can change the sdk language by setting the AzurWaySDKOptions languageCode with the following codes : Here is the list of the language availiable (and their code) :

french (fr)
english (en)
dutch (nl)
japanese (ja)
spanish (es)
russian (ru)
portugese (pt-PT)
korean (ko)
italian (it)
german (de)
chinese (trad.) (zh-Hant)
AzurWaySdkPaymentDelegate
- (void) initWithActivity:(AzurWayActivity *) activityInfos;
- (void) paymentSuccess;
- (void) paymentError;
AzurWayActivity
Feel free to tell us what information you need for the payment

Name	Type	Description
name	NSString	name
price	CGFloat	price
location	CLLocation	activity location
© 2018 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About
Press h to open a hovercard with more details.
