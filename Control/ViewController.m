//
//  ViewController.m
//  Control
//
//  Created by Nathan Goodwin on 6/19/17.
//  Copyright © 2017 Nathan Goodwin. All rights reserved.
//

// This is my personal home control app, made for developers who want full control of their smart home.
// Currently, I have my basic Hue lights configred for control via touch 'Platters'.
// Hue documentation can be found on the Hue developers page.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize switchBoxLabel; // So we can change the text from a seperate method.

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // First off, we need to set our basic variables. Variables are commented with what they're used for.
    
    CGRect screen = [[UIScreen mainScreen] bounds]; // This is for later when we setup our background image.
    UIImage *backgroundImage =[UIImage imageNamed:@"background.jpg"]; // This is for our app background.
    UIImage *lightImage = [UIImage imageNamed:@"light.png"]; // The image used for our light icon in the platter view.
    
    // Now for the UI. We're going to start by making the background image first because that's what loads first.
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)]; // Uses the 'screen' variable from earlier.
    backgroundView.image = backgroundImage; // Image from earlier.
    [self.view addSubview:backgroundView]; // Attach imageView to our ViewController.
    
    // Now we want to make our blur view on top of the background image.
    
    UIBlurEffect *backgroundBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]; // Make the effect.
    UIVisualEffectView *backgroundBlurView = [[UIVisualEffectView alloc] initWithEffect:backgroundBlur]; // Add it to a view.
    backgroundBlurView.frame = self.view.frame; // Set the frame.
    [self.view addSubview:backgroundBlurView]; // Attach it to ViewController.
    
    // Now that we have our background all set up, let's create our header.
    
    UILabel *titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, screen.size.width, 120)];
    titleHeader.text = @"Devices";
    titleHeader.textColor = [UIColor whiteColor];
    titleHeader.font = [UIFont fontWithName:@"Helvetica-bold" size:40];
    [self.view addSubview:titleHeader]; // Attaches label to view.
    
    // Now I will make an On/Off button that controls what is sent to the lights.
    
    UIBlurEffect *UISwitchBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *UISwitchBlurView = [[UIVisualEffectView alloc] initWithEffect:UISwitchBlur];
    UISwitchBlurView.frame = CGRectMake(25, screen.size.height - 90, 100, 50);
    [UISwitchBlurView.layer setCornerRadius:13];
    [UISwitchBlurView setClipsToBounds:YES];
    [self.view addSubview:UISwitchBlurView];
    
    // Now for the switch label.
    
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, screen.size.height - 80, screen.size.width, 120)];
    switchLabel.text = @"Tap the switch to toggle on/off.";
    switchLabel.textColor = [UIColor whiteColor];
    switchLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:14];
    [self.view addSubview:switchLabel];
    
    // Now for the INSIDE switch label.
    
    self.switchBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, -35, screen.size.width, 120)];
    switchBoxLabel.text = @"Off";
    switchBoxLabel.textColor = [UIColor blackColor];
    switchBoxLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:30];
    [UISwitchBlurView.contentView addSubview:switchBoxLabel];
    
    // Now we need to add a tap gesture to the switch.
    
    UITapGestureRecognizer *toggleSwitchTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleSwitchTapped)];
    [toggleSwitchTapped setNumberOfTapsRequired:1];
    [UISwitchBlurView.contentView addGestureRecognizer:toggleSwitchTapped];
    
    // Now we're gonna make our 'Platter' views. These are what our buttons are made of.
    // These platters are made out of blur views, but are pretty much used as UIViews for stuff.
    
    UIBlurEffect *UIPlatterViewBlurOne = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *UIPlatterViewBlurOneEffectView = [[UIVisualEffectView alloc] initWithEffect:UIPlatterViewBlurOne]; // Adds to our Platter view one.
    UIPlatterViewBlurOneEffectView.frame = CGRectMake(screen.size.width / 15, 120, 115, 115); // This makes the frame for our platter view. 🐙
    [UIPlatterViewBlurOneEffectView.layer setCornerRadius:13]; // Sets corner radius to the iOS default. (13)
    [UIPlatterViewBlurOneEffectView setClipsToBounds:YES]; // Sets clipsToBounds.
    [self.view addSubview:UIPlatterViewBlurOneEffectView]; // Should attach to the view controller.
    
    // Now the platter actually exists, we can add stuff to it!
    
    UILabel *platterOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen.size.width, 120)];
    platterOneLabel.text = @"Lamp";
    platterOneLabel.textColor = [UIColor blackColor];
    platterOneLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:14];
    [UIPlatterViewBlurOneEffectView.contentView addSubview:platterOneLabel]; // Adds our "Lamp" label to the content view of our blurred "Platter"
    
    // Now for creating the subLabel.
    
    UILabel *platterOneSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, screen.size.width, 120)];
    platterOneSubLabel.text = @"Living Room";
    platterOneSubLabel.textColor = [UIColor grayColor];
    platterOneSubLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:14];
    [UIPlatterViewBlurOneEffectView.contentView addSubview:platterOneSubLabel];
    
    // Great! Now in order to know what it is, we should add a small light above. 💡
    
    UIImageView *lightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 32.5)]; // Values came from the original image.
    lightIcon.image = lightImage;
    [UIPlatterViewBlurOneEffectView.contentView addSubview:lightIcon]; // Attaches to contentView.
    
    // Now what we see is all done! Lets log it.
    
    NSLog(@"PlatterView one was just created! 🎉");
    
    // Great! Now we can add touch recognizers to our platter to control the lights.
    
    UITapGestureRecognizer *platterViewOneTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(platterViewOneTapped)]; // Calls our method if platter one is tapped.
    [platterViewOneTapped setNumberOfTapsRequired:1]; // Sets one tap required.
    [UIPlatterViewBlurOneEffectView.contentView addGestureRecognizer:platterViewOneTapped];
    
    ////////////////////////////////////////
    // Platter Number Two! (Nathans Room) //
    ////////////////////////////////////////
    
    UIBlurEffect *UIPlatterViewBlurTwo = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]; // Nathans Room Platter.
    UIVisualEffectView *UIPlatterViewBlurTwoEffectView = [[UIVisualEffectView alloc] initWithEffect:UIPlatterViewBlurTwo]; // Adds to our Platter view two.
    UIPlatterViewBlurTwoEffectView.frame = CGRectMake(screen.size.width / 2, 120, 115, 115); // This makes the frame for our platter view. 🐙 (Nathans room :p)
    [UIPlatterViewBlurTwoEffectView.layer setCornerRadius:13]; // Sets corner radius to the iOS default. (13)
    [UIPlatterViewBlurTwoEffectView setClipsToBounds:YES]; // We know what you do. Shut up.
    [self.view addSubview:UIPlatterViewBlurTwoEffectView]; // Should attach to the view controller.
    
    // I'm so ready to create my Platter label!
    
    UILabel *platterTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screen.size.width, 120)];
    platterTwoLabel.text = @"My Room";
    platterTwoLabel.textColor = [UIColor blackColor];
    platterTwoLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:14];
    [UIPlatterViewBlurTwoEffectView.contentView addSubview:platterTwoLabel]; // Adds our "Object" label to the content view of our blurred "Platter"
    
    // I can't wait to make this subLabel!
    
    UILabel *platterTwoSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, screen.size.width, 120)];
    platterTwoSubLabel.text = @"Cat Nest";
    platterTwoSubLabel.textColor = [UIColor grayColor];
    platterTwoSubLabel.font = [UIFont fontWithName:@"Helvetica-bold" size:14];
    [UIPlatterViewBlurTwoEffectView.contentView addSubview:platterTwoSubLabel];
    
    // Attaching an icon! I'm going to have to do work!
    
    UIImageView *lightIconOne = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 32.5)]; // Values came from the original image.
    lightIconOne.image = lightImage;
    [UIPlatterViewBlurTwoEffectView.contentView addSubview:lightIconOne]; // Attaches to contentView.
    
    // Add my tappes!
    
    UITapGestureRecognizer *platterViewTwoTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(platterViewTwoTapped)]; // Calls our method if platter one is tapped.
    [platterViewTwoTapped setNumberOfTapsRequired:1]; // Sets one tap required.
    [UIPlatterViewBlurTwoEffectView.contentView addGestureRecognizer:platterViewTwoTapped];
    
    // Lets log it!
    
    NSLog(@"Platter Two created! 🐙");
}

// Here is the method for the toggle switch.

- (void)toggleSwitchTapped {
    if (self.switchBoxLabel.text == @"Off") {
        self.switchBoxLabel.text = @"On";
    } else {
        self.switchBoxLabel.text = @"Off";
    }
}

// Here is where we set up our custom methods.
// Below is where you would need to register with your hub for a Hue API key if you don't have one already.

- (void)platterViewOneTapped {
    NSLog(@"PlatterViewOneTapped 🐙");
    
    if (self.switchBoxLabel.text == @"Off") {
        NSLog(@"Switch is set to off. Turning off the lights.");
        
        // This handles if the light state is set to 'ON'.
        // If it is, we want to turn them off, like a switch.
        
        NSData *putBody = [@"{\"on\":false}" dataUsingEncoding:NSUTF8StringEncoding]; // The data we're sending.
        NSURL *platterAPIURL = [NSURL URLWithString:@"http://10.0.1.2/api/QcnzYHTkADNZEf6aMaOr0RoIV4lAHQWLkmcV4pei/lights/3/state"]; // The connection to our Hub.
        
        // Now we can talk to the Hub.
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:platterAPIURL]; // The API the platter calls.
        request.HTTPMethod = @"PUT"; // The method of our call.
        [request setHTTPBody:putBody]; // The body of our call.
        [[NSURLConnection alloc] initWithRequest:request delegate:self]; // Should send the request.
        
        [self showAlert]; // For confirming action.
        
    } else if (self.switchBoxLabel.text == @"On") {
        NSLog(@"Switch is set to on. Turing on the lights.");
        
        NSData *putBody = [@"{\"on\":true}" dataUsingEncoding:NSUTF8StringEncoding]; // The data we're sending. Same as the last if statment.
        NSURL *platterAPIURL = [NSURL URLWithString:@"http://10.0.1.2/api/QcnzYHTkADNZEf6aMaOr0RoIV4lAHQWLkmcV4pei/lights/3/state"]; // The connection to our Hub.
        
        // Let's make another connection.
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:platterAPIURL];
        request.HTTPMethod = @"PUT";
        [request setHTTPBody:putBody];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [self showAlert];
    }
}

// Now I am going to make my "Nathans Room" methods.

- (void)platterViewTwoTapped {
    NSLog(@"Switch is set to off. Turning off the lights.");
    
    if (self.switchBoxLabel.text == @"Off") {
        NSLog(@"Platter two is on! Turning it off.");
        
        NSData *putBody = [@"{\"on\":false}" dataUsingEncoding:NSUTF8StringEncoding]; // The data we're sending.
        NSURL *platterAPIURL = [NSURL URLWithString:@"http://10.0.1.2/api/QcnzYHTkADNZEf6aMaOr0RoIV4lAHQWLkmcV4pei/groups/2/action"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:platterAPIURL];
        request.HTTPMethod = @"PUT";
        [request setHTTPBody:putBody];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [self showAlert];
        
    } else if (self.switchBoxLabel.text == @"On") {
        NSLog(@"Switch is set to on. Turning on the lights.");
        
        NSData *putBody = [@"{\"on\":true}" dataUsingEncoding:NSUTF8StringEncoding]; // The data we're sending. Same as the last if statment.
        NSURL *platterAPIURL = [NSURL URLWithString:@"http://10.0.1.2/api/QcnzYHTkADNZEf6aMaOr0RoIV4lAHQWLkmcV4pei/groups/2/action"]; // The connection to our Hub.
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:platterAPIURL];
        request.HTTPMethod = @"PUT";
        [request setHTTPBody:putBody];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [self showAlert];
    }
}

- (void)showAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Action Sent" message:@"Your action was sent to the device." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok." style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
