//
//  RZViewController.m
//  Volume Setter
//
//  Created by Roger on 8/26/14.
//  Copyright (c) 2014 Roger Zou. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "RZViewController.h"

@interface RZViewController ()

@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UITextField *volumeTextField;
//@property (weak, nonatomic) IBOutlet UIView *boundsViewVolume;

//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 575)];
    //self.scrollView.contentSize = self.view.frame.size;
    
    //to resign keyboard. One liner lol. http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    //fml keyboardDismissMode only in scrollView
    scroller.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    //self.view = self.scrollView;
    //MPVolumeView *volumeView = [[MPVolumeView alloc]initWithFrame:self.boundsViewVolume.bounds];
    //[self.boundsViewVolume addSubview:volumeView];
    [[AVAudioSession sharedInstance] setActive:YES error:NULL];
    //0.00000003282911897883877497 is lowest so far and idk why so exact needed
    //0.000000000010888904795197664
    MPMusicPlayerController *iPod = [MPMusicPlayerController iPodMusicPlayer];
    self.volumeTextField.text = [NSString stringWithFormat:@"%f",iPod.volume];
    self.volumeSlider.value = iPod.volume;
    //rounds to 6 zeroes
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)maxButtonTapped {
    self.volumeSlider.value = 1.0;
    self.volumeTextField.text = @"1.0";
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:1.0];
}

- (IBAction)minSpeakersButtonTapped {
    //NOTE for speakers, not for the headphones
    self.volumeSlider.value = 0.00000003282911897883877497;
    self.volumeTextField.text = [NSString stringWithFormat:@"0.00000003282911897883877497"];
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:0.00000003282911897883877497];
}
- (IBAction)minHeadphonesButtonTapped {
    self.volumeSlider.value = 0.000000000010888904795197664;
    self.volumeTextField.text = [NSString stringWithFormat:@"0.000000000010888904795197664"];
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:0.000000000010888904795197664];
}


- (IBAction)textChanged:(UITextField *)sender {
    if ([self isNumeric:sender.text]) {
        self.volumeSlider.value = [sender.text floatValue];
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:self.volumeSlider.value];
    } else
        sender.text = @"";
}

- (IBAction)sliderChanged:(UISlider *)sender {
    self.volumeTextField.text = [NSString stringWithFormat:@"%f",sender.value];
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:sender.value];
}

// http://stackoverflow.com/questions/7153376/detect-if-nsstring-is-a-float-number
-(bool) isNumeric:(NSString*) checkText{
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    //Set the locale to US
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //Set the number style to Scientific
    [numberFormatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSNumber* number = [numberFormatter numberFromString:checkText];
    if (number != nil) {
        return true;
    }
    return false;
}

@end
